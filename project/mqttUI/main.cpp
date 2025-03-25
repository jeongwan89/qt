#include <QCoreApplication>
#include <QMqttClient>
#include <QObject>
#include <QDebug>
#include <QQuickView>
#include <QQmlApplicationEngine>


#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QMqttClient client;
    client.setHostname("192.168.0.24");
    client.setPort(1883);
    client.setUsername("farmmain");
    client.setPassword("eerrtt");
    client.setClientId("ubuntu_project_#1");

    qDebug() << "Start program";
    QObject::connect(&client, &QMqttClient::connected, [&client](){
        qDebug() << "Connected to broker";
        QMqttTopicFilter topic("Sensor/GH1/Center/Temp");
        client.subscribe(topic);
    });

    QObject::connect(&client, &QMqttClient::messageReceived, [](const QByteArray &message, const QMqttTopicName &topic){
        qDebug() << "Message received:" << message << "on topic:" << topic.name();
    });

    client.connectToHost();

    QQuickView view;
    view.setSource(QUrl("qrc:/Main.qml"));
    view.show();
    return app.exec(); //이벤트 루프의 시작
}
