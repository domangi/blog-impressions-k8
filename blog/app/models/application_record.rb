class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def app_name
    Rails.application.class.module_parent.to_s
  end
end
