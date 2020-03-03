![](https://img.shields.io/badge/ruby-2.5%2B-red.svg)
![Gem Version](https://img.shields.io/gem/v/camaleon_sitemap_customizer.svg?colorB=blue)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
[![Build Status](https://travis-ci.com/brian-kephart/camaleon_sitemap_customizer.svg?branch=master)](https://travis-ci.com/brian-kephart/camaleon_sitemap_customizer)


# Camaleon Sitemap Customizer
Camaleon CMS automatically generates sitemaps for all content of your site. This plugin allows you to select content to omit from the sitemap. You may wish to do this for a variety of reasons:
- Keep search engines from indexing pages that are not relevant to the general public.
- Keep search engines from indexing summary pages that only contain duplicate content.
- Remove redundant entries. (ex. – 'https://yoursite.com', 'https://yoursite.com/index')

This plugin also comes with:
- an optional sitemap template that includes caching to speed up rendering,
- links in plugin settings to submit your sitemap to Google,
- an option to automatically resubmit your sitemap to Google when changes are made (requires ActiveJob).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'camaleon_sitemap_customizer'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install camaleon_sitemap_customizer
```

## Usage
Use the site settings (/admin/plugins/camaleon_sitemap_customizer/settings) to:
- Select **content types** to exclude **completely** (individual posts and list pages).
- Select **content types** for which to exclude **list pages only**. For example, if you have a content type called 'Podcast', this option would allow you to exclude 'http://yoursite.com/podcast' (the page listing all posts of type 'Podcast') without excluding the pages for each individual post.
- Select **categories** for which to exclude list pages, same as above.
- Exclude all **tag** list pages.
- Exclude post url for page designated as the homepage. For example, if you have a page called '/index' that you have set as your homepage in the site settings, the sitemap will list the same page at 'http://yoursite.com/' and 'http://yoursite.com/index'. This option allows you to avoid the duplicate listing.
- Choose whether to use the included sitemap template, which includes caching to speed up rendering.

This plugin also adds an option to each post for exclusion from the sitemap. This is accessible via the regular post editor, rather than in the plugin settings.

### About sitemap caching
The default sitemaps in Camaleon render very slowly due to the many database queries required for them to be accurate. This may not be noticeable on small sites, but large ones can sometimes take several seconds to render. This can be sped up with caching, but Camaleon's Front Cache plugin does not render XML.

This plugin offers an XML builder template that uses Russian doll caching to speed up rendering. It can be enabled on the settings page.

If you wish to make changes to the included template:
1. **Disable** the caching option in the plugin settings.
2. Copy the included `app/views/camaleon_cms/default_theme/sitemap_with_caching.xml.builder` into your app's `app/apps/themes/your_theme/views/sitemap.xml.builder` and make your changes. Camaleon will use the `sitemap.xml.builder` file in your theme directory by default.

## Contributing
See CONTRIBUTING.md

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
