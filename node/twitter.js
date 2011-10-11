var sys = require('sys'),
    http = require('http'),
    qs  = require('querystring');

var OAuth       = require('oauth').OAuth,
    TwitterNode = require('twitter-node').TwitterNode;


/**
 * The Prizzm constructor
 *
 * @constructor
 * @param {Object} options The options parameter for the Prizzm class
 */
var Prizzm = function(options){
    if (typeof options == 'object') {
        this.settings = {
            database : {

            },

            twitter : {
                username : options.twitter.username || undefined, 
                password : options.twitter.password || undefined, 

                accessToken : options.twitter.accessToken || undefined, 
                accessTokenSecret : options.twitter.accessTokenSecret || undefined, 

                consumerKey : options.twitter.consumerKey || undefined, 
                consumerSecret : options.twitter.consumerSecret || undefined, 
            }
        };
    }

    if (this.settings.twitter.consumerKey    == undefined ||
        this.settings.twitter.consumerSecret == undefined) {
      throw new Error('No application consumer key or secret.');
    }

    this._oauth = new OAuth('https://api.twitter.com/oauth/request_token', 'https://api.twitter.com/oauth/access_token',
                            this.settings.twitter.consumerKey, this.settings.twitter.consumerSecret,
                            '1.0A', null, 'HMAC-SHA1');
};


/**
 * OAuth authorization
 */
Prizzm.prototype.authorize = function () {
    var parent = this;

    this._oauth.getOAuthRequestToken(function (error, oAuthToken, oAuthTokenSecret, results) {
        if (error) {
            throw new Error('Twitter error ' + error.statusCode + ' ' + error.data);
        }

        parent.settings.twitter.authToken = oAuthToken;
        parent.settings.twitter.authTokenSecret = oAuthTokenSecret;

        console.log('Please navigate to the following url and enter in the pin');
        console.log('https://twitter.com/oauth/authorize?oauth_token=' + parent.settings.twitter.authToken);

        var stdin = process.openStdin().on('data', function (chunk) {
            var pin = chunk.toString().trim();

            parent._oauth.getOAuthAccessToken(oAuthToken, oAuthTokenSecret, pin, function (error, oAuthAccessToken, oAuthAccessTokenSecret, results) {
                console.log(oAuthAccessToken, oAuthAccessTokenSecret);
            });
        });
    });
};


/**
 * Monitor tweets
 */
Prizzm.prototype.monitor = function () {
    var parent = this;

    if (this.settings.twitter.username    == undefined ||
        this.settings.twitter.password == undefined) {
      throw new Error('No twitter username or password.');
    }

    var twitter = new TwitterNode({
        user: this.settings.twitter.username,
        password: this.settings.twitter.password
    });


    twitter.addListener('error', function (error) {
        console.log(error.message);
    });

    twitter.addListener('tweet', function (tweet) {
        var haveWantRegex = /\bI\s+(want|have)(?:\s+a)?\s+(.*?)\s+by\s+(.*?)\s+@PrizzmCRM/i;

        if (haveWantRegex.test(tweet.text) == true) {
            var data = tweet.text.match(haveWantRegex);

            var request = http.request({
                host: '127.0.0.1',
                port: 3000,
                path: '/api/items',
                method: 'POST'
            }, function(response) {

            });
            request.write(qs.stringify({
                username: tweet.user.screen_name,
                possession: data[1],
                product: data[2],
                company: data[3],
            }), 'utf8');

            request.end();
        }

        sys.puts("@" + tweet.user.screen_name + ": " + tweet.text);
    });

    twitter.track('@PrizzmCRM');
    twitter.stream();
}


Prizzm.prototype.post = function (status) {
    var parent = this;

    if (this.settings.twitter.accessToken       === undefined ||
        this.settings.twitter.accessTokenSecret === undefined) {
        this.authorize();
    }

    this._oauth.post('https://api.twitter.com/1/statuses/update.json', this.settings.twitter.accessToken,
                                                                       this.settings.twitter.accessTokenSecret, {
        status: status
    }, function (error, data) {
        if (error.statusCode == 401) {
            parent.authorize();
        }
    });
}


Prizzm.prototype.stream = function () {
    var parent = this;

    if (this.settings.twitter.accessToken       === undefined ||
        this.settings.twitter.accessTokenSecret === undefined) {
        this.authorize();
    }

    this._oauth.get('https://userstream.twitter.com/2/user.json', this.settings.twitter.accessToken,
                                                                  this.settings.twitter.accessTokenSecret, 
    function (error, data) {
        console.log(error, data);
    });
}


var p = new Prizzm({
    twitter: {
        // User username / password
        username: 'PrizzmCRM',
        password: 'kiclowrucr',

        // User token / secret
        accessToken: '16936652-Sqpu2dg0MEohwNh3wYqqwOn9D2zA2W0Fa3vKQgg8',
        accessTokenSecret: 'dI4LCRGPmUIeYBwaE9ouegCpWwzWVMLjHXSZ29tk',

        // Application keys / secret
        consumerKey: 'kyJqaKKivaWRTxDoIDvTQ',
        consumerSecret: 'rpfLkuPwNQjjP5nfXr3BdcVp1KuSbks14QVBFOuFGs',
    }
});

p.monitor();
