# frozen_string_literal: true

class Plugins::CamaleonSitemapCustomizer::AdminController < CamaleonCms::Apps::PluginsAdminController
  DEFAULT_OPTIONS = {
    "skip_post_types" => [],
    "skip_post_list_types" => [],
    "skip_category_list_types" => [],
    "skip_all_categories" => false,
    "skip_tags" => false,
    "skip_home" => false,
    "cache" => Rails.env.test?,
  }.freeze

  include Plugins::CamaleonSitemapCustomizer::MainHelper
  def index
  end

  # show settings form
  def settings
  end

  # save values from settings form
  def save_settings
    options = DEFAULT_OPTIONS.merge(params[:options]&.to_unsafe_h.presence || {})
    @plugin.set_options(options) # save option values
    @plugin.set_metas(params[:metas]) if params[:metas].present? # save meta values
    @plugin.set_field_values(params[:field_options]) if params[:field_options].present? # save custom field values
    redirect_to url_for(action: :settings), notice: "Settings Saved Successfully"
  end
end
