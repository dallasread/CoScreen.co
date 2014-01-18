@CoScreen ||= {}
CoScreen.resize =
	frequency: 500

	check: ->
		setTimeout ->
			now = new Date().getTime()
			
			if CoScreen.lastResize + CoScreen.resize.frequency < now
				width = $(window).width()
				CoScreen.mice[CoScreen.me].width = width
				CoScreen.mice[CoScreen.me].height = $(window).height()
				CoScreen.pubnub.publish
					channel: "#{CoScreen.roomToken}-resize"
					message: 
						mouse: CoScreen.mice[CoScreen.me]
			else
				CoScreen.resize.check()
		, CoScreen.resize.frequency
	
	events: ->
		CoScreen.pubnub.subscribe
			channel: "#{CoScreen.roomToken}-resize"
			message: (data) ->
				width = data.mouse.width
				CoScreen.$("body").animate
					width: width
				, CoScreen.resize.frequency