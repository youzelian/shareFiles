<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>忘记密码</title>
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f5f5f5;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .progress-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 500px;
            margin-bottom: 30px;
        }

        .progress-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }

        .progress-step .circle {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .progress-step.active .circle {
            background-color: #28a745;
        }

        .progress-step .label {
            font-size: 14px;
            color: #666;
        }

        .progress-line {
            flex: 1;
            height: 4px;
            background-color: #ccc;
        }

        .progress-line.active {
            background-color: #28a745;
        }

        .step-content {
            display: none;
            width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .step-content.active {
            display: block;
        }

        .step-content label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #333;
        }

        .step-content input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .step-content button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            margin: 5px;
        }

        .step-content button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .step-content button.cancel {
            background-color: #ccc;
            color: #333;
        }

        .step-content button.cancel:hover {
            background-color: #b3b3b3;
        }

        .tips {
            font-size: 12px;
            margin-top: 5px;
            color: #ff6f91;
            text-align: center;
        }

        .tips.success {
            color: #28a745;
        }
    </style>
</head>
<body>
<h2>忘记密码</h2>
<div class="progress-bar">
    <div class="progress-step active">
        <div class="circle">1</div>
        <div class="label">验证身份</div>
    </div>
    <div class="progress-line"></div>
    <div class="progress-step">
        <div class="circle">2</div>
        <div class="label">获取验证码</div>
    </div>
    <div class="progress-line"></div>
    <div class="progress-step">
        <div class="circle">3</div>
        <div class="label">设置新密码</div>
    </div>
    <div class="progress-line"></div>
    <div class="progress-step">
        <div class="circle">4</div>
        <div class="label">完成</div>
    </div>
</div>

<!-- 步骤1：验证身份 -->
<div class="step-content active" id="step1">
    <label>用户名：</label>
    <input type="text" id="userName" placeholder="请输入用户名">
    <label>邮箱：</label>
    <input type="email" id="userEmail" placeholder="请输入邮箱">
    <div class="tips" id="step1Tips"></div>
    <button onclick="verifyIdentity()">下一步</button>
    <button class="cancel" onclick="window.location.href='loginRegistrationPage.jsp'">返回</button>
</div>

<!-- 步骤2：获取验证码 -->
<div class="step-content" id="step2">
    <label>邮箱验证码：</label>
    <input type="text" id="emailVCode" placeholder="请输入邮箱验证码">
    <div class="tips" id="step2Tips"></div>
    <button id="sendEmailCode">发送验证码</button>
    <button onclick="verifyCode()">下一步</button>
    <button class="cancel" onclick="goToStep(1)">上一步</button>
</div>

<!-- 步骤3：设置新密码 -->
<div class="step-content" id="step3">
    <label>新密码：</label>
    <input type="password" id="newPwd1" placeholder="请输入新密码">
    <label>确认新密码：</label>
    <input type="password" id="newPwd2" placeholder="再次确认新密码">
    <div class="tips" id="step3Tips"></div>
    <button onclick="changePassword()">下一步</button>
    <button class="cancel" onclick="goToStep(2)">上一步</button>
</div>

<!-- 步骤4：完成 -->
<div class="step-content" id="step4">
    <p style="text-align: center; color: #28a745;">密码修改成功！请重新登录。</p>
    <button onclick="window.location.href='loginRegistrationPage.jsp'">返回登录</button>
</div>

