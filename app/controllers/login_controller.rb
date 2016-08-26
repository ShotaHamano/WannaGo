class LoginController < ApplicationController
    def login
      
      @user_id= params[:user_id]
      session[:user_id] = @user_id
      
      case @user_id.to_i
      when 1 then
        @user_name = "はまちゃん"
      when 2 then
        @user_name = "しゅんちゃん"
      when 3 then
        @user_name = "にしこう"
      when 4 then
        @user_name = "セッキー"
      when 5 then
        @user_name = "よこやん"
      when 6 then
        @user_name = "よこやま(母)"
      when 7 then
        @user_name = "はる"
      when 8 then
        @user_name = "渡辺じゅん"
      else
        @user_name = "こういち"
      end         
      session[:user_name] = @user_name
      redirect_to 'https://wannago-shota-hamano.c9users.io/home'
      
    end
         
        

end
