import 'package:email_validator/email_validator.dart';
import 'package:flutter_channel/view/flutter_ch_home/home.dart';
import 'package:flutter_channel/view/importer.dart';

// ログイン画面
class Login extends StatelessWidget {
  // 認証クラス
  final _auth = FlutterChAuth();
  // フォームキー
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final emailCntrlr = TextEditingController();
  final passCntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormHelper(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  // Emailアドレス入力
                  TextFormField(
                    controller: emailCntrlr,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
                      hintText: 'メールアドレスを入力してください',
                      labelText: 'your Email*',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "必須";
                      }
                      if (EmailValidator.validate(value) == false) {
                        return "メールアドレスのフォーマットが正しくありません";
                      }
                      return null;
                    },
                  ),
                  // パスワード入力
                  Builder(builder: (context) {
                    final _isShow = Provider.of<FormHelper>(context);

                    return TextFormField(
                      // パスワードの表示非表示の制御可能
                      obscureText: _isShow.getShow,
                      controller: passCntrlr,
                      maxLength: 12,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _isShow.getShow
                                ? Colors.grey
                                : Colors.blueAccent,
                          ),
                          onPressed: () {
                            _isShow.isChangeDisplay();
                          },
                        ),
                        icon: Icon(Icons.security),
                        hintText: 'パスワードを入力してください',
                        labelText: 'your PassWord*',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "必須";
                        }
                        if (value.length < 6) {
                          return "パスワードは6文字以上必要です";
                        }
                        return null;
                      },
                    );
                  }),

                  Container(
                    margin: EdgeInsets.only(top: 20.0, right: 10.0),
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          var result = _auth.newSignIn(
                              emailCntrlr.text, passCntrlr.text);
                          result.then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FlutterChHome()));
                            // エラーの場合
                          }).catchError((error) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("認証に失敗しました")));
                          });
                        }
                      },
                      child: const Text("登録"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _Stepper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _step = Provider.of<StepNo>(context);
//     //
//     return Stepper(
//         type: StepperType.horizontal,
//         currentStep: _step.getCurrentStep,
//         onStepTapped: (int step) => _step.setCurrentStep(step),
//         onStepContinue: _step.getCurrentStep < 2 ? _step.stepIncrement() : null,
//         onStepCancel: _step.getCurrentStep > 0 ? _step.stepDecrement() : null,
//         steps: <Step>[]);
//   }
// }
