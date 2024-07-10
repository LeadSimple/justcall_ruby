module JustCall
  class Error < StandardError
    class NoContent < JustCall::Error; end
    class NotAuthorized < JustCall::Error; end
    class NotFound < JustCall::Error; end
    class RequestError < JustCall::Error; end
    class TimeoutError < JustCall::Error; end
  end
end
