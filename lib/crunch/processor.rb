module Crunch

  module Processor

    class Facebook

      def process(response)
        response.flat_map do |page|
          page.flat_map do |post|
            page_id, post_id = post['id'].split('_')
            post_type = post['type']
            reactions = (post['reactions'] || {'data' => []})['data']
            comments = (post['comments'] || {'data' => []})['data']
            reactions.map do |reaction|
              [
                reaction['id'],
                page_id,
                post_id,
                post_type,
                'reaction',
                reaction['type']
              ]
            end + comments.map do |comment|
              [
                comment['from']['id'],
                page_id,
                post_id,
                post_type,
                'comment'
              ]
            end
          end
        end
      end

    end

  end

end
