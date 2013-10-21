requirejs.config({
	baseUrl: 'js',
	paths: {
		jquery: 'components/jquery/jquery',
		validator: 'components/jquery.validation/jquery.validate',
		bootstrap: 'components/bootstrap.css/js/bootstrap',
        underscore: "components/underscore/underscore",
        backbone: "components/backbone/backbone",
        marionette: "components/backbone.marionette/lib/backbone.marionette",
        app: 'app/app',
        account: 'app/account',
        car: 'app/models/car',
        cars: 'app/collections/cars',
        order: 'app/models/order',
        orders: 'app/collections/orders',
        user: 'app/models/users',
        users: 'app/collections/users'
	},
	shim: {
		bootstrap: {
			deps: ['jquery']
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
    console.log("start");
    return App.start();
});
