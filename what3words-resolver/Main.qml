import QtQuick 2.4
import Ubuntu.Components 1.3

import "w3wConfig.js" as W3wConfig
import "w3w.js" as W3W

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "what3words-resolver.sicoe"

    width: units.gu(100)
    height: units.gu(60)

    property var standardMarginSize: units.gu(2)

    property var coordinates: {
        valid: false
        longitude: 0
        latitude: 0
    }

    AdaptivePageLayout {
        anchors.fill: parent
        primaryPage: searchPage

        Page {
            id: searchPage

            header: PageHeader {
                id: pageHeader
                title: i18n.tr("What3Words Resolver")
            }

            Column {
                anchors.topMargin: standardMarginSize
                anchors.top: pageHeader.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: standardMarginSize

                TextField {
                    id: words
                    objectName: "wordsTextField"
                    placeholderText: "one.two.three"
                    width: searchPage.width - (standardMarginSize * 2)

                    anchors {
                        //horizontalCenter: parent.horizontalCenter

                        topMargin: standardMarginSize
                        leftMargin: standardMarginSize
                        rightMargin: standardMarginSize
                    }
                }

                Button {
                    id: button
                    objectName: "button"
                    anchors {
                        //horizontalCenter: parent.horizontalCenter
                        //top: words.bottom
                        topMargin: standardMarginSize
                        leftMargin: standardMarginSize
                        rightMargin: standardMarginSize
                    }
                    width: searchPage.width - (standardMarginSize * 2)
                    text: i18n.tr("Find Location")
                    onClicked: {
                        if (words.text.length === 0) {
                            label.text = i18n.tr("please enter an address")
                        } else {
                            label.text = i18n.tr("searching for ") + words.text
                            W3W.forward(words.text, function (result) {
                                coordinates = W3W.getCoordinatesFromResult(result)
                                coordinates.valid = true
                                label.text = i18n.tr("found ") + words.text
                                externalLinksPage.words = words.text
                                searchPage.pageStack.addPageToNextColumn(searchPage, externalLinksPage)
                            }, function (errorMessage) {
                                coordinates.valid = false
                                label.text = errorMessage
                            })
                        }
                    }
                }

                Label {
                    id: label
                    objectName: "label"
                    anchors {
                        //horizontalCenter: parent.horizontalCenter
                        //top: button.bottom
                        topMargin: standardMarginSize
                    }
                    width: searchPage.width - (standardMarginSize * 2)
                    wrapMode: Text.WordWrap

                    text: i18n.tr("Enter a 3 word location")
                }

            }
        }

        Page {
            id: externalLinksPage

            property string words: "";

            header: PageHeader {
                id: externalLinksPageHeader
                title: externalLinksPage.words;
            }

            Component {
                id: resultItem

                ListItem {
                    height: layout.height + (divider.visible ? divider.height : 0)
                    width: resultsList.width

                    ListItemLayout {
                        id: layout
                        height: units.gu(10)
                        width: resultsList.width
                        title.text: name

                        Icon {
                            anchors {
                                margins: units.gu(1)
                            }

                            source: iconUrl
                            asynchronous: true
                            SlotsLayout.position: SlotsLayout.Leading;
                            width: parent.height - units.gu(2)
                            height: parent.height - units.gu(2)
                        }

                    }

                    onClicked: {
                        var url = parameteredUrl.replace("{words}", words.text).replace("{coordinates.longitude}", coordinates.longitude).replace("{coordinates.latitude}", coordinates.latitude)
                        //layout.summary.text = url
                        console.log("attempting to open " + url)
                        Qt.openUrlExternally(url)
                    }
                }
            }

            UbuntuListView {
                id: resultsList
                objectName: "resultsListView"
                model: ResultsModel {}
                delegate: resultItem
                anchors {
                    //horizontalCenter: parent.horizontalCenter
                    top: externalLinksPageHeader.bottom
                    topMargin: standardMarginSize
                    leftMargin: 0
                    rightMargin: 0

                }
                width: parent.width
                height: units.gu(100)
            }

        }
    }
}

