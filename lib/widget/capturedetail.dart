import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

Dialog captureDetailBook(BuildContext context) {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<void> captureAndRecognizeText() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final inputImage = InputImage.fromFilePath(photo.path);

      try {
        final RecognizedText recognizedText =
            await _textRecognizer.processImage(inputImage);
        String detectedText = recognizedText.text;
        List<String> lines = detectedText.split('\n');
        String title = lines.isNotEmpty ? lines[0] : "No title detected";
        String author = lines.length > 1 ? lines[1] : "No author detected";

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmed Book Details"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text("Tajuk: ", style: GoogleFonts.mulish(fontSize: 16)),
                    Flexible(
                        child: Text(title,
                            style: GoogleFonts.mulish(fontSize: 16))),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text("Penulis: ", style: GoogleFonts.mulish(fontSize: 16)),
                    Flexible(
                        child: Text(author,
                            style: GoogleFonts.mulish(fontSize: 16))),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print("Error recognizing text: $e");
        }
      }
    }
  }

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
      height: 350,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/Vector.png', scale: 2.5),
          const SizedBox(height: 20),
          Text(
            'Scan your book cover to',
            style: GoogleFonts.mulish(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'start adding it in your Library',
            style: GoogleFonts.mulish(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color(0xFF175844)),
            ),
            onPressed: captureAndRecognizeText,
            child: Text(
              'Scan Cover',
              style: GoogleFonts.mulish(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Skip for now',
              style: GoogleFonts.mulish(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
