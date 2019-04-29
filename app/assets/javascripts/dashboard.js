

function attachEventsListener() {
  $(".js-events-index-link").on('click', function(e) {
    e.preventDefault();
    loadEvents('upcoming');
  })

  $("button#js-past-events").on('click', () => loadEvents('past'));
}

function loadEvents(timeFrame) {
  $.get('/events/' + timeFrame, response => displayEvents(response, timeFrame));
}

function displayEvents(response, timeFrame) {
  let html = Event.renderEvents(response, timeFrame);
  $("div#js-container").html(html);
  attachListeners();
}
