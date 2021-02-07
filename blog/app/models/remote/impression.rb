module Remote
  class Impression
    SERVICE_HOST = ENV.fetch('IMPRESSIONS_SERVICE_URL')

    class << self
      def get(urn)
        response = RestClient.get("#{SERVICE_HOST}/impressions/#{urn}")
        JSON.parse(response.body)['count']
      rescue StandardError => e
        Rails.logger.info "Remote::Impressions.get error: #{SERVICE_HOST}: #{e}"
        0
      end
    end
  end
end
