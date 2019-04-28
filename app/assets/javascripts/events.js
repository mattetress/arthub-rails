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
    this.description = attributes.description;
    this.createdAt = new Date(attributes.created_at);
    this.users = attributes.users;
    this.city = attributes.city.name;
    this.area = attributs.area;
    this.comments = attributes.comments;
  }

  renderTR() {
    return Event.template(this);
  }

  eventButtons() {
    let buttons = "";

    if (this.owner.id === currentUser) {
      buttons += `<a class="btn btn-primary btn-sm" role="button" href="/events/${this.id}/edit">Edit Event</a> <a class="btn btn-secondary btn-sm" role="button" rel="nofollow" data-method="delete" href="/events/${this.id}">Delete Event</a>`
    }

    if (this.users.some(user => user.id === currentUser)) {
      buttons += `<img class="star" id="star-${this.id}" data-id="${this.id}" data-state="1" src="/assets/star32.png" />`
    } else {
      buttons += `<img class="star" id="star-${this.id}" data-id="${this.id}" data-state="0" src="/assets/star-blank32.png" />`
    }

    return buttons;
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
