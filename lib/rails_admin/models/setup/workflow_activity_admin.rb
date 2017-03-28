module RailsAdmin
  module Models
    module Setup
      module WorkflowActivityAdmin
        extend ActiveSupport::Concern

        included do
          rails_admin do
            navigation_label 'Activities'
            weight 500
            object_label_method { :name }

            edit do
              field :type, :enum do
                required true
                visible do
                  bindings[:object].new_record?
                end
                formatted_value do |value|
                  bindings[:object].new_record? ? value : bindings[:object].icon.html_safe
                end
              end
              field :icon do
                required true
                read_only true
                label 'Type'
                visible do
                  !bindings[:object].new_record?
                end
                formatted_value do
                  bindings[:view].render partial: '/rails_admin/workflow/activity_icon', locals: {
                    type: bindings[:object].type.humanize,
                    icon: bindings[:object].icon
                  }
                end
              end
              field :description do
                visible do
                  !bindings[:object].new_record? && bindings[:object].has_multiple_outbounds?
                end
              end
              field :transitions do
                visible do
                  !bindings[:object].new_record? && bindings[:object].has_multiple_outbounds?
                end
              end
              field :next_activity_id, :enum do
                visible do
                  !bindings[:object].new_record? && bindings[:object].has_simple_outbound?
                end
                enum do
                  workflow = bindings[:controller].instance_variable_get(:@object)
                  workflow.passable_activities.map { |a| [a.name, a.id] }
                end
              end
            end
          end
        end

      end
    end
  end
end