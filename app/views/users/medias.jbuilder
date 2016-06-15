json.total_count @medias_count
json.medias do
    json.array!(@medias) do |media|
        json.extract! media, :id, :type, :likes, :comments, :media_url, :caption, :tags, :created_time, :link
        json.time_ago time_ago_in_words(Time.at(media.created_time.to_i), include_seconds: true)
        json.video_poster media.video_poster if media.type == "video"
        json.pinned media.isPinned?
    end
end