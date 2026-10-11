import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/ebook.dart';
import '../services/ebook_api_service.dart';

class EbookReaderScreen extends StatefulWidget {
  final Ebook ebook;

  const EbookReaderScreen({super.key, required this.ebook});

  @override
  State<EbookReaderScreen> createState() => _EbookReaderScreenState();
}

class _EbookReaderScreenState extends State<EbookReaderScreen> {
  String? localPath;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${widget.ebook.id}_${widget.ebook.title}.pdf';
      final file = File(filePath);

      if (!await file.exists()) {
        final apiService = EbookApiService();
        final ebookId = widget.ebook.id;
        if (ebookId != null) {
          await apiService.downloadEbook(ebookId, filePath);
        } else {
          throw Exception('Ebook ID is missing');
        }
      }

      setState(() {
        localPath = filePath;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ebook.title),
        backgroundColor: Colors.blue.shade700,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error loading PDF: $error'),
                      ElevatedButton(
                        onPressed: _preparePdf,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : PDFView(
                  filePath: localPath,
                  autoSpacing: true,
                  onRender: (pages) {
                    debugPrint('Rendered $pages pages');
                  },
                  onError: (error) {
                    debugPrint('PDF Error: $error');
                  },
                ),
    );
  }
}
