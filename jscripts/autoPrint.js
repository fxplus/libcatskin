/* 
 * This will automaticly open the print dialog for 
  * the current page, place in the body=onload
 */
 
 function printPage() {
 	window.print();
 }

  function getURL() {
	var url = window.location.toString();
	if(url.match("receipt")){
		return 'receipt';
	}
	else {
		return 'other';
	}
 }

 function getcss(cssfile){
	loadcss = document.createElement('link')
	loadcss.setAttribute("rel", "stylesheet")
	loadcss.setAttribute("type", "text/css")
	loadcss.setAttribute("href", cssfile)
	document.getElementsByTagName("head")[0].appendChild(loadcss)
 }
