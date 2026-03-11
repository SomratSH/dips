import 'package:dips/components/custom_loading_dialog.dart';
import 'package:dips/components/custom_padding.dart';
import 'package:dips/components/custom_snackbar.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:dips/presentation/user/home/home_provider.dart';
import 'package:dips/presentation/user/profile/edit_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditAgentProfile extends StatefulWidget {
  const EditAgentProfile({Key? key}) : super(key: key);

  @override
  State<EditAgentProfile> createState() => _EditAgentProfileState();
}

class _EditAgentProfileState extends State<EditAgentProfile> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _brandController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();

  bool _isProfileTab = true;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  String? _errorMessage;

  void _validateAndUpdatePassword() {
    setState(() {
      _errorMessage = null;
    });

    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
      });
      return;
    }

    if (_newPasswordController.text.length < 8) {
      setState(() {
        _errorMessage = 'Password must be at least 8 characters long.';
      });
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }

    // Success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password updated successfully!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );

    // Clear fields
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final v = context.read<HomeAgentProvider>();
    _fullNameController = TextEditingController(
      text: v.agentProfileModel.fullName,
    );
    _phoneController = TextEditingController(text: v.agentProfileModel.phone);
    _emailController = TextEditingController(text: v.agentProfileModel.email);

    _brandController = TextEditingController(
      text: v.agentProfileModel.agentProfile!.brandName!,
    );

    _websiteController = TextEditingController(
      text: v.agentProfileModel.agentProfile!.website!,
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(
                color: const Color(0xFF041E41),
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),
            ),
            _buildTabBar(),
            Expanded(
              child: SingleChildScrollView(
                child: _isProfileTab == true
                    ? Column(
                        children: [
                          const SizedBox(height: 24),
                          _buildBandingHeader(provider),
                          const SizedBox(height: 24),
                          _buildProfileHeader(provider),

                          const SizedBox(height: 24),
                          _buildButtons(provider),
                          const SizedBox(height: 32),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DecoratedBox(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.62),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 24.36,
                                offset: Offset(0, 4.87),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: _buildHeader(),
                                ),
                                const SizedBox(height: 24),
                                _buildPasswordForm(),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.shield_outlined, color: Color(0xFFEF4444), size: 24),
            SizedBox(width: 8),
            Text(
              'Password & Security',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Manage your password and security settings',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildPasswordForm() {
    return Container(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPasswordField(
            controller: _currentPasswordController,
            label: 'Current Password',
            obscureText: _obscureCurrentPassword,
            onToggleVisibility: () {
              setState(() {
                _obscureCurrentPassword = !_obscureCurrentPassword;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildPasswordField(
            controller: _newPasswordController,
            label: 'New Password',
            obscureText: _obscureNewPassword,
            onToggleVisibility: () {
              setState(() {
                _obscureNewPassword = !_obscureNewPassword;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildPasswordField(
            controller: _confirmPasswordController,
            label: 'Confirm New Password',
            hintText: 'Must be at least 8 characters...',
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _validateAndUpdatePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Update Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lock_outline, size: 18, color: Color(0xFFEF4444)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey[600],
                  size: 20,
                ),
                onPressed: onToggleVisibility,
              ),
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1F2937)),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isProfileTab = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isProfileTab
                      ? const Color(0xFFEF4444)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _isProfileTab ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isProfileTab = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isProfileTab
                      ? const Color(0xFFEF4444)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Security',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: !_isProfileTab ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBandingHeader(HomeAgentProvider provider) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/dinein.svg"),
                  CustomPadding().hPad5,
                  Text(
                    'Branding',
                    style: TextStyle(
                      color: const Color(0xFF041E41),
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                'Customize your brand appearance',
                style: TextStyle(
                  color: const Color(0xFF041E41),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ],
          ),
          CustomPadding().vPad20,

          Row(
            children: [
              CircleAvatar(
                child: provider.selectedLogo != null
                    ? Image.file(provider.selectedLogo!)
                    : provider.agentProfileModel.agentProfile!.logo != null
                    ? Image.network(
                        provider.agentProfileModel.agentProfile!.logo!,
                      )
                    : Image.asset("assets/image/Text.png"),
              ),
              CustomPadding().hPad10,
              InkWell(
                onTap: () => showImagePickerBottomSheetV(context),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.11,
                        color: Colors.black.withValues(alpha: 0.10),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: Row(
                    children: [
                      Icon(Icons.file_upload_outlined),
                      CustomPadding().hPad5,
                      Text(
                        'Upload New Logo',
                        style: TextStyle(
                          color: const Color(0xFF0A0A0A),
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _brandController,
            icon: Icons.person_outline,
            label: 'Company Name',
            iconColor: const Color(0xFFEF4444),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _websiteController,
            icon: Icons.phone_outlined,
            label: 'Website',
            iconColor: const Color(0xFFEF4444),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(HomeAgentProvider provider) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/agent.svg",
                    color: Theme.of(context).primaryColor,
                  ),
                  CustomPadding().hPad5,
                  Text(
                    'Agent Information',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                'Update your profile details',
                style: TextStyle(
                  color: const Color(0xFF717182),
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          CustomPadding().vPad20,
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: provider.selectedImage != null
                        ? FileImage(provider.selectedImage!)
                        : provider.agentProfileModel.profilePicture != null
                        ? NetworkImage(
                            "https://scan2home.selimreza.dev" +  provider.agentProfileModel.profilePicture!,
                          )
                        : NetworkImage(
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () => showImagePickerBottomSheet(context),
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _fullNameController,
            icon: Icons.person_outline,
            label: 'Full Name',
            iconColor: const Color(0xFFEF4444),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            iconColor: const Color(0xFFEF4444),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            icon: Icons.email_outlined,
            label: 'Email Address',
            iconColor: const Color(0xFFEF4444),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTextField(
            controller: _fullNameController,
            icon: Icons.person_outline,
            label: 'Full Name',
            iconColor: const Color(0xFFEF4444),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            iconColor: const Color(0xFFEF4444),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            icon: Icons.email_outlined,
            label: 'Email Address',
            iconColor: const Color(0xFFEF4444),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required Color iconColor,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            style: const TextStyle(fontSize: 15, color: Color(0xFF1F2937)),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(HomeAgentProvider proivder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async{
                 CustomLoading.show(context);

                final response = await proivder.updateAgentProfile({
                  "full_name" : _fullNameController.text,
                  "phone" : _phoneController.text,
                  "agent_profile": {"brand_name": _brandController.text, "website" : _websiteController.text},
                });

                if(response){
                  CustomLoading.hide(context);
                  AppSnackbar.show(context, title: "Profile Update", message:"Profile Update Successfully",type: SnackType.success);
                }else{
                      CustomLoading.hide(context);
                  AppSnackbar.show(context, title: "Profile Update", message:"Profile Update Not Successfully", type: SnackType.error);
                }
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
               

               context.pop();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFFEF4444)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Gallery
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<HomeAgentProvider>().pickFromGallery();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.photo, size: 28),
                      ),
                      SizedBox(height: 8),
                      Text("Gallery"),
                    ],
                  ),
                ),

                /// Camera
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<HomeAgentProvider>().pickFromCamera();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.camera_alt, size: 28),
                      ),
                      SizedBox(height: 8),
                      Text("Camera"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showImagePickerBottomSheetV(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Gallery
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<HomeAgentProvider>().pickFromGalleryv();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.photo, size: 28),
                      ),
                      SizedBox(height: 8),
                      Text("Gallery"),
                    ],
                  ),
                ),

                /// Camera
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<HomeAgentProvider>().pickFromCamerav();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.camera_alt, size: 28),
                      ),
                      SizedBox(height: 8),
                      Text("Camera"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
