require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  CONTROLLER = CamaleonCms::AdminController

  def setup
    admin_sign_in
    get 'http://localhost:3000/admin/plugins/toggle?id=camaleon_sitemap_customizer&status=false'
    assert_equal 'Plugin "Camaleon Sitemap Customizer" was activated.', flash[:notice]
    # Use the sitemap file included with the plugin for tests. Reset all other options.
    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { cache: true }
    }
  end

  def teardown
    # Use the sitemap file included with the plugin for tests. Reset all other options.
    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { cache: true }
    }
    follow_redirect!
    assert_equal 'Settings Saved Successfully', flash[:notice]
  end

  test 'exclude content type completely' do
    content_type = current_site.the_post_types.first.decorate
    posts = content_type.the_posts.decorate
    assert posts.count.positive?

    # Make sure content_type page shows up in the sitemap
    get "#{current_site.the_url}sitemap"
    assert_response :ok
    assert_select 'loc', text: content_type.the_url, count: 1

    # Make sure each post shows up in the sitemap
    posts.each do |post|
      assert_select 'loc', text: post.the_url, count: 1
    end

    # Change settings to remove content_type
    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { skip_post_types: [content_type.id] }
    }
    assert_redirected_to 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/settings', 'Did not correctly redirect to plugin settings page after saving settings.'

    # Make sure content_type page was removed from the sitemap
    get "#{current_site.the_url}sitemap"
    assert_response :ok
    assert_select 'loc', text: content_type.the_url, count: 0

    # Make sure each post was removed from the sitemap
    posts.each do |post|
      assert_select 'loc', text: post.the_url, count: 0
    end
  end

  test 'exclude content type lists' do
    content_type = current_site.the_post_types.first.decorate
    posts = content_type.the_posts.decorate
    assert posts.count.positive?

    # Make sure content_type page shows up in the sitemap
    get "#{current_site.the_url}sitemap"
    assert_response :ok
    assert_select 'loc', text: content_type.the_url, count: 1

    # Make sure each post shows up in the sitemap
    posts.each do |post|
      assert_select 'loc', text: post.the_url, count: 1
    end

    # Change settings to remove content_type
    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { skip_post_list_types: [content_type.id] }
    }
    assert_redirected_to 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/settings', 'Did not correctly redirect to plugin settings page after saving settings.'

    # Make sure content_type page was removed from the sitemap
    get "#{current_site.the_url}sitemap"
    assert_response :ok
    assert_select 'loc', text: content_type.the_url, count: 0

    # Make sure individual posts were not removed from the sitemap
    posts.each do |post|
      assert_select 'loc', text: post.the_url, count: 1
    end
  end

  test 'exclude specific category' do
    cat = current_site.the_categories.first.decorate
    get "#{current_site.the_url}sitemap"
    assert_select 'loc', text: cat.the_url, count: 1

    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { skip_category_list_types: [cat.id] }
    }

    get "#{current_site.the_url}sitemap"
    assert_select 'loc', text: cat.the_url, count: 0
  end

  test 'exclude all category list pages' do
    cats = current_site.the_categories.decorate
    assert cats.count.positive?, 'No Categories found.'
    get "#{current_site.the_url}sitemap"
    count = css_select('loc').count - cats.count

    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { skip_all_categories: true }
    }

    get "#{current_site.the_url}sitemap"
    assert_equal count, css_select('loc').count, 'The number of entries removed from the sitemap did not match the number of Categories.'
    cats.each do |cat|
      assert_select 'loc', text: cat.the_url, count: 0
    end
  end

  test 'exclude all tags' do
    tags = current_site.the_tags.decorate
    assert tags.count.positive?, 'No Tags found.'
    get "#{current_site.the_url}sitemap"
    count = css_select('loc').count - tags.count

    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { skip_tags: true }
    }

    get "#{current_site.the_url}sitemap"
    assert_equal count, css_select('loc').count, 'The number of entries removed from the sitemap did not match the number of Tags.'
    tags.each do |tag|
      assert_select 'loc', text: tag.the_url, count: 0
    end
  end

  test 'exclude redundant homepage url' do
    home = current_site.posts.find_by_id(current_site.options.dig :home_page).decorate

    # Make sure both homepage URLs are in the sitemap.
    get "#{current_site.the_url}sitemap"
    assert_select 'loc', text: current_site.the_url, count: 1
    assert_select 'loc', text: home.the_url, count: 1

    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { skip_home: true }
    }

    # Make sure redundant ULR is removed from sitemap.
    get "#{current_site.the_url}sitemap"
    assert_select 'loc', text: current_site.the_url, count: 1
    assert_select 'loc', text: home.the_url, count: 0
  end

  test 'test that sitemap with caching operates correctly' do
    # All tests are run using the sitemap template with caching to be sure
    # that it works. This test just verifies that turning off the cache option
    # results in using the default sitemap file, which is intentionally blank
    # except for the test message.
    post 'http://localhost:3000/admin/plugins/camaleon_sitemap_customizer/save_settings', params: {
      options: { cache: false }
    }
    get '/sitemap.xml'
    assert_select 'xml', text: 'Default sitemap found successfully'
  end

  private

  def current_site
    CONTROLLER.new.current_site
  end

  def admin_sign_in
    current_site.set_option 'date_notified', Date.today # Avoid weird threading bug
    post "#{current_site.the_url}admin/login", params: {
      user: { username: 'admin', password: 'admin123' }
    }
    follow_redirect!
    assert_equal 'Welcome!!!', flash[:notice]
  end
end
