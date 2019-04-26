$(document).ready(function() {
  $("img.star").each(function(num, star) {
    attachStarListener(star);
  });
});

function attachStarListener(star) {
  $(star).on('click', function(){
    toggleInterest(star);
  })

  $(star).hover(function (){
    toggleStarImage(star);
    toggleState(star);
  }, () => {
    toggleStarImage(star);
    toggleState(star);
  })
}

function toggleInterest(star) {
  const id = parseInt($(star).data("id"));
  const state = parseInt($(star).data("state"));
  $.get(`/events/${id}/toggle_interest`);
  if (state) {
    addUser(id);
  } else {
    removeUser(id);
  }
  toggleState(star);
}

function toggleStarImage(star) {
  const state = parseInt($(star).data("state"));
  if (state) {
    $(star).attr('src', '/assets/star-blank32.png');
  } else {
    $(star).attr("src", '/assets/star32.png');
  }
}

function toggleState(star) {
  const state = parseInt($(star).data("state"));
  if (state) {
    $(star).data("state", "0");
  } else {
    $(star).data("state", "1");
  }
}

function removeUser(eventId) {
  const element = $(`td#js-user-count-${eventId}`);
  let count = parseInt(element.text())
  element.text(`${count - 1}`)
}

function addUser(eventId) {
  const element = $(`td#js-user-count-${eventId}`);
  let count = parseInt(element.text())
  element.text(`${count + 1}`)
}
