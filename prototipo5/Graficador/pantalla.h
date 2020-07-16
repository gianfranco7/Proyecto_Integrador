#ifndef PANTALLA_H
#define PANTALLA_H

#include <QWidget>



namespace Ui {
class pantalla;
}

class pantalla : public QWidget
{
    Q_OBJECT

public:
    explicit pantalla(QWidget *parent = 0);
    ~pantalla();


private slots:


    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_3_clicked();

private:
    Ui::pantalla *ui;
};

#endif // PANTALLA_H
