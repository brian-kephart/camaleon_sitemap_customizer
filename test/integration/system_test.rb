# frozen_string_literal: true

require "test_helper"

class SystemTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def setup
    archive_db_path = Rails.root.join("db", "test_copy.sqlite3")
    test_db_path = Rails.root.join("db", "test.sqlite3")
    FileUtils.cp archive_db_path, test_db_path
    admin_sign_in
    get "http://localhost:3000/admin/plugins/toggle?id=camaleon_sitemap_customizer&status=false"
    reset_plugin_options
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  test "option in post editor to exclude post from sitemap" do
    activate_plugin
    current_post = current_site.the_posts.first.decorate

    visit current_post.the_edit_url
    check "Hide in Sitemap?"
    click_on "Update"
    visit "http://localhost:3000/sitemap"
    assert page.has_no_content?(current_post.the_url), "Post found in the sitemap when it should be hidden."

    visit current_post.the_edit_url
    uncheck "Hide in Sitemap?"
    click_on "Update"
    visit "http://localhost:3000/sitemap"
    assert page.has_content?(current_post.the_url), "Post not found in the sitemap when it should be visible."
  end

  private

  def current_site
    @current_site ||= CamaleonCms::Site.first.decorate
  end

  def activate_plugin
    admin_sign_in
    visit "http://localhost:3000/admin/plugins/toggle?id=camaleon_sitemap_customizer&status=false"
    assert find(".alert-success").has_content?('Plugin "Camaleon Sitemap Customizer" was activated.'), "Plugin could not be activated."
  end

  def admin_sign_in
    current_site.set_option "date_notified", Date.today # Avoid weird threading bug
    visit "#{current_site.the_url}admin/logout"
    fill_in "Username", with: "admin"
    fill_in "Password", with: "admin123"
    click_on "Log In"
    assert find(".alert-success").has_content?("Welcome!!!"), "Login failed."
  end

  def reset_plugin_options
    # Use the sitemap file included with the plugin for tests. Reset all other options.
    post "http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings", params: {
      options: {cache: true}
    }
    follow_redirect!
  end
end
