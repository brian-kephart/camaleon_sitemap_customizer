# frozen_string_literal: true

xml.instruct! :xml, version: '1.0'
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  current_site.get_languages.each_with_index do |lang, index|
    lang = (index.zero? ? nil : lang)
    xml.url do
      xml.loc current_site.the_url(locale: lang)
      xml.lastmod current_site.updated_at.to_date
      xml.changefreq 'daily'
      xml.priority '1.0'
    end

    cache ["xml_sitemap/posts/#{current_site.the_posts.maximum :updated_at}", @r[:skip_post_ids]] do
      current_site.the_posts.decorate.each do |post|
        next if @r[:skip_post_ids].include? post.id
        cache post do
          xml.url do
            xml.loc post.the_url(locale: lang)
            xml.lastmod post.updated_at.to_date
            xml.changefreq 'monthly'
            xml.priority '0.5'
          end
        end
      end
    end

    cache ["xml_sitemap/categories/#{current_site.full_categories.maximum :updated_at}", @r[:skip_cat_ids]] do
      current_site.full_categories.no_empty.decorate.each do |cat|
        next if @r[:skip_cat_ids].include? cat.id
        cache cat do
          xml.url do
            xml.loc cat.the_url(locale: lang)
            xml.lastmod cat.updated_at.to_date
            xml.changefreq 'monthly'
            xml.priority '0.5'
          end
        end
      end
    end

    cache ["xml_sitemap/post_types/#{current_site.post_types.maximum :updated_at}", @r[:skip_posttype_ids]] do
      current_site.post_types.decorate.each do |ptype|
        next if @r[:skip_posttype_ids].include? ptype.id
        cache ptype do
          xml.url do
            xml.loc ptype.the_url(locale: lang)
            xml.lastmod ptype.updated_at.to_date
            xml.changefreq 'monthly'
            xml.priority '0.5'
          end
        end
      end
    end

    cache ["xml_sitemap/post_tags/#{current_site.post_types.maximum :updated_at}", @r[:skip_tag_ids]] do
      current_site.post_tags.decorate.each do |tag|
        next if @r[:skip_tag_ids].include? tag.id
        cache tag do
          xml.url do
            xml.loc tag.the_url(locale: lang)
            xml.lastmod tag.updated_at.to_date
            xml.changefreq 'monthly'
            xml.priority '0.5'
          end
        end
      end
    end
  end

  cache @r[:custom] do
    @r[:custom].each do |_key, item|
      cache item do
        xml.url do
          xml.loc item[:url]
          xml.lastmod item[:lastmod] || Date.today.to_s
          xml.changefreq item[:changefreq] || 'monthly'
          xml.priority item[:priority] || '0.5'
        end
      end
    end
  end
end
