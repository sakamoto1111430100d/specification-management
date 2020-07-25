$(function() {

  function documentEditForm(document) {
    var html =
    `
    <div class="document_edit_content">
      <form action="/documents/${document.id}/edit" method="get" id="document_edit_content">
        <div>
          <textarea name="note" id="document_edit__form" >${document.note}</textarea>
          <input type="hidden" name="item_id" value="${document.item_id}">
          <input type="hidden" name="company_id" value="${document.company_id}">
        </div>
        <div>
          <br>
            <input type="submit" value="登録" id="document_edit__submit" onclick="return confirm('登録してよろしいでしょうか？')" >
        </div>
    </div>
    `
    $(".document-content__note[data=" + document.id + "]").append(html);
  }

  $(".document-content__note--icon").on("click", function() {
    var id = $(this).attr('data');
    $(".document-content__note[data=" + id + "]").empty();
    $.ajax( {
      type: 'get',
      url: "/documents/edit_form",
      data: {id: id},
      dataType: 'json'
    })
    .done(function(document) {
      documentEditForm(document);
    })
    .fail(function() {
      console.log("失敗です");
      console.log("XMLHttpRequest : " + XMLHttpRequest.status);
      console.log("textStatus     : " + textStatus);
      console.log("errorThrown    : " + errorThrown.message);
    });
  });
})