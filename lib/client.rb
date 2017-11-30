require_relative './http_api'
require_relative './api/command'
require_relative './multihash'

module Ipfs
  class Client
    def initialize(server = {})
      @http_api = HttpApi.new server
    end

    def id
      execute Command::Id
    end

    def version
      execute Command::Version
    end

    def cat(multi_hash)
      execute Command::Cat, multi_hash
    end

    def ls(multi_hash)
      execute Command::Ls, Multihash.new(multi_hash)
    end

    private

    def execute(command, *args)
      command.parse_response @http_api.call command.build_request *args
    end
  end
end