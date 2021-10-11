import 'package:city_petro/models/PdfDoc.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:velocity_x/velocity_x.dart';

class PdfViewerPage extends StatefulWidget {
  final PdfDoc doc;
  const PdfViewerPage({Key? key, required this.doc}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.doc.name,
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: SfPdfViewer.network(
        widget.doc.url,
        key: _pdfViewerKey,
        
        onDocumentLoadFailed: (details) {
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            //backgroundColor: color,
            content: new Text(details.description),
            duration: Duration(milliseconds: 1500),
          ));
        },
      ),
    );
  }
}
