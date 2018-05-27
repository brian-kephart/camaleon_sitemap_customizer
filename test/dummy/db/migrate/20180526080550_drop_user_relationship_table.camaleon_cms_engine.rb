# This migration comes from camaleon_cms_engine (originally 20161215202255)
class DropUserRelationshipTable < CamaManager.migration_class
  def change
    drop_table "#{PluginRoutes.static_system_info["db_prefix"]}user_relationships"
  end
end
