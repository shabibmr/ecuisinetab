// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/material.dart';

// class QRScanner extends StatefulWidget {
//   QRScanner({Key? key}) : super(key: key);

//   @override
//   State<QRScanner> createState() => _QRScannerState();
// }

// class _QRScannerState extends State<QRScanner> {
//   String? barcode;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(' Scanner - $barcode'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               child: const Text('Scan'),
//               onPressed: () async {
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => AiBarcodeScanner(
//                       // validateText: 'https://', // link to be validated
//                       // validateType: ValidateType.startsWith,
//                       canPop: true,
//                       onScan: (String value) {
//                         debugPrint(value);
//                         setState(() {
//                           barcode = value;
//                         });
//                       },
//                       onDetect: (p0) {},
//                       controller: MobileScannerController(
//                         detectionSpeed: DetectionSpeed.noDuplicates,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Text(barcode ?? 'No Scan Yet'),
//           ],
//         ),
//       ),
//     );
//   }
// }
