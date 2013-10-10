define(function() {
    return {
        initialize: function() {
            console.log('Hello world');
            // Setup drop down menu
            $('.dropdown-toggle').dropdown();

            // Fix input element click problem
            $('.dropdown-menu input, .dropdown-menu label, .dropdown-menu .alert').click(function(e) {
                e.stopPropagation();
            });
        }
    };
});