#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>

class tcpclient : public QObject
{
    Q_OBJECT
public:
    explicit tcpclient(QObject *parent = nullptr);
    Q_INVOKABLE void send(QString msg);
    Q_INVOKABLE void exit();
//    Q_INVOKABLE void connectToServer();
    Q_INVOKABLE void connectServer(QString server);
    Q_INVOKABLE bool checkConnect();
signals:
    void messagesReceived(QString msg);
    void tcpError();
    void tcpConnected();
public slots:
    void connected();
    void disconnected();
    void error(QAbstractSocket::SocketError socketError);
    void hostFound();
    void bytesWritten(qint64 bytes);
    void readyRead();
private slots:
    void connectToServer();
private:
    QTcpSocket *socket;
};


#endif // TCPCLIENT_H
