# coding: utf-8

require 'elasticsearch'

module Klartext; end

module Klartext
  class ESClient
    
    def initialize
      @client = Elasticsearch::Client.new
    end
  end
end
