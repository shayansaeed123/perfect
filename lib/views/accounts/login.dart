

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/loginnotifier.dart';
import 'package:project/database/my_shared.dart';
import 'package:project/models/logincheck.dart';
import 'package:project/repo/perfect_repo.dart';
import 'package:project/repo/utils.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';
import 'package:project/views/dashboard/navbar.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late FocusNode _emailfocusNode;
  late FocusNode _passfocusNode;
  late FocusNode _buttonFocusNode;
  bool pass = true;
  PerfectRepo repo = PerfectRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailfocusNode = FocusNode();
    _emailfocusNode.addListener(_onFocusChange);
    _passfocusNode = FocusNode();
    _passfocusNode.addListener(_onFocusChange);
    _buttonFocusNode = FocusNode();
    repo.get_Token();
    
  }

  @override
  void dispose() {
    _emailfocusNode.removeListener(_onFocusChange);
    _emailfocusNode.dispose();
    _passfocusNode.removeListener(_onFocusChange);
    _passfocusNode.dispose();
    _buttonFocusNode.dispose();
    super.dispose();
  }


  void _onFocusChange() {
    setState(() {
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    ref.listen<AuthState>(authProvider, (prev, next) {
    if (next.isLoggedIn && next.userId != null && next.userId!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const NavBar()),
          (route) => false,
        );
      });
    }

    if (next.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utils.snakbar(context, next.error!);
      });
    }
    if (next.success != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utils.snakbarSuccess(context, next.success!);
      });
    }
  });
    return WillPopScope(
      onWillPop: repo.onWillPop,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand, 
          children: [
           Image.asset(
                'assets/images/logincar.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover, // ✅ fills full screen, cropping if needed
                width: double.infinity,
                height: double.infinity,
              ),
            Align(
              alignment: Alignment(0, 0.3),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: colorController.whiteColor
                ),
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  reusableText('LOGIN',color: colorController.textfieldColor,fontsize: 28,fontweight: FontWeight.bold),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: reusableTextField(context, email, 'Email', colorController.textfieldColor, _emailfocusNode,
                        () {
                          // _onEmailChanged;
                          _emailfocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_passfocusNode);
                        },fillColor: colorController.textfieldBackgroundColor
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: reusablePassField(context, password, 'Password', colorController.textfieldColor, _passfocusNode, () {
                        _passfocusNode.unfocus();
                        FocusScope.of(context).requestFocus(_buttonFocusNode);
                                    },
                                    pass,(){
                                      setState(() {
                                        pass = !pass;
                                      });
                                    })
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  reusableBtn(context, 'Sign in', (){
                     ref.read(authProvider.notifier).login(
                              email.text.trim(),
                              password.text.trim(),
                              MySharedPrefrence().get_cell_token(),
                            );
                  },width: 0.8,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: "${MySharedPrefrence().get_cell_token()}"));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Link copied to clipboard")),
                            );
                        },
                        child: Image.asset('assets/images/copy.png',filterQuality: FilterQuality.medium,fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.04,)),
                ],
              ),
              ),
            ),
             /// 🔹 Center Loading Overlay
        if (authState.isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          ],
        ),
      ),
    );
  }
}