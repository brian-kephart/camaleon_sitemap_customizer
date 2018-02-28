module Plugins::CamaleonSitemapCustomizer::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def camaleon_sitemap_customizer_on_active(plugin)
    set_skip_posts plugin
  end

  def camaleon_sitemap_customizer_on_inactive(plugin)
  end

  def camaleon_sitemap_customizer_on_upgrade(plugin)
    set_skip_posts plugin
  end

  def camaleon_sitemap_customizer_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_camaleon_sitemap_customizer_settings_path)
  end

  def customize_sitemap(r)

    # completely excluded content types
    r[:skip_posttype_ids] += current_plugin.get_option('skip_post_types').map(&:to_i) rescue nil
    r[:skip_posttype_ids].each do |ptype|
      # leave out post pages within content type
      current_site.the_posts(ptype).each do |post|
        r[:skip_post_ids] += [post.id]
      end
      # leave out category pages within content type
      current_site.the_categories(ptype).each do |cat|
        r[:skip_cat_ids] += [cat.id]
      end
    end

    # excluded list pages
    r[:skip_posttype_ids] += current_plugin.get_option('skip_post_list_types')    .map(&:to_i) rescue []
    r[:skip_cat_ids]      += select_categories
    r[:skip_tag_ids]      += current_site.the_tags.map(&:id)   if current_plugin.get_option('skip_tags')
    r[:skip_post_ids]     += [@_site_options[:home_page].to_i] if current_plugin.get_option('skip_home')
    r[:skip_post_ids]     += current_plugin.get_option('skip_posts').presence || []
  end

  def camaleon_sitemap_customizer_form(args)
    args[:extra_settings] << "
      <div class='form-group'>
        <label for='options_hide_in_sitemap' class='control-label'>
        <input type='checkbox' name='options[hide_in_sitemap]' id='options_hide_in_sitemap' value='true' #{'checked' if args[:post].get_option('hide_in_sitemap').present?}>
        &nbsp;&nbsp;#{cama_t('hide_in_sitemap')}?
        </label>
      </div>
    "
  end

  def camaleon_sitemap_customizer_save(args)
    args[:post].set_option 'hide_in_sitemap', nil unless params.dig(:options, 'hide_in_sitemap').present?
    set_skip_posts current_plugin
  end

  def set_skip_posts(plugin)
    plugin.set_option 'skip_posts', current_site.the_posts.eager_load(:metas).select { |post| post.get_option('hide_in_sitemap').present? } .map(&:id)
  end

  def select_categories
    current_plugin.get_option('skip_all_categories').present? ?
    current_site.the_full_categories.pluck(:id) :
    current_plugin.get_option('skip_category_list_types').map(&:to_i)
  rescue
    []
  end
end
