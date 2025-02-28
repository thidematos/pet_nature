import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pet_nature/providers/tab_provider.dart';
import 'package:pet_nature/themes/ui_instances.dart';

class BarcodeScanner extends ConsumerStatefulWidget {
  const BarcodeScanner({super.key});

  @override
  ConsumerState<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends ConsumerState<BarcodeScanner> {
  MobileScannerController cameraController = MobileScannerController(
    formats: [BarcodeFormat.code128],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  Barcode? barcode;

  void onDetectBarcode(BarcodeCapture code) {
    String? strCode = code.barcodes[0].rawValue;
    print(strCode);

    if (strCode == null) return;

    Navigator.of(context).pop(strCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiInstances.appBar(() {}),
      body: MobileScanner(
        controller: cameraController,
        onDetect: onDetectBarcode,
      ),
    );
  }
}
