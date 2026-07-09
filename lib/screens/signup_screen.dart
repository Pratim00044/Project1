import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'dart:math' as math;
import '../roles/organization/organization_home.dart';
import '../roles/player/player_home.dart';
import '../roles/coach/coach_home.dart';
import '../roles/manager/manager_home.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _clubCodeController = TextEditingController();
  
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _dobController = TextEditingController();
  final _parentEmailController = TextEditingController();
  String? _selectedFoot;
  String? _selectedPosition;

  bool _obscurePassword = true;
  bool _isClubCodeStep = true;

  String? _idProofName;
  String? _photoName;

  Future<void> _pickFile(bool isIdProof) async {
    fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        if (isIdProof) {
          _idProofName = result.files.single.name;
        } else {
          _photoName = result.files.single.name;
        }
      });
    }
  }

  final List<Map<String, dynamic>> _roles = [
    {'name': 'PLAYER', 'icon': Icons.directions_run_outlined, 'color': Colors.blueAccent},
    {'name': 'ORGANIZER/HOST', 'icon': Icons.groups_outlined, 'color': Colors.blueAccent},
    {'name': 'COACH', 'icon': Icons.sports_outlined, 'color': Colors.orangeAccent},
    {'name': 'MANAGER', 'icon': Icons.manage_accounts_outlined, 'color': Colors.purpleAccent},
  ];

  late PageController _pageController;
  late VideoPlayerController _videoController;
  int _currentIndex = 0;
  double _buttonScale = 1.0;
  double _linkScale = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.25,
      initialPage: _currentIndex,
    );
    _videoController = VideoPlayerController.asset('assets/Video/Banner.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _dobController.dispose();
    _parentEmailController.dispose();
    _clubCodeController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: goldColor,
              onPrimary: Colors.black,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF080808),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _handleRegister() {
    String roleName = _roles[_currentIndex]['name'];
    if (roleName != 'ORGANIZER/HOST' && _isClubCodeStep) {
      if (_clubCodeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid Club Code to continue.')),
        );
        return;
      }
      setState(() => _isClubCodeStep = false);
      return;
    }

    if (_formKey.currentState!.validate()) {
      if (roleName == 'PLAYER') {
        if (_selectedFoot == null || _selectedPosition == null || _heightController.text.isEmpty || _weightController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All stats are mandatory for this role.')),
          );
          return;
        }
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      if (_roles[_currentIndex]['name'] == 'ORGANIZER/HOST') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration submitted. Awaiting Super Admin verification.')),
        );
      }
      
      Widget homePage;
      switch (_roles[_currentIndex]['name']) {
        case 'ORGANIZER/HOST':
          homePage = const OrganizationHome();
          break;
        case 'PLAYER':
          homePage = const PlayerHome();
          break;
        case 'COACH':
          homePage = const CoachHome();
          break;
        case 'MANAGER':
          homePage = const ManagerHome();
          break;
        default:
          homePage = const CoachHome();
          break;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homePage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 900;
          double formWidth = isDesktop ? 450 : constraints.maxWidth;
          
          double currentFraction = isDesktop ? 0.2 : 0.35; 
          if (_pageController.viewportFraction != currentFraction) {
            _pageController = PageController(
              viewportFraction: currentFraction,
              initialPage: _currentIndex,
            );
          }
          
          return Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width > 0 ? _videoController.value.size.width : 1920,
                    height: _videoController.value.size.height > 0 ? _videoController.value.size.height : 1080,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
              
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        goldColor.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              SafeArea(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          _buildLogo(),
                          
                          const SizedBox(height: 20),
                          _buildInteractiveCurvedSelector(isDesktop),
                          
                          const SizedBox(height: 20),
                          
                          Container(
                            width: formWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (_roles[_currentIndex]['name'] != 'ORGANIZER/HOST' && _isClubCodeStep) ...[
                                        _buildLabel('Club Code', Icons.qr_code_scanner_rounded),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          controller: _clubCodeController,
                                          hint: 'Enter your club invitation code',
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 12.0),
                                          child: Text(
                                            '* Obtain this code from your club organizer.',
                                            style: TextStyle(color: goldColor, fontSize: 10, fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ] else ...[
                                        if (_roles[_currentIndex]['name'] != 'ORGANIZER/HOST') ...[
                                          _buildLabel('Club Code', Icons.qr_code_scanner_rounded),
                                          const SizedBox(height: 10),
                                          _buildTextField(
                                            controller: _clubCodeController,
                                            hint: 'Enter your club invitation code',
                                            readOnly: true,
                                          ),
                                          const SizedBox(height: 24),
                                        ],
                                        _buildLabel('Full Name', Icons.person),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          controller: _nameController,
                                          hint: 'Enter full name',
                                          keyboardType: TextInputType.name,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                                          ],
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return 'Required';
                                            if (value.trim().split(' ').length < 2) return 'Enter full name';
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                        _buildLabel('Email', Icons.email),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          controller: _emailController,
                                          hint: 'Enter email',
                                          keyboardType: TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return 'Required';
                                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Invalid email';
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                        _buildLabel('Mobile Number', Icons.phone),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          controller: _mobileController,
                                          hint: 'Enter 10-digit mobile number',
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return 'Required';
                                            if (value.length != 10) return 'Must be 10 digits';
                                            return null;
                                          },
                                        ),

                                        const SizedBox(height: 32),
                                        const Divider(color: Colors.white10),
                                        const SizedBox(height: 16),
                                        _buildLabel('Identity Verification', Icons.verified_user_outlined),
                                        const SizedBox(height: 16),
                                        _buildUploadPlaceholder(
                                          _idProofName ?? 'Upload ID Proof Document',
                                          onTap: () => _pickFile(true),
                                          isSelected: _idProofName != null,
                                        ),
                                        const SizedBox(height: 16),
                                        _buildUploadPlaceholder(
                                          _photoName ?? 'Upload Recent Photo',
                                          onTap: () => _pickFile(false),
                                          isSelected: _photoName != null,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 12.0),
                                          child: Text(
                                            '* Documents will be verified by Statixa Administration.',
                                            style: TextStyle(color: goldColor, fontSize: 10, fontStyle: FontStyle.italic),
                                          ),
                                        ),

                                        if (_roles[_currentIndex]['name'] == 'PLAYER') ...[
                                          const SizedBox(height: 32),
                                          const Divider(color: Colors.white10),
                                          const SizedBox(height: 16),
                                          _buildLabel('Personal Details', Icons.cake_outlined),
                                          const SizedBox(height: 16),
                                          _buildTextField(
                                            controller: _dobController,
                                            hint: 'Date of Birth (DD/MM/YYYY)',
                                            readOnly: true,
                                            onTap: () => _selectDate(context),
                                            validator: (value) => value!.isEmpty ? 'Required' : null,
                                          ),
                                          const SizedBox(height: 24),
                                          _buildLabel('Parent/Guardian Contact', Icons.family_restroom_outlined),
                                          const SizedBox(height: 16),
                                          _buildTextField(
                                            controller: _parentEmailController,
                                            hint: 'Parent Email',
                                            keyboardType: TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) return 'Required';
                                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Invalid email';
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 32),
                                          _buildLabel('Physical Stats', Icons.fitness_center),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildTextField(
                                                  controller: _heightController,
                                                  hint: 'Height (cm)',
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  validator: (value) => value!.isEmpty ? 'Required' : null,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildTextField(
                                                  controller: _weightController,
                                                  hint: 'Weight (kg)',
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  validator: (value) => value!.isEmpty ? 'Required' : null,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 24),
                                          _buildLabel('Field Preferences', Icons.settings_input_component),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildDropdown(
                                                  hint: 'Strong Foot',
                                                  value: _selectedFoot,
                                                  items: ['Right', 'Left', 'Both'],
                                                  onChanged: (val) => setState(() => _selectedFoot = val),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: _buildDropdown(
                                                  hint: 'Position',
                                                  value: _selectedPosition,
                                                  items: ['Forward', 'Midfielder', 'Defender', 'Goalkeeper'],
                                                  onChanged: (val) => setState(() => _selectedPosition = val),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],

                                        const SizedBox(height: 24),
                                        _buildLabel('Password', Icons.lock),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          controller: _passwordController,
                                          hint: 'Create password',
                                          isPassword: true,
                                          obscureText: _obscurePassword,
                                          validator: (value) => value!.length < 6 ? 'Too short' : null,
                                          togglePassword: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                        _buildLabel('Confirm Password', Icons.lock_reset),
                                        const SizedBox(height: 10),
                                        _buildTextField(
                                          controller: _confirmPasswordController,
                                          hint: 'Confirm password',
                                          isPassword: true,
                                          obscureText: _obscurePassword,
                                          validator: (value) => value!.isEmpty ? 'Required' : null,
                                        ),
                                      ],
                                      
                                      const SizedBox(height: 40),
                                      _buildRegisterButton(),
                                      const SizedBox(height: 30),
                                      
                                      Center(
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              "Already have an account? ",
                                              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
                                            ),
                                            GestureDetector(
                                              onTapDown: (_) => setState(() => _linkScale = 0.90),
                                              onTapUp: (_) => setState(() => _linkScale = 1.0),
                                              onTapCancel: () => setState(() => _linkScale = 1.0),
                                              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                                              child: AnimatedScale(
                                                scale: _linkScale,
                                                duration: const Duration(milliseconds: 100),
                                                child: const Text(
                                                  'LOGIN',
                                                  style: TextStyle(
                                                    color: goldColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                          const SizedBox(height: 40),
                          _buildFooter(isDesktop),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: goldColor.withValues(alpha: 0.2),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractiveCurvedSelector(bool isDesktop) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 60,
              width: isDesktop ? 600 : double.infinity,
              child: CustomPaint(
                painter: ArcPainter(),
              ),
            ),
            Positioned(
              top: 5,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: goldColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: goldColor.withValues(alpha: 0.8),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 160,
          child: AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double page = 0;
              if (_pageController.hasClients) {
                page = _pageController.page ?? _currentIndex.toDouble();
              } else {
                page = _currentIndex.toDouble();
              }
              
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _isClubCodeStep = true;
                  });
                },
                itemCount: _roles.length,
                itemBuilder: (context, index) {
                  final role = _roles[index];
                  double diff = index - page;
                  
                  double yOffset = math.pow(diff.abs(), 1.5) * 40;
                  double scale = (1 - (diff.abs() * 0.25)).clamp(0.6, 1.2);
                  double opacity = (1 - (diff.abs() * 0.6)).clamp(0.1, 1.0);
                  bool isSelected = index == _currentIndex;

                  final roleColor = role['color'] as Color;
                  return Center(
                    child: Transform.translate(
                      offset: Offset(0, yOffset),
                      child: Transform.scale(
                        scale: scale,
                        child: Opacity(
                          opacity: opacity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected ? roleColor.withValues(alpha: 0.1) : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected ? roleColor : Colors.white.withValues(alpha: 0.1),
                                    width: 2,
                                  ),
                                  boxShadow: isSelected ? [
                                    BoxShadow(
                                      color: roleColor.withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    )
                                  ] : null,
                                ),
                                child: Icon(
                                  role['icon'],
                                  color: isSelected ? roleColor : Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                role['name'],
                                style: TextStyle(
                                  color: isSelected ? roleColor : Colors.white.withValues(alpha: 0.5),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: goldColor),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? togglePassword,
    String? Function(String?)? validator,
    bool enabled = true,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A), 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        enabled: enabled,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: (enabled || readOnly) ? Colors.white : Colors.white24, 
          fontSize: 14,
          fontWeight: readOnly ? FontWeight.w600 : FontWeight.normal,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 22,
                  ),
                  onPressed: togglePassword,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 14)),
          dropdownColor: const Color(0xFF1A1A1A),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white24),
          isExpanded: true,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildUploadPlaceholder(String label, {required VoidCallback onTap, bool isSelected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? goldColor.withValues(alpha: 0.1) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? goldColor : Colors.white.withValues(alpha: 0.1), 
            style: BorderStyle.solid
          ),
        ),
        child: Column(
          children: [
            Icon(
              isSelected ? Icons.check_circle_outline : Icons.cloud_upload_outlined, 
              color: isSelected ? goldColor : Colors.white24, 
              size: 30
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white38, 
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    bool isStepOne = _roles[_currentIndex]['name'] != 'ORGANIZER/HOST' && _isClubCodeStep;
    final roleColor = _roles[_currentIndex]['color'] as Color;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _buttonScale = 0.92),
      onTapUp: (_) => setState(() => _buttonScale = 1.0),
      onTapCancel: () => setState(() => _buttonScale = 1.0),
      onTap: _handleRegister,
      child: AnimatedScale(
        scale: _buttonScale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [roleColor, roleColor.withValues(alpha: 0.7)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: roleColor.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  isStepOne ? 'CONTINUE' : 'CREATE ACCOUNT',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(isStepOne ? Icons.arrow_forward_rounded : Icons.check_circle_outline, color: Colors.black, size: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.sports_soccer, size: 16, color: Colors.white54),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            'JOIN THE LEGACY. BECOME A PRO.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 11 : 9,
              color: Colors.white.withValues(alpha: 0.4),
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          goldColor.withValues(alpha: 0.0),
          goldColor.withValues(alpha: 0.4),
          goldColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.05, size.height);
    path.quadraticBezierTo(size.width / 2, -size.height * 0.4, size.width * 0.95, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
