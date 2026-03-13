import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dips/components/custom_button.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddProperitesAgent extends StatefulWidget {
  const AddProperitesAgent({super.key});

  @override
  State<AddProperitesAgent> createState() => _AddProperitesAgentState();
}

class _AddProperitesAgentState extends State<AddProperitesAgent> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Media state
  List<File> _selectedImages = [];
  File? _agentVideo;

  // Form Controllers
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _postcodeCtrl = TextEditingController();
  final _bedsCtrl = TextEditingController();
  final _bathsCtrl = TextEditingController();
  final _sizeCtrl = TextEditingController();
  final _parkingCtrl = TextEditingController();

  String _propertyType = 'villa';
  bool _hasPool = false;
  bool _hasGarden = false;

  @override
  void dispose() {
    for (var ctrl in [
      _titleCtrl, _descCtrl, _priceCtrl, _addressCtrl,
      _postcodeCtrl, _bedsCtrl, _bathsCtrl, _sizeCtrl, _parkingCtrl
    ]) {
      ctrl.dispose();
    }
    super.dispose();
  }

  // --- Logic Methods ---

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((xfile) => File(xfile.path)).toList());
      });
    }
  }

  void _showVideoPickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Record Video'),
              onTap: () => _handleVideoPick(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Choose from Gallery'),
              onTap: () => _handleVideoPick(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleVideoPick(ImageSource source) async {
    Navigator.pop(context);
    final XFile? video = await _picker.pickVideo(source: source);
    if (video != null) {
      setState(() => _agentVideo = File(video.path));
    }
  }



Future<void> _saveProperty() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (!_formKey.currentState!.validate()) return;

  // 1. Create the Multipart Request
  var request = http.MultipartRequest(
    'POST',
    
    Uri.parse('https://api.scan2home.co.uk/api/v1/agent/properties/create/',),
  );

  request.headers.addAll({
    'Authorization': 'Bearer ${preferences.getString("authToken")}',
    'Accept': 'application/json', // Good practice for Laravel/Node backends
    'Content-Type': 'multipart/form-data',
  });

  // 2. Add Text Fields (Note: All multipart values are strings)
  request.fields.addAll({
    "title": _titleCtrl.text,
    "description": _descCtrl.text,
    "property_type": _propertyType,
    "price": _priceCtrl.text,
    "address": _addressCtrl.text,
    "postcode": _postcodeCtrl.text,
    "lat": "40.712800", // You can add controllers for these later
    "lon": "-74.006000",
    "status": "available",
    "is_featured": "false",
    "beds": _bedsCtrl.text,
    "baths": _bathsCtrl.text,
    "size_sqft": _sizeCtrl.text,
    "parking_slots": _parkingCtrl.text,
    "has_pool": _hasPool.toString(),
    "has_garden": _hasGarden.toString(),
    "has_garage": "true",
    "has_fireplace": "false",
    "is_smart_home": "true",
    "has_gym": "true",
    "is_pet_friendly": "true",
  });

  // 3. Add Multiple Images
  for (File image in _selectedImages) {
    var stream = http.ByteStream(image.openRead());
    var length = await image.length();
    var multipartFile = http.MultipartFile(
      'uploaded_images', // Field name expected by backend
      stream,
      length,
      filename: image.path.split('/').last,
    );
    request.files.add(multipartFile);
  }

  // 4. Add Video
  if (_agentVideo != null) {
    request.files.add(
      await http.MultipartFile.fromPath(
        'uploaded_video', // Field name expected by backend
        _agentVideo!.path,
      ),
    );
  }

  // 5. Send Request
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    var response = await request.send();

    Navigator.pop(context); // Close loading dialog

    if (response.statusCode == 200 || response.statusCode == 201) {
      AppSnackbar.show(context, title: "Success", message: "Property Uploaded!");
      context.pop();
    } else {
      AppSnackbar.show(context, title: "Error", message: "Server Error: ${response.statusCode}");
    }
  } catch (e) {
    Navigator.pop(context);
    AppSnackbar.show(context, title: "Error", message: e.toString());
  }
}

  // --- UI Components ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text('Add Property', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF6F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(Icons.image, "Property Photos"),
              _buildImageArea(),
              
              const SizedBox(height: 16),
              _buildSectionTitle(Icons.title, "Basic Information"),
              _buildTextField(_titleCtrl, "Modern Villa in London", "Enter title"),
              const SizedBox(height: 12),
              _buildTextField(_descCtrl, "Description", "Enter description", maxLines: 3),

              const SizedBox(height: 16),
              _buildSectionTitle(Icons.home, "Property Details"),
              DropdownButtonFormField<String>(
                value: _propertyType,
                items: ['apartment', 'villa', 'office', 'plot']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
                    .toList(),
                onChanged: (v) => setState(() => _propertyType = v!),
                decoration: _inputDecoration("Type"),
              ),
              
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildTextField(_priceCtrl, "Price", "Enter price", isNumber: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField(_postcodeCtrl, "Postcode", "Enter postcode")),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(_addressCtrl, "123 Baker Street, London", "Enter address"),

              const SizedBox(height: 16),
              _buildSectionTitle(Icons.king_bed, "Specifications"),
              Row(
                children: [
                  Expanded(child: _buildTextField(_bedsCtrl, "Beds", "0", isNumber: true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField(_bathsCtrl, "Baths", "0", isNumber: true)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField(_parkingCtrl, "Parking", "0", isNumber: true)),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(_sizeCtrl, "Size (sqft)", "2500", isNumber: true),

              const SizedBox(height: 16),
              _buildSectionTitle(Icons.featured_play_list, "Amenities"),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text("Swimming Pool"),
                      value: _hasPool,
                      onChanged: (v) => setState(() => _hasPool = v),
                    ),
                    SwitchListTile(
                      title: const Text("Garden"),
                      value: _hasGarden,
                      onChanged: (v) => setState(() => _hasGarden = v),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _buildSectionTitle(Icons.video_call, "Agent Video"),
              _buildVideoArea(),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: _saveProperty,
                  title: "Save Property",
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageArea() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImages,
          child: const DottedImageUpload(),
        ),
        if (_selectedImages.isNotEmpty) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(_selectedImages[index], width: 80, height: 80, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedImages.removeAt(index)),
                      child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 12, color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildVideoArea() {
    return GestureDetector(
      onTap: _showVideoPickerOptions,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _agentVideo != null ? Colors.green.withOpacity(0.05) : const Color(0xFFF3F3F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _agentVideo != null ? Colors.green : const Color(0xFFCAD5E2)),
        ),
        child: Column(
          children: [
            Icon(
              _agentVideo != null ? Icons.check_circle : Icons.cloud_upload_outlined,
              size: 40, 
              color: _agentVideo != null ? Colors.green : Colors.blueGrey
            ),
            const SizedBox(height: 10),
            Text(
              _agentVideo != null 
                ? "Video Selected: ${_agentVideo!.path.split('/').last}" 
                : "Upload Agent Walkthrough Video",
              style: TextStyle(color: _agentVideo != null ? Colors.green : Colors.blueGrey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, String error, {bool isNumber = false, int maxLines = 1}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: _inputDecoration(hint),
      validator: (v) => (v == null || v.isEmpty) ? error : null,
    );
  }
}

class DottedImageUpload extends StatelessWidget {
  const DottedImageUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCAD5E2), style: BorderStyle.solid),
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, color: Colors.red),
            SizedBox(width: 10),
            Text('Tap to add property images', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}