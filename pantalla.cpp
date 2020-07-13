#include "pantalla.h"
#include "ui_pantalla.h"
#include <iostream>


using namespace std;
pantalla::pantalla(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::pantalla)
{
    QString SN1 = "Pulso";
    ui->setupUi(this);
    ui->L1->setText(SN1);
    ui->L2->setText("Presion Diastollica");
    ui->L3->setText("Presion Sistolica");
    ui->L4->setText("Tasa Respiratoria");
    ui->L5->setText("Saturación Oxigeno");
    QVector<double> S1x(500), S1y(500);
    for(int i=0;i<300;++i){
        S1x[i]=i;
        S1y[i+200]=i;
    }
    QVector<double> S2x(500), S2y(500);
    for(int i=0;i<500;++i){

    }
    QVector<double> S3x(500), S3y(500);
    for(int i=0;i<500;++i){

    }
    QVector<double> S4x(500), S4y(500);
    for(int i=0;i<300;++i){

    }
    QVector<double> S5x(500), S5y(500);
    for(int i=0;i<300;++i){

    }

    //Sensor1
    ui->G1->addGraph();
    ui->G1->graph(0)->setData(S1x,S1y);
    ui->G1->xAxis->setLabel("x");
    ui->G1->yAxis->setLabel("y");
    ui->G1->xAxis->setRange(0,300);
    ui->G1->yAxis->setRange(0,500);
    ui->G1->replot();
    //Sensor2
    ui->G2->addGraph();
    ui->G2->graph(0)->setData(S2x,S2y);
    ui->G2->xAxis->setLabel("x");
    ui->G2->yAxis->setLabel("y");
    ui->G2->xAxis->setRange(0,300);
    ui->G2->yAxis->setRange(0,500);
    ui->G2->replot();
    //Sensor3
    ui->G3->addGraph();
    ui->G3->graph(0)->setData(S3x,S3y);
    ui->G3->xAxis->setLabel("x");
    ui->G3->yAxis->setLabel("y");
    ui->G3->xAxis->setRange(0,300);
    ui->G3->yAxis->setRange(0,500);
    ui->G3->replot();
    //Sensor4
    ui->G4->addGraph();
    ui->G4->graph(0)->setData(S4x,S4y);
    ui->G4->xAxis->setLabel("x");
    ui->G4->yAxis->setLabel("y");
    ui->G4->xAxis->setRange(0,300);
    ui->G4->yAxis->setRange(0,500);
    ui->G4->replot();
    //Sensor5
    ui->G5->addGraph();
    ui->G5->graph(0)->setData(S5x,S5y);
    ui->G5->xAxis->setLabel("x");
    ui->G5->yAxis->setLabel("y");
    ui->G5->xAxis->setRange(0,300);
    ui->G5->yAxis->setRange(0,500);
    ui->G5->replot();

}

pantalla::~pantalla()
{
    delete ui;
}

void pantalla::on_pushButton_clicked(bool checked)
{
    ui->L3->setText("holi");
}
