# This migration comes from camaleon_cms_engine (originally 20160606135421)
class ImproveMenusStructure < CamaManager.migration_class
  def change
    CamaleonCms::NavMenuItem.all.each do |menu|
      menu.update_columns({description: menu.get_option('object_id'), slug: menu.get_option('type')})
    end
  end
end
