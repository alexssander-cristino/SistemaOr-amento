import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:path_provider/path_provider.dart';

import 'package:share_plus/share_plus.dart';





class PdfService {



static Future<void> gerarOrcamento({


required String cliente,

required String evento,

required List servicos,

required double total


}) async{



final pdf =
pw.Document();




pdf.addPage(



pw.Page(



build:(context){



return pw.Column(



crossAxisAlignment:

pw.CrossAxisAlignment.start,



children:[




pw.Text(

"ORÇAMENTO DE EVENTO",

style:

pw.TextStyle(

fontSize:24,

fontWeight:

pw.FontWeight.bold

)

),



pw.SizedBox(height:20),





pw.Text(

"Cliente: $cliente"

),




pw.Text(

"Evento: $evento"

),






pw.SizedBox(height:20),





pw.Text(

"Serviços",

style:

pw.TextStyle(

fontSize:18,

fontWeight:

pw.FontWeight.bold

)

),






...servicos.map((s){



return pw.Text(

"${s['nome']} - R\$ ${s['valor']}"

);



}),






pw.Divider(),






pw.Text(

"Total: R\$ ${total.toStringAsFixed(2)}",

style:

pw.TextStyle(

fontSize:20,

fontWeight:

pw.FontWeight.bold

)

)







]

);



}



)





);







final dir =

await getTemporaryDirectory();



final file =

File(

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



}