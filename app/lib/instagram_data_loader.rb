class InstagramDataLoader
    def get_recent_media(ig_id, count=200)
        #579257861
        JSON.parse(Instagram.user_recent_media(ig_id, {:count => count}).to_json)
    end

    def load_and_store_data(ig_id, count=200)
        return if User.exists?(ig_id)

        @media = get_recent_media(ig_id, count=200)

        unless @media.empty?
            user = @media.first['user']
            User.create(
                id: user['id'],
                username: user['username'],
                profile_picture: user['profile_picture'],
                full_name: user['full_name']
            )
        end

        @media.each do |m|
            media_url = (m['type'] == 'video' ? m['videos']['standard_resolution']['url'] : m['images']['standard_resolution']['url'])
            caption = m['caption'] ? m['caption']['text'] : nil
            video_poster = (m['type'] == 'video' ? m['images']['standard_resolution']['url'] : nil)
            Media.create(
                id: m['id'],
                type: m['type'],
                likes: m['likes']['count'],
                comments: m['comments']['count'],
                created_time: m['created_time'],
                link: m['link'],
                media_url: media_url,
                caption: caption,
                tags: m['tags'],
                video_poster: video_poster
            )
            User.find(user['id']).add_media(m['id'])
        end
    end
end