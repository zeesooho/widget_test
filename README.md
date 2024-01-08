실제 위젯 개발 전 테스트
# 로그인 위젯

사용 예제

로그인 버튼 클릭 이벤트 onSignIn

회원가입 버튼 클릭 이벤트 onSignUp

비밀번호를 잊어버렸나요? 버튼 클릭 이벤트 onForgot

``` dart
LoginWidget(
          onSignIn: (id, pw) async {
            ...
            return 성공여부: bool; // false 일 경우 forgot pssword 버튼 표시
          },
          onSignUp: () {
          },
          onForgot: () {
          },
        )
```

![LoginWidget_v2](https://github.com/zeesooho/widget_test/assets/25339188/8621396a-6f4e-4eba-93c0-15b0f91d3934)


# 회원가입 위젯

SignUpWidget의 onSignUp은 해당 위젯에서 제공하는 action으로만 사용 가능

액션바에서 완료 버튼을 누르기 위함

id, pw를 화면 진입 전 미리 넣고 들어갈 수 있도록 id, pw를 생성자에서 받음

사용하지 않을 시 공백으로

``` dart
var signUpWidget = SignUpWidget(
id: id,
pw: pw,
onSignUp: (signUpForm) async { // api 사용할 수 있도록 async로 사용
if (context.mounted) Navigator.of(context).pop();
return false; // 위에서 pop하면 여기까지 올 일이 없기에 실패 시 return 하도록 함
},
);

return Scaffold(
appBar: AppBar(
centerTitle: true,
title: const Text("회원가입"),
actions: [signupWidget.action],
),
body: signUpWidget,
);
```
