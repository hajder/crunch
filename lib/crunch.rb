require 'koala'
require 'yaml'
require 'json'
require 'csv'
require 'trollop'

Thread.abort_on_exception = true
Encoding.default_external = Encoding.find('UTF-8')

require_relative 'crunch/core'
require_relative 'crunch/exporter'
require_relative 'crunch/loader'
require_relative 'crunch/processor'
require_relative 'crunch/provider'

public def run()
  opts = Trollop::options do
    opt :idsfile, "Path to input file with ids and totals.", :type => :string,
        :default => File.expand_path("../../data/example.csv", __FILE__)
    opt :csvfile, "Path to output csv file.", :type => :string,
        :default => File.expand_path("../../data/result.csv",  __FILE__)
  end

  Koala.config.api_version = "v2.8"

  input_path = opts[:idsfile]
  output_path = opts[:csvfile]

  conf_file = File.expand_path("../../config.yml", __FILE__)
  config = YAML.load_file(conf_file)
  access_token = config['oauth_access_token']

  loader = Crunch::Loader.new
  provider = Crunch::Provider::Facebook.new(access_token)
  processor = Crunch::Processor::Facebook.new
  exporter = Crunch::Exporter.new

  core = Crunch::Core.new(loader, provider, processor, exporter)
  core.run(input_path, output_path)
end
