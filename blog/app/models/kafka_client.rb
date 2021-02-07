require 'kafka'

class KafkaClient
  class << self
    def client
      @client ||= Kafka.new(brokers, client_id: Rails.application.class.module_parent.to_s, logger: Rails.logger)
    end

    def produce(data, topic:)
      client.deliver_message(data, topic: topic)
    rescue StandardError => e
      Rails.logger.warn "Kafka exception: #{e}"
    end

    def brokers
      kafka_url = ENV['KAFKA_URL'] || 'localhost:9092'

      [kafka_url]
    end
  end
end
