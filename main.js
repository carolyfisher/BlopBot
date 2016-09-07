//TODO: Make all modules Hubot and CoffeeScript
'use strict';

require('dotenv').load();
// Arbitary location module loading requirements
global.__rootPath = __dirname;
global.rootPathJoin = function () {
    var a = [global.__rootPath],
        path = require('path');
    for (var i = 0; i < arguments.length; i++) {
        a.push(arguments[i]);
    }
    return path.join.apply(this, a);
};

// Load NodeJS Modifications/Variables
require('./core/prototypes.js');
require('./core/status.js');
require('./core/unsafe/console.js');

var integf = require('./core/integrations/integrations.js'),
    startup = require('./core/startup.js'),
    integ = integf.listIntegrations(),
    argp = require('./core/arguments.js'),
    args = process.argv;

args.splice(0, 2);

// Parse optional arguments
argp.runArguments(args);

// Check modules path is set
if (!global.__modulesPath) {
    var path = require('path');
    global.__modulesPath = path.resolve('./modules/');
}

require('coffee-script').register();
global.coffeescriptLoaded = true;

// Check startup modes
if (!args || args.length === 0) {
    console.error("You can't do that. Specify an integration.");
    process.exit();
}

// Check startup integrations
var startArgs = [];
for (var i = 0; i < args.length; i++) {
    args[i] = args[i].toLowerCase();
    var inte = integ.find(function(int) {
        return int.name === args[i];
    });
    if (!inte) {
        console.error('Unknown mode \'' + args[i] + '\'');
        console.info('The integrations avalible on your system are:');
        for (var i = 0; i < integ.length; i++) {
            console.info('\t- \'' + integ[i].name + '\'');
        }
        process.exit(-2);
    }
    else {
        startArgs.push(inte);
    }
}

process.on('uncaughtException', function(err) {
        console.error("Carol screwed up. It's not the Bot's fault, go get mad at Carol");
    console.critical(err);
});

startup.run(startArgs);
