

function attachEventsListener() {
  $(".js-events-index-link").on('click', function(e) {
    e.preventDefault();
    loadEvents();
  })
}

function loadEvents() {
  $.get('/events', response => displayEvents(response));
}

function displayEvents(response) {
  let html = Event.renderEvents(response);
  $("div#js-container").html(html);
  attachListeners();
}
