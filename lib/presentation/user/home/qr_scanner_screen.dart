import 'package:dips/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';



class QRScanScreen extends StatefulWidget {
  const QRScanScreen({Key? key}) : super(key: key);

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  late MobileScannerController controller;
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.start(); // Restart camera when app comes back
    } else {
      controller.stop(); // Stop camera when app is hidden
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 4. Clean up

    controller.dispose();
    super.dispose();
  }

  Key data = Key("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan QR Code',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // QR Code Scanner Frame
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF1A237E),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // LIVE SCANNER REPLACING THE STATIC IMAGE
                        MobileScanner(
                          controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates,

                            autoStart: true,
                          ),
                          onDetect: (capture) {
                            print(capture);
                            final List<Barcode> barcodes = capture.barcodes;
                            for (final barcode in barcodes) {
                              debugPrint('Barcode found! ${barcode.rawValue}');
                              context.push(RoutePath.resultScanner);
                              // Handle your logic here (e.g., Navigator.pop with result)
                            }
                          },
                        ),

                        // Semi-transparent overlay to keep the "Scan2Home" branding visible
                        // but allowing the camera to peek through
                        // Center(
                        //   child: Opacity(
                        //     opacity:
                        //         0.8, // Slightly transparent so user sees camera
                        //     child: Container(
                        //       width: 200,
                        //       padding: const EdgeInsets.all(16),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white.withOpacity(0.9),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       child: _buildBrandingContent(),
                        //     ),
                        //   ),
                        // ),

                        // Corner decorations
                        Positioned(
                          top: 12,
                          left: 12,
                          child: _buildCorner(true, true),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: _buildCorner(true, false),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: _buildCorner(false, true),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: _buildCorner(false, false),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                const Text(
                  'Scan QR Code',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Stand close to the board and hold steady while scanning.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                _buildNoteSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Extracted the branding UI to keep the build method clean
  Widget _buildBrandingContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'FOR SALE',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1A237E), width: 2),
              ),
              child: const Icon(Icons.home, color: Colors.red, size: 20),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scan',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2Home',
                  style: TextStyle(
                    color: Color(0xFF1A237E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoteSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Note',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Only scan verified Scan2Home boards.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(bool isTop, bool isLeft) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? const BorderSide(color: Colors.white, width: 3)
              : BorderSide.none,
          left: isLeft
              ? const BorderSide(color: Colors.white, width: 3)
              : BorderSide.none,
          bottom: !isTop
              ? const BorderSide(color: Colors.white, width: 3)
              : BorderSide.none,
          right: !isLeft
              ? const BorderSide(color: Colors.white, width: 3)
              : BorderSide.none,
        ),
      ),
    );
  }
}
