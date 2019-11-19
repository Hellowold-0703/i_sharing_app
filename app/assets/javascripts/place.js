$(document).on('turbolinks:load', function() {
  $(".place__details__images-thumbnails img").hover(function(){
    var $thisImg = $(this).attr("src");
    var $thisAlt = $(this).attr("alt")
    $(".place__details__images-main img").attr({src:$thisImg,alt:$thisAlt});
  });
});