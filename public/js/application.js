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

	$('#search_bar').on('click', '#get_my_current_location', getMyCurrentLocation());

	
	// var formData = 
	// {"coordinate":[
	//     {
	//     	"latitude": current_lat.val(), 
	//         "longitude": current_long.val()
	//     }
	// ]}

	// $.ajax({
	// 	url: '/',
	// 	type: 'GET',
	// 	dataType: 'JSON',
	// 	data: formData
	// }).done(function(response){
	// 	console.log(success);
	// });
});
