class WannaGoController < ApplicationController
    def top
        @wannagos = Behavior.joins(:picture).where(user_id: 1).group('picture_id').order('created_at DESC')
        @user_name = "はまちゃん"
    end
    
    def register
        behavior = Behavior.new
        behavior.picture_id = params[:picture_id]
        @picid = behavior.picture_id
        behavior.user_id = 1
        behavior.save
    end
    
    def detail
        @pic_id = params[:pic_id]
        location_id = Picture.find(@pic_id)
        @location = Location.find(location_id)
        @wannago_pic = Picture.find(@pic_id)
        @user_name = "はまちゃん"
    end
    
end
