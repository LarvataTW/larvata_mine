module LarvataMine
  class IssueDecorator < SimpleDelegator
    def tracker_id
      raise NotImplementedError
    end

    def status_id
      1
    end

    def subject
      raise NotImplementedError
    end

    def description
      raise NotImplementedError
    end

    def assigned_to_id
      raise NotImplementedError
    end

    def as_json(*)
      raise NotImplementedError
    end
  end
end
