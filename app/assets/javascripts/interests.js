$(document).ready(function() {
  $("img.star").each(function(num, star) {
    attachStarListener(star);
  });
});

function attachStarListener(star) {
  $(star).on('click', function(){
    toggleInterest(star);
  })
}

function toggleInterest(star) {
  const id = parseInt($(star).data("id"));
  const state = parseInt($(star).data("state"));
  $.get(`/events/${id}/toggle_interest`);
  toggleStarImage(star, state);
}

function toggleStarImage(star, state) {
  if (state) {
    $(star).attr('src', '/assets/star-blank32.png');
    $(star).data("state", "0");
  } else {
    $(star).attr("src", '/assets/star32.png');
    $(star).data("state", "1");
  }
}
