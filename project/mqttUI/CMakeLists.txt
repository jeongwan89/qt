cmake_minimum_required(VERSION 3.16)

project(mqttUI VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt 설치 경로 설정
set(CMAKE_PREFIX_PATH "/home/kjw/Qt/6.5.3/gcc_64")

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED
    Widgets Mqtt)

qt_add_executable(appmqttUI
    main.cpp
)

qt_add_qml_module(appmqttUI
    URI mqttUI
    VERSION 1.0
    QML_FILES main.qml 
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appmqttUI PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appmqttUI
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appmqttUI
    PRIVATE Qt6::Quick
    Qt6::Widgets
    Qt6::Mqtt)

include(GNUInstallDirs)
install(TARGETS appmqttUI
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
