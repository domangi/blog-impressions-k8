class Article < ApplicationRecord
  def urn
    "#{app_name}:#{self.class.name}:#{id}".downcase
  end

  def impressions
    @impressions ||= Remote::Impression.get(urn)
  end
end
