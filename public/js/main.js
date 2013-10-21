requirejs.config({
	baseUrl: 'js',
	paths: {
		jquery: 'components/jquery/jquery',
		validator: 'components/jquery.validation/jquery.validate',
		bootstrap: 'components/bootstrap.css/js/bootstrap',
		app: 'app/app',
		account: 'app/account',
        underscore: "components/underscore/underscore",
        backbone: "components/backbone/backbone",
        marionette: "components/backbone.marionette/lib/backbone.marionette"
	},
	shim: {
		bootstrap: {
			deps: ['jquery']
		},
		app: {
			deps: ['jquery', 'bootstrap', 'marionette']
		},
		account: {
			deps: ['jquery', 'validator']
		},
		validator: {
			deps: ['jquery']
		},
        backbone: {
            deps: ["underscore", "jquery"],
            exports: "Backbone"
        },
        marionette: {
            deps: ["underscore", "backbone", "jquery"],
            exports: "Marionette"
        }
	},
	urlArgs: "bust=" + (new Date()).getTime()
});

requirejs(['cs!app'], function (App) {
    return App.start();
});
