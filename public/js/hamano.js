
$(function(){
  $("lazy").lazyload();
  eventRegister();
});


function eventRegister(){
$('.lazy').click(function(){
    $(this).css('opacity', '0.5');
    // var position = $(this).position();
    var id = this.id;
    $('#'+id).append('<img src="../picture/check.png" class="check" width="60" height="60"/>')
    $.ajax(
      {
        type: 'GET',
        // リクエストURL
        url: '/wannago/register',
        // タイムアウト(ミリ秒)
        timeout: 10000,
        // キャッシュするかどうか
        cache: true,
        // サーバに送信するデータ(name: value)
        data: {
          'picture_id': this.id
        }
      }
    );
});
  
}




// もっと見る
$('.more_read').click(function(){
  var latest_id = $('.lazy').last().attr('id');
  console.log("最後のid="+latest_id);
  $.ajax(
      {
        type: 'GET',
        // リクエストURL
        url: '/hamano/more_read',
        // タイムアウト(ミリ秒)
        timeout: 10000,
        // キャッシュするかどうか
        cache: true,
        // サーバに送信するデータ(name: value)
        data: {
          'picture_id': latest_id
        }
      }
    ).success(function(data){
      
      $('.add_pic_tr').last().append(data);
      eventRegister();
    }
    );
    

});
