class WannaGoController < ApplicationController
    def top
        @wannagos = Behavior.joins(:picture).where(user_id: session[:user_id]).group('picture_id').order('behaviors.updated_at DESC')
    end
    
    def register
        behavior = Behavior.new
        behavior.picture_id = params[:picture_id]
        @picid = behavior.picture_id
        behavior.user_id = session[:user_id]
        behavior.save

        @behavior_num = format("%02d", Behavior.where(picture_id: params[:picture_id]).count)
        render :register, layout: false
    end
    
    def detail
        @pic_id = params[:pic_id]
        location_id = Picture.find(@pic_id)
        @location = Location.find(location_id)
        @wannago_pic = Picture.find(@pic_id)
    end
    
end
