#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include "config.h"
class TcpClient : public QObject
{
    Q_OBJECT
public:
    explicit TcpClient(QObject *parent = nullptr);
    Q_INVOKABLE void send(QString msg);
    Q_INVOKABLE void sendOnly(int num,int inputNum);
    Q_INVOKABLE void exit();

signals:
    void messagesReceived(QString msg);
    void tcpError();
    void tcpConnected();
public slots:
    QString intToQString(int a[120]);
    QString formatRequest(QString msg);
    QByteArray toByteArray(QString &stringList);
private slots:
    void connectToServer();
    void onlyConnectServer(int num);
    void onlyExit(int num);

private:   
    QTcpSocket *client;
};

#endif // TCPCLIENT_H
