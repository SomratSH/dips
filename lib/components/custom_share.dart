import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void onShare(BuildContext context) async {
  // 1. Get the render box for iPad support (iPad needs a specific position for the popup)
  final box = context.findRenderObject() as RenderBox?;

  // 2. Trigger the share sheet
  await Share.share(
    'Check out the code I scanned! https://example.com',
    subject: 'Scanned QR Result',
    // The sharePositionOrigin is required for iPads, otherwise the app might crash
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}

class ContactActions {
  // 1. Open Phone Dialer
  static Future<void> openDialer(String phoneNumber) async {
    final Uri telLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(telLaunchUri)) {
      throw Exception('Could not launch dialer');
    }
  }

  // 2. Open WhatsApp Direct Message
  static Future<void> openWhatsApp(String phoneNumber, String message) async {
    // Number format: CountryCode + Number (no '+', no spaces)
    // Example: 919876543210
    final String url =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    final Uri whatsappUri = Uri.parse(url);

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(
        whatsappUri,
        mode: LaunchMode
            .externalApplication, // Forces it to open the App, not a browser
      );
    } else {
      // Fallback: If app isn't installed, try opening in browser (WhatsApp Web)
      await launchUrl(whatsappUri, mode: LaunchMode.platformDefault);
    }
  }
}
