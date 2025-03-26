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

        /* 页面整体样式 */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center; /* 垂直居中 */
            height: 100vh; /* 占满视口高度 */
            background-color: #f5f5f5;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        /* 进度条样式 */
        .progress-bar {
            display: flex;
            align-items: center;
            justify-content: space-between; /* 均匀分布步骤 */
            width: 500px; /* 固定宽度 */
            margin-bottom: 30px;
        }

        .progress-step {
            display: flex;
            flex-direction: column;
            align-items: center; /* 步骤内容居中 */
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
            background-color: #28a745; /* 激活时绿色 */
        }

        .progress-step .label {
            font-size: 14px;
            color: #666;
        }

        .progress-line {
            flex: 1; /* 自动填充间距 */
            height: 4px;
            background-color: #ccc; /* 默认灰色连接线 */
        }

        .progress-line.active {
            background-color: #28a745;
        }

        /* 步骤内容区域样式 */
        .step-content {
            display: none; /* 默认隐藏 */
            width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 8px; /* 圆角 */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 轻微阴影 */
        }

        .step-content.active {
            display: block; /* 激活时显示 */
        }

        .step-content label {
            display: block;
            margin-bottom: 5px; /* 标签与输入框间距 */
            font-size: 14px;
            color: #333;
        }

        .step-content input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px; /* 输入框间距 */
            border: 1px solid #ccc; /* 灰色边框 */
            border-radius: 4px;
            font-size: 14px;
        }

        .step-content button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #007bff; /* 蓝色按钮 */
            color: white;
            cursor: pointer;
            margin: 5px; /* 按钮间距 */
        }

        .step-content button:disabled {
            background-color: #ccc; /* 禁用状态灰色 */
            cursor: not-allowed; /* 禁用光标 */
        }

        .step-content button.cancel {
            background-color: #ccc; /* 取消按钮灰色 */
            color: #333;
        }

        .step-content button.cancel:hover {
            background-color: #b3b3b3; /* 悬停时变深 */
        }

        .tips {
            font-size: 12px; /* 小号提示文字 */
            margin-top: 5px;
            color: #ff6f91; /* 错误提示粉红色 */
            text-align: center;
        }

        .tips.success {
            color: #28a745; /* 成功提示绿色 */
        }
    </style>
</head>
<body>
<h2>忘记密码</h2>
<!-- 进度条 -->
<div class="progress-bar">
    <div class="progress-step active"> <!-- 第一步默认激活 -->
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
    <div class="tips" id="step1Tips"></div> <!-- 提示信息 -->
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
    let currentStep = 1; // 当前步骤，默认从1开始

    // 切换到指定步骤
    function goToStep(step) {
        currentStep = step;
        updateProgress(); // 更新进度条
        $(".step-content").removeClass("active"); // 隐藏所有步骤内容
        $("#step" + step).addClass("active"); // 显示当前步骤内容
    }

    // 更新进度条状态
    function updateProgress() {
        $(".progress-step").removeClass("active");
        $(".progress-line").removeClass("active");
        for (let i = 1; i <= currentStep; i++) {
            $(".progress-step").eq(i - 1).addClass("active"); // 激活当前及之前的步骤
            if (i < currentStep) {
                $(".progress-line").eq(i - 1).addClass("active"); // 激活之前的连接线
            }
        }
    }

    // 步骤1：验证身份
    function verifyIdentity() {
        let userName = $("#userName").val(); // 获取用户名
        let userEmail = $("#userEmail").val(); // 获取邮箱
        let $tips = $("#step1Tips"); // 提示元素

        if (!userName || !userEmail) { // 检查是否为空
            $tips.removeClass("success").addClass("error").text("用户名和邮箱不能为空！");
            return;
        }

        // 发送 POST 请求验证身份
        $.post("verifyIdentityServlet", {userName: userName, userEmail: userEmail}, function (res) {
            if (res.success) {
                $tips.removeClass("error").addClass("success").text("验证成功！");
                goToStep(2); // 跳转到步骤2
            } else {
                $tips.removeClass("success").addClass("error").text(res.message); // 显示错误信息
            }
        }, "json").fail(function () {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    }

    // 按钮发送验证码函数
    $("#sendEmailCode").click(function () {
        let userEmail = $("#userEmail").val(); // 获取邮箱
        let $btn = $(this); // 发送按钮
        let $tips = $("#step2Tips"); // 提示元素

        // 发送 POST 请求到 sendEmailServlet
        $.post("sendEmailServlet", {email: userEmail, action: "resetPassword"}, function (res) {
            if (res.success) {
                $tips.removeClass("error").addClass("success").text("验证码已发送！");
                $btn.prop("disabled", true); // 禁用按钮
                let countdown = 60; // 倒计时60秒
                $btn.text(countdown + "秒后重试");
                let timer = setInterval(function () {
                    countdown--;
                    $btn.text(countdown + "秒后重试");
                    if (countdown <= 0) {
                        clearInterval(timer); // 清除计时器
                        $btn.text("发送验证码");
                        $btn.prop("disabled", false); // 恢复按钮
                    }
                }, 1000);
            } else {
                $tips.removeClass("success").addClass("error").text(res.message);
            }
        }, "json").fail(function () {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    });

    // 步骤2：验证验证码
    function verifyCode() {
        let emailVCode = $("#emailVCode").val(); // 获取验证码
        let $tips = $("#step2Tips");

        if (!emailVCode) { // 检查是否为空
            $tips.removeClass("success").addClass("error").text("验证码不能为空！");
            return;
        }

        // 发送 POST 请求验证验证码
        $.post("verifyCodeServlet", {emailVCode: emailVCode}, function (res) {
            if (res.success) {
                $tips.removeClass("error").addClass("success").text("验证码正确！");
                goToStep(3); // 跳转到步骤3
            } else {
                $tips.removeClass("success").addClass("error").text(res.message);
            }
        }, "json").fail(function () {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    }

    // 步骤3：更改密码
    function changePassword() {
        let newPwd1 = $("#newPwd1").val(); // 获取新密码
        let newPwd2 = $("#newPwd2").val(); // 获取确认密码
        let $tips = $("#step3Tips");

        if (!newPwd1 || !newPwd2) { // 检查是否为空
            $tips.removeClass("success").addClass("error").text("新密码不能为空！");
            return;
        }
        if (newPwd1 !== newPwd2) { // 检查两次输入是否一致
            $tips.removeClass("success").addClass("error").text("两次密码不一致！");
            return;
        }
        if (newPwd1.length < 6 || newPwd1.length > 20 || !isComplexEnough(newPwd1)) { // 检查密码复杂度
            $tips.removeClass("success").addClass("error").text("密码需6-20个字符，且包含字母、数字、特殊符号中的至少两种！");
            return;
        }

        // 发送 POST 请求更改密码
        $.post("forgetPwdServlet", {newPwd: newPwd1}, function (res) {
            if (res.success) {
                // 创建表单动态提交到 Servlet
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
                form.submit(); // 提交表单跳转
            } else {
                $tips.removeClass("error").addClass("success").text(res.message); // 显示错误信息（应为 error）
            }
        }, "json").fail(function () {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    }

    // 检查密码复杂度
    function isComplexEnough(pwd) {
        let types = 0;
        if (/[a-zA-Z]/.test(pwd)) types++; // 检查是否包含字母
        if (/\d/.test(pwd)) types++; // 检查是否包含数字
        if (/[@$!%*?&]/.test(pwd)) types++; // 检查是否包含特殊符号
        return types >= 2; // 至少包含两种类型
    }
</script>
</body>
</html>