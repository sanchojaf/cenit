module RailsAdmin
  module Models
    module Setup
      module ApiPullAdmin
        extend ActiveSupport::Concern

        included do
          rails_admin do
            navigation_label 'Monitors'
            visible false
            object_label_method { :to_s }

            configure :attempts_succeded, :text do
              label 'Attempts/Succedded'
            end

            edit do
              field :description
              field :auto_retry
            end

            fields :api, :pull_request, :pulled_request, :description, :scheduler, :attempts_succeded, :retries, :progress, :status, :notifications, :updated_at
          end
        end

      end
    end
  end
end