# This migration comes from camaleon_cms_engine (originally 20160609121449)
class AddGroupToCustomFieldValues < CamaManager.migration_class
  def change
    add_column "#{PluginRoutes.static_system_info["db_prefix"]}custom_fields_relationships", :group_number, :integer, default: 0
  end
end
