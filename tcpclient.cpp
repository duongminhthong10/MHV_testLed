#include "tcpclient.h"
#include <QHostAddress>
#include <QNetworkInterface>
#include <QThread>

int Cong1[120]={0};
int Cong2[120]={0};
int Cong[2][120] = {{0},{0}};

TcpClient::TcpClient(QObject *parent) : QObject(parent)
{
    client1=new QTcpSocket(this);
    client2=new QTcpSocket(this);
    client3=new QTcpSocket(this);
    client4=new QTcpSocket(this);
    client5=new QTcpSocket(this);
    client6=new QTcpSocket(this);
    client7=new QTcpSocket(this);
    client8=new QTcpSocket(this);
    client9=new QTcpSocket(this);
    client10=new QTcpSocket(this);

    client = new QTcpSocket[10];
    qDebug() << "ANh Thong ba dao 2k";
}

void TcpClient::send(QString msg)
{
    connectToServer();
    static QString sent;
    if (sent == msg) return;
    QThread::msleep(100);

//    client1->write(msg.toUtf8());
//    client2->write(msg.toUtf8());
//    client3->write(msg.toUtf8());
//    client4->write(msg.toUtf8());
//    client5->write(msg.toUtf8());
//    client6->write(msg.toUtf8());
//    client7->write(msg.toUtf8());
//    client8->write(msg.toUtf8());
//    client9->write(msg.toUtf8());
//    client10->write(msg.toUtf8());
    (client + 1)->write(msg.toUtf8());
    //(socket+i)->waitForBytesWritten();
    sent = msg;
    exit();

}

void TcpClient::sendOnly(int num, QString msg, int inputNum)
{
    onlyConnectServer(num);
    Cong[num][inputNum - 1] = 1;
    QString mess = intToQString(Cong[num]);
    QString tempStr=formatRequest(mess);
    //QByteArray ms=toByteArray(tempStr);
    qDebug() <<"test"<<Cong<< mess;

    client1->write(tempStr.toUtf8());
    onlyExit(num);
    Cong[num][inputNum - 1] = 0;
}

void TcpClient::exit()
{
    //send("exit");
    client1->close();
    client2->close();
    client3->close();
    client4->close();
    client5->close();
    client6->close();
    client7->close();
    client8->close();
    client9->close();
    client10->close();
}

void TcpClient::connected()
{
    qDebug() << "Connected.\n";
    //socket->write("Hello server.\n");
    emit tcpConnected();
}

void TcpClient::disconnected()
{
    qDebug() << "Disconnected.\n";
}

void TcpClient::error(QAbstractSocket::SocketError socketError)
{
    //    Q_UNUSED(socketError)
    //    QString errorStr = socket->errorString();
    //    qDebug() << "An error occured: " + errorStr;
    //    emit tcpError();
}

void TcpClient::hostFound()
{
    qDebug() << "Host found.\n";
}

void TcpClient::bytesWritten(qint64 bytes)
{
    QString outString = QString::number(bytes) + " bytes writen.";
    qDebug() << outString;
}

void TcpClient::readyRead()
{
    //    qint64 bytes = socket->bytesAvailable();
    //    qDebug() << QString::number(bytes)+ " for you to read";
    //    /*
    //     * When you read data from a socket, data is also removed from the socket buffer space.
    //     */
    //    QByteArray ba = socket->readAll();
    //    emit messagesReceived(ba);
}

QString TcpClient::intToQString(int a[120])
{
    QString My_String;
    for(int i=0; i < 120; i++)
    {
        My_String.append(QString::number(a[i]));
    }
    return My_String;
}

QString TcpClient::formatRequest(QString msg)
{
    QString str = "DKTC_"+msg;
    return str;
}

QByteArray TcpClient::toByteArray(QString &stringList)
{
    QByteArray msg=stringList.toUtf8();
    return msg;
}

void TcpClient::connectToServer()
{
//    client1->connectToHost("192.168.1.150", 8888);
//    client2->connectToHost("192.168.1.151", 8888);
//    client3->connectToHost("192.168.1.152", 8888);
//    client4->connectToHost("192.168.1.153", 8888);
//    client5->connectToHost("192.168.1.154", 8888);
//    client6->connectToHost("192.168.1.155", 8888);
//    client7->connectToHost("192.168.1.156", 8888);
//    client8->connectToHost("192.168.1.157", 8888);
//    client9->connectToHost("192.168.1.158", 8888);
//    client10->connectToHost("192.168.1.159", 8888);
    for (int i = 0; i < 10 ; i++)
    {
        (client + i)->connectToHost("192.168.0." + QString::number(150 + i), 8888);
    }
}

void TcpClient::onlyConnectServer(int num)
{
    switch (num) {
    case 1:
        client1->connectToHost("192.168.1.150", 8888);
        break;
    case 2:
        client2->connectToHost("192.168.1.151", 8888);
    case 3:
        client3->connectToHost("192.168.1.152", 8888);
    default:
        break;
    }
}

void TcpClient::onlyExit(int num)
{
    switch (num) {
    case 1:
        client1->connectToHost("192.168.1.150", 8888);
        break;
    case 2:
        client2->connectToHost("192.168.1.151", 8888);
    case 3:
        client3->connectToHost("192.168.1.152", 8888);
    default:
        break;
    }
}
