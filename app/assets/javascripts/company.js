$(function() {

  function companyEditForm(company) {
    var individual_id = location.pathname.replace("/companies", "");
    var html =
    `
    <div class="company_edit_content-name">
      <div class="edit_company">
        <form action="${individual_id}/companies/${company.id}/edit" method="get">
          <div class="company_edit_content__company">
            <div class="company_edit_content__company--wrapper">
              <div class="company_edit_content__element">
                会社名：
                <input type="text" name="name" value="${company.name}" id="company_edit__form" required>
              </div>
              <div class="company_edit_content__element">
                事業所（任意）：
                <input type="text" name="office" value="${company.office}" id="company_edit__form">
                <input type="hidden" name="company_id" value="${company.id}">
              </div>
            </div>
            <div class="company_edit_content__input">
              <input type="submit" value="登録" id="company_edit__submit" onclick="return confirm('登録してよろしいでしょうか？')" >
            </div>
          </div>
      </div>
    </div>
    `
    $(".company-main__name").append(html);
  }
  $(".company-main__name--edit").on("click", function() {
    var id = $(this).attr('data');
    var pathname = location.pathname.replace("/companies", "");
    var path = pathname + "/companies/edit_form"

    $.ajax({
      type: 'get',
      url: path,
      data: {id: id},
      dataType: 'json'
    })
    .done(function(company) {
      $(".company-main__name").empty()
      companyEditForm(company);
    })
    .fail(function() {
      console.log("失敗です");
      console.log("XMLHttpRequest : " + XMLHttpRequest.status);
      console.log("textStatus     : " + textStatus);
      console.log("errorThrown    : " + errorThrown.message);
    });
  });
});