<script>
    let currentStep = 1;

    function goToStep(step) {
        currentStep = step;
        updateProgress();
        $(".step-content").removeClass("active");
        $("#step" + step).addClass("active");
    }

    function updateProgress() {
        $(".progress-step").removeClass("active");
        $(".progress-line").removeClass("active");
        for (let i = 1; i <= currentStep; i++) {
            $(".progress-step").eq(i - 1).addClass("active");
            if (i < currentStep) {
                $(".progress-line").eq(i - 1).addClass("active");
            }
        }
    }

    // 步骤1：验证身份
    function verifyIdentity() {
        let userName = $("#userName").val();
        let userEmail = $("#userEmail").val();
        let $tips = $("#step1Tips");

        if (!userName || !userEmail) {
            $tips.removeClass("success").addClass("error").text("用户名和邮箱不能为空！");
            return;
        }

        $.post("verifyIdentityServlet", { userName: userName, userEmail: userEmail }, function(res) {
            if (res.success) {
                $tips.removeClass("error").addClass("success").text("验证成功！");
                goToStep(2);
            } else {
                $tips.removeClass("success").addClass("error").text(res.message);
            }
        }, "json").fail(function() {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    }

    // 步骤2：发送和验证验证码
    $("#sendEmailCode").click(function() {
        let userEmail = $("#userEmail").val();
        let $btn = $(this);
        let $tips = $("#step2Tips");

        $.post("sendEmailServlet", { email: userEmail, action: "resetPassword" }, function(res) {
            if (res.success) {
                $tips.removeClass("error").addClass("success").text("验证码已发送！");
                $btn.prop("disabled", true);
                let countdown = 60;
                $btn.text(countdown + "秒后重试");
                let timer = setInterval(function() {
                    countdown--;
                    $btn.text(countdown + "秒后重试");
                    if (countdown <= 0) {
                        clearInterval(timer);
                        $btn.text("发送验证码");
                        $btn.prop("disabled", false);
                    }
                }, 1000);
            } else {
                $tips.removeClass("success").addClass("error").text(res.message);
            }
        }, "json").fail(function() {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    });

    function verifyCode() {
        let emailVCode = $("#emailVCode").val();
        let $tips = $("#step2Tips");

        if (!emailVCode) {
            $tips.removeClass("success").addClass("error").text("验证码不能为空！");
            return;
        }

        $.post("verifyCodeServlet", { emailVCode: emailVCode }, function(res) {
            if (res.success) {
                $tips.removeClass("error").addClass("success").text("验证码正确！");
                goToStep(3);
            } else {
                $tips.removeClass("success").addClass("error").text(res.message);
            }
        }, "json").fail(function() {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    }

    // 步骤3：更改密码
    function changePassword() {
        let newPwd1 = $("#newPwd1").val();
        let newPwd2 = $("#newPwd2").val();
        let $tips = $("#step3Tips");

        if (!newPwd1 || !newPwd2) {
            $tips.removeClass("success").addClass("error").text("新密码不能为空！");
            return;
        }
        if (newPwd1 !== newPwd2) {
            $tips.removeClass("success").addClass("error").text("两次密码不一致！");
            return;
        }
        if (newPwd1.length < 6 || newPwd1.length > 20 || !isComplexEnough(newPwd1)) {
            $tips.removeClass("success").addClass("error").text("密码需6-20个字符，且包含字母、数字、特殊符号中的至少两种！");
            return;
        }

        $.post("forgetPwdServlet", { newPwd: newPwd1 }, function(res) {
            if (res.success) {
                // 成功时提交到 Servlet 进行页面跳转
                let form = document.createElement("form");
                form.method = "POST";
                form.action = "forgetPwdServlet";

                let inputSuccess = document.createElement("input");
                inputSuccess.type = "hidden";
                inputSuccess.name = "success";
                inputSuccess.value = "true";
                form.appendChild(inputSuccess);

                let inputNewPwd = document.createElement("input");
                inputNewPwd.type = "hidden";
                inputNewPwd.name = "newPwd";
                inputNewPwd.value = newPwd1;
                form.appendChild(inputNewPwd);

                document.body.appendChild(form);
                form.submit();
            } else {
                $tips.removeClass("error").addClass("success").text(res.message);
            }
        }, "json").fail(function() {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    }

    function isComplexEnough(pwd) {
        let types = 0;
        if (/[a-zA-Z]/.test(pwd)) types++;
        if (/\d/.test(pwd)) types++;
        if (/[@$!%*?&]/.test(pwd)) types++;
        return types >= 2;
    }
</script>
</body>
</html>