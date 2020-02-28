#ifndef ADDRESSLIST_H
#define ADDRESSLIST_H

#include <QObject>
#include <qvariant.h>
#include <qgeolocation.h>

class AddressList : public QObject
{
    Q_OBJECT
public:
    explicit AddressList(QObject *parent = nullptr);
    Q_PROPERTY(QString inputText READ getInputText WRITE setInputText NOTIFY inputTextChanged);
    Q_PROPERTY(QVariant selectedLocation READ getSelectedLocation WRITE setSelectedLocation NOTIFY selectedLocationChanged);
signals:
    void inputTextChanged();
    void selectedLocationChanged();

public slots:

public:
    QString			getInputText();
    void			setInputText(const QString& aText);
	QVariant		getSelectedLocation();
    void			setSelectedLocation(const QVariant& aLocation);
private:
   QString m_inputText;
   QGeoLocation m_selectedLocation;
};

#endif // ADDRESSLIST_H
