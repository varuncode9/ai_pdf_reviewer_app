import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

class PdfService {
  static final PdfService _instance = PdfService._internal();
  factory PdfService() => _instance;
  PdfService._internal();

  Future<File?> pickPdfFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> extractTextFromPdf(File pdfFile) async {
    try {
      final PdfDocument document = PdfDocument(inputBytes: await pdfFile.readAsBytes());

      String extractedText = '';

      for (int i = 0; i < document.pages.count; i++) {
        final PdfPage page = document.pages[i];
        final String pageText = PdfTextExtractor(document).extractText(startPageIndex: i, endPageIndex: i);
        extractedText += pageText;
        extractedText += '\n\n';
      }

      document.dispose();

      if (extractedText.trim().isEmpty) {
        return 'No text content found in the PDF. The document may contain only images or scanned content.';
      }

      return extractedText.trim();
    } catch (e) {
      throw Exception('Failed to extract text from PDF: ${e.toString()}');
    }
  }

  String truncateText(String text, {int maxLength = 30000}) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '\n\n[Text truncated due to length...]';
  }
}
