$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "camaleon_sitemap_customizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "camaleon_sitemap_customizer"
  s.version     = CamaleonSitemapCustomizer::VERSION
  s.authors     = ["Brian Kephart"]
  s.email       = ["briantkephart@gmail.com"]
  s.homepage    = ""
  s.summary     = "Customize auto-generated sitemap in Camaleon CMS"
  s.description = "Customize auto-generated sitemap in Camaleon CMS"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "camaleon_cms"
end
