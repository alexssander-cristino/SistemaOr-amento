class Orcamento {


  final int? id;

  final int eventoId;

  final String? eventoNome;

  final double desconto;

  final double valorTotal;

  final String status;


  final List itens;

  final List pagamentos;





  Orcamento({

    this.id,

    required this.eventoId,

    this.eventoNome,

    required this.desconto,

    required this.valorTotal,

    required this.status,

    this.itens = const [],

    this.pagamentos = const [],

  });








  factory Orcamento.fromJson(
      Map<String,dynamic> json
      ){


    return Orcamento(


      id:
      json['id'],



      eventoId:

      json['evento_id'] ?? 0,




      eventoNome:

      json['evento'] != null

          ?

      json['evento']['tipo'] ??

          json['evento']['nome']

          :

      null,





      desconto:

      double.tryParse(

          json['desconto']
              .toString()

      ) ?? 0,






      valorTotal:

      double.tryParse(

          json['valor_total']
              .toString()

      ) ?? 0,






      status:

      json['status'] ?? 'pendente',





      itens:

      json['itens'] ?? [],





      pagamentos:

      json['pagamentos'] ?? [],



    );


  }









  Map<String,dynamic> toJson(){


    return {



      "id":

      id,



      "evento_id":

      eventoId,



      "desconto":

      desconto,



      "valor_total":

      valorTotal,



      "status":

      status,



      "itens":

      itens,



      "pagamentos":

      pagamentos,



    };


  }






}

