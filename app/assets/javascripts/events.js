class Event {
  constructor(attributes) {
    this.id = attributes.id;
    this.name = attributes.name;
    this.imageUrl = attributes.image_url;
    this.startTime = new Date(attributes.start_time);
    this.endTime = new Date(attributes.end_time);
    this.venue = attributes.venue;
    this.acceptingApplications = (attributes.accepting_applications ? "Yes" : "No" )
    this.userCount = attributes.user_count;
    this.owner = new User(attributes.owner);
    this.description = attributes.description;
  }

  renderTR() {
    return Event.template(this);
  }
}

$(function(){
  Event.templateSource = $("#table-row-template").html();
  Event.template = Handlebars.compile(Event.templateSource);

  $("button#js-new-event").on('click', function() {
    $.get("/events/new", response => displayForm(response))
  })

  $.get("/current_user", function(data) {
    currentUser = data.id;
  })
})

function displayForm(form) {
  $("div#js-new-event-form").html(form);
  $("form#new_event").on('submit', function(e) {
    e.preventDefault();
    let form = $("form#new_event")
    let formData = new FormData(document.querySelector("form#new_event"));
    newEventSubmit(formData);
  });
}

function newEventSubmit(form) {
  $.ajax({
     url: "/events",
     type: 'POST',
     data: form,
     enctype: 'multipart/form-data',
     contentType: false,
     processData: false,
     success: (response) => updatePage(response),
     error: (response) => redisplayForm(response)
  });
}

function updatePage(response) {
  $("div#js-new-event-form").html("");

  let thisEvent = new Event(response);
  let newRow = thisEvent.renderTR();

  $("tbody>tr:first-child").after(newRow);

  attachStarListener(`img#star-${thisEvent.id}`);
}

function redisplayForm(response){
  $("div#js-new-event-form").html("");
  displayForm(response.responseText);
}
