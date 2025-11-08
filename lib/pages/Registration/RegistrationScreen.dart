import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_com_bell_app/components/ButtonSmall.dart';
import 'package:to_com_bell_app/models/User.dart';
import 'package:to_com_bell_app/pages/LoginPage.dart';
import 'package:to_com_bell_app/pages/Registration/Registration_Step1.dart';
import 'package:to_com_bell_app/pages/Registration/Registration_Step2.dart';
import 'package:to_com_bell_app/pages/Registration/Registration_Step3.dart';
import 'package:to_com_bell_app/pages/Registration/Registration_Step4.dart';
import 'package:to_com_bell_app/pages/Registration/SuccessRegistrationScreen.dart';
import 'package:to_com_bell_app/services/UserService.dart';
import 'package:to_com_bell_app/theme/app_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isStepValid = false;
  final User _user = User();

  final UserService _userService = UserService();

  final TextEditingController _apelidoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _apelidoController.text = _user.apelido ?? "";
    _nomeController.text = _user.nome ?? "";
    _sobrenomeController.text = _user.sobrenome ?? "";
    _senhaController.text = _user.senha ?? "";
  }

  @override
  void dispose() {
    _apelidoController.dispose();
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _enviarCodigoConfirmacao() async {
    try {
      await _userService.enviarCodigoConfirmacao(_user.email ?? "");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Código de confirmação enviado para o e-mail!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao enviar código: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _nextPage() async {
    if (_isStepValid) {
      if (_currentPage == 1) {
        final bool emailValido = await _userService.verificarEmail(_emailController.text);
        if (!emailValido) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Este e-mail já está cadastrado. Por favor, use outro e-mail."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }

      if (_currentPage < 3) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage++;
          _isStepValid = false;
        });

        if (_currentPage == 3) {
          await _enviarCodigoConfirmacao();
        }
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Preencha todos os campos antes de continuar.",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: "OK",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
        _isStepValid = true;
      });
    }
  }

  void _loginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  void _finalizeRegistration() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SuccessRegistrationScreen()),
    );
  }

  void _updateButtonState(bool isValid) {
    setState(() {
      _isStepValid = isValid;
    });
  }

  String _getStepIcon(int currentPage) {
    final List<String> stepIcons = [
      "lib/assets/icons/user-check-registration.svg",
      "lib/assets/icons/file-registration.svg",
      "lib/assets/icons/lock-registration.svg",
      "lib/assets/icons/users-check-registration.svg"
    ];
    return stepIcons[currentPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(116),
        child: Container(
          height: 116,
          padding: const EdgeInsets.only(top: 55, left: 16, right: 16, bottom: 10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF5125),
                Color(0xFFFF135E),
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    _getStepIcon(_currentPage),
                    width: 28,
                    height: 28,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Etapa ${_currentPage + 1} de 4: ",
                    style: TextStyle(color: Colors.white, fontWeight: AppFonts.bold),
                  ),
                  Text(
                    "Sobre Você",
                    style: TextStyle(color: Colors.white, fontWeight: AppFonts.normal),
                  )
                ],
              ),
              const SizedBox(height: 13),
              LinearProgressIndicator(
                value: (_currentPage + 1) / 4,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
                borderRadius: BorderRadius.circular(8),
                minHeight: 5,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Registration_Step1(
                  user: _user,
                  onValidate: _updateButtonState,
                  apelidoController: _apelidoController,
                  nomeController: _nomeController,
                  sobrenomeController: _sobrenomeController,
                ),
                Registration_Step2(
                  user: _user,
                  onValidate: _updateButtonState,
                  emailController: _emailController,
                ),
                Registration_Step3(
                  user: _user,
                  onValidate: _updateButtonState,
                  senhaController: _senhaController,
                  confirmarSenhaController: _confirmarSenhaController,
                ),
                Registration_Step4(
                  user: _user,
                  onValidationComplete: _finalizeRegistration,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ButtonSmall(
                    onPressed: _currentPage > 0 ? _previousPage : _loginPage,
                    text: "VOLTAR",
                    gradientColors: const [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                    borderColor: 0xFFDDDDDD,
                    textColor: 0xFF949494,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ButtonSmall(
                    onPressed: _currentPage == 3 ? _finalizeRegistration : _nextPage,
                    text: _currentPage == 3 ? "VALIDAR" : "CONTINUAR",
                    gradientColors: const [
                      Color(0xFFFF5125),
                      Color(0xFFFF135E),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
