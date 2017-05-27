# coding: utf-8

require 'elasticsearch'

module Klartext; end
module Klartext::Cli; end

module Klartext
  module Cli
    class ESClient

      def initialize
        @client = Elasticsearch::Client.new
      end
    end
  end
end
