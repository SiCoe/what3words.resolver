import QtQuick 2.0

ListModel {
    ListElement {
        name: "what3words"
        parameteredUrl: "http:w3w.co/{words}"
        iconUrl: "what3words-resolver.png"
    }
    ListElement {
        name: "Geo URL"
        parameteredUrl: "geo:{coordinates.latitude},{coordinates.longitude}"
        iconUrl: "icons/geourl.png"
    }
    ListElement {
        name: "uNav"
        parameteredUrl: "http://unav-go.github.io?p={coordinates.latitude},{coordinates.longitude}"
        iconUrl: "icons/uNav.png"
    }
    ListElement {
        name: "Open Street Map"
        parameteredUrl: "http://www.openstreetmap.org/search?query={coordinates.latitude}%2C{coordinates.longitude}"
        iconUrl: "icons/OpenStreetMap.svg.png"
    }
    ListElement {
        name: "Google Maps"
        parameteredUrl: "http://www.google.com/maps/@{coordinates.latitude},{coordinates.longitude}"
        iconUrl: "icons/GMaps.png"
    }
}

