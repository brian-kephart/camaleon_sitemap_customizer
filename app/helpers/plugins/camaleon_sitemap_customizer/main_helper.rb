module Plugins::CamaleonSitemapCustomizer::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def camaleon_sitemap_customizer_on_active(plugin)
  end

  def camaleon_sitemap_customizer_on_inactive(plugin)
  end

  def camaleon_sitemap_customizer_on_upgrade(plugin)
  end

  def camaleon_sitemap_customizer_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_camaleon_sitemap_customizer_settings_path)
  end

  def customize_sitemap(r)

    # completely excluded content types
    r[:skip_posttype_ids] += current_plugin.get_option('skip_post_types').map(&:to_i)
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
    r[:skip_posttype_ids] += current_plugin.get_option('skip_post_list_types')    .map(&:to_i)
    r[:skip_cat_ids]      += current_plugin.get_option('skip_category_list_types').map(&:to_i)
    r[:skip_tag_ids]      += current_site.the_tags.map(&:id)   if current_plugin.get_option('skip_tags')
    r[:skip_post_ids]     += [@_site_options[:home_page].to_i] if current_plugin.get_option('skip_home')
  end
end
