@CoScreen ||= {}
CoScreen.keyup =

	events: ->
		CoScreen.pubnub.subscribe
			channel: "#{CoScreen.roomToken}-form"
			message: (data) ->
				m = data.mouse
				if m.id != CoScreen.me
					$(data.path).val data.value
	
		CoScreen.$(document).on "keyup", "input, textarea, select", ->
			path = CoScreen.click.pathify $(this).getPath()
			CoScreen.pubnub.publish
				channel: "#{CoScreen.roomToken}-form"
				message:
					mouse: CoScreen.mice[CoScreen.me]
					path: path
					value: $(this).val()