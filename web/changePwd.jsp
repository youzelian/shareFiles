<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码</title>
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

        .form-container {
            width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .form-container label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #333;
        }

        .form-container input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-container button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin: 5px 0 5px 0;
        }

        .form-container button[type="submit"] {
            background-color: #007bff;
            color: white;
        }

        .form-container button[type="submit"]:hover {
            background-color: #0056b3;
        }

        .form-container button.cancel {
            background-color: #ccc;
            color: #333;
        }

        .form-container button.cancel:hover {
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
<h2>修改密码</h2>
<div class="form-container">
    <form id="changePwdForm">
        <label>旧密码：</label>
        <input type="password" id="oldPwd" name="oldPwd" placeholder="请输入旧密码">
        <label>新密码：</label>
        <input type="password" id="newPwd1" name="newPwd1" placeholder="请输入新密码">
        <label>确认新密码：</label>
        <input type="password" id="newPwd2" name="newPwd2" placeholder="再次确认新密码">
        <div class="tips" id="step1Tips"></div>
        <button type="submit">提交</button>
        <button type="button" class="cancel" onclick="window.location.href='index.jsp'">返回</button>
    </form>
</div>

<script>
    $("#changePwdForm").on("submit", function(event) {
        event.preventDefault(); // 阻止表单默认提交

        let oldPwd = $("#oldPwd").val();
        let newPwd1 = $("#newPwd1").val();
        let newPwd2 = $("#newPwd2").val();
        let $tips = $("#step1Tips");

        // 客户端校验
        if (!oldPwd || !newPwd1 || !newPwd2) {
            $tips.removeClass("success").addClass("error").text("所有字段不能为空！");
            return;
        }
        if (newPwd1 !== newPwd2) {
            $tips.removeClass("success").addClass("error").text("两次新密码不一致！");
            return;
        }
        if (oldPwd === newPwd1) {
            $tips.removeClass("success").addClass("error").text("旧密码和新密码不能相同！");
            return;
        }
        if (newPwd1.length < 6 || newPwd1.length > 20 || !isComplexEnough(newPwd1)) {
            $tips.removeClass("success").addClass("error").text("密码需6-20个字符，且包含字母、数字、特殊符号中的至少两种！");
            return;
        }

        // 提交到后端
        $.post("changePwdServlet", { oldPwd: oldPwd, newPwd: newPwd1 }, function(res) {
            if (res.success) {
                // 成功时提交到 Servlet 进行页面跳转
                let form = document.createElement("form");
                form.method = "POST";
                form.action = "changePwdServlet";

                let inputSuccess = document.createElement("input");
                inputSuccess.type = "hidden";
                inputSuccess.name = "success";
                inputSuccess.value = "true";
                form.appendChild(inputSuccess);

                let inputOldPwd = document.createElement("input");
                inputOldPwd.type = "hidden";
                inputOldPwd.name = "oldPwd";
                inputOldPwd.value = oldPwd;
                form.appendChild(inputOldPwd);

                let inputNewPwd = document.createElement("input");
                inputNewPwd.type = "hidden";
                inputNewPwd.name = "newPwd";
                inputNewPwd.value = newPwd1;
                form.appendChild(inputNewPwd);

                document.body.appendChild(form);
                form.submit();
            } else {
                // 失败时显示错误提示
                $tips.removeClass("success").addClass("error").text(res.message);
            }
        }, "json").fail(function(xhr, status, error) {
            $tips.removeClass("success").addClass("error").text("服务器错误，请稍后再试！");
        });
    });

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