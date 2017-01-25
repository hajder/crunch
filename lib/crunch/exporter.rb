module Crunch

  class Exporter

    def write(things, path)
      CSV.open(path, 'w') { |csv| things.each { |thing| csv << thing } }
    end

  end

end
