/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2009 Tarrant County College
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: spellcheck js
**          Version : 2.4.7
**          Created : 27-AUG-2008
**      Orig Author : Jim Robinson
**    Last Modified : 18-FEB-2010
** Last Modified By : Jim Robinson
*/

var httpRequest = null;
//////////////////////////////////////////////////////////////////////

function spellcheck() {
	if(document.getElementById && document.getElementById("spellcheck_message")) {
		document.getElementById("spellcheck_message").innerHTML = "<br/>Searching for suggestions...";
	}
			
	var params = parseQueryString();
	var searchArg = "";
	searchArg += params["searchArg"]!=null?params["searchArg"]:"";
	searchArg += params["text"]!=null?params["text"]:"";
	
	for(var i=1;i<=3; i++) {
		var paramName = "searchArg"+i;
		if(params[paramName]!=null) {
			if(searchArg != "") searchArg += "+";
			searchArg += params[paramName];
		}
	}
	searchArg = encodeURIComponent ? encodeURIComponent(searchArg) : escape(searchArg);
	searchArg = searchArg.toLowerCase(); // Jazzy ignores uppercase words
	var url = "/spellcheck/spellcheck?searchArg=";
	var send = url + searchArg;
	
	httpRequest = createXMLHttpRequest();
	if (httpRequest != null) {
		if (httpRequest.overrideMimeType) {
			httpRequest.overrideMimeType('text/xml');
		}
		httpRequest.open("GET", send, true);
		httpRequest.onreadystatechange = parseXML;
		httpRequest.send(null);
	}
}

//////////////////////////////////////////////////////////////////////

function parseXML() {
	if(httpRequest.readyState == 4) {
		if(httpRequest.status == 200) {
			
			/**************************** Get XML Data ***************************/
			var xmldoc = httpRequest.responseXML;
			var words = xmldoc.getElementsByTagName("word");
			var suggestionDisplay = "";
			var suggestions = new Array();
			for(var i=0; i<words.length; i++) {
				var word=words[i].getAttribute("text");
				if(suggestionDisplay != "") suggestionDisplay += " ";
				suggestion = words[i].getElementsByTagName("suggestion")[0] ? words[i].getElementsByTagName("suggestion")[0].childNodes[0].nodeValue : null;
				if(suggestion != null && suggestion !='') {
					suggestionDisplay += suggestion;
					suggestions.push(suggestion);
				} else {
					suggestionDisplay += word;
					suggestions.push(word);
				}
			}

			/****************************** Format URL ***************************/
			var response;
			if(suggestions.length > 0) {
				var pathname = window.location.pathname;
				//response = "<br/>Did you mean <a href='/vwebv/search?";
				response = "<br />Did you mean <a href='" + pathname + "?";
				
				/* 
				 * Loop through all query data and replace any searchArgs with 
				 * spelling suggestions, append all other parameters as-is
				 */
				var searchArgs = parseQueryString();
				for(var varName in searchArgs) {
					if(varName == "searchArg") {
						response += "searchArg=";
						response += suggestionDisplay!=null?escape(suggestionDisplay):"";
					} else if(varName == "searchArg1") {
						response += "searchArg1=";
						response += suggestions[0]!=null?escape(suggestions[0]):"";
					} else if(varName == "searchArg2") {
						response += "&searchArg2=";
						response += suggestions[1]!=null?escape(suggestions[1]):"";
					} else if(varName == "searchArg3") {
						response += "&searchArg3=";
						response += suggestions[2]!=null?escape(suggestions[2]):"";
					} else if(varName == "text") {
						response += "text=";
						response += suggestionDisplay!=null?suggestionDisplay.replace(/ /g,"+"):"";
					} else {
						response = response + "&" + varName + "=" + searchArgs[varName];	
					}
				}
				response = response + "'>"+suggestionDisplay+"</a>?";
			}
			
			/************************ Format Errors Message **********************/
			var error = xmldoc.getElementsByTagName("errors");
			var errors = "";
			for(var i=0;i<error.length;i++) {
				if(error[i].getElementsByTagName("error")) {
					if(errors != "") errors += " ";
					errors += error[i].getElementsByTagName("error")[0].childNodes[0].nodeValue;
				}
			}
			if(errors != "") {
				response += "<br/>" + errors;
			}
			
			/********************* If no suggestions or errors *******************/
			if(response == null || response == "") {
				response = "<br/>No alternate spellings found.";
			}
			
			/*************************** Print Results ***************************/
			if(document.getElementById && document.getElementById("spellcheck_message")) {
				document.getElementById("spellcheck_message").innerHTML = response;
			}
		} else {
			if(document.getElementById && document.getElementById("spellcheck_message")) {
				document.getElementById("spellcheck_message").innerHTML = "No alternate spellings found. Status:" + httpRequest.status;
			}
		}
	}
}

//////////////////////////////////////////////////////////////////////

function parseQueryString() {
	var paramArray = new Array();
	var query = decodeURIComponent ? decodeURIComponent(window.location.search.substring(1)) : unescape(window.location.search.substring(1));
	var pairs = query.split(/\&/);
	for(var i in pairs) {
		var varName = pairs[i].split(/\=/);
		paramArray[varName[0]] = varName[1];
	}
	return paramArray;
}

//////////////////////////////////////////////////////////////////////

function hide_spelling() {
	if(document.getElementById && document.getElementById("noHitsError")) {
		document.getElementById("noHitsError").style.visibility="hidden";
	}
}

//////////////////////////////////////////////////////////////////////