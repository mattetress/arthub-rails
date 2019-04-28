function attachCommentListener(){
  $("form#new_comment").on('submit', function(e) {
    e.preventDefault();

    const $form = $(this)
    const formData = $form.serialize();
    $("textarea#comment_body").val("");
    const posting = $.post($(this).attr("action"), formData);

    posting.done(function(commentLi) {
      $("ul#js-new-comment").append(commentLi);
    })
  })
}
