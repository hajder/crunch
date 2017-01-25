module Crunch

  module Processor

    class Facebook

      def process(payload)
        flattened = payload.flat_map { |chunk| process_chunk(chunk) }
        flattened.flat_map do |entry|
          (entry['interactions'] || []).map do |interaction|
            [
              interaction['user_id'],
              entry['page_id'],
              entry['id'],
              entry['type'],
              interaction['interaction_type'],
              interaction['interaction_subtype']
            ].compact
          end
        end

        # csvd.sort do |a, b|
        #   [a[0].to_i, a[1].to_i, a[2].to_i] <=> [b[0].to_i, b[1].to_i, b[2].to_i]
        # end
      end

      def process_chunk(chunk)
        chunk.map do |p|
          {
            'page_id' => p['id'].split('_')[0],
            'id' => p['id'].split('_')[1],
            'type' => p['type'],
            'interactions' => process_interactions(p)
          }
        end
      end

      def process_interactions(post)
        reactions = (post['reactions'] || {'data' => []})['data'].map do |reaction|
          {
            'user_id' => reaction['id'],
            'interaction_type' => 'reaction',
            'interaction_subtype' => reaction['type']
          }
        end

        comments = (post['comments'] || {'data' => []})['data'].map do |comment|
          {
            'user_id' => comment['from']['id'],
            'interaction_type' => 'comment',
            'interaction_subtype' => nil
          }
        end

        reactions + comments
      end

    end

  end
end
