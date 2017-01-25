module Crunch

  class Core

    def initialize(loader, provider, processor, exporter)
      @loader = loader
      @provider = provider
      @processor = processor
      @exporter = exporter
    end

    def run(input_path, output_path)
      page_ids = @loader.read(input_path)
      posts = @provider.get_posts(page_ids)
      transformed = @processor.process(posts)
      @exporter.write(transformed, output_path)
    end

  end

end
