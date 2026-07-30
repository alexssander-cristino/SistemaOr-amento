import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';



class PdfService {



static Future<void> gerarOrcamento({


required String cliente,

required String evento,

required List servicos,

required double total


}) async {



final pdf = pw.Document();




pdf.addPage(



pw.Page(



pageFormat: PdfPageFormat.a4,



build:(context){



return pw.Column(



crossAxisAlignment:

pw.CrossAxisAlignment.start,



children:[



pw.Center(

child:

pw.Text(

"ORÇAMENTO DE EVENTO",

style:

pw.TextStyle(

fontSize:24,

fontWeight:

pw.FontWeight.bold

)

)

),




pw.SizedBox(height:20),





pw.Text(

"Cliente: $cliente"

),




pw.Text(

"Evento: $evento"

),





pw.SizedBox(height:30),





pw.Text(

"SERVIÇOS CONTRATADOS",

style:

pw.TextStyle(

fontSize:18,

fontWeight:

pw.FontWeight.bold

)

),





pw.SizedBox(height:10),






pw.Table(



border:

pw.TableBorder.all(),



children:[




pw.TableRow(



children:[


celula("Serviço"),

celula("Qtd"),

celula("Valor Unit."),

celula("Subtotal"),



]


),






...servicos.map((item){



final servico =

item['servico'];




String nome =

"Serviço";




if(servico != null){

nome = servico['nome'] ?? "Serviço";

}

else{

nome = item['nome'] ?? "Serviço";

}






double valor =

double.tryParse(

(item['valor_unitario'] ??

item['valor'] ??

0)

.toString()

)

??

0;







int quantidade =

int.tryParse(

(item['quantidade'] ?? 1)

.toString()

)

??

1;







double subtotal =

double.tryParse(

(item['subtotal'] ??

(valor * quantidade))

.toString()

)

??

0;






return pw.TableRow(



children:[


celula(nome),


celula(

quantidade.toString()

),



celula(

"R\$ ${valor.toStringAsFixed(2)}"

),




celula(

"R\$ ${subtotal.toStringAsFixed(2)}"

),



]

);



})





]

),







pw.SizedBox(height:30),





pw.Align(



alignment:

pw.Alignment.centerRight,



child:

pw.Text(



"TOTAL: R\$ ${total.toStringAsFixed(2)}",



style:

pw.TextStyle(

fontSize:20,

fontWeight:

pw.FontWeight.bold

)





)



)





]

);



}



)

);







final dir =

await getTemporaryDirectory();






final file = File(

"${dir.path}/orcamento.pdf"

);






await file.writeAsBytes(

await pdf.save()

);








await Share.shareXFiles(

[

XFile(file.path)

],


text:

"Orçamento de evento"

);



}







static pw.Widget celula(String texto){



return pw.Padding(



padding:

const pw.EdgeInsets.all(6),



child:

pw.Text(texto)



);



}



}