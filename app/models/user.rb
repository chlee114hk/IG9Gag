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
        medias.push(media_id) if Media.exists?(media_id)
        # use unshift if you want to add at the begining of list
        # medias.unshift(media_id) if Media.exists?(media_id)
    end

    # order:  "asc"/"desc"
    # sort_by:  "created_time"/"likes"/"comments"
    def get_medias(page=1, page_size=10, sort_by="created_time", order="desc")
        from = (page.to_i-1)*page_size.to_i
        opt = {}
        opt[:order] = order
        opt[:by] = "media:*:#{sort_by}"
        opt[:limit] = [from, page_size]
        p opt[:limit]
        store_key = "user#{id}_page#{page}_by_#{sort_by}_#{order}"
        opt[:store] = store_key
        p medias.values
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
end