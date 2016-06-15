class User
    include Redis::Objects

    attr_reader :id

    value :username
    value :full_name
    value :profile_picture
    list :medias

    def initialize(id)
        @id = id
    end

    def add_media(media_id)
        medias.push(media_id) if Media.exists?(media_id) && !has_media?(media_id)
        # use unshift if you want to add at the begining of list
        # medias.unshift(media_id) if Media.exists?(media_id) && !medias.exists?(media_id)
    end

    # order:  "asc"/"desc"
    # sort_by:  "created_time"/"likes"/"comments"
    def get_medias(page=1, page_size=10, sort_by="created_time", order="desc")
        from = (page.to_i-1)*page_size.to_i
        opt = {}
        opt[:order] = order
        opt[:by] = "media:*:score"
        #opt[:by] = "media:*:#{sort_by}"
        opt[:limit] = [from, page_size]

        # key for caching search result 
        store_key = "user#{id}_page#{page}_by_#{sort_by}_#{order}"
        opt[:store] = store_key

        medias.sort(opt)
        # cache result for 5 minutes
        self.redis.expire(store_key, 300)
        stored_result = self.redis.lrange(store_key, 0, -1)
        # return media instances
        p stored_result
        stored_result.map do |media_id|
            Media.find(media_id)
        end
    end

    def self.exists?(id)
        # assume the user exists if username key exists
        self.redis.exists("user:#{id}:username")
    end

    # this method can be written in base class and inherited
    def self.find(id)
        self.exists?(id) ? self.new(id) : nil
    end

    def self.create(attributes={})
        user = self.new(attributes[:id])
        user.username = attributes[:username]
        user.full_name = attributes[:full_name]
        user.profile_picture = attributes[:profile_picture]
    end

    def score_medias(field)
        medias.values.each do |m|
            media = Media.find(m)
            score = Redis::Value.new("media:#{m}:score")
            score.value = media.pinned.value.to_i * 10000000000 + media.send(field).value.to_i
        end
    end

    def has_media?(id)
        medias.values.include?(id)
    end
end