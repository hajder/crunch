module Crunch

  class Loader

    def read(path)
      CSV.open(path).map { |row| {'page_id' => row[0], 'limit' => row[1].to_i} }
    end

  end

end
