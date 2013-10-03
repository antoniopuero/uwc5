/**
 * Created with JetBrains PhpStorm.
 * User: a.savchenko
 * Date: 03.10.13
 * Time: 15:30
 * To change this template use File | Settings | File Templates.
 */
define(function () {
	return {
		initialize: function () {
			$('.dropdown-menu').find('form').click(function (e) {
				e.stopPropagation();
			});
		}
	}
});
