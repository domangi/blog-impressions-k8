import Config

config :kaffe,
  consumer: [
    heroku_kafka_env: true,
    topics: ["blog.article.viewed"],
    consumer_group: "impressions",
    consumer_group: "your-app-consumer-group",
    message_handler: Consumer
  ]

import_config "#{Mix.env()}.exs"
