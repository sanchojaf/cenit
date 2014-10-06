module Setup
  class Webhook
    include Mongoid::Document
    include Mongoid::Timestamps
    include Setup::Enum

    field :name, type: String
    field :path, type: String
    field :purpose, type: String

    belongs_to :model_schema, class_name: 'Setup::ModelSchema'

    validates_presence_of :name, :path, :purpose

  end
end
