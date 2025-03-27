#include <QCoreApplication> // Qt 코어 애플리케이션 클래스 포함
#include <QMqttClient> // MQTT 클라이언트 클래스 포함
#include <QObject> // Qt 객체 클래스 포함
#include <QDebug> // 디버깅을 위한 클래스 포함
#include <QQuickView> // QML 뷰어 클래스 포함
#include <QQmlApplicationEngine> // QML 애플리케이션 엔진 클래스 포함
#include <QQmlContext> // QML 컨텍스트 클래스 포함
#include <QApplication> // Qt 애플리케이션 클래스 포함

int main(int argc, char *argv[])
{
    QApplication app(argc, argv); // Qt 애플리케이션 객체 생성

    QMqttClient client; // MQTT 클라이언트 객체 생성

    QQmlApplicationEngine engine; // QML 애플리케이션 엔진 객체 생성
    engine.rootContext()->setContextProperty("mqttClient", &client); // QML 컨텍스트에 MQTT 클라이언트 객체 설정
    const QUrl url(QStringLiteral("qrc:/main.qml")); // QML 파일의 URL 설정
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl) // QML 객체가 생성되지 않았을 경우
                QCoreApplication::exit(-1); // 애플리케이션 종료
        },
        Qt::QueuedConnection); // 큐 연결 방식으로 시그널 연결
    engine.load(url); // QML 파일 로드

    if (engine.rootObjects().isEmpty()) // 루트 객체가 비어 있을 경우
        return -1; // 애플리케이션 종료

    QObject::connect(&client, &QMqttClient::connected, [&client](){
        qDebug() << "Connected to broker"; // 브로커에 연결되었음을 디버그 출력
        QMqttTopicFilter topic("Sensor/GH1/Center/Temp"); // 구독할 토픽 설정
        client.subscribe(topic); // 토픽 구독
    });

    QObject::connect(&client, &QMqttClient::messageReceived, [](const QByteArray &message, const QMqttTopicName &topic){
        qDebug() << "Message received:" << message << "on topic:" << topic.name(); // 메시지 수신 시 디버그 출력
    });

    return app.exec(); // 이벤트 루프 시작
}