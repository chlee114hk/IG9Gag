class UsersController < ApplicationController
    respond_to :json

    def show
        InstagramDataLoader.new.load_and_store_data(params[:id], 200)
        @user = User.find(params[:id])
    end

    def medias
        reload = params.has_key?(:reload) ? params[:reload] == 'true' : false

        InstagramDataLoader.new.load_and_store_data(params[:id], 200, reload)
        @user = User.find(params[:id])

        page = params[:page] || 1
        page_size = params[:page_size] || 10
        sort_by = params[:sort_by] || "created_time"
        order = params[:order] || "desc"

        @medias_count = @user.medias.length
        @medias = @user.get_medias(page, page_size, sort_by, order)
    end
end