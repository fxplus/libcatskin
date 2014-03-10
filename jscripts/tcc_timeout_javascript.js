/****************************************************************************
 * Timeout Script
*****************************************************************************/
function tcc_display_timeout(msg) {
	//if(msg==null || msg=='' || msg=='undefined') msg='Your session will end soon.';
	seconds = seconds > 0 ? seconds-1 : 0;
	msg = "Your session will end in " + seconds + " seconds.";
	document.getElementById('tcc_timeout_message').innerHTML=msg;
	document.getElementById('tcc_timeout_container').style.display='inline';
	setTimeout("tcc_display_timeout()",1000);
}

/*****************************************************************************
*	Drag and Drop
*****************************************************************************/
var tccDrag = {
	object : null,

	init : function(baseElement, handle, startX, startY) {
		handle.onmousedown = tccDrag.start;
		handle.base = baseElement;
		
		handle.base.style.left = startX ? startX : '0px';
		handle.base.style.top  = startY ? startY : '0px';
		
		handle.base.doDragStart = new Function();
		handle.base.doDragEnd   = new Function();
		handle.base.doDrag      = new Function();
	},

	start : function(event) {
		tccDrag.object = this;
		event = tccDrag.getEvent(event);
		var x = parseInt(tccDrag.object.base.style.left);
		var y = parseInt(tccDrag.object.base.style.top);
		tccDrag.object.base.doDragStart(x, y);

		tccDrag.object.lastMouseX = event.clientX;
		tccDrag.object.lastMouseY = event.clientY;

		document.onmousemove = tccDrag.drag;
		document.onmouseup   = tccDrag.end;

		return false;
	},

	drag : function(event) {
		event = tccDrag.getEvent(event);

		var mouseY = event.clientY;
		var mouseX = event.clientX;
		var x = parseInt(tccDrag.object.base.style.left);
		var y = parseInt(tccDrag.object.base.style.top);
		var deltaX = x + (mouseX - tccDrag.object.lastMouseX);
		var deltaY = y + (mouseY - tccDrag.object.lastMouseY);

		tccDrag.object.base.style["left"] = deltaX + "px";
		tccDrag.object.base.style["top"]  = deltaY + "px";
		tccDrag.object.lastMouseX = mouseX;
		tccDrag.object.lastMouseY = mouseY;

		tccDrag.object.base.doDrag(deltaX, deltaY);
		return false;
	},

	end : function() {
		document.onmousemove = null;
		document.onmouseup   = null;
		var x = parseInt(tccDrag.object.base.style["left"]);
		var y = parseInt(tccDrag.object.base.style["top"]);
		tccDrag.object.base.doDragEnd(x,y);
		tccDrag.object = null;
	},

	getEvent : function(event) {
		if (typeof event == 'undefined') event = window.event;
		if (typeof event.layerX == 'undefined') event.layerX = event.offsetX;
		if (typeof event.layerY == 'undefined') event.layerY = event.offsetY;
		return event;
	}
};