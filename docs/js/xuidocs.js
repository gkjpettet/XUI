// Vanilla javascript mechanism to determine if the DOM is ready.
function docReady(fn) {
	if (document.readyState === "complete" || document.readyState === "interactive") {
		// Call on next available tick.
		setTimeout(fn, 1);
	} else {
		document.addEventListener("DOMContentLoaded", fn);
	}
}

// DOM is loaded and ready for manipulation here
docReady(function() {

// mkdocs automatically adds a <h1>Home<h1> heading to the top of the root page. Let's hide that.
if (location.pathname == "/") {
	document.getElementsByTagName("h1")[0].style.display = "none";
	//                                  ^ index 0 for the first h1.
}
	
});
