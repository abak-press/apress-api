require 'json'

module Apress
  module Api
    module Rspec
      module Utils
        def dump_response
          <<-EOS.strip_heredoc
            Request: #{request.method} #{request.original_url}
            Status: #{response.code}
            #{JSON.pretty_generate(JSON.parse(response.body.to_s))}
          EOS
        end
      end
    end
  end
end
