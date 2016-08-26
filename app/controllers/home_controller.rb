class HomeController < ApplicationController
    def index
        #@pictures = Picture.all
        # @pic_pages = Picture.page(params[:page]).per(10)
        user_id = session[:user_id]
        
        @pictures = Picture.page(params[:page]).per(10)
        
        
        @pictures.each do |pic|
            behavior_num = Behavior.where(picture_id: pic.id).count()

            pic.behavior_num = format("%02d", behavior_num)
            
            pic.like = (Behavior.where(user_id: user_id, picture_id: pic.id).count() > 0)
 
            pic.like_image_url = "/picture/"+behavior_num.to_s+".jpg"
=begin
            if behavior_num < 5 then
                pic.width = 360
                pic.height = 270
                pic.size = "s_pic"
            elsif behavior_num < 10 then
                pic.width = 480
                pic.height = 360
                pic.size = "m_pic"
            else
                pic.width = 640
                pic.height = 480
                pic.size = "l_pic"
            end
=end
        end
   
        #@pic_pages = pic_pages

    end
         
        
    def more_read
        @pictures = Picture.where("picture_id > #{params[:picture_id]}").limit(10)
            user_id = session[:user_id]
            @pictures.each do |pic|
            
            pic.like = (Behavior.where(user_id: user_id, picture_id: pic.id).count() > 0)
               
            behavior_num = Behavior.where(picture_id: pic.id).count()

            pic.behavior_num = format("%02d", behavior_num)
            if behavior_num < 5 then
                pic.width = 360
                pic.height = 270
                pic.size = "s_pic"
            elsif behavior_num < 10 then
                pic.width = 480
                pic.height = 360
                pic.size = "m_pic"
            else
                pic.width = 640
                pic.height = 480
                pic.size = "l_pic"
            end
        end
        render :more_read, layout: false
    end
end
