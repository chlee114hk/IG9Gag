class Media
    include Redis::Objects

    attr_reader :id

    value :type
    value :likes
    value :comments
    value :created_time
    value :link
    value :media_url
    value :caption
    value :video_poster
    list :tags

    def initialize(id)
        @id = id
    end

    def self.exists?(id)
        # assume the media exists if media_url key exists
        self.redis.exists("media:#{id}:media_url")
    end

    # this method can be written in base class and inherited
    def self.find(id)
        self.exists?(id) ? self.new(id) : nil
    end

    def self.create(attributes={})
        media = self.new(attributes[:id])
        media.type = attributes[:type]
        media.likes = attributes[:likes]
        media.comments = attributes[:comments]
        media.created_time = attributes[:created_time]
        media.link = attributes[:link]
        media.media_url = attributes[:media_url]
        media.caption = attributes[:caption]
        media.video_poster = attributes[:video_poster] if attributes[:video_poster]
        attributes[:tags].each do |tag|
            media.tags << tag
        end
    end
end