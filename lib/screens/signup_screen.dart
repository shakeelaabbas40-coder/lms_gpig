import 'package:flutter/material.dart';
import 'main_navigation_screen.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _deptController = TextEditingController(text: 'Computer Science');
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedRole = 'Student';
  bool _obscurePassword = true;
  bool _agreeToTerms = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _deptController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms & Academic Code of Conduct to proceed.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await AuthService().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      role: _selectedRole,
      studentId: _idController.text.trim(),
      department: _deptController.text.trim(),
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2563EB);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Student Registration',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Join your university academic portal to enroll in courses and track assignments',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.4),
                ),
                const SizedBox(height: 20),

                // Role selector
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _selectedRole = 'Student'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedRole == 'Student' ? primaryColor.withOpacity(0.1) : Colors.white,
                          side: BorderSide(
                            color: _selectedRole == 'Student' ? primaryColor : Colors.grey.shade300,
                            width: _selectedRole == 'Student' ? 1.8 : 1,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Student',
                          style: TextStyle(
                            color: _selectedRole == 'Student' ? primaryColor : Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _selectedRole = 'Instructor'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedRole == 'Instructor' ? primaryColor.withOpacity(0.1) : Colors.white,
                          side: BorderSide(
                            color: _selectedRole == 'Instructor' ? primaryColor : Colors.grey.shade300,
                            width: _selectedRole == 'Instructor' ? 1.8 : 1,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Instructor / Faculty',
                          style: TextStyle(
                            color: _selectedRole == 'Instructor' ? primaryColor : Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Full Name
                _buildFieldLabel('Full Name'),
                TextFormField(
                  controller: _nameController,
                  validator: (v) => (v == null || v.isEmpty) ? 'Please enter your full name' : null,
                  decoration: _buildInputDecoration('e.g. Sarah Khan', Icons.person_outline_rounded),
                ),
                const SizedBox(height: 14),

                // Student / Employee ID
                _buildFieldLabel(_selectedRole == 'Student' ? 'Student Registration / Roll No' : 'Faculty ID'),
                TextFormField(
                  controller: _idController,
                  validator: (v) => (v == null || v.isEmpty) ? 'Please enter ID number' : null,
                  decoration: _buildInputDecoration('e.g. LMS-2024-892', Icons.badge_outlined),
                ),
                const SizedBox(height: 14),

                // Department
                _buildFieldLabel('Department / Program'),
                TextFormField(
                  controller: _deptController,
                  validator: (v) => (v == null || v.isEmpty) ? 'Please enter your department' : null,
                  decoration: _buildInputDecoration('e.g. Computer Science & IT', Icons.domain_rounded),
                ),
                const SizedBox(height: 14),

                // Institutional Email
                _buildFieldLabel('Institutional Email'),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter your institutional email';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                  decoration: _buildInputDecoration('e.g. student@university.edu', Icons.email_outlined),
                ),
                const SizedBox(height: 14),

                // Password
                _buildFieldLabel('Password'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter a password';
                    if (v.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.grey, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryColor, width: 1.8)),
                  ),
                ),
                const SizedBox(height: 14),

                // Confirm Password
                _buildFieldLabel('Confirm Password'),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  validator: (v) {
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                  decoration: _buildInputDecoration('••••••••', Icons.lock_reset_rounded),
                ),
                const SizedBox(height: 14),

                // Terms agreement
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      activeColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (val) => setState(() => _agreeToTerms = val ?? true),
                    ),
                    Expanded(
                      child: Text(
                        'I accept the Academic Code of Conduct and Institutional Policy.',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Register Button
                CustomButton(
                  text: 'Create Account',
                  isLoading: _isLoading,
                  icon: Icons.person_add_rounded,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: 20),

                // Already registered
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already registered? ', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.8)),
    );
  }
}