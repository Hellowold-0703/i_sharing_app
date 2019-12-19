$(function() {

  var search_list = $(".place__all__pictures");

  function appendPlace(place) {
    var html = `<div class="place__box">
                  <div class="place__list__item">
                    <div class="place__list__item__user">
                    ${place.user.name}
                    </div>
                    <div class="place__list__item__time">
                    ${place.created_at}
                    </div>
                  </div>
                    <div class="place__list__item__image">
                      <a href="/places/${place.id}"><img src="${place.image.url}">
                      </a>
                    </div>
                    <div class="place__list__item__address">
                    <span>
                    ${place.address}
                    </span>
                    <div class="likes_count">
                      <i class="far fa-heart">
                      ${place.likes_count}
                      </i>
                    </div>
                  </div>
                </div>`
    search_list.append(html);
  }

  function appendErrMsgToHTML(msg) {
    var html = `<div class="count">${msg}</div>`
    search_list.append(html);   
  }
  $(".search-input").on("keyup", function() {
    var input = $(".search-input").val();
    $.ajax({
      type: 'GET',
      url: '/places/all',
      data: {search: input},
      dataType: 'json'
    })
    .done(function(places) {
      search_list.empty();
      if (places.length !== 0) {
        places.forEach(function(place){
          appendPlace(place);
        });
      }
      else {
        appendErrMsgToHTML("一致するものはありません")
      }
    })
    .fail(function() {
      alert('error')
    });
  });
});