// This script seeks to mimic an ICMP check in New Relic Synthetics (Scripted API check)
// It uses the dns module to resolve a domain name to an IP and
// then uses the net-ping module to ping the IP address
var assert = require('assert');
var ping = require('net-ping');
var url = 's00.us'
var session = ping.createSession({
    retries: 2,
    timeout: 1000
  });
var dnsFailures = [];
var pingFailures = [];
const dnsResource = $har.addResource('DNS Lookup');
const pingResource = $har.addResource('Ping Check');

const { Resolver } = require('dns').promises;
const myResolver = new Resolver();
myResolver.setServers(['1.1.1.1'])

async function dnsLookup() {
    try {
        dnsResource.startTimer();
        dnsResource.dns().startTimer();
        let dnsCheck = await myResolver.resolve4(url);
        dnsResource.dns().endTimer();
        dnsResource.endTimer();
        return dnsCheck[0];
    } catch (err) {
        dnsFailures.push(url)
        console.log("An error occurred while looking up "+url+" on "+": "+err);
        assert.ok(dnsFailures.length == 0, "An error occurred while looking up "+url+" on "+": "+err);
        session.close();
    }
}

async function pingCheckIP() {
    var lookupIP = await dnsLookup();
    pingResource.startTimer();
    pingResource.wait().startTimer();
    session.pingHost(ip = lookupIP, function (error, target, sent, rcvd) {
        pingResource.wait().endTimer();
        pingResource.endTimer();
        if (error) {
            pingFailures.push(ip);
            assert.ok(pingFailures.length == 0, 'Ping failed for IP ' + ip + ' with error: ' + error);
            console.log('ERROR - Ping failed for IP ' + ip + ' with error: ' + error);
        }
        else {
            var timeRequired = rcvd - sent
            console.log('Ping successful for IP ' + ip + '. Response (ms): ' + timeRequired);
            session.close();
        }
    });
}
pingCheckIP();