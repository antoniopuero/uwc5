var fs = require('fs');

fileContent = JSON.parse(fs.readFileSync('bla.js').toString());

entries = fileContent.log.entries;


// HAR
var maxDeep = 100;
var HAR = function (data) {

    var result = [];

    data.log.entries.forEach(function (elem) {
        var row = [];
        iterator(0, elem, row, 'entries');
        result.push(row);
    });
    result.forEach(function (row) {
        console.log(row);
    });
};

var iterator = function (deep, data, row, prefix) {
    if (prefix !== '') {
        prefix += '.';
    }
    for (var key in data) {
        if ('headers' === key || 'cookies' === key) {
            row.push(prefix  + key + ':  ' + data[key]);
        } else if ('object' !== typeof data[key]) {
            row.push(prefix  + key + ':  ' + data[key]);
        } else if (deep === maxDeep) {
            row.push(prefix + key + ':  ' + data[key]);
        } else {
            iterator(++deep, data[key], row, prefix + key);
        }
    }
};

HAR(fileContent);