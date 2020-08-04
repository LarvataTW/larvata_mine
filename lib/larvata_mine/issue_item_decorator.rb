require 'larvata_mine/issue_decorator'
require 'forwardable'

module LarvataMine
  class EstimateItemDecorator < IssueDecorator
    extend Forwardable

    def as_json(custom_fields = {})
      { is_public: true,
        tracker_id: 7,
        status_id: 1 }.merge(custom_fields)
    end
  end

  class CertificatePaymentsDecorator < IssueDecorator
    extend Forwardable

    def as_json(custom_fields = {})
      { is_public: true,
        tracker_id: 8,
        status_id: 1 }.merge(custom_fields)
    end
  end

  class ConstMethodsDecorator < IssueDecorator
    extend Forwardable

    def as_json(custom_fields = {})
      { is_public: true,
        tracker_id: 9,
        status_id: 1 }.merge(custom_fields)
    end
  end
end
