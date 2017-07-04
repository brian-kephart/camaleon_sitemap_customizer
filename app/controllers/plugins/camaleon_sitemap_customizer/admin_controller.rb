class Plugins::CamaleonSitemapCustomizer::AdminController < CamaleonCms::Apps::PluginsAdminController
  include Plugins::CamaleonSitemapCustomizer::MainHelper
  def index
  end

  # show settings form
  def settings
  end

  # save values from settings form
  def save_settings
    if params[:options].present?
      @plugin.set_options(params[:options]) # save option values
    else
      @plugin.set_options({'skip_post_types' => []}) # removed saved values if form is blank
    end
    @plugin.set_metas(params[:metas]) if params[:metas].present? # save meta values
    @plugin.set_field_values(params[:field_options]) if params[:field_options].present? # save custom field values
    redirect_to url_for(action: :settings), notice: 'Settings Saved Successfully'
  end
end
