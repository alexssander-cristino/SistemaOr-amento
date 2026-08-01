import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class GraficoWidget extends StatelessWidget {


  final int clientes;
  final int eventos;
  final int servicos;
  final int orcamentos;




  const GraficoWidget({

    super.key,

    required this.clientes,

    required this.eventos,

    required this.servicos,

    required this.orcamentos,

  });







  @override
  Widget build(BuildContext context) {



    final maiorValor = [

      clientes,

      eventos,

      servicos,

      orcamentos,


    ].reduce((a,b)=>a>b?a:b);






    final limiteGrafico = maiorValor <= 0

        ? 5

        : maiorValor + (maiorValor * 0.2);







    final intervalo = calcularIntervalo(maiorValor);







    return Container(


      height: 320,


      padding: const EdgeInsets.all(20),



      decoration: BoxDecoration(


        color: Colors.white,


        borderRadius: BorderRadius.circular(15),


      ),




      child: BarChart(



        BarChartData(



          minY: 0,



          maxY: limiteGrafico.toDouble(),





          alignment: BarChartAlignment.spaceAround,







          barGroups: [



            criarBarra(
              0,
              clientes,
            ),



            criarBarra(
              1,
              eventos,
            ),



            criarBarra(
              2,
              servicos,
            ),



            criarBarra(
              3,
              orcamentos,
            ),



          ],







          titlesData: FlTitlesData(





            bottomTitles: AxisTitles(


              sideTitles: SideTitles(


                showTitles: true,



                getTitlesWidget: (value, meta){



                  switch(value.toInt()){



                    case 0:

                      return const Text(
                        "Clientes",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      );



                    case 1:

                      return const Text(
                        "Eventos",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      );



                    case 2:

                      return const Text(
                        "Serviços",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      );



                    case 3:

                      return const Text(
                        "Orç.",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      );



                    default:

                      return const Text("");

                  }



                },

              ),


            ),








            leftTitles: AxisTitles(



              sideTitles: SideTitles(



                showTitles: true,



                interval: intervalo,



                reservedSize: tamanhoNumero(maiorValor),





                getTitlesWidget:(value,meta){



                  return Text(



                    value.toInt().toString(),



                    style: const TextStyle(


                      fontSize: 10,


                    ),


                  );


                },



              ),



            ),







            rightTitles: const AxisTitles(


              sideTitles: SideTitles(

                showTitles:false,

              ),


            ),






            topTitles: const AxisTitles(


              sideTitles: SideTitles(

                showTitles:false,

              ),


            ),



          ),







          gridData: FlGridData(


            show:true,


          ),






          borderData: FlBorderData(


            show:false,


          ),



        ),



      ),



    );


  }













  double calcularIntervalo(int valor){



    if(valor <= 10){


      return 1;


    }



    if(valor <= 50){


      return 5;


    }



    if(valor <= 200){


      return 20;


    }



    if(valor <= 1000){


      return 100;


    }



    return 500;



  }












  double tamanhoNumero(int valor){



    if(valor >= 1000){


      return 55;


    }



    if(valor >= 100){


      return 45;


    }



    if(valor >= 10){


      return 35;


    }



    return 25;



  }












  BarChartGroupData criarBarra(



      int x,

      int valor



      ){



    return BarChartGroupData(



      x:x,



      barRods:[



        BarChartRodData(



          toY: valor.toDouble(),



          width:25,



          borderRadius: BorderRadius.circular(5),



        ),



      ],



    );



  }




}