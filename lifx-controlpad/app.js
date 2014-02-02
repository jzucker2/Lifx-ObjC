var     lifx = require('lifx');
var       lx = lifx.init();
var pubnub = require("pubnub").init({
    publish_key   : "demo",
    subscribe_key : "demo"
});

lifx.setDebug(false);

lx.on('bulb', function(b) {
  console.log('New bulb found: ' + b.name);
});

lx.on('gateway', function(g) {
  console.log('New gateway found: ' + g.ipAddress.ip);
});

pubnub.subscribe({
    channel  : "jordanlifx",
    callback : function(data) {
        lx.lightsColour(data.h, data.s, data.l, 0, 0);
    }
});