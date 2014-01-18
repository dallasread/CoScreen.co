@CoScreen ||= {}
CoScreen.mousemove =
	frequency: 200

	publish: (freq) ->
		freq = if freq then freq else CoScreen.mousemove.frequency
		setTimeout ->
			if CoScreen.mice[CoScreen.me].x isnt CoScreen.mice[CoScreen.me].lastX or CoScreen.mice[CoScreen.me].y isnt CoScreen.mice[CoScreen.me].lastY
				CoScreen.mice[CoScreen.me].lastX = CoScreen.mice[CoScreen.me].x
				CoScreen.mice[CoScreen.me].lastY = CoScreen.mice[CoScreen.me].x
				CoScreen.pubnub.publish
					channel: "#{CoScreen.roomToken}-mousemove"
					message:
						mouse: CoScreen.mice[CoScreen.me]
			CoScreen.mousemove.publish()
		, freq
	
	events: ->
		CoScreen.mousemove.publish 0
		
		CoScreen.$(document).on "mousemove", (e) ->
			e = e || window.event
			CoScreen.mice[CoScreen.me].x = e.pageX || e.clientX
			CoScreen.mice[CoScreen.me].y = e.pageY || e.clientY

		CoScreen.pubnub.subscribe
			channel: "#{CoScreen.roomToken}-mousemove"
			message: (data) ->
				m = data.mouse
				if m.id != CoScreen.me
					scrolled = $(document).scrollTop()
					pointer = $("#coscreen_pointer_#{m.id}")

					unless pointer.length
						pointer = $("<div>").addClass("coscreen_remote_pointer").attr("id", "coscreen_pointer_#{m.id}")
						pointer.appendTo("body")

					pointer.css
						left: m.x
						top: m.y

					if m.y > CoScreen.mice[CoScreen.me].height + scrolled
						$("#coscreen_scroll_down").show()
						$("#coscreen_scroll_up").hide()
					else if m.y + 10 < scrolled
						$("#coscreen_scroll_up").show()
						$("#coscreen_scroll_down").hide()
					else
						$("#coscreen_scroll_up, #coscreen_scroll_down").hide()