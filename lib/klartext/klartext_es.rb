# coding: utf-8
require 'elasticsearch'

module Klartext; end

class Klartext::ESClient
  def initialize
    @client = Elasticsearch::Client.new host: 'localhost:9200'
  end

  def create_index
    @client.indices.create index: 'klartext',
                           body: {
                             settings: {
                               index: {
                                 number_of_shards: 3,
                                 number_of_replicas: 1
                               },
                               analysis: {
                                 filter: {
                                   word_filter: {
                                     type: 'edge_ngram',
                                     min_gram: 2,
                                     max_gram: 10
                                   }
                                 },
                                 analyzer: {
                                   word_analyzer: {
                                     tokenizer: 'standard',
                                     filter: ['lowercase','word_filter'],
                                     type: 'custom'
                                   },
                                   word_search: {
                                     tokenizer: 'standard',
                                     filter: ['lowercase'],
                                     type: 'custom'
                                   }
                                 }
                               }
                             }
                           }
  end

  def update_mapping
    @client.indices.put_mapping index: 'klartext',
                                type: 'word',
                                body: {
                                  word: {
                                    properties: {
                                      value: {
                                        type: 'string',
                                        analyzer: 'word_analyzer',
                                        search_analyzer: 'word_search'
                                      },
                                      klass: {
                                        type: 'string',
                                        index: 'not_analyzed'
                                      },
                                      lang: {
                                        type: 'string',
                                        index: 'not_analyzed'
                                      },
                                      inflection: {
                                        type: 'string',
                                        analyzer: 'word_analyzer',
                                        search_analyzer: 'word_search'
                                      },
                                      translation: {
                                        type: 'string',
                                        analyzer: 'word_analyzer',
                                        search_analyzer: 'word_search'
                                      }
                                    }
                                  }
                                }
  end

  def delete_index
    @client.indices.delete index: ["klartext","lillebror"]
  end
end
