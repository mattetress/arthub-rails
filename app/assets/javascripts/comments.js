$(function() {
  $("form#new_comment").on('submit', function(e) {
    e.preventDefault();
    $("textarea#comment_body").val("");
    const $form = $(this)
    const formData = $form.serialize();
    const posting = $.post($(this).attr("action"), formData);

    posting.done(function(commentLi) {
      $("ul#js-new-comment").append(commentLi);
    })
  })
})
