@CoScreen ||= {}
CoScreen.click =
	
	pathify: (path) ->
		path = path.replace(/>/g, "")
		path = path.replace(/\.\./g, ".")
		path = path.replace(/\s+/g, " ")
		path = path.replace(/\.\s/g, " ")
		path
	
	events: ->
		CoScreen.$(document).on "click", "*", ->
			if CoScreen.sendClick
				path = CoScreen.click.pathify $(this).getPath()
			
				CoScreen.pubnub.publish
					channel: "#{CoScreen.roomToken}-click"
					message:
						mouse: CoScreen.mice[CoScreen.me]
						path: path
						
		CoScreen.pubnub.subscribe
			channel: "#{CoScreen.roomToken}-click"
			message: (data) ->
				m = data.mouse
				if m.id != CoScreen.me
					scrolled = $(document).scrollTop()
					pointer = $("#coscreen_pointer_#{m.id}")
					pointer.addClass "click"
					CoScreen.sendClick = false
					$(data.path).trigger "click"
					CoScreen.sendClick = true
					setTimeout ->
						pointer.removeClass "click"
					, 500
		