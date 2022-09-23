#include "tcpclient.h"
#include <QHostAddress>
#include <QNetworkInterface>
#include <QThread>

int Cong1[120]={0};
int Cong2[120]={0};
int Cong[10][120] = {{0},{0}};

TcpClient::TcpClient(QObject *parent) : QObject(parent)
{
    client = new QTcpSocket[10];
    qDebug() << "Anh Thong ba dao 2k";
}

void TcpClient::send(QString msg)
{
    connectToServer();
    static QString sent;
    if (sent == msg) return;
    QThread::msleep(100);
    for (int i = 0; i < 10 ; i++)
    {
        (client + i)->write(msg.toUtf8());
    }
    sent = msg;
    exit();

}
void TcpClient::sendOnly(int num,int inputNum)
{
    if (inputNum > 0 && inputNum < 121)
    {
        onlyConnectServer(num);
        Cong[num][inputNum - 1] = 1;
        QString mess = intToQString(Cong[num]);
        QString tempStr=formatRequest(mess);
        //QByteArray ms=toByteArray(tempStr);
        qDebug() <<"test"<<Cong<< mess;

        (client + num)->write(tempStr.toUtf8());
        onlyExit(num);
        Cong[num][inputNum - 1] = 0;
    }
    else
    {
        qDebug("Nhap lai di ban");
    }
}

void TcpClient::exit()
{
    //send("exit");
    for (int i = 0; i < 10 ; i++)
    {
        (client + i)->close();
    }
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
    for (int i = 0; i < 10 ; i++)
    {
        (client + i)->connectToHost(host + QString::number(150 + i), 8888);
    }
}

void TcpClient::onlyConnectServer(int num)
{    
    (client + num)->connectToHost(host + QString::number(150 + num), 8888);
}

void TcpClient::onlyExit(int num)
{
    (client + num)->close();
}
