# what3words.resolver
The Ubuntu Touch app for finding locations of What3Words addresses.

For more information on the service, see the [what3words](http://what3words.com) website.

## Development

### Setup

Built using the [Ubuntu SDK](https://developer.ubuntu.com/en/phone/platform/sdk/) and [node.js](https://nodejs.org).

#### Typescript transcoding

This app's logic is written in Typescript and transcoded to JavaScript.
The transcoding as been automated adn can be run as follows:

1. Ensure nodejs and npm is installed.
2. From the What3Words-Resolver directory run
    ```bash
    npm install
    ```
    This should install all the npm dev dependencies
3. From the What3Words-Resolver directory run
    ```
    npm run build
    ```
    This should kick off the gulp build that generates app output.
 
#### Configuration file

This app also requires a w3wConfig.js file that is in the same directory as the Main.qml file.

The file should contain the following:

```javascript
// Required for all service types
var apiBase = "<base url of the w3w service you'll be calling>"

// Required for use with what3words.resolver.server
var callingAppId = "<00000000-0000-0000-0000-000000000000>" //guid for this version of what3words resolver
var callingAppName = "what3words-resolver"
var callingAppVersion = "<#.#>" //e.g. "1.1", should match manifest app version
var callingAppKey = "<key>" //the key to use for the api your calling

// Required for use with the what3words API v2
var w3wApiKey = "<your api key>"
```
replace items within `<` and `>` with your own values for teh section that's relevant for you.

#### What3Words Service

This app is designed to work with the [what3words.resolver.server](https://github.com/SiCoe/what3words.resolver.server)
though I've tried (without testing) to allow it to work with the [what 3 words RESTful API](https://docs.what3words.com/api/v2/) directly, hence the differnt sections of w3wConfig.js.
