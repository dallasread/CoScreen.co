@CoScreen ||= {}
CoScreen.rooms =
	createToken: (length) ->
	  text = ""
	  # charset = "abcdefghjkmnpqrstuvwxyz23456789"
	  charset = "0123456789"
	  i = 0

	  while i < length
	    text += charset.charAt(Math.floor(Math.random() * charset.length))
	    i++
	  text
		
	leave: ->
		$.removeCookie "coscreen_room", { path: "/" }
		$.removeCookie "coscreen_mouse", { path: "/" }
		CoScreen.$("#coscreen_prompter").show()
		CoScreen.$("#coscreen_status_bar").hide()
	
	connect: (roomToken = false) ->
		$.cookie("coscreen_mouse", CoScreen.rooms.createToken(32)) unless $.cookie("coscreen_mouse")
		CoScreen.roomToken = if roomToken then roomToken else CoScreen.rooms.createToken(5)
		CoScreen.me = $.cookie("coscreen_mouse")
		
		CoScreen.lastResize = 0
		CoScreen.mice = {}
		CoScreen.mice[CoScreen.me] =
			id: CoScreen.me
			lastX: 0
			lastY: 0
		
		room_is_empty = true
		on_page_of_room = true

		if room_is_empty && on_page_of_room
			$.cookie "coscreen_room", CoScreen.roomToken, { expires: 1, path: "/" }
			CoScreen.$("#coscreen_room_token").text CoScreen.roomToken
			
			CoScreen.$("#coscreen_activation_code_form")[0].reset()
			CoScreen.$("#coscreen_prompter").hide()
			CoScreen.$("#coscreen_status_bar").show()
			
			CoScreen.pubnub = PUBNUB.init
				publish_key: "pub-c-3e82a6cf-6787-4947-9871-7db14af20db5"
				subscribe_key: "sub-c-e68492c6-54ca-11e3-b2ab-02ee2ddab7fe"
			
			CoScreen.mousemove.events()
			CoScreen.click.events()
			CoScreen.resize.events()
			CoScreen.keyup.events()

		else if !room_is_empty
			alert "This room is already occupied."
		else if !on_page_of_room
			alert "You're on the wrong page."
		
		CoScreen.$(window).resize ->
			now = new Date().getTime()

			if CoScreen.lastResize + CoScreen.resize.frequency < now
				CoScreen.lastResize = now
				CoScreen.resize.check()
		
		CoScreen.$(window).trigger "resize"