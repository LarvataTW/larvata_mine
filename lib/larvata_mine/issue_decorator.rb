module LarvataMine
  class IssueDecorator < SimpleDelegator
    def tracker_id
      raise "Not implemented, please override"
    end

    def status_id
      1
    end

    def subject
      raise "Not implemented, please override"
    end

    def description
      raise "Not implemented, please override"
    end

    def assigned_to_id
      raise "Not implemented, please override"
    end
  end
end
