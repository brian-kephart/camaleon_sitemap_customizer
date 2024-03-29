# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "camaleon_sitemap_customizer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "camaleon_sitemap_customizer"
  s.version = CamaleonSitemapCustomizer::VERSION
  s.authors = ["Brian Kephart"]
  s.email = ["briantkephart@gmail.com"]
  s.homepage = "https://www.github.com/brian-kephart/camaleon_sitemap_customizer"
  s.summary = "Customize auto-generated sitemap in Camaleon CMS"
  s.description = "Customize auto-generated sitemap in Camaleon CMS. Eliminate duplicate content and list pages."
  s.license = "MIT"
  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.metadata = {
    "homepage_uri" => "https://www.github.com/brian-kephart/camaleon_sitemap_customizer",
    "changelog_uri" => "https://www.github.com/brian-kephart/camaleon_sitemap_customizer/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://www.github.com/brian-kephart/camaleon_sitemap_customizer",
    "rubygems_mfa_required" => "true"
  }

  s.required_ruby_version = ">= 2.6"

  s.add_dependency "camaleon_cms", "~> 2.0"

  s.add_development_dependency "sqlite3", "~> 1.4"
  s.add_development_dependency "rails", ">= 6.1.0"
end
