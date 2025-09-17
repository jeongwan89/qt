cmake_minimum_required(VERSION 3.5)

# C++ 컴파일러 경로 설정
# set(CMAKE_CXX_COMPILER /home/kjw/Qt/6.5.3/gcc_64/bin/g++)

project(mqttMonitor VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt6 REQUIRED COMPONENTS Widgets Quick Mqtt)

add_executable(mqttMonitor
    main.cpp
    mainwindow.cpp
    mainwindow.h
    mainwindow.ui
    qml.qrc
)
target_link_libraries(mqttMonitor 
                        PRIVATE 
                        Qt6::Widgets
                        Qt6::Quick
                        Qt6::Mqtt)

set_target_properties(mqttMonitor PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS mqttMonitor
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(mqttMonitor)
endif()
