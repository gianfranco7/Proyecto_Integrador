#include "pantalla.h"
#include "ui_pantalla.h"
#include <iostream>


using namespace std;
QVector<double> S1x(500), S1y(500);
QVector<double> S2x(500), S2y(500);
QVector<double> S3x(500), S3y(500);
QVector<double> S4x(500), S4y(500);
QVector<double> S5x(500), S5y(500);
//extern double promedio;
//extern double menor;
//extern double mayor;

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
    ui->uni1->setText("n/a");
    ui->uni2->setText("n/a");
    ui->uni3->setText("n/a");
    ui->uni4->setText("n/a");
    ui->uni5->setText("n/a");

    int jk =0;
    for(int i=0;i<300;++i){
        S1x[i]=i;
        jk = jk+4;
        S1y[i]=(jk%5)*50;
        S2x[i]=i;
        S2y[i]=(jk%7)*50;
        S3x[i]=i;
        S3y[i]=(jk%10)*50;
        S4x[i]=i;
        S4y[i]=(jk%12)*50;
        S5x[i]=i;
        S5y[i]=(jk%15)*50;
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
    ui->G3->yAxis->setRange(0,400);
    ui->G3->replot();
    //Sensor4
    ui->G4->addGraph();
    ui->G4->xAxis->setRange(0,300);
    ui->G4->yAxis->setRange(0,400);
    ui->G4->replot();
    //Sensor5
    ui->G5->addGraph();
    ui->G5->xAxis->setRange(0,300);
    ui->G5->yAxis->setRange(0,400);
    ui->G5->replot();

}

pantalla::~pantalla()
{
    delete ui;
}

double l=0;
double min1 = 500;
double min2 = 500;
double min3 = 500;
double min4 = 500;
double min5 = 500;
double max1 = 0;
double max2 = 0;
double max3 = 0;
double max4 = 0;
double max5 = 0;
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
    //QString prome1 = mayor(S1y[l], S1y[l+1]);
    double prome1 =0;
    for (int k=1; k<=l;k++){
        prome1 = (prome1+S1y[k])/k;
    }
    ui->prom1->setText("Promedio: " +QString::number((prome1)));
    if (min1> S1y[l]){
        min1 = S1y[l];
        ui->min1->setText("Minimo: " +QString::number((min1)));
    }
    if (max1 < S1y[l]){
        max1 = S1y[l];
        ui->mx1->setText("Maximo: " +QString::number((max1)));
    }

    ui->G2->xAxis->setRange(0,l);
    ui->G2->replot();
    ui->G2->update();
    ui->G2->graph(0)->setData(S2x,S2y);
    double prome2 =0;
    for (int k=1; k<=l;k++){
        prome2 = (prome2+S2y[k])/k;
    }
    ui->prom2->setText("Promedio: " +QString::number((prome2)));
    if (min2> S2y[l]){
        min2 = S2y[l];
        ui->min2->setText("Minimo: " +QString::number((min2)));
    }
    if (max2 < S2y[l]){
        max2 = S2y[l];
        ui->mx2->setText("Maximo: " +QString::number((max2)));
    }


    ui->G3->xAxis->setRange(0,l);
    ui->G3->replot();
    ui->G3->update();
    ui->G3->graph(0)->setData(S3x,S3y);
    double prome3 =0;
    for (int k=1; k<=l;k++){
        prome3 = (prome3+S3y[k])/k;
    }
    ui->prom3->setText("Promedio: " +QString::number((prome3)));
    if (min3> S3y[l]){
        min3 = S3y[l];
        ui->min3->setText("Minimo: " +QString::number((min3)));
    }
    if (max3 < S3y[l]){
        max3 = S3y[l];
        ui->mx3->setText("Maximo: " +QString::number((max3)));
    }


    ui->G4->xAxis->setRange(0,l);
    ui->G4->replot();
    ui->G4->update();
    ui->G4->graph(0)->setData(S4x,S4y);
    double prome4 =0;
    for (int k=1; k<=l;k++){
        prome4 = (prome4+S4y[k])/k;
    }
    ui->prom4->setText("Promedio: " +QString::number((prome4)));
    if (min4> S4y[l]){
        min4 = S4y[l];
        ui->min4->setText("Minimo: " +QString::number((min4)));
    }
    if (max4 < S4y[l]){
        max4 = S4y[l];
        ui->mx4->setText("Maximo: " +QString::number((max4)));
    }

    ui->G5->xAxis->setRange(0,l);
    ui->G5->replot();
    ui->G5->update();
    ui->G5->graph(0)->setData(S5x,S5y);
    double prome5 =0;
    for (int k=1; k<l;k++){
        prome5 = (prome5+S5y[k])/k;
    }
    ui->prom5->setText("Promedio: " +QString::number((prome5)));
    if (min5> S5y[l]){
        min5 = S5y[l];
    }
    ui->min5->setText("Minimo: " +QString::number((min5)));
    if (max5 < S5y[l]){
        max5 = S5y[l];
        ui->mx5->setText("Maximo: " +QString::number((max5)));
    }
    l++;
}


