class MediasController < ApplicationController
    respond_to :json

    def pin
        @media = Media.find(params[:id])
        if @media.isPinned?
            @media.unpin
        else
            @media.pin
        end
    end

end