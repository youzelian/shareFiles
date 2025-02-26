<%@ page import="DTO.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息修改</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }

        .main {
            max-width: 800px;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .profile-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-avatar {
            position: relative;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-right: 20px;
            cursor: pointer;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }

        .avatar-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 16px;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .profile-avatar:hover .avatar-overlay {
            opacity: 1;
        }

        .profile-info {
            font-size: 18px;
            font-weight: 500;
        }

        .profile-info .edit-link {
            font-size: 14px;
            color: #00c7e1;
            cursor: pointer;
            text-decoration: none;
        }

        .form-field input,
        .form-field select,
        .form-field textarea {
            border-radius: 5px;
            border: 1px solid #ccc;
            padding: 10px;
            width: 100%;
            margin-top: 8px;
            font-size: 14px;
        }

        .form-field textarea {
            height: 100px;
        }

        #submit {
            width: 100%;
            background-color: #00c7e1;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        #submit:hover {
            background-color: #00a8c6;
        }

        .back-button {
            display: inline-block;
            text-align: center;
            text-decoration: none;
            background: linear-gradient(90deg, #bdc3c7, #95a5a6);
            color: white;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            width: 100%;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 10px;
        }

        .back-button:hover {
            background: linear-gradient(90deg, #95a5a6, #7f8c8d);
        }

        .back-button:active {
            transform: translateY(1px);
        }

        a:hover {
            color: white;
        }
    </style>
</head>

<body>

<div class="container mt-5">
    <div class="main">
        <h2 class="form-title text-center">个人信息修改</h2>

        <form action="userUpdateServlet" method="post" enctype="multipart/form-data">
            <%
                User user = (User) session.getAttribute("user");
            %>
            <!-- 头像和昵称部分 -->
            <div class="profile-container">
                <div class="profile-avatar">
                    <img src="<%=user.getUserImgPath()%>" alt="头像">
                    <div class="avatar-overlay">
                        <span>更换头像</span>
                    </div>
                    <input type="file" name="userImg" id="avatar-upload" style="display: none;"
                           onchange="previewAvatar(event)">
                </div>
                <div class="profile-info">
                    <input class="username" name="userName" type="text" value="<%=user.getUserName()%>">
                </div>
            </div>

            <!-- 性别 -->
            <div class="form-field mb-3">
                <label>性别</label>
                <div class="form-check form-check-inline">
                    <input type="radio" name="userGender" id="man" class="form-check-input" value="男" checked>
                    <label class="form-check-label" for="man">男</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" name="userGender" id="woman" class="form-check-input" value="女">
                    <label class="form-check-label" for="woman">女</label>
                </div>
            </div>

            <!-- 邮箱 -->
            <div class="form-field mb-3">
                <label for="userEmail">邮箱</label>
                <input type="email" value="<%=user.getUserEmail()%>" name="userEmail" id="userEmail"
                       placeholder="请输入邮箱" required>
            </div>

            <!-- 联系电话 -->
            <div class="form-field mb-3">
                <label for="userTel">联系电话</label>
                <input type="text" value="<%=user.getUserTel()%>" name="userTel" id="userTel"
                       placeholder="请输入联系电话" required>
            </div>

            <!-- 地址 -->
            <div class="form-field mb-3">
                <label for="userAddress">地址</label>
                <input type="text" value="<%=user.getUserAddress()%>" name="userAddress" id="userAddress"
                       placeholder="请输入地址" required>
            </div>

            <!-- 密保问题 -->
            <div class="form-field mb-3">
                <label for="question">密保</label>
                <select id="question" name="pwdQuestion" class="form-control">
                    <option value="初恋的名字" selected="selected">初恋的名字</option>
                    <option value="小学校名">小学校名</option>
                    <option value="玩的最好的朋友">玩的最好的朋友</option>
                    <option value="喜欢看的电影">喜欢看的电影</option>
                    <option value="您的母亲的名字">您的母亲的名字</option>
                    <option value="出生地">出生地</option>
                </select>
            </div>

            <!-- 密保答案 -->
            <div class="form-field mb-3">
                <label for="pwdQuestionAnswer">密保答案</label>
                <input type="text" value="<%=user.getPwdReqAnswer()%>" name="pwdQuestionAnswer" id="pwdQuestionAnswer"
                       placeholder="设置密保才能修改密码" required>
            </div>

            <!-- 个性签名 -->
            <div class="form-field mb-3">
                <label for="personal_signature">个性签名</label>
                <textarea name="personalSignature" id="personal_signature" class="form-control"
                          placeholder="定义个性签名" rows="4"><%=user.getPersonalSignature()%></textarea>
            </div>

            <!-- 提交按钮 -->
            <div class="form-field">
                <button type="submit" id="submit">更新信息</button>
                <a href="index.jsp" class="back-button">取消</a>
            </div>
        </form>
    </div>
</div>

<script>
    // 点击头像时触发文件选择框
    document.querySelector('.profile-avatar').addEventListener('click', function () {
        document.getElementById('avatar-upload').click();
    });

    // 上传头像后预览
    function previewAvatar(event) {
        var file = event.target.files[0];
        var reader = new FileReader();
        reader.onload = function (e) {
            document.querySelector('.profile-avatar img').src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    // 编辑个性签名功能（你可以根据需求扩展）
    function editSignature() {
        alert('编辑个性签名');
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>