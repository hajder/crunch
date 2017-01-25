module Crunch

  module Provider

    class Facebook

      def initialize(access_token)
        @graph = Koala::Facebook::API.new access_token
      end

      def get_posts(csv_input)
        # should we pass in a timestamp to only process new posts?
        @graph.batch do |batch_api|
          csv_input.each do |line|
            batch_api.get_connections(line['page_id'], "posts", {
              'fields' => ['id','created_time','type','reactions','comments.order(reverse_chronological){from}'],
              'date_format' => 'U',
              'order' => 'reverse_chronological',
              'limit' => line['limit']
            })
          end
        end
      end

    end

  end

end
