#include "tcpclient.h"
#include <QHostAddress>
#include <QNetworkInterface>
#include <QThread>
tcpclient::tcpclient(QObject *parent)
    : QObject{parent}
{
    socket = new QTcpSocket(this);

    connect(socket, SIGNAL(connected()), this, SLOT(connected()));
    connect(socket, SIGNAL(disconnected()), this, SLOT(disconnected()));
    connect(socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error(QAbstractSocket::SocketError)));
    connect(socket, SIGNAL(hostFound()), this, SLOT(hostFound()));
    connect(socket, SIGNAL(bytesWritten(qint64)), this, SLOT(bytesWritten(qint64)));
    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()));

    //    connect(socket, SIGNAL(disconnected()), this, SLOT(connectToServer()));
    //connectToServer();
    //qDebug() << "Anh Thong ba dao 2k";
}

void tcpclient::send(QString msg)
{
    if (checkConnect())
    {
        static QString sent;
        if (sent == msg) return;
        QThread::msleep(100);
        socket->write(msg.toUtf8());
        socket->waitForBytesWritten();
        sent = msg;
        // moi them
        socket->disconnectFromHost();
    }
    else
    {
        qDebug () << "khong ket noi";
    }
//    socket->disconnect();
}

void tcpclient::exit()
{
    send("exit");
    socket->close();
}

void tcpclient::connectServer(QString server)
{
    socket->connectToHost(server, 8888);
    if(socket->waitForConnected(150))
    {
        foreach (const QHostAddress &address, QNetworkInterface::allAddresses()) {
            if (address.protocol() == QAbstractSocket::IPv4Protocol && address != QHostAddress(QHostAddress::LocalHost))
                qDebug() << address.toString();
        }
    }
    else
    {
        qDebug() << "Not connected!";
    }
}

bool tcpclient::checkConnect()
{
    if (socket->state() == QAbstractSocket::ConnectedState)
    {
        return true;
    }
    else
    {
        socket->connectToHost("192.168.1.150", 8888);
//        socket->connectToHost("172.31.99.202", 88);
        if(socket->waitForConnected(150))
        {
            qDebug() << "connect!";
            return true;

        }
        else
        {
            qDebug() << "not connect";
            return false;
        }
    }
}
void tcpclient::connected()
{
    qDebug() << "Connected.\n";
    //socket->write("Hello server.\n");
    emit tcpConnected();
}

void tcpclient::disconnected()
{
    qDebug() << "Disconnected.\n";
}

void tcpclient::error(QAbstractSocket::SocketError socketError)
{
    Q_UNUSED(socketError)
    QString errorStr = socket->errorString();
    qDebug() << "An error occured: " + errorStr;
    emit tcpError();
}

void tcpclient::hostFound()
{
    qDebug() << "Host found.\n";
}

void tcpclient::bytesWritten(qint64 bytes)
{
    QString outString = QString::number(bytes) + " bytes writen.";
    qDebug() << outString;
}

void tcpclient::readyRead()
{
    qint64 bytes = socket->bytesAvailable();
    qDebug() << QString::number(bytes)+ " for you to read";
    /*
     * When you read data from a socket, data is also removed from the socket buffer space.
     */
    QByteArray ba = socket->readAll();
    emit messagesReceived(ba);
}

void tcpclient::connectToServer()
{
    socket->connectToHost("192.168.1.150", 8888);
//    socket->connectToHost("172.31.99.202", 88);
    if(socket->waitForConnected(150))
    {
        foreach (const QHostAddress &address, QNetworkInterface::allAddresses()) {
            if (address.protocol() == QAbstractSocket::IPv4Protocol && address != QHostAddress(QHostAddress::LocalHost))
                qDebug() << address.toString();
        }
    }
    else
    {
        qDebug() << "Not connected!";
    }

}
