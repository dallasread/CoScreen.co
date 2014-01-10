CoScreen =
	
	prompter:
		"""
			<div style="background: blue; color: yellow; ">
				Aweosme
			</div>
		"""
	
	statusBar: 
		"""
			<div id="coscreen_status_bar">
				awesome bar
			</div>
		"""
	
	init: ->
		CoScreen.append CoScreen.prompter
		CoScreen.append CoScreen.statusBar
		CoScreen.addStyles()
	
	addStyles: ->
		ss = document.createElement("link")
		ss.setAttribute "rel", "stylesheet"
		ss.setAttribute "type", "text/css"
		ss.setAttribute "href", "http://localhost:8888/new_eo/wp-content/plugins/coscreen/CoScreen.co/tmp/CoScreen-0.0.1.css"
		document.getElementsByTagName("head")[0].appendChild ss
	
	append: (string, parent) ->
		div = document.createElement("div")
		div.innerHTML = string
		document.querySelector(parent or "body").appendChild div.firstChild
		

CoScreen.init()