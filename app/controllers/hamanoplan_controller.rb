class UnnamedRoadError < StandardError
end

class PlanController < ApplicationController
  def index
    # @plans = Plan.find(user_id: 1)
    @user_name = "はまちゃん"
  end
    
  def proposal
    data_limit_num = Picture.all.size
    params[:pic_id] = randum_num(data_limit_num) unless params[:pic_id]
    base_location_id = params[:pic_id]
    3.times do |i|
      begin
        first_id = randum_num(data_limit_num)
        second_id = randum_num(data_limit_num)
        third_id = randum_num(data_limit_num)

        loca = Picture.find(base_location_id.to_i)
        loca1 = Picture.find(first_id.to_i)
        loca2 = Picture.find(second_id.to_i)
        loca3 = Picture.find(third_id.to_i)

        image_0 = "@images_picture_#{i}_0"
        image_1 = "@images_picture_#{i}_1"
        image_2 = "@images_picture_#{i}_2"
        image_3 = "@images_picture_#{i}_3"

        eval("#{image_0} = Picture.find(base_location_id.to_i)")
        eval("#{image_1} = Picture.find(first_id.to_i)")
        eval("#{image_2} = Picture.find(second_id.to_i)")
        eval("#{image_3} = Picture.find(third_id.to_i)")
        
        location_info = "@location_info_#{i}"
        eval("#{location_info} = Location.joins(:pictures).where(pictures: { picture_id: base_location_id }).first")

        raw_routes_infos= RestClient.get "https://maps.googleapis.com/maps/api/directions/json?origin=#{loca.latitude},#{loca.longitude}&destination=#{loca1.latitude},#{loca1.longitude}&waypoints=optimize:true|#{loca2.latitude},#{loca2.longitude}|#{loca3.latitude},#{loca3.longitude}&key=AIzaSyBIcPwtGUcAWmG413jGezEXeHwZydid22s"
        raise UnnamedRoadError if JSON.load(raw_routes_infos.to_str)['routes'][0].nil?
        route_infos = "@routes_infos_#{i}"
        val = JSON.load(raw_routes_infos.to_str)['routes'][0]['legs']
        eval("#{route_infos} = val")
        
        routes = JSON.load(raw_routes_infos.to_str)['routes'][0]['legs']
        routes.each do |route_info|
          if route_info.to_s.include?('Unnamed Road')
            raise UnnamedRoadError
          else
            next
          end
        end
        
        hotel_data_0 = RestClient.get("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20131024?applicationId=1013890697698086625&format=json&latitude=#{loca.latitude}&longitude=#{loca.longitude}&searchRadius=1&datumType=1&hits=1") { |response, request, result, &block|
          case response.code
          when 200
            response
          else
            p "response not 200"
            nil            
          end
        }
        
        hotel_data_1 = RestClient.get("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20131024?applicationId=1013890697698086625&format=json&latitude=#{loca1.latitude}&longitude=#{loca1.longitude}&searchRadius=1&datumType=1&hits=1") { |response, request, result, &block|
          case response.code
          when 200
            response
          else
            p "response not 200"
            nil            
          end
        }
        
        hotel_data_2 = RestClient.get("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20131024?applicationId=1013890697698086625&format=json&latitude=#{loca2.latitude}&longitude=#{loca2.longitude}&searchRadius=1&datumType=1&hits=1") { |response, request, result, &block|
          case response.code
          when 200
            response
          else
            p "response not 200"
            nil            
          end
        }
        
        hotel_data_3 = RestClient.get("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20131024?applicationId=1013890697698086625&format=json&latitude=#{loca3.latitude}&longitude=#{loca3.longitude}&searchRadius=1&datumType=1&hits=1") { |response, request, result, &block|
          case response.code
          when 200
            response
          else
            p "response not 200"
            nil            
          end
        }

        hotel_0 = "@hotel_info_#{i}_0"
        hotel_1 = "@hotel_info_#{i}_1"
        hotel_2 = "@hotel_info_#{i}_2"
        hotel_3 = "@hotel_info_#{i}_3"
        
        eval("#{hotel_0} = JSON.load(hotel_data_0.to_str)['hotels'][0]['hotel'][0]['hotelBasicInfo']") if hotel_data_0
        eval("#{hotel_1} = JSON.load(hotel_data_1.to_str)['hotels'][0]['hotel'][0]['hotelBasicInfo']") if hotel_data_1
        eval("#{hotel_2} = JSON.load(hotel_data_2.to_str)['hotels'][0]['hotel'][0]['hotelBasicInfo']") if hotel_data_2
        eval("#{hotel_3} = JSON.load(hotel_data_3.to_str)['hotels'][0]['hotel'][0]['hotelBasicInfo']") if hotel_data_3
      rescue UnnamedRoadError => e
        retry
      end
    end
  end

  def index
    raw_routes_infos= RestClient.get 'https://maps.googleapis.com/maps/api/directions/json?origin=Sapporo Clock Tower&destination=Moerenuma Park &waypoints=optimize:true|Otaru|sapporo%20eki&key=AIzaSyAM6c0HI52TgwBJws6u9A_3Q5k4br305Hc'
    @routes_infos=JSON.load(raw_routes_infos.to_str)["routes"][0]['legs']
 
    raw_routes_infos2= RestClient.get 'https://maps.googleapis.com/maps/api/directions/json?origin=Sapporo Clock Tower&destination=Sapporo Factory  &waypoints=optimize:true|Tanukikoji |sapporo%20eki&key=AIzaSyAXtVr7N-nXnkMFXLdpYD2AzQLs4POSiqs'
    @routes_infos2=JSON.load(raw_routes_infos.to_str)["routes"][0]['legs']
 
    raw_data= RestClient.get 'https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20131024?applicationId=1013890697698086625&format=json&latitude=43.062&longitude=141.35&searchRadius=1&datumType=1&hits=1'
    @hotel_info = JSON.load(raw_data.to_str)["hotels"][0]['hotel'][0]['hotelBasicInfo']
  end
  
  private
  
  def randum_num(data_limit_num)
    rand(data_limit_num) + 1
  end
end