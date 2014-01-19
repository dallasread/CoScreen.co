@CoScreen ||= {}
CoScreen.general =
	events: ->
		CoScreen.$(document).on "click", ".coscreen_show_activate", ->
			CoScreen.$("#coscreen_prompter").toggleClass "coscreen_open"
			false

		CoScreen.$(document).on "click", "#coscreen_already_have", ->
			CoScreen.$("#coscreen_activation_code_form").toggle()
			CoScreen.$("#coscreen_activation_code_form input:first").focus()
			false

		CoScreen.$(document).on "click", "#coscreen_start", ->
			CoScreen.rooms.connect()
			false

		CoScreen.$(document).on "submit", "#coscreen_activation_code_form", ->
			room = CoScreen.$("#coscreen_activation_code").val()
			CoScreen.rooms.connect room
			false

		CoScreen.$(document).on "click", "#coscreen_leave_room", ->
			CoScreen.rooms.leave()
			false