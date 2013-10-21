var isPrimitive = function (target) {
	if (typeof target === "undefined" || target === null) {
		throw new Error('bad argument');
	}

	if (typeof target === 'object') {
		console.log('false');
		return false;
	}

	console.log('true');
	return true;

};

isPrimitive(1)
isPrimitive({})
isPrimitive([])
isPrimitive('');
isPrimitive('asdasd');

