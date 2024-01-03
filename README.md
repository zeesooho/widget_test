실제 위젯 개발 전 테스트
# 로그인 위젯

사용 예제

로그인 버튼 클릭 이벤트 onSignIn

회원가입 버튼 클릭 이벤트 onSignUp

비밀번호를 잊어버렸나요? 버튼 클릭 이벤트 onForgot

``` dart
LoginWidget(
          onSignIn: (id, pw) {
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
