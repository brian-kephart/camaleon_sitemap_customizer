# This migration comes from camaleon_cms_engine (originally 20161206211917)
class InstallMigratedSeoPlugin < CamaManager.migration_class
  # install seo plugin without calling hooks (seo logic moved to separated plugin)
  def change
    CamaleonCms::Site.all.each do |s|
      s.plugins.where(slug: 'cama_meta_tag').first_or_create!(term_group: 1)
    end
  end
end
