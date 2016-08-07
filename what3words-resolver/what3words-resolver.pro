TEMPLATE = aux
TARGET = what3words-resolver

RESOURCES += what3words-resolver.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

ICON_FILES += $$files(icons/*.*, true)

CONF_FILES +=  what3words-resolver.apparmor \
               what3words-resolver.png


AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               what3words-resolver.desktop \
               what3words-resolver-dispatcher.json \

#specify where the qml/js files are installed to
qml_files.path = /what3words-resolver
qml_files.files += $${QML_FILES}

icon_files.path = /what3words-resolver/icons
icon_files.files += $${ICON_FILES}

#specify where the config files are installed to
config_files.path = /what3words-resolver
config_files.files += $${CONF_FILES}

#install the desktop file, a translated version is
#automatically created in the build directory
desktop_file.path = /what3words-resolver
desktop_file.files = $$OUT_PWD/what3words-resolver.desktop
desktop_file.CONFIG += no_check_exist

INSTALLS+=config_files qml_files icon_files desktop_file

DISTFILES += \
    ResultsModel.qml \
    icons/uNav.png \
    icons/OpenStreetMap.svg.png \
    what3words-resolver-dispatcher.json \
    icons/GMaps.png \
    w3w.js \
    w3wConfig.js \
    icons/geourl.png
