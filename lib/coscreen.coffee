CoScreenInit = ->
	unless window.CoScreenInit
		if typeof jQuery is "undefined" or (typeof jQuery isnt "undefined" and not (/[1-9]\.(9|10)\.[1-9]/.test(jQuery.fn.jquery)))
			headTag = document.getElementsByTagName("head")[0]
			jqTag = document.createElement("script")
			jqTag.type = "text/javascript"
			jqTag.src = "//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"
			jqTag.onload = CoScreenInit
			headTag.appendChild jqTag
		else
			window.CoScreenInit = true
			@CoScreen ||= {}
			CoScreen.$ = jQuery.noConflict()
			CoScreen.init()

CoScreenInit()