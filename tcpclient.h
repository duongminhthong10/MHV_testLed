#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>

class TcpClient : public QObject
{
    Q_OBJECT
public:
    explicit TcpClient(QObject *parent = nullptr);
    Q_INVOKABLE void send(QString msg);
    Q_INVOKABLE void sendOnly(int num, QString msg, int inputNum);
    Q_INVOKABLE void exit();

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
    QString intToQString(int a[120]);
    QString formatRequest(QString msg);
    QByteArray toByteArray(QString &stringList);
private slots:
    void connectToServer();
    void onlyConnectServer(int num);
    void onlyExit(int num);

private:
    QTcpSocket *client1, *client2, *client3, *client4, *client5, *client6, *client7, *client8, *client9, *client10;
    QTcpSocket *client;
};

#endif // TCPCLIENT_H
