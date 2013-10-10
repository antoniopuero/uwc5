define(['account'], function(account) {


	var initialize = function() {
		console.log('Hello world');
		// Setup drop down menu
		$('.dropdown-toggle').dropdown();

		// Fix input element click problem
		$('.dropdown-menu input, .dropdown-menu label, .dropdown-menu .btn-login, .dropdown-menu .alert').click(function(e) {
			e.stopPropagation();
		});
		//signin/signup form validation
		account.validateForms();
		account.handleRequests();
	};

    return {
        initialize: initialize
    };
});
