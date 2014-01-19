@CoScreen ||= {}

CoScreen.init = ->
	CoScreen.$("body").append CoScreen.html.prompter
	CoScreen.$("body").append CoScreen.html.statusBar
	CoScreen.addStyles()
	CoScreen.general.events()

CoScreen.addStyles = ->
	url = CoScreen.$("#cobrowser").data("stylesheet")
	url = "https://www.daljs.org/coscreen.min.css" if url == null
	ss = document.createElement("link")
	ss.setAttribute "id", "coscreen_stylesheet"
	ss.setAttribute "rel", "stylesheet"
	ss.setAttribute "type", "text/css"
	ss.setAttribute "href", url
	ss.onload = CoScreen.load
	document.getElementsByTagName("head")[0].appendChild ss
	
CoScreen.load = ->
	if typeof $.cookie("coscreen_room") == "undefined"
		CoScreen.$("#coscreen_prompter").show()
	else
		CoScreen.rooms.connect $.cookie("coscreen_room")