module.exports = (grunt) ->
	js_dependencies = ["dependencies/js/*.js"]
	js_lib = ["lib/*.coffee"]
	css_lib = ["assets/css/*.scss"]
	
	grunt.initConfig
		identifier: "<%= pkg.name %>-<%= version %>"
		tmpjspkg: "tmp/<%= identifier %>.js"
		version: "<%= pkg.version %>"
		pkg: grunt.file.readJSON "package.json"
		coffee:
			compile:
				files:
					"<%= tmpjspkg %>": js_lib
		concat:
			dist:
				src: js_dependencies.concat(["<%= tmpjspkg %>"])
				dest: "tmp/<%= identifier %>.js"
		sass:
			dist:
				src: css_lib
				dest: "tmp/<%= identifier %>.css"
		uglify:
			options:
				banner: "/*! <%= identifier %>.min.js <%= grunt.template.today(\"dd-mm-yyyy\") %> */\n"
			dist:
				files:
					"latest/<%= pkg.name %>.min.js": "<%= concat.dist.dest %>"
					"versions/js/<%= identifier %>.min.js": "<%= concat.dist.dest %>"
		cssmin:
			options:
				banner: "/* <%= identifier %>.min.css <%= grunt.template.today(\"dd-mm-yyyy\") %> */\n"
			dist:
				files:
					"latest/<%= pkg.name %>.min.css": "<%= sass.dist.dest %>"
					"versions/css/<%= identifier %>.min.css": "<%= sass.dist.dest %>"
		watch:
			files: js_dependencies.concat(js_lib)
			tasks: ["default"]

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-uglify"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-concat"
	grunt.loadNpmTasks "grunt-contrib-sass"
	grunt.loadNpmTasks "grunt-contrib-cssmin"
	grunt.registerTask "default", ["coffee", "concat", "sass"]
	grunt.registerTask "publish", ["default", "uglify", "sass", "cssmin"]