.import 'w3wConfig.js' as W3wConfig

function getXMLHttpRequest() {
    var http = new XMLHttpRequest(method, query);
    http.open("GET", W3wConfig.apiBase + method, true);

    http.setRequestHeader("Accepts", "application/json");

}

function forward(words, successCallback, failCallback) {
    var http = new XMLHttpRequest()
    var url = W3wConfig.apiBase + "forward?addr=" + words;
    http.open("GET", url, true);

    // Send the proper header information along with the request
    http.setRequestHeader("Accepts", "application/json");
    http.setRequestHeader("X-CallingAppId", W3wConfig.callingAppId);
    http.setRequestHeader("X-CallingAppName", W3wConfig.callingAppName);
    http.setRequestHeader("X-CallingAppVersion", W3wConfig.callingAppVersion);
    http.setRequestHeader("X-CallingAppKey", W3wConfig.callingAppKey);

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState == 4) {
            console.log("response:\n" + http.responseText)
            if (http.status == 200) {
                var responseObject = JSON.parse(http.responseText);
                if (responseObject.status.code === 300) {
                    console.log("unsuccessful: " + responseObject.status.message)
                    failCallback(responseObject.status.message);
                } else {

                    console.log("success: " + http.responseText);
                    successCallback(http.responseText);
                }
            } else {
                console.log("error: " + http.status)
                failCallback(http.responseText);
            }
        }
    }
    http.send();
}

function getCoordinatesFromResult(result) {
    console.log(result)
    var responseObject = JSON.parse(result);
    return {
        longitude: responseObject.geometry.lng,
        latitude: responseObject.geometry.lat
    }
}
