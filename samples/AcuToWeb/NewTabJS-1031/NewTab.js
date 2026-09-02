var internval = setInterval(function () {
	// Select by jQuery a first frame container
	var firstButton = $("#OPEN-JS");
	if (firstButton.length > 0) {
		clearInterval(internval);
		// Do something
		document.getElementById('OPEN-JS').onclick = function() {
			var URL = document.getElementById("WS-URL").textContent;
			window.open(URL);
		}
	}
});


