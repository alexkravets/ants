module Constraints
  class Redirects

    def self.matches?(request)
      Redirect.match(request)
    end

  end
end
