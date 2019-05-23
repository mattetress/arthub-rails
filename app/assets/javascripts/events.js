class Event {
  constructor(attributes) {
    this.id = attributes.id;
    this.name = attributes.name;
    this.imageUrl = attributes.image_url;
    this.imageUrl400 = attributes.image_url_400;
    this.imageUrlFull = attributes.image_url_full;
    this.startTime = new Date(attributes.start_time);
    this.endTime = new Date(attributes.end_time);
    this.venue = attributes.venue;
    this.acceptingApplications = (attributes.accepting_applications ? "Yes" : "No" )
    this.userCount = attributes.user_count;
    this.owner = new User(attributes.owner);
    this.description = attributes.description.replace(/\n/g,"<br>");
    this.createdAt = new Date(attributes.created_at);
    this.users = attributes.users;
    this.city = attributes.city.name;
    this.area = attributes.area;
    this.comments = attributes.comments;

    Handlebars.registerHelper("hbEventButtons", () => this.renderEventButtons());
    Handlebars.registerHelper("hbListComments", () => this.listComments());
    Handlebars.registerHelper("star", () => this.renderStar());


  }

  renderTR() {
    return Event.template(this);
  }

  renderEventButtons() {
    let buttons = "";

    if (this.owner.id === currentUser) {
      buttons += `<a class="btn btn-primary btn-sm" role="button" href="/events/${this.id}/edit">Edit Event</a> <a class="btn btn-secondary btn-sm" role="button" rel="nofollow" data-method="delete" href="/events/${this.id}">Delete Event</a>`
    }

    buttons += this.renderStar();

    return buttons;
  }

  renderStar() {
    if (this.users.some(user => user.id === currentUser)) {
      return `<img class="star" id="star-${this.id}" data-id="${this.id}" data-state="1" src="/star32.png" />`
    } else {
      return `<img class="star" id="star-${this.id}" data-id="${this.id}" data-state="0" src="/star-blank32.png" />`
    }
  }

  renderEvent() {
    return Event.showTemplate(this);
  }

  listComments() {
    let ul = "";
    ul += `<ul id="js-new-comment" class="list-unstyled">`;

    this.comments.forEach(function(comment) {
      ul += `<li class="media mt-5">
        <a href="/users/${comment.user_id}"><img class="mr-3 rounded-lg" src="${comment.user_avatar}" /></a>

        <div class="media-body">
          <span class="comment-head"><a href="/users/${comment.user_id}">${comment.user_name}</a> </span>
          <small>${new Date(comment.created_at)}</small><br>
          ${comment.body} <br>`

      if (currentUser === comment.user_id) {
        ul += `<a href="/events/${comment.event_id}/comments/${comment.id}/edit">Edit</a> <a rel="nofollow" data-method="delete" href="/events/${comment.event_id}/comments/${comment.id}">Delete</a>`
      }
      ul += '</div>'
    })
    ul += '</li></ul>'

    return ul;
  }

  static renderEvents(response, timeFrame) {
    let html =
      `<div class="bg-white fill p-5">
        <h1>${capitalize(timeFrame)} Events</h1>
        <div id="event_buttons">
          <button name="button" type="button" class="btn btn-outline-primary" id="js-new-event">New Event</button>
          <button name="button" type="button" class="btn btn-outline-secondary" id="js-past-events">Past Events</button>
        </div>
          <div class="row">
            <div class=""></div>
            <div class="col-12">
              <div id="js-new-event-form"></div>
            </div>
            <div class=""></div>
          </div>
        
        <table class="table">
          <tr>
            <th>Interested</th>
            <th>Image</th>
            <th>Event Title</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Venue</th>
            <th>Accepting Applications</th>
            <th>Users Interested:</th>
          </tr>`

    response.forEach(function(data) {
      const thisEvent = new Event(data);
      html += thisEvent.renderTR();
    });

    html += "</table></div>"

    return html;
  }

}

function attachEventLinkListener() {
  $("a.js-event-link").on('click', function(e) {
    e.preventDefault();

    $.get((e.target + ".json"), response => displayEvent(response));
  })
}

Handlebars.registerHelper("hbRenderEvents", () => {
  thisEvent = new Event(this);
  thisEvent.renderTr();
});

function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}


function attachEventFormListener() {
  $("button#js-new-event").on('click', function() {
    $.get("/events/new", response => displayForm(response))
  })
}

$(function(){
  $.get("/current_user", function(data) {
    currentUser = data.id;
  })
})

function displayEvent(response) {
  const thisEvent = new Event(response);
  const html = thisEvent.renderEvent();

  $("div#js-container").html(html);
  attachListeners();
}

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

  attachListeners();
}

function redisplayForm(response){
  $("div#js-new-event-form").html("");
  displayForm(response.responseText);
}
