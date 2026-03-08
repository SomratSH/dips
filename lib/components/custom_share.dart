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
  static Future<void> sendMail({
    required String email,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters({
        'subject': subject,
        'body': body,
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw Exception('Could not launch email client');
    }
  }
  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
