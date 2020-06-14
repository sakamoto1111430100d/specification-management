$(function() {

  function appendCompany(keyword) {
    if ( keyword.company_id ) {
      var html = 
      `
      <div class="company-list">
          <div class="company-list__element">
          <a href="/users/${keyword.user_id}/companies?company_id=${keyword.company_id}">
          ${keyword.company_name}
          ${keyword.company_office}
          </div>
      </div>
      `
      $("#search-result").append(html);
    } else {
      var html = 
      `
      <div class="company-list">
          <div class="company-list__element">
          <a href="/users/${keyword.user_id}/items?items_id=${keyword.item_id}">
          ${keyword.item_code}
          ${keyword.item_name}
          </div>
      </div>
      `
      $("#search-result").append(html);
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
    $("#search-result").append(html)
  }


  $("#search-form_id").on("keyup", function(e) {
    e.preventDefault();
    console.log(this);
    var input = $(".search-input").val();
    var url = $(this).attr('action')
    $.ajax( {
      type: 'get',
      url: url,
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(keywords) {
      $("#search-result").empty();
      console.log("成功です");
      if (keywords.length !== 0 ) {
        keywords.forEach(function(keyword) {
          console.log(keyword);
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
});