source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in camaleon_sitemap_customizer.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :development, :test do
  gem 'camaleon_cms', github: 'owen2345/camaleon-cms'
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'draper'
  gem 'puma'
  gem 'selenium-webdriver'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

#################### Camaleon CMS include all gems for plugins and themes ####################
require_relative 'test/dummy/lib/plugin_routes'
instance_eval(PluginRoutes.draw_gems)
