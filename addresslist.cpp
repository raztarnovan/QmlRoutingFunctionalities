#include "addresslist.h"

AddressList::AddressList(QObject *parent) : QObject(parent)
{
}

QString AddressList::getInputText()
{
    return m_inputText;
}
void AddressList::setInputText(const QString& aText)
{
    if( m_inputText.compare(aText) != 0)
    {
        m_inputText = aText;
        Q_EMIT inputTextChanged();
    }
}
QVariant AddressList::getSelectedLocation()
{
    return QVariant::fromValue( m_selectedLocation );
}
void AddressList::setSelectedLocation(const QVariant& aLocation)
{
	{
        m_selectedLocation = aLocation.value<QGeoLocation>();
        Q_EMIT selectedLocationChanged();
    }
}
