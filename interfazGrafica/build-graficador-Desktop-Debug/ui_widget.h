/********************************************************************************
** Form generated from reading UI file 'widget.ui'
**
** Created by: Qt User Interface Compiler version 5.9.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WIDGET_H
#define UI_WIDGET_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QFormLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLCDNumber>
#include <QtWidgets/QLabel>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Widget
{
public:
    QWidget *formLayoutWidget;
    QFormLayout *formLayout;
    QLabel *label;
    QLCDNumber *lcdNumber;
    QLabel *label_2;
    QLCDNumber *lcdNumber_2;
    QLabel *label_3;
    QLCDNumber *lcdNumber_3;
    QLabel *label_4;
    QLCDNumber *lcdNumber_4;
    QLabel *label_5;
    QLCDNumber *lcdNumber_5;

    void setupUi(QWidget *Widget)
    {
        if (Widget->objectName().isEmpty())
            Widget->setObjectName(QStringLiteral("Widget"));
        Widget->resize(517, 487);
        formLayoutWidget = new QWidget(Widget);
        formLayoutWidget->setObjectName(QStringLiteral("formLayoutWidget"));
        formLayoutWidget->setGeometry(QRect(0, 10, 511, 517));
        formLayout = new QFormLayout(formLayoutWidget);
        formLayout->setSpacing(6);
        formLayout->setContentsMargins(11, 11, 11, 11);
        formLayout->setObjectName(QStringLiteral("formLayout"));
        formLayout->setSizeConstraint(QLayout::SetDefaultConstraint);
        formLayout->setHorizontalSpacing(100);
        formLayout->setVerticalSpacing(100);
        formLayout->setContentsMargins(0, 0, 0, 0);
        label = new QLabel(formLayoutWidget);
        label->setObjectName(QStringLiteral("label"));

        formLayout->setWidget(0, QFormLayout::LabelRole, label);

        lcdNumber = new QLCDNumber(formLayoutWidget);
        lcdNumber->setObjectName(QStringLiteral("lcdNumber"));

        formLayout->setWidget(0, QFormLayout::FieldRole, lcdNumber);

        label_2 = new QLabel(formLayoutWidget);
        label_2->setObjectName(QStringLiteral("label_2"));

        formLayout->setWidget(1, QFormLayout::LabelRole, label_2);

        lcdNumber_2 = new QLCDNumber(formLayoutWidget);
        lcdNumber_2->setObjectName(QStringLiteral("lcdNumber_2"));

        formLayout->setWidget(1, QFormLayout::FieldRole, lcdNumber_2);

        label_3 = new QLabel(formLayoutWidget);
        label_3->setObjectName(QStringLiteral("label_3"));

        formLayout->setWidget(2, QFormLayout::LabelRole, label_3);

        lcdNumber_3 = new QLCDNumber(formLayoutWidget);
        lcdNumber_3->setObjectName(QStringLiteral("lcdNumber_3"));

        formLayout->setWidget(2, QFormLayout::FieldRole, lcdNumber_3);

        label_4 = new QLabel(formLayoutWidget);
        label_4->setObjectName(QStringLiteral("label_4"));

        formLayout->setWidget(3, QFormLayout::LabelRole, label_4);

        lcdNumber_4 = new QLCDNumber(formLayoutWidget);
        lcdNumber_4->setObjectName(QStringLiteral("lcdNumber_4"));
        lcdNumber_4->setBaseSize(QSize(100, 100));

        formLayout->setWidget(3, QFormLayout::FieldRole, lcdNumber_4);

        label_5 = new QLabel(formLayoutWidget);
        label_5->setObjectName(QStringLiteral("label_5"));

        formLayout->setWidget(4, QFormLayout::LabelRole, label_5);

        lcdNumber_5 = new QLCDNumber(formLayoutWidget);
        lcdNumber_5->setObjectName(QStringLiteral("lcdNumber_5"));
        lcdNumber_5->setBaseSize(QSize(50, 50));
        lcdNumber_5->setSmallDecimalPoint(false);

        formLayout->setWidget(4, QFormLayout::FieldRole, lcdNumber_5);


        retranslateUi(Widget);

        QMetaObject::connectSlotsByName(Widget);
    } // setupUi

    void retranslateUi(QWidget *Widget)
    {
        Widget->setWindowTitle(QApplication::translate("Widget", "Widget", Q_NULLPTR));
        label->setText(QApplication::translate("Widget", "S1", Q_NULLPTR));
        label_2->setText(QApplication::translate("Widget", "S2", Q_NULLPTR));
        label_3->setText(QApplication::translate("Widget", "S3", Q_NULLPTR));
        label_4->setText(QApplication::translate("Widget", "S4", Q_NULLPTR));
        label_5->setText(QApplication::translate("Widget", "S5", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class Widget: public Ui_Widget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WIDGET_H
