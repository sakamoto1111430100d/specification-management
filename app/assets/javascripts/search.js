$(function() {

  function appendCompany(keyword) {
    if ( keyword.company_id ) {
      var html = 
      `
      <div class="company-list">
          <div class="company-list__element">
          <a href="/companies?company_id=${keyword.company_id}">
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
          <a href="/items?items_id=${keyword.item_id}">
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


  $("#keyword").on("keyup", function(e) {
    e.preventDefault();
    var input = $(".search-input").val();
    $.ajax( {
      type: 'get',
      url: '/searches/search',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(keywords) {
      $("#search-result").empty();
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
});