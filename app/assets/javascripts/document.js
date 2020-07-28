$(function() {
  var cancelFlag = 0;
  function documentEditForm(document) {
    var individual_id = location.pathname.replace("/documents", "");
    var html =
    `
    <div class="document_edit_content">
      <form action="${individual_id}/documents/${document.id}/edit" method="get" id="document_edit_content">
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

  function StockedIcon(document) {
    var html =
    `
    <div class="stocked_icon">
    <i class="fas fa-bookmark">&nbsp;済み</i>
    </div>
    `
    $(".stock_btn[document_id=" + document.id + "]").append(html);
  }

  function NoneStockIcon(document) {
    var html =
    `
    <div class="none_stock_icon">
    <i class="fas fa-bookmark">&nbsp;保存</i>
    </div>
    `
    $(".stock_btn[document_id=" + document.id + "]").append(html);
  }

  $(".document-content__note--icon").on("click", function() {
    var id = $(this).attr('data');
    var pathname = location.pathname
    var path = pathname + "/edit_form"
    $(".document-content__note[data=" + id + "]").empty();
    $.ajax( {
      type: 'get',
      url: path,
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
  $(document).on("click", ".none_stock_icon", function() {
    if( cancelFlag == 0 ){
        cancelFlag = 1; 
      var document_id = $(this).parent().attr('document_id');
      var individual_id = $(this).parent().attr('individual_id');
      $.ajax( {
        type: 'post',
        url: '/stocks',
        data: {document_id: document_id, individual_id: individual_id},
        dataType: 'json'
      })
      .done(function(document) {
        $(".stock_btn[document_id=" + document.id + "]").empty();
        StockedIcon(document);
        cancelFlag = 0;
      });
    }
  });
  $(document).on("click", ".stocked_icon", function() {
    if( cancelFlag == 0 ){
        cancelFlag = 1; 
      var document_id = $(this).parent().attr('document_id');
      var individual_id = $(this).parent().attr('individual_id');
      $.ajax( {
        type: 'delete',
        url: '/stocks',
        data: {document_id: document_id, individual_id: individual_id},
        dataType: 'json'
      })
      .done(function(document) {
        $(".stock_btn[document_id=" + document.id + "]").empty();
        NoneStockIcon(document);
        cancelFlag = 0;
      });
    }
  });
});