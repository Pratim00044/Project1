import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

import '../roles/super_admin/super_admin_home.dart';
import '../roles/organization/organization_home.dart';
import '../roles/player/player_home.dart';
import '../roles/coach/coach_home.dart';
import '../roles/manager/manager_home.dart';

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
    {'name': 'PLAYER', 'icon': Icons.directions_run_outlined, 'color': Colors.blueAccent},
    {'name': 'ORGANIZER/HOST', 'icon': Icons.groups_outlined, 'color': Colors.greenAccent},
    {'name': 'COACH', 'icon': Icons.sports_outlined, 'color': Colors.orangeAccent},
    {'name': 'MANAGER', 'icon': Icons.manage_accounts_outlined, 'color': Colors.purpleAccent},
    {'name': 'SUPER ADMIN', 'icon': Icons.admin_panel_settings_outlined, 'color': goldColor},
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
    _emailController.dispose();
    _passwordController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final bool isOrganizer = _roles[_currentIndex]['name'] == 'ORGANIZER/HOST';
    
    if (isOrganizer || _formKey.currentState!.validate()) {
      Widget homePage;
      switch (_roles[_currentIndex]['name']) {
        case 'SUPER ADMIN':
          homePage = const SuperAdminHome();
          break;
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
                child: _videoController.value.isInitialized
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController.value.size.width,
                          height: _videoController.value.size.height,
                          child: VideoPlayer(_videoController),
                        ),
                      )
                    : Image.asset(
                        'assets/images/login_background.jpeg',
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.6),
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

              if (isDesktop)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.9),
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
                                  _buildLabel('Email', Icons.email),
                                  const SizedBox(height: 10),
                                  _buildTextField(
                                    controller: _emailController,
                                    hint: 'Enter your email',
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
                                              activeColor: goldColor,
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
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: goldColor,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 30),
                                  _buildLoginButton(),
                                  const SizedBox(height: 30),
                                  
                                  Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account? ",
                                          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
                                        ),
                                        GestureDetector(
                                          onTapDown: (_) => setState(() => _linkScale = 0.90),
                                          onTapUp: (_) => setState(() => _linkScale = 1.0),
                                          onTapCancel: () => setState(() => _linkScale = 1.0),
                                          onTap: () => Navigator.pushNamed(context, '/signup'),
                                          child: AnimatedScale(
                                            scale: _linkScale,
                                            duration: const Duration(milliseconds: 100),
                                            child: const Text(
                                              'REGISTER',
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
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

  Widget _buildLoginButton() {
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
              colors: [goldColor, goldColor.withValues(alpha: 0.7)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: goldColor.withValues(alpha: 0.4),
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
                  'LOGIN',
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
