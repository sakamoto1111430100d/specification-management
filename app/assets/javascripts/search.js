$(function() {
  function appendCompany(keyword) {
    var individual_id = location.search.replace("?individual_id=", "")
    if ( keyword.company_id ) {
      var html = 
      `
      <div class="company-list">
          <div class="company-list__element">
          <a href="/individuals/${individual_id}/companies?company_id=${keyword.company_id}">
          ${keyword.company_name}
          ${keyword.company_office}
          </div>
      </div>
      `
      $(".create-content").append(html);
    } else {
      var html = 
      `
      <div class="company-list">
          <div class="company-list__element">
          <a href="/individuals/${individual_id}/items?item_id=${keyword.item_id}">
          ${keyword.item_code}
          ${keyword.item_name}
          </div>
      </div>
      `
      $(".create-content").append(html);
    }
    
  }
  function appendErrMsgHTML() {
    var html =
      `
      <div class="company-list">
          <div class="company-list__element">
            該当なし
          </div>
      </div>
      `
    $(".create-content").append(html)
  }

  function createContent() {
    var html =
    `
    <div class="create-content"></div>
    `
    $(".search-result-content").append(html)
  }

  function createMenue(individual) {
    var html =
    `
    <div class="menue-content__wrapper">
      <div class="menue-content__element">
        <a data-method="delete" href="/users/sign_out" id="menue-content__element">ログアウト</a>
      </div>
      <div class="menue-content__element">
        <a data-method="get" href="/individuals?individual_id=${individual.id}&id=1" id="menue-content__element">登録したもの</a>
      </div>
      <div class="menue-content__element">
        <a data-method="get" href="/individuals?individual_id=${individual.id}&id=2" id="menue-content__element">保管したもの</a>
      </div>
      <div class="menue-content__element", id="menue-content__userdata" data="${individual.id}">
        ユーザー情報の編集
      </div>
    </div>
    `
    $(".menue-content").append(html)
  }

  function createIndividualEdit(individual) {
    var html =
    `
    <div class="individual_edit_form__content">
      <div class="individual_edit">
      <form action="/individuals/${individual.id}/edit" method="get">
        <div class="individual_edit__element">
        会社名：
          <input type="text" name="company" value="${individual.company}" class="individual_edit__form" >
        </div>
        <div class="individual_edit__element">
        事業所名：
          <input type="text" name="office" value="${individual.office}" class="individual_edit__form" >
        </div>
        <div class="individual_edit__element">
        部署名：
          <input type="text" name="department" value="${individual.department}" class="individual_edit__form" >
        </div>
        <div class="individual_edit__element">
        氏名：
          <input type="text" name="name" value="${individual.name}" class="individual_edit__form" required>
        </div>
        <div class="individual_edit__submit">
          <input type="submit" value="登録" id="individual_edit__submit" onclick="return confirm('登録してよろしいでしょうか？')" >
        </div>
      </div>
    </div>
    `
    $(".individual_edit_form").append(html)
  }
  timer = null
  $("#keyword").on("keyup", function(e) {
    e.preventDefault();
    var individual_id = $(this).parent().attr('individual_id');
    var path = "/individuals/" + individual_id + "/searches/search"

    if ( timer !== null ) { clearTimeout(timer); };
    timer = setTimeout(function(){
      $(".create-content").remove();
    },5000);

    $(".create-content").remove();
    createContent();
    var input = $(".search-input").val();
    $.ajax( {
      type: 'get',
      url: path,
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(keywords) {
      $(".create-content").empty();
      if (keywords.length !== 0 ) {
        keywords.forEach(function(keyword) {
          appendCompany(keyword);
        });
      }else if (input.length == 0) {
        return false;
      } else {
        appendErrMsgHTML();
      }
    })
    .fail(function() {
      console.log("失敗です");
      console.log("XMLHttpRequest : " + XMLHttpRequest.status);
      console.log("textStatus     : " + textStatus);
      console.log("errorThrown    : " + errorThrown.message);
    });
  });
  $(document).on("click", ".header__bars_icon", function() {
    if ( $(".menue-content__wrapper").length) {
      $(".menue-content__wrapper").remove();
      $(".individual_edit_form__content").remove();
    } else {
      var id = $(this).attr('data');
      var path = "/individuals/" + id + "/searches/menue_list"
      $.ajax({
        type: 'get',
        url: path,
        data: {id: id},
        dataType: 'json'
      })
      .done(function(individual) {
        createMenue(individual);
      })
    }
  });
  $(document).on("click", "#menue-content__userdata", function() {
    if ($(".individual_edit_form__content").length) {
      $(".individual_edit_form__content").remove();
    } else {
      var id = $(this).attr('data');
      $.ajax({
        type: 'get',
        url: "/individuals/edit_form",
        data: {id: id},
        dataType: 'json'
      })
      .done(function(individual) {
        createIndividualEdit(individual);
      })
      .fail(function() {
        console.log("失敗です");
        console.log("XMLHttpRequest : " + XMLHttpRequest.status);
        console.log("textStatus     : " + textStatus);
        console.log("errorThrown    : " + errorThrown.message);
      });
    }
  });
});