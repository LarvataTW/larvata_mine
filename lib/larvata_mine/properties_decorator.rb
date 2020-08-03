require 'larvata_mine/issue_decorator'
require 'forwardable'

module LarvataMine
  class PropertiesDecorator < IssueDecorator
    extend Forwardable

    def identifier_and_custom_field
      redmine_identifier_custom_field
    end

    def as_json
      { is_public: true,
        inherit_members: true }.merge(identifier_and_custom_field)
    end
  end
end
