![](https://img.shields.io/badge/ruby-2.3%2B-red.svg)
![Gem Version](https://img.shields.io/gem/v/camaleon_sitemap_customizer.svg?colorB=blue)
[![Build Status](https://travis-ci.com/brian-kephart/camaleon_sitemap_customizer.svg?branch=master)](https://travis-ci.com/brian-kephart/camaleon_sitemap_customizer)

# Camaleon Sitemap Customizer
Camaleon CMS automatically generates sitemaps for all content of your site. This plugin allows you to select content to omit from the sitemap. You may wish to do this for a variety of reasons:
- Keep search engines from indexing pages that are not relevant to the general public.
- Keep search engines from indexing summary pages that only contain duplicate content.
- Remove redundant entries. (ex. – 'https://yoursite.com', 'https://yoursite.com/index')

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

This plugin also adds an option to each post for exclusion from the sitemap. This is accessible via the regular post editor, rather than in the plugin settings.

## Contributing
See CONTRIBUTING.md

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
