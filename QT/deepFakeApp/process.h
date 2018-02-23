#include <QProcess>
#include <QVariant>
#include <QDebug>

class Process : public QProcess {
    Q_OBJECT

public:
    Process(QObject *parent = 0) : QProcess(parent) { }

    Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
        QStringList args;
        // convert QVariantList from QML to QStringList for QProcess

        for (int i = 0; i < arguments.length(); i++)
            args << arguments[i].toString();
//        QProcess *myProcess;
        QProcess::setProcessChannelMode(QProcess::MergedChannels);
        QProcess::start(program, args);
    }

    Q_INVOKABLE QByteArray readAll() {
        return QProcess::readAll();
//        ProcessChannel tmp = readChannel();
//        setReadChannel(StandardOutput);
//        QByteArray data = readAll();
//        setReadChannel(tmp);
//        return data;
    }

    Q_INVOKABLE QByteArray readStdOut() {
        return QProcess::readAll();
//        return QProcess::readAllStandardOutput();
//        ProcessChannel tmp = readChannel();
//        setReadChannel(StandardOutput);
//        QByteArray data = readAll();
//        setReadChannel(tmp);
//        return data;
    }

    Q_INVOKABLE QByteArray readStdErr() {
        return QProcess::readAllStandardError();
    }
};
