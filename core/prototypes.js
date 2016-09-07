
'use strict';

var path = require('path');
require('babel-register')({
    plugins: [
        path.join(__dirname, 'require.js')
    ]
});
require('babel-polyfill');

if (typeof String.prototype.toProperCase !== 'function') {
    String.prototype.toProperCase = function () {
        return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    };
}

if (typeof String.prototype.contains !== 'function') {
    String.prototype.contains = function(str) {
        return this.indexOf(str) !== -1;
    };
}

if (typeof String.prototype.capitilizFirst !== 'function') {
    String.prototype.capitilizeFirst = function () {
        if (this.length >= 2) {
            return this[0].toUpperCase() + this.substring(1);
        }
        return this;
    };
}
