// var getMyCurrentLocation = function() {

// 	if(!!navigator.geolocation) {
	
// 		navigator.geolocation.getCurrentPosition(function(position) {
		
//     		var geolocate = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    		
//     		var current_lat = document.getElementsByClass('get_location_lat');
//     		var current_long = document.getElementsByClass('get_location_long');
//     		current_lat.innerHTML(position.coords.latitude);
//     	    current_long.innerHTML(position.coords.longitude);    		
    		
// 		});
		
// 	} else {
// 		document.getElementsByClass('google_canvas').innerHTML = 'No Geolocation Support.';
// 	}
	
// };

$(document).ready(function() {
	var current_lat = $('#get_location_lat');
	var current_long = $('#get_location_long');

	var getMyCurrentLocation = function(){
		if(!!navigator.geolocation) {
		
			navigator.geolocation.getCurrentPosition(function(position) {
			
	    		var geolocate = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
	    		
	    		current_lat.text(position.coords.latitude);
	    	    current_long.text(position.coords.longitude);  		
			});	
		}
		
	};

	$('#search_bar').on('click', '#get_my_current_location', getMyCurrentLocation);
		var commentSubmit = function(){
		var $target = $(event.target),
	  		formData = $('#comment_form').serialize();

		$.ajax({
		    url: $target.attr('action'),
		    type: 'POST',
		    dataType: 'JSON',
		    data: formData
		  }).done(function(response){
		  	console.log('success');
		    var new_comment = $('.comments_section .col-md-6');
		    new_comment.append('<div class="container-fluid"><div class="row"><b>' +
		    response.screen_name + '</b><div class="row">' + response.content + '</div></div>');
		  })
		  .fail(function(response){
		  	console.log('fail');
		  });
	};

	$('#comment_form').on('click', '#submit_comment', function(event){
	    event.preventDefault();
	    commentSubmit($(this));
	 });
});
