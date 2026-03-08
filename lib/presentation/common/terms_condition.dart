import 'package:flutter/material.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Terms and Condition',
          style: TextStyle(
            color: Color(0xFF1A335D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Introduction
          _buildMainCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader("1. Introduction"),
                const SizedBox(height: 12),
                _bodyText(
                  "At Scan2Home, we take your privacy seriously. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.",
                ),
                const SizedBox(height: 16),
                _bodyText(
                  "Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.",
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Section 2: Information We Collect
          _buildMainCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader("2. Information We Collect"),
                const SizedBox(height: 12),
                _bodyText(
                  "We collect information that you provide directly to us and information automatically collected when you use our services.",
                ),
                const SizedBox(height: 20),

                // Subsection 2.1
                _buildSubSection("2.1 Personal Information", [
                  "Name and contact information",
                  "Email address",
                  "Phone number",
                  "Account credentials",
                  "Profile information",
                ]),

                // Subsection 2.2
                _buildSubSection("2.2 Property Search Data", [
                  "Search queries and filters",
                  "Saved properties and favorites",
                  "Viewing requests and appointments",
                  "Communication with agents",
                ]),

                // Subsection 2.3
                _buildSubSection("2.3 Device and Usage Information", [
                  "Device type and operating system",
                  "IP address and location data",
                  "App usage statistics",
                  "QR code scan data",
                  "Camera access for QR scanning",
                ], isLast: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build the white outer cards
  Widget _buildMainCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  // Helper for the light blue-grey subsections
  Widget _buildSubSection(
    String title,
    List<String> items, {
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF34495E),
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey.shade700,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.blueGrey.shade600,
        height: 1.5,
      ),
    );
  }
}
