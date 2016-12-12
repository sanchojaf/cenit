module RailsAdmin
  module Models
    module Setup
      module OauthProviderAdmin
        extend ActiveSupport::Concern

        included do
          rails_admin do
            weight 311
            label 'OAuth 1.0 provider'
            register_instance_option :label_navigation do
              'OAuth 1.0'
            end
            object_label_method { :custom_title }

            configure :tenant do
              visible { Account.current_super_admin? }
              read_only { true }
              help ''
            end

            configure :refresh_token_algorithm do
              visible { bindings[:object].refresh_token_strategy == :custom.to_s }
            end

            edit do
              field :namespace, :enum_edit, &RailsAdmin::Models::Setup::FieldsConfigAdmin.shared_non_editable
              field :name
              field :response_type
              field :authorization_endpoint
              field :token_endpoint
              field :token_method
              field :request_token_endpoint
              field :refresh_token_strategy
              field :refresh_token_algorithm
            end

            fields :namespace, :name, :response_type, :authorization_endpoint, :token_endpoint, :token_method, :request_token_endpoint, :refresh_token_strategy, :refresh_token_algorithm, :tenant, :updated_at
          end
        end

      end
    end
  end
end