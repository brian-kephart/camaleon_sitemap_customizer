# This migration comes from camaleon_cms_engine (originally 20160504155652)
class AddFeatureToPosts < CamaManager.migration_class
  def change
    add_column "#{PluginRoutes.static_system_info["db_prefix"]}posts", :is_feature, :boolean, default: false
  end
end
