import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../roles/super_admin/super_admin_home.dart';
import '../roles/organization/organization_home.dart';
import '../roles/player/player_home.dart';
import '../roles/coach/coach_home.dart';
import '../roles/manager/manager_home.dart';
import '../widgets/notification_service.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  final List<Map<String, dynamic>> _roles = [
    {'name': 'PLAYER', 'icon': Icons.directions_run_outlined, 'color': goldColor},
    {'name': 'ORGANISER', 'icon': Icons.groups_outlined, 'color': Colors.tealAccent},
    {'name': 'COACH', 'icon': Icons.sports_outlined, 'color': Colors.grey},
    {'name': 'MANAGER', 'icon': Icons.manage_accounts_outlined, 'color': Colors.purpleAccent},
    {'name': 'ADMIN', 'icon': Icons.admin_panel_settings_outlined, 'color': goldColor},
  ];

  late PageController _pageController;
  int _currentIndex = 0;
  double _buttonScale = 1.0;
  double _linkScale = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.35,
      initialPage: _currentIndex,
    );
    
    // Clear any profile reminders once the user enters the app
    NotificationService.clearProfileNotifications();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    Widget homePage;
    switch (_roles[_currentIndex]['name']) {
      case 'ADMIN':
        homePage = const SuperAdminHome();
        break;
      case 'ORGANISER':
        homePage = const OrganisationHome();
        break;
      case 'PLAYER':
        homePage = PlayerHome();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double formWidth = constraints.maxWidth;
          
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/img_1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.6),
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
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/logo.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          _buildInteractiveCurvedSelector(false),
                          
                          const SizedBox(height: 20),
                          
                          Container(
                            width: formWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Email', Icons.email),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: _emailController,
                                    hint: 'Enter your email',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildLabel('Password', Icons.lock),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: _passwordController,
                                    hint: 'Enter your password',
                                    isPassword: true,
                                    obscureText: _obscurePassword,
                                    togglePassword: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Checkbox(
                                              value: _rememberMe,
                                              onChanged: (value) {
                                                setState(() {
                                                  _rememberMe = value!;
                                                });
                                              },
                                              activeColor: _roles[_currentIndex]['color'] as Color,
                                              checkColor: Colors.black,
                                              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Remember me',
                                            style: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.5),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: _roles[_currentIndex]['color'] as Color,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 30),
                                  _buildLoginButton(),
                                  const SizedBox(height: 20),

                                  if (_roles[_currentIndex]['name'] == 'PLAYER') ...[
                                    Center(
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account? ",
                                            style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
                                          ),
                                          GestureDetector(
                                            onTapDown: (_) => setState(() => _linkScale = 0.90),
                                            onTapUp: (_) => setState(() => _linkScale = 1.0),
                                            onTapCancel: () => setState(() => _linkScale = 1.0),
                                            onTap: () => Navigator.pushNamed(context, '/signup'),
                                            child: AnimatedScale(
                                              scale: _linkScale,
                                              duration: const Duration(milliseconds: 100),
                                              child: Text(
                                                'REGISTER',
                                                style: TextStyle(
                                                  color: _roles[_currentIndex]['color'] as Color,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildFooter(false),
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

  Widget _buildInteractiveCurvedSelector(bool isDesktop) {
    return Column(
      children: [
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
                  setState(() => _currentIndex = index);
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
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Center(
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
                                    color: isSelected 
                                        ? roleColor.withValues(alpha: 0.2)
                                        : Colors.black.withValues(alpha: 0.4),
                                    border: Border.all(
                                      color: isSelected ? roleColor : Colors.white.withValues(alpha: 0.3),
                                      width: isSelected ? 3 : 1.5,
                                    ),
                                    boxShadow: isSelected ? [
                                      BoxShadow(
                                        color: roleColor.withValues(alpha: 0.5),
                                        blurRadius: 25,
                                        spreadRadius: 4,
                                      )
                                    ] : [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.3),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    role['icon'],
                                    color: isSelected ? roleColor : Colors.white.withValues(alpha: 0.7),
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  role['name'],
                                  style: TextStyle(
                                    color: isSelected ? roleColor : Colors.white.withValues(alpha: 0.7),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        offset: const Offset(1, 1),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
    final roleColor = _roles[_currentIndex]['color'] as Color;
    return Row(
      children: [
        Icon(icon, size: 18, color: roleColor),
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
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final roleColor = _roles[_currentIndex]['color'] as Color;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: roleColor.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: roleColor.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: roleColor.withValues(alpha: 0.7),
                    size: 22,
                  ),
                  onPressed: togglePassword,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    final roleColor = _roles[_currentIndex]['color'] as Color;
    return GestureDetector(
      onTapDown: (_) => setState(() => _buttonScale = 0.92),
      onTapUp: (_) => setState(() => _buttonScale = 1.0),
      onTapCancel: () => setState(() => _buttonScale = 1.0),
      onTap: _handleLogin,
      child: AnimatedScale(
        scale: _buttonScale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
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
          child: const Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.chevron_right, color: Colors.black, size: 28),
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
            'ONE TEAM. ONE PASSION. ONE VICTORY.',
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

