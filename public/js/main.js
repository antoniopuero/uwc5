requirejs.config({
	baseUrl: 'js/',
	paths: {
		// THIRD PART
        jquery: 'components/jquery/jquery',
		validator: 'components/jquery.validation/jquery.validate',
		bootstrap: 'components/bootstrap.css/js/bootstrap',
        timepicker: 'components/bootstrap-timepicker/js/bootstrap-timepicker',
        underscore: "components/underscore/underscore",
        backbone: "components/backbone/backbone",
        marionette: "components/backbone.marionette/lib/backbone.marionette",

        account: 'app/account',

        // MODELS
        car: 'app/models/car',
        cars: 'app/collections/cars',
        order: 'app/models/order',
        orders: 'app/collections/orders',
        user: 'app/models/users',
        users: 'app/collections/users',

        // VIEWS
        adminLayout: 'app/views/admin_layout',
        carMapView: 'app/views/car_map_view',
        carListView: 'app/views/car_list_view',
        carView: 'app/views/car_view',
        createOrderView: 'app/views/CreateOrderView'
	},
	shim: {
		bootstrap: {
			deps: ['jquery']
		},
        timepicker: {
          deps: ["jquery"]
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

requirejs(['cs!app/app', 'marionette', 'cs!account', 'timepicker'], function (App) {
    console.log("start");
    return $(function(){
        App.start();
    });
});
