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
    <%--    <link rel="stylesheet" href="css/style.css">--%>
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            /* background-image: linear-gradient(120deg, #3498db, #8e44ad); */
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

        /* p {
            font-size: 14px;
            line-height: 20px;
            letter-spacing: .5px;
            margin: 20px 0 30px;
        } */

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
            /* background-color: #efdbde; */
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
            /* background-image: linear-gradient(120deg, #3498db, #8e44ad); */
            background-color: #f6f6f6;
            color: #fff;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            transform: translateY(0);
            transition: transform .6s ease-in-out;
        }

        /* 修改3 */
        .overlay p {
            font-family: "Open Sans", sans-serif;
            font-size: .7em;
            letter-spacing: 2px;
            color: #8E9AAF;
            text-align: center;
        }

        /* 修改1 */
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

        /* 修改3 */
        .overlay span {
            color: #EAC7CC;
        }

        /* 修改2 */
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

        .container.container.right-panel-active .overlay-container {
            transform: translateX(-100%);
        }

        .container.right-panel-active .sign-up-container {
            transform: translateX(100%);
            opacity: 1;
            z-index: 5;
        }

        .container.container.right-panel-active .overlay {
            transform: translateX(50%);
        }

        .container.container.right-panel-active .overlay-left {
            transform: translateY(0);
        }

        .container.container.right-panel-active .overlay-right {
            transform: translateY(20%);
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
                <label id='registerNameTips'></label>
            </div>
            <div class="txtb">
                <input type="password" id="registerPwd1">
                <span data-placeholder="Password"></span>
            </div>
            <div class="txtb">
                <input type="password" id="registerPwd2" name="userPwd">
                <span data-placeholder="Confirm Password"></span>
                <label id='registerPwdTips'></label>
            </div>
            <button type="button" id="registerCheck">注册</button>
        </form>
    </div>
    <!-- 登录界面 -->
    <div class="form-container sign-in-container">
        <form action="">
            <h1>登录</h1>
            <div class="txtb">
                <input type="text" name="loginUserName">
                <span data-placeholder="userName"></span>
                <label id='loginNameTips'></label>
            </div>
            <div class="txtb">
                <input type="password" name="loginUserPwd">
                <span data-placeholder="Password"></span>
                <label id='loginPwdTips'></label>
            </div>
            <div class="txtb">
                <input type="text" name="inputCode">
                <span data-placeholder="验证码"></span>
            </div>
            <%--验证码--%>
            <img src="createCode" id="codeImg"/>
            <a href="#">忘记密码？</a>
            <button type="button">登录</button>
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
                <img src="imgs/1.jpg" alt="" class="flower">
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
                <img src="imgs/2.jpg" alt="" class="flower">
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
    })

    // 提交表单前确认注册是否符合规范
    // function checkForm() {
    //     var flag = 0;
    //     // 发送ajax请求，判断用户名是否可用
    //     var name = $("#userName").val();
    //     var pwd1 = $("#Pwd1").val();
    //     var pwd2 = $("#Pwd2").val();
    //     // 参数1:请求的urL
    //     // 参数2:传递的参数
    //     // 参数3:回调函数
    //     // 参数4,服务器返回的数据的格式(json,html,text,xml)
    //     $.get("registerCheckServlet", {userName: name, Pwd1: pwd1, Pwd2: pwd2}, function (res) {
    //         if (res.nameCode == 1) {
    //             $("#nameTips").replaceWith("<label id='nameTips' style='color:green;float:right;bottom: 0;margin-bottom: 5px' >用户名可用!</label>");
    //         } else {
    //             $("#nameTips").replaceWith("<label id='nameTips' style='color:red'>用户名被占用!</label>");
    //         }
    //         if (res.pwdCode == 1) {
    //             $("#pwdTips").replaceWith("<label id='pwdTips' style='color:green'>√</label>");
    //         } else {
    //             $("#pwdTips").replaceWith("<label id='pwdTips' style='color:red'>密码不一致</label>");
    //         }
    //
    //         if (res.pwdCode === 1 && res.nameCode === 1) {
    //             flag = 1;
    //         }
    //         console.log("flag" + flag);
    //
    //     }, "json");
    //     console.log("flag" + flag);
    //     $("#from1").submit();
    //     if (flag == 1) {
    //         setTimeout(function () {
    //             $("#from1").submit();
    //         }, 3000);
    //     }
    // }

    // 注册提交表单前确认是否符合规范
    $("#registerCheck").click(function () {
        var userName = $("#registerUserName").val();
        var pwd1 = $("#registerPwd1").val();
        var pwd2 = $("#registerPwd2").val();
        // 参数1:请求的urL
        // 参数2:传递的参数
        // 参数3:回调函数
        // 参数4,服务器返回的数据的格式(json,html,text,xml)
        $.post("registerCheckServlet", {
            registerUserName: userName,
            registerPwd1: pwd1,
            registerPwd2: pwd2
        }, function (res) {
            if (res.nameCode == 1) {
                $("#registerNameTips").replaceWith("<label id='registerNameTips' style='color:green'>用户名可用!</label>");
            } else {
                $("#registerNameTips").replaceWith("<label id='tipsLabel' style='color:red'>用户名不可用!</label>");
            }
            if (res.pwdCode == 1) {
                $("#registerPwdTips").replaceWith("<label id='registerPwdTips' style='color:green'>√</label>");
            } else {
                $("#registerPwdTips").replaceWith("<label id='registerPwdTips' style='color:green'>密码不一致</label>");
            }
            if (res.nameCode == 1 && res.pwdCode == 1) {
                $("#form1").submit();
            }
        }, "json")
    })

    $("#signUp").click(function () {
        $("#login-box").addClass('right-panel-active')
    })

    $("#signIn").click(function () {
        $("#login-box").removeClass('right-panel-active')
    })

    $(".txtb input").on("focus", function () {
        $(this).addClass("focus")
    })

    $(".txtb input").on("blur", function () {
        if ($(this).val() == '')
            $(this).removeClass("focus")
    })

</script>

</html>