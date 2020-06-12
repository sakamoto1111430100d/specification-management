$(function() {

  function appendCompany(company) {
    var html = 
      `
      <div class="company-list">
          <div class="company-list__element">
            ${company.name}
            ${company.office}
            ${ccompany.user.id}

          </div>
      </div>
      `
    $("#search-result").append(html)
  }
  function appendErrMsgHTML() {
    var html =
      `
      <div class="company-list">
          <div class="company-list__element">
            ユーザーが見つかりません
          </div>
      </div>
      `
    $("#search-result").append(html)
  }


  $("#search-form_id").on("submit", function(e) {
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
    .done(function(companies) {
      console.log("成功です");
      if (companies.length !== 0 ) {
        companies.forEach(function(company) {
          console.log(company);
          appendCompany(company);
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


// <%= link_to ${company.id}, user_companies_path(company_id: ${company.id}, user_id: ${current_user.id}, ), class: 'link' %>
//<a href="/users/:user_id/companies" id="idLnk">なにかのリンク</a>
