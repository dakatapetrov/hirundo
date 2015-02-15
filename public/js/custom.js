var ajax_call = function() {
  $.getJSON("new.json", function(result){
    $.each(result, function(i, message){
      var span = "";
      if (message['follows']) {
        span = "<span class=\"glyphicon glyphicon-star\" aria-hidden=\"true\">";
      } else {
      }
      var divs = "<div class='panel panel-default spacer'><div class='panel-heading inline'><strong>" + span + "</span><a href=\"/user/profile/" + message['username'] + "\">" + message['username'] + "</a>:</strong><div class='right'>just now</div></div><div class='panel-body'>" + message['content'] + "<div class='right'><span class='glyphicon glyphicon-map-marker'> " + message['location'] + "</span></div></div></div>";
      $(".messages.container").prepend(divs);
    });
  });
};

var interval = 1000 * 30 * 1;

setInterval(ajax_call, interval);
