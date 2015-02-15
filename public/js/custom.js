var ajax_call = function() {
  $.getJSON("new.json", function(result){
    $.each(result, function(i, message){
      $(".messages.container").prepend(message['content'] + '<br />');
    });
  });
};

var interval = 1000 * 30 * 1;

setInterval(ajax_call, interval);
