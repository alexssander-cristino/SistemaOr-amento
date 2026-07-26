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



    return Container(


      height:300,


      padding:const EdgeInsets.all(20),



      decoration:BoxDecoration(


        color:Colors.white,


        borderRadius:
        BorderRadius.circular(15),



      ),




      child:BarChart(


        BarChartData(



          alignment:
          BarChartAlignment.spaceAround,



          maxY:10,



          barGroups:[



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





          titlesData:FlTitlesData(



            bottomTitles:AxisTitles(


              sideTitles:SideTitles(


                showTitles:true,



                getTitlesWidget:(value,meta){



                  switch(value.toInt()){


                    case 0:
                      return const Text("Clientes");


                    case 1:
                      return const Text("Eventos");


                    case 2:
                      return const Text("Serviços");


                    case 3:
                      return const Text("Orç.");

                    default:
                      return const Text("");

                  }


                },


              ),


            ),



            leftTitles:const AxisTitles(

              sideTitles:
              SideTitles(

                showTitles:true,

              )

            ),


          ),



        ),



      ),



    );


  }









  BarChartGroupData criarBarra(

      int x,

      int valor

      ){



    return BarChartGroupData(


      x:x,


      barRods:[


        BarChartRodData(


          toY:
          valor.toDouble(),



          width:25,



          borderRadius:
          BorderRadius.circular(5),


        )


      ],


    );


  }





}