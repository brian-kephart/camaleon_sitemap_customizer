# frozen_string_literal: true

class CamaleonSitemapCustomizer::SubmitSitemapJob < ActiveJob::Base
  queue_as :default

  def perform(submit_url)
    url = URI.parse submit_url
    Net::HTTP.get url
  end
end
