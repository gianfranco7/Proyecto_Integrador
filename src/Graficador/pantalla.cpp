#include "pantalla.h"
#include "ui_pantalla.h"
#include <iostream>


using namespace std;
QVector<double> S1x(500), S1y(500);
QVector<double> S2x(500), S2y(500);
QVector<double> S3x(500), S3y(500);
QVector<double> S4x(500), S4y(500);
QVector<double> S5x(500), S5y(500);

pantalla::pantalla(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::pantalla)
{
    QString SN1 = "Pulso";
    QString SN2 = "Presion Diastollica";
    QString SN3 = "Presion Sistolica";
    QString SN4 = "Tasa Respiratoria";
    QString SN5 = "Saturación Oxigeno";
    ui->setupUi(this);
    ui->L1->setText(SN1);
    ui->L2->setText(SN2);
    ui->L3->setText(SN3);
    ui->L4->setText(SN4);
    ui->L5->setText(SN5);
    ui->uni1->setText("km");
    ui->uni2->setText("km");
    ui->uni3->setText("km");
    ui->uni4->setText("km");
    ui->uni5->setText("km");

    for(int i=0;i<300;++i){
        S1x[i]=i;
        S1y[i]=i*2;
        S2x[i]=i;
        S2y[i]=i*i;
        S3x[i]=i;
        S3y[i]=i*i*i/2;
        S4x[i]=i;
        S4y[i]=i;
        S5x[i]=i;
        S5y[i]=i*5;
    }

    //Sensor1
    ui->G1->addGraph();
    ui->G1->xAxis->setRange(0,300);
    ui->G1->yAxis->setRange(0,300);
    ui->G1->replot();
    //Sensor2
    ui->G2->addGraph();
    ui->G2->xAxis->setRange(0,300);
    ui->G2->yAxis->setRange(0,400);
    ui->G2->replot();
    //Sensor3
    ui->G3->addGraph();
    ui->G3->xAxis->setRange(0,300);
    ui->G3->yAxis->setRange(0,100);
    ui->G3->replot();
    //Sensor4
    ui->G4->addGraph();
    ui->G4->xAxis->setRange(0,300);
    ui->G4->yAxis->setRange(0,100);
    ui->G4->replot();
    //Sensor5
    ui->G5->addGraph();
    ui->G5->xAxis->setRange(0,300);
    ui->G5->yAxis->setRange(0,100);
    ui->G5->replot();

}

pantalla::~pantalla()
{
    delete ui;
}

int l=0;
void pantalla::on_pushButton_clicked()
{
    ui->G1->xAxis->setRange(l-30,l);
    ui->G1->replot();
    ui->G1->update();
    ui->G2->xAxis->setRange(l-30,l);
    ui->G2->replot();
    ui->G2->update();
    ui->G3->xAxis->setRange(l-30,l);
    ui->G3->replot();
    ui->G3->update();
    ui->G4->xAxis->setRange(l-30,l);
    ui->G4->replot();
    ui->G4->update();
    ui->G5->xAxis->setRange(l-30,l);
    ui->G5->replot();
    ui->G5->update();

}

void pantalla::on_pushButton_2_clicked()
{
    ui->G1->xAxis->setRange(0,l);
    ui->G1->replot();
    ui->G1->update();
    ui->G2->xAxis->setRange(0,l);
    ui->G2->replot();
    ui->G2->update();
    ui->G3->xAxis->setRange(0,l);
    ui->G3->replot();
    ui->G3->update();
    ui->G4->xAxis->setRange(0,l);
    ui->G4->replot();
    ui->G4->update();
    ui->G5->xAxis->setRange(0,l);
    ui->G5->replot();
    ui->G5->update();
}

void pantalla::on_pushButton_3_clicked()
{

    ui->G1->xAxis->setRange(0,l);
    ui->G1->replot();
    ui->G1->update();
    ui->G1->graph(0)->setData(S1x,S1y);

    ui->G2->xAxis->setRange(0,l);
    ui->G2->replot();
    ui->G2->update();
    ui->G2->graph(0)->setData(S2x,S2y);

    ui->G3->xAxis->setRange(0,l);
    ui->G3->replot();
    ui->G3->update();
    ui->G3->graph(0)->setData(S3x,S3y);

    ui->G4->xAxis->setRange(0,l);
    ui->G4->replot();
    ui->G4->update();
    ui->G4->graph(0)->setData(S4x,S4y);

    ui->G5->xAxis->setRange(0,l);
    ui->G5->replot();
    ui->G5->update();
    ui->G5->graph(0)->setData(S5x,S5y);
    l++;
}
