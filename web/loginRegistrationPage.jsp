<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/21 0021
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #cbc0d3;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: -20px 0 50px;
        }

        h1 {
            font-weight: bold;
            margin: 0;
        }

        span {
            font-size: 12px;
        }

        a {
            color: #333;
            font-size: 14px;
            text-decoration: none;
            margin: 15px 0;
        }

        .container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0, 0, 0, .25), 0 10px 10px rgba(0, 0, 0, .22);
            position: relative;
            overflow: hidden;
            width: 768px;
            max-width: 100%;
            min-height: 480px;
        }

        .form-container form {
            background: #fff;
            display: flex;
            flex-direction: column;
            padding: 0 50px;
            height: 100%;
            justify-content: center;
            text-align: center;
        }

        .social-container {
            margin: 20px 0;
        }

        .social-container a {
            border: 1px solid #ddd;
            border-radius: 50%;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            margin: 0 5px;
            height: 40px;
            width: 40px;
        }

        .social-container a:hover {
            background-color: #eee;
        }

        .txtb {
            border-bottom: 2px solid #adadad;
            position: relative;
            margin: 10px 0;
        }

        .txtb input {
            font-size: 15px;
            color: #333;
            border: none;
            width: 60%;
            outline: none;
            background: none;
            padding: 0 3px;
            height: 35px;
            float: left;
        }

        .txtb span::before {
            content: attr(data-placeholder);
            position: absolute;
            top: 50%;
            left: 5px;
            color: #adadad;
            transform: translateY(-50%);
            transition: .5s;
        }

        .txtb span::after {
            content: '';
            position: absolute;
            left: 0%;
            top: 100%;
            width: 0%;
            height: 2px;
            background-image: linear-gradient(120deg, #3498db, #8e44ad);
            transition: .5s;
        }

        .focus + span::before {
            top: -5px;
        }

        .focus + span::after {
            width: 100%;
        }

        button {
            border-radius: 20px;
            border: 1px solid #ff4b2b;
            background: #ff4b2b;
            color: #fff;
            font-size: 12px;
            font-weight: bold;
            padding: 12px 45px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: transform 80ms ease-in;
            cursor: pointer;
        }

        button:disabled {
            background: #ccc;
            cursor: not-allowed;
            opacity: 0.6;
        }

        button:active {
            transform: scale(.95);
        }

        button:focus {
            outline: none;
        }

        button.ghost {
            background: transparent;
            border-color: #ce7d88;
            border: solid 1px #EAC7CC;
            color: #ce7d88;
        }

        button.ghost:hover {
            transition: background-color 0.8s;
            background-color: #eac7cc;
        }

        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all .6s ease-in-out;
        }

        .form-container button {
            background: linear-gradient(120deg, #3498db, #8e44ad);
            border: none;
            background-size: 200%;
            color: #fff;
            transition: .5s;
        }

        .form-container button:hover {
            background-position: right;
        }

        .sign-in-container {
            left: 0;
            width: 50%;
            z-index: 2;
        }

        .sign-in-container form a {
            position: relative;
            left: 100px;
        }

        .sign-up-container {
            left: 0;
            width: 50%;
            z-index: 1;
            opacity: 0;
        }

        .sign-up-container button {
            margin-top: 20px;
        }

        .overlay-container {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            overflow: hidden;
            transition: transform .6s ease-in-out;
            z-index: 100;
        }

        .overlay {
            background-color: #f6f6f6;
            color: #fff;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            transform: translateY(0);
            transition: transform .6s ease-in-out;
        }

        .overlay p {
            font-family: "Open Sans", sans-serif;
            font-size: .7em;
            letter-spacing: 2px;
            color: #8E9AAF;
            text-align: center;
        }

        .overlay .title {
            font-family: "Lora", serif;
            color: #8E9AAF;
            font-size: 1.8em;
            line-height: 1.1em;
            letter-spacing: 7px;
            text-align: center;
            font-weight: 300;
            margin-top: 20%;
        }

        .overlay .title span {
            font-size: 1em;
        }

        .account {
            margin-top: 47%;
            font-size: 10px;
        }

        .flower {
            position: absolute;
            width: 120px;
            height: 120px;
            top: 46%;
            left: 34%;
            opacity: .7;
        }

        .overlay span {
            color: #EAC7CC;
        }

        .overlay .desc {
            margin-top: -8px;
        }

        .overlay .overlay-panel {
            position: absolute;
            top: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 0 40px;
            height: 100%;
            width: 50%;
            text-align: center;
            transform: translateY(0);
            transition: transform .6s ease-in-out;
        }

        .overlay-right {
            right: 0;
            transform: translateY(0);
        }

        .overlay-left {
            transform: translateY(-20%);
        }

        .container.right-panel-active .sign-in-container {
            transform: translateY(100%);
        }

        .container.right-panel-active .overlay-container {
            transform: translateX(-100%);
        }

        .container.right-panel-active .sign-up-container {
            transform: translateX(100%);
            opacity: 1;
            z-index: 5;
        }

        .container.right-panel-active .overlay {
            transform: translateX(50%);
        }

        .container.right-panel-active .overlay-left {
            transform: translateY(0);
        }

        .container.right-panel-active .overlay-right {
            transform: translateY(20%);
        }

        /* 提示信息样式 */
        .tips {
            font-size: 12px;
            margin-top: 5px;
            display: flex;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease-in-out; /* 淡入淡出动画 */
        }

        .tips.show {
            opacity: 1;
        }

        .tips.success {
            color: #28a745; /* 绿色 */
        }

        .tips.error {
            color: #ff6f91; /* 淡粉色，与页面风格匹配 */
        }

        .tips::before {
            content: '';
            display: inline-block;
            width: 14px;
            height: 14px;
            margin-right: 5px;
            background-size: contain;
            background-repeat: no-repeat;
        }

        .tips.success::before {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="%2328a745" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>');
        }

        .tips.error::before {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="%23ff6f91" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>');
        }

        /* 输入框边框颜色 */
        input.valid {
            border-color: #28a745 !important;
        }

        input.invalid {
            border-color: #ff6f91 !important;
        }
    </style>
</head>

<body>
<div class="container" id="login-box">
    <!-- 注册界面 -->
    <div class="form-container sign-up-container">
        <form action="userSaveServlet" method="post" id="form1">
            <h1>注册</h1>
            <div class="txtb" style="display: block">
                <input type="text" name="userName" id="registerUserName">
                <span data-placeholder="Username"></span>
                <div id="registerNameTips" class="tips"></div>
            </div>
            <div class="txtb">
                <input type="email" name="userEmail" id="registerEmail">
                <span data-placeholder="Email"></span>
                <div id="registerEmailTips" class="tips"></div>
            </div>
            <div class="txtb">
                <input type="password" id="registerPwd1">
                <span data-placeholder="Password"></span>
                <div id="registerPwdTips" class="tips"></div>
            </div>
            <div class="txtb">
                <input type="password" id="registerPwd2" name="userPwd">
                <span data-placeholder="Confirm Password"></span>
                <div id="registerConfirmPwdTips" class="tips"></div>
            </div>
            <div class="txtb">
                <input type="text" id="emailVCode" name="emailVCode">
                <span data-placeholder="邮箱验证码"></span>
                <div id="emailVCodeTips" class="tips"></div>
            </div>
            <button type="button" id="sendEmailCode">发送验证码</button>
            <button type="button" id="registerCheck">注册</button>
        </form>
    </div>

    <!-- 登录界面 -->
    <div class="form-container sign-in-container">
        <form action="loginServlet" id="form2" method="post">
            <h1>登录</h1>
            <div class="txtb">
                <input type="email" id="loginUserEmail" name="userEmail">
                <span data-placeholder="Email"></span>
                <div id="loginEmailTips" class="tips"></div>
            </div>
            <div class="txtb">
                <input type="password" id="loginPwd" name="userPwd">
                <span data-placeholder="Password"></span>
                <div id="loginPwdTips" class="tips"></div>
            </div>
            <div class="txtb">
                <input type="text" name="inputVCode" id="inputVCode">
                <span data-placeholder="验证码"></span>
                <div id="loginVCodeTips" class="tips"></div>
            </div>
            <img src="createCode" id="codeImg"/>
            <input type="checkbox" name="auto_login">自动登录<br>
            <a href="forgetPwd.jsp">忘记密码？</a>
            <button type="button" id="loginCheck">登录</button>
        </form>
    </div>

    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h2 class="title">
                    <span>BLOOM</span><span style="color: #8E9AAF;">&</span>
                    <br>
                    BOUQUET
                </h2>
                <p class="desc">
                    选择你最喜欢的<span>鲜花</span>
                </p>
                <img src="images/flower1.jpg" alt="" class="flower">
                <p class="account">已有账号？</p>
                <p>请使用您的账号进行登录</p>
                <button class="ghost" id="signIn">登录</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h2 class="title">
                    <span>BLOOM</span><span style="color: #8E9AAF;">&</span>
                    <br>
                    BOUQUET
                </h2>
                <p class="desc">
                    选择你最喜欢的<span>鲜花</span>
                </p>
                <img src="images/flower2.jpg" alt="" class="flower">
                <p class="account">没有账号?</p>
                <p>立即注册加入我们，和我们一起开始旅程吧</p>
                <button class="ghost" id="signUp">注册</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    // 刷新验证码
    $("#codeImg").click(function () {
        $(this).attr('src', "createCode?m=" + Math.random());
    });

    // 发送验证码
    var contextPath = "<%=request.getContextPath()%>";
    $("#sendEmailCode").click(function () {
        var email = $("#registerEmail").val();
        var $btn = $(this);

        if (!email || email.trim() === "") {
            $("#emailVCodeTips").removeClass("success error show").text("邮箱不能为空!");
            $("#emailVCodeTips").addClass("error show");
            return;
        }
        if (!email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)) {
            $("#emailVCodeTips").removeClass("success error show").text("邮箱格式不正确!");
            $("#emailVCodeTips").addClass("error show");
            return;
        }

        console.log("Sending request to: " + contextPath + "/sendEmailServlet");
        $.post(contextPath + "/sendEmailServlet", {email: email, action: "register"}, function (res) {
            console.log("Response: ", res);
            if (res.success) {
                $("#emailVCodeTips").removeClass("success error show").text("验证码已发送!");
                $("#emailVCodeTips").addClass("success show");
                $btn.prop("disabled", true);
                var countdown = 60;
                $btn.text(countdown + "秒后重试");
                var timer = setInterval(function () {
                    countdown--;
                    $btn.text(countdown + "秒后重试");
                    if (countdown <= 0) {
                        clearInterval(timer);
                        $btn.text("发送验证码");
                        $btn.prop("disabled", false);
                    }
                }, 1000);
            } else {
                $("#emailVCodeTips").removeClass("success error show").text(res.message);
                $("#emailVCodeTips").addClass("error show");
            }
        }, "json").fail(function (xhr, status, error) {
            console.error("AJAX error: ", status, error);
            $("#emailVCodeTips").removeClass("success error show").text("服务器错误，请稍后再试!");
            $("#emailVCodeTips").addClass("error show");
        });
    });

    // 注册页面实时校验
    // 用户名
    $("#registerUserName").on("input", function () {
        var userName = $(this).val();
        var $input = $(this);
        var $tips = $("#registerNameTips");

        if (!userName || userName.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("用户名不能为空!");
            $tips.addClass("error show");
        } else if (userName.length < 2 || userName.length > 20) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("用户名长度需在2-20个字符之间!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show").text("用户名格式正确!");
            $tips.addClass("success show");
            // 3秒后淡出
            setTimeout(function () {
                $tips.removeClass("show");
            }, 3000);
        }
    });

    // 邮箱
    $("#registerEmail").on("input", function () {
        var email = $(this).val();
        var $input = $(this);
        var $tips = $("#registerEmailTips");

        if (!email || email.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("邮箱不能为空!");
            $tips.addClass("error show");
        } else if (!email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("邮箱格式不正确!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show").text("邮箱格式正确!");
            $tips.addClass("success show");
            // 3秒后淡出
            setTimeout(function () {
                $tips.removeClass("show");
            }, 3000);
        }
    });

    // 密码
    $("#registerPwd1").on("input", function () {
        var pwd1 = $(this).val();
        var hasLetter = /[a-zA-Z]/.test(pwd1);
        var hasNumber = /\d/.test(pwd1);
        var hasSpecial = /[@$!%*?&]/.test(pwd1);
        var typeCount = (hasLetter ? 1 : 0) + (hasNumber ? 1 : 0) + (hasSpecial ? 1 : 0);
        var $input = $(this);
        var $tips = $("#registerPwdTips");

        if (!pwd1 || pwd1.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("密码不能为空!");
            $tips.addClass("error show");
        } else if (pwd1.length < 6) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("密码长度需6-20个字符!");
            $tips.addClass("error show");
        } else if (pwd1.length > 20) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("密码长度需6-20个字符!");
            $tips.addClass("error show");
        } else if (typeCount < 2) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("密码需包含字母、数字、特殊符号中的至少两种!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show").text("密码格式正确!");
            $tips.addClass("success show");
            // 3秒后淡出
            setTimeout(function () {
                $tips.removeClass("show");
            }, 3000);
        }

        // 同步校验确认密码
        var pwd2 = $("#registerPwd2").val();
        var $confirmTips = $("#registerConfirmPwdTips");
        if (pwd2 && pwd1 !== pwd2) {
            $("#registerPwd2").removeClass("valid invalid").addClass("invalid");
            $confirmTips.removeClass("success error show").text("两次密码不一致!");
            $confirmTips.addClass("error show");
        } else if (pwd2) {
            $("#registerPwd2").removeClass("valid invalid").addClass("valid");
            $confirmTips.removeClass("success error show").text("密码一致!");
            $confirmTips.addClass("success show");
        }
    });

    // 确认密码
    $("#registerPwd2").on("input", function () {
        var pwd1 = $("#registerPwd1").val();
        var pwd2 = $(this).val();
        var $input = $(this);
        var $tips = $("#registerConfirmPwdTips");

        if (!pwd2 || pwd2.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("确认密码不能为空!");
            $tips.addClass("error show");
        } else if (pwd1 !== pwd2) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("两次密码不一致!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show").text("密码一致!");
            $tips.addClass("success show");
        }
    });

    // 邮箱验证码
    $("#emailVCode").on("input", function () {
        var vCode = $(this).val();
        var $input = $(this);
        var $tips = $("#emailVCodeTips");

        if (!vCode || vCode.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("验证码不能为空!");
            $tips.addClass("error show");
        }
    });

    // 注册提交表单前确认是否符合规范
    $("#registerCheck").click(function () {
        var userName = $("#registerUserName").val();
        var email = $("#registerEmail").val();
        var pwd1 = $("#registerPwd1").val();
        var pwd2 = $("#registerPwd2").val();
        var vCode = $("#emailVCode").val();

        // 前端简单校验，减少无效请求
        if (!userName || userName.trim() === "") {
            $("#registerUserName").removeClass("valid invalid").addClass("invalid");
            $("#registerNameTips").removeClass("success error show").text("用户名不能为空!");
            $("#registerNameTips").addClass("error show");
            return;
        }
        if (userName.length < 2 || userName.length > 20) {
            $("#registerUserName").removeClass("valid invalid").addClass("invalid");
            $("#registerNameTips").removeClass("success error show").text("用户名长度需在2-20个字符之间!");
            $("#registerNameTips").addClass("error show");
            return;
        }
        if (!email || email.trim() === "") {
            $("#registerEmail").removeClass("valid invalid").addClass("invalid");
            $("#registerEmailTips").removeClass("success error show").text("邮箱不能为空!");
            $("#registerEmailTips").addClass("error show");
            return;
        }
        if (!email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)) {
            $("#registerEmail").removeClass("valid invalid").addClass("invalid");
            $("#registerEmailTips").removeClass("success error show").text("邮箱格式不正确!");
            $("#registerEmailTips").addClass("error show");
            return;
        }
        var hasLetter = /[a-zA-Z]/.test(pwd1);
        var hasNumber = /\d/.test(pwd1);
        var hasSpecial = /[@$!%*?&]/.test(pwd1);
        var typeCount = (hasLetter ? 1 : 0) + (hasNumber ? 1 : 0) + (hasSpecial ? 1 : 0);
        if (pwd1.length < 6 || pwd1.length > 20 || typeCount < 2) {
            $("#registerPwd1").removeClass("valid invalid").addClass("invalid");
            $("#registerPwdTips").removeClass("success error show").text("密码需6-20个字符，且包含字母、数字、特殊符号中的至少两种!");
            $("#registerPwdTips").addClass("error show");
            return;
        }
        if (pwd1 !== pwd2) {
            $("#registerPwd2").removeClass("valid invalid").addClass("invalid");
            $("#registerConfirmPwdTips").removeClass("success error show").text("两次密码不一致!");
            $("#registerConfirmPwdTips").addClass("error show");
            return;
        }
        if (!vCode || vCode.trim() === "") {
            $("#emailVCode").removeClass("valid invalid").addClass("invalid");
            $("#emailVCodeTips").removeClass("success error show").text("验证码不能为空!");
            $("#emailVCodeTips").addClass("error show");
            return;
        }

        // 发送 AJAX 请求
        $.post(contextPath + "/registerCheckServlet", {
            registerUserName: userName,
            registerEmail: email,
            registerPwd1: pwd1,
            registerPwd2: pwd2,
            emailVCode: vCode
        }, function (res) {
            // 用户名提示
            $("#registerUserName").removeClass("valid invalid").addClass(res.nameCode ? "valid" : "invalid");
            $("#registerNameTips").removeClass("success error show").text(
                res.nameCode ? "用户名可用!" : (userName.length < 2 || userName.length > 20 ? "用户名长度需在2-20个字符之间!" : "用户名已被注册!")
            );
            $("#registerNameTips").addClass((res.nameCode ? "success" : "error") + " show");
            if (res.nameCode) {
                setTimeout(function () {
                    $("#registerNameTips").removeClass("show");
                }, 3000);
            }

            // 邮箱提示
            $("#registerEmail").removeClass("valid invalid").addClass(res.emailCode ? "valid" : "invalid");
            $("#registerEmailTips").removeClass("success error show").text(
                res.emailCode ? "邮箱可用!" : (email && !email.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/) ? "邮箱格式不正确!" : "邮箱已被注册!")
            );
            $("#registerEmailTips").addClass((res.emailCode ? "success" : "error") + " show");
            if (res.emailCode) {
                setTimeout(function () {
                    $("#registerEmailTips").removeClass("show");
                }, 3000);
            }

            // 验证码提示
            $("#emailVCode").removeClass("valid invalid").addClass(res.vCode ? "valid" : "invalid");
            $("#emailVCodeTips").removeClass("success error show").text(
                res.vCode ? "验证码正确!" : "验证码错误或已过期!"
            );
            $("#emailVCodeTips").addClass((res.vCode ? "success" : "error") + " show");

            // 所有验证通过后提交表单
            if (res.nameCode && res.emailCode && res.pwdCode && res.vCode) {
                $("#form1").submit();
            }
        }, "json").fail(function (xhr, status, error) {
            console.error("AJAX error: ", status, error);
            $("#emailVCodeTips").removeClass("success error show").text("服务器错误，请稍后再试!");
            $("#emailVCodeTips").addClass("error show");
        });
    });

    // 登录页面实时校验
    // 邮箱
    $("#loginUserEmail").on("input", function () {
        var userEmail = $(this).val();
        var $input = $(this);
        var $tips = $("#loginEmailTips");

        if (!userEmail || userEmail.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("邮箱不能为空!");
            $tips.addClass("error show");
        } else if (!userEmail.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)) {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("邮箱格式不正确!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show"); // 不显示成功提示
        }
    });

    // 密码
    $("#loginPwd").on("input", function () {
        var pwd = $(this).val();
        var $input = $(this);
        var $tips = $("#loginPwdTips");

        if (!pwd || pwd.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("密码不能为空!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show"); // 不显示成功提示
        }
    });

    // 验证码
    $("#inputVCode").on("input", function () {
        var vCode = $(this).val();
        var $input = $(this);
        var $tips = $("#loginVCodeTips");

        if (!vCode || vCode.trim() === "") {
            $input.removeClass("valid invalid").addClass("invalid");
            $tips.removeClass("success error show").text("验证码不能为空!");
            $tips.addClass("error show");
        } else {
            $input.removeClass("valid invalid").addClass("valid");
            $tips.removeClass("success error show"); // 不显示成功提示
        }
    });

    // 登录提交表单前确认是否符合规范
    $("#loginCheck").click(function () {
        var userEmail = $("#loginUserEmail").val();
        var pwd = $("#loginPwd").val();
        var vCode = $("#inputVCode").val();

        if (!userEmail || userEmail.trim() === "") {
            $("#loginUserEmail").removeClass("valid invalid").addClass("invalid");
            $("#loginEmailTips").removeClass("success error show").text("邮箱不能为空!");
            $("#loginEmailTips").addClass("error show");
            return;
        }
        if (!userEmail.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/)) {
            $("#loginUserEmail").removeClass("valid invalid").addClass("invalid");
            $("#loginEmailTips").removeClass("success error show").text("邮箱格式不正确!");
            $("#loginEmailTips").addClass("error show");
            return;
        }
        if (!pwd || pwd.trim() === "") {
            $("#loginPwd").removeClass("valid invalid").addClass("invalid");
            $("#loginPwdTips").removeClass("success error show").text("密码不能为空!");
            $("#loginPwdTips").addClass("error show");
            return;
        }
        if (!vCode || vCode.trim() === "") {
            $("#inputVCode").removeClass("valid invalid").addClass("invalid");
            $("#loginVCodeTips").removeClass("success error show").text("验证码不能为空!");
            $("#loginVCodeTips").addClass("error show");
            return;
        }

        $.post("loginCheckServlet", {
            loginUserEmail: userEmail,
            loginPwd: pwd,
            inputVCode: vCode
        }, function (res) {
            console.log("xxx");
            if (res.emailCode == 1) {
                $("#loginUserEmail").removeClass("valid invalid").addClass("valid");
                $("#loginEmailTips").removeClass("success error show"); // 不显示成功提示
            } else {
                $("#loginUserEmail").removeClass("valid invalid").addClass("invalid");
                $("#loginEmailTips").removeClass("success error show").text("邮箱不存在!");
                $("#loginEmailTips").addClass("error show");
            }
            if (res.pwdCode == 1) {
                $("#loginPwd").removeClass("valid invalid").addClass("valid");
                $("#loginPwdTips").removeClass("success error show"); // 不显示成功提示
            } else if (res.emailCode == 1) {
                $("#loginPwd").removeClass("valid invalid").addClass("invalid");
                $("#loginPwdTips").removeClass("success error show").text("密码错误!");
                $("#loginPwdTips").addClass("error show");
            }
            if (res.vCode == 1) {
                $("#inputVCode").removeClass("valid invalid").addClass("valid");
                $("#loginVCodeTips").removeClass("success error show"); // 不显示成功提示
            } else {
                $("#inputVCode").removeClass("valid invalid").addClass("invalid");
                $("#loginVCodeTips").removeClass("success error show").text("验证码错误!");
                $("#loginVCodeTips").addClass("error show");
            }
            if (res.emailCode == 1 && res.pwdCode == 1 && res.vCode == 1) {
                $("#form2").submit();
            }
        }, "json");
    });

    // 切换注册/登录面板
    $("#signUp").click(function () {
        $("#login-box").addClass('right-panel-active');
    });

    $("#signIn").click(function () {
        $("#login-box").removeClass('right-panel-active');
    });

    // 输入框焦点效果
    $(".txtb input").on("focus", function () {
        $(this).addClass("focus");
    });

    $(".txtb input").on("blur", function () {
        if ($(this).val() == '')
            $(this).removeClass("focus");
    });
</script>

</html>