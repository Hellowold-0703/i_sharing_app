$(function() {

  var search_list = $(".place__all__pictures");

  function appendPlace(place) {
    if (place.user_id == place.user.id) {
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
                        <a href="/places/45"><img src="${place.image.url}">
                        </a>
                      </div>
                      <div class="place__list__item__address">
                        <span>
                        ${place.address}
                        </span>
                        <div class="place__list__link">
                          <a href="/places/${place.id}/edit">
                            <i class="far fa-edit"></i>
                          </a>
                          <a data-confirm="削除してよろしいですか?" rel="nofollow" data-method="delete" href="/places/${place.id}">
                            <i class="far fa-trash-alt"></i>
                          </a>
                        </div>
                          <i class="far fa-heart">
                            <span class="fade-in-down">
                            ${place.likes_count}
                            </span>
                              </i>
                            </a>
                          </div>
                        </div>
                      </div>
                    </div>`
  }else {
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
                      <a href="/places/45"><img src="${place.image.url}">
                      </a>
                    </div>
                    <div class="place__list__item__address">
                      <span>
                      ${place.address}
                      </span>
                        <i class="far fa-heart">
                          <span class="fade-in-down">
                          ${place.likes_count}
                          </span>
                        </i>
                    </div>
                  </div>
                </div>`
  }
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