$(function(){
  $(".place__details__images-thumbnails img").click(function(){
    var $thisImg = $(this).attr("src");
    var $thisAlt = $(this).attr("alt")
    $(".place__details__images-main img").attr({src:$thisImg,alt:$thisAlt});
  });
});