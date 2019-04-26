$(document).ready(function() {
  $("button#js-new-event").on('click', function(e) {
    $.get("/events/new", function(response) {
      displayForm(response);
    })
  })

  $.get("/current_user", function(data) {
    currentUser = data.id;
  })
})

$("button#js-new-event").on('click', function(e) {
  $.get("/events/new", function(response) {
    displayForm(response);
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
    console.log("FORM", form)
    console.log("FORM DATA", formData)
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
     success: function (response) {
       $("div#js-new-event-form").html("");
       updatePage(response);
       console.log('RESPONSE', response);
    },
    error: function(response) {
      redisplayForm(response)
    }
  });



  function updatePage(data) {
    let star = `<img src="/assets/star-blank32.png" class="star" id="star-${data.id}" data-id="${data.id}" data-state="0">`
    let image;
    if (data.image_url) {
      image = `<td><img src="${data.image_url}"></td>`
    } else {
      image = '<td></td>'
    }
    const startDate = new Date(data.start_time);
    const endDate = new Date(data.end_time);

    let newRow = '<tr>';
    newRow += `<td>${star}</td>`;
    newRow += image;
    newRow += `<td><a href="/events/${data.id}">${data.name}</a></td>`
    newRow += `<td>${startDate}</td>`
    newRow += `<td>${endDate}</td>`
    newRow += `<td>${data.venue}</td>`
    newRow += `<td>${data.accepting_applications ? "Yes" : "No" }</td>`
    newRow += `<td id="js-user-count-${data.id}">0</td></tr>`

    $("tbody>tr:first-child").after(newRow);
    attachStarListener(`img#star-${data.id}`);

  }

  function redisplayForm(response){
    $("div#js-new-event-form").html("");
    displayForm(response.responseText);
  }


}
