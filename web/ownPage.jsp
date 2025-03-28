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
    <style>
        body {
            font-family: 'PingFang SC', 'Helvetica Neue', Arial, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .main {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 800px; /* 调整宽度为 800px */
            margin: 20px;
        }

        .form-title {
            text-align: center;
            color: #333;
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
        }

        .profile-container {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .profile-avatar {
            position: relative;
            width: 60px;
            height: 60px;
            margin-right: 1rem;
            cursor: pointer;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%
        }

        .avatar-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .profile-avatar:hover .avatar-overlay {
            opacity: 1;
        }

        .avatar-overlay span {
            color: white;
            font-size: 12px;
        }

        .username-container {
            flex: 1;
        }

        .form-control.username {
            width: 100%;
            max-width: 200px; /* 限制用户名输入框宽度 */
            padding: 0.75rem;
            border: 1px solid #e5e5e5;
            border-radius: 5px;
            font-size: 0.9rem;
            color: #333;
            transition: border-color 0.3s ease;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e5e5e5;
            border-radius: 5px;
            font-size: 0.9rem;
            color: #333;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #40c4ff;
            box-shadow: 0 0 5px rgba(64, 196, 255, 0.2);
        }

        .form-control[readonly] {
            background: #f5f5f5;
            color: #999;
            cursor: not-allowed;
        }

        .form-label {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-check-input {
            margin-right: 0.5rem;
        }

        .form-check-label {
            color: #666;
            font-size: 0.9rem;
        }

        .form-check-inline {
            margin-right: 1rem; /* 增加性别选项之间的间距 */
            display: inline-block;
        }

        .mb-3 {
            margin-bottom: 1.2rem;
        }

        .btn {
            padding: 0.75rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.3s ease;
        }

        .btn-primary {
            background: #40c4ff;
            color: white;
            width: 103%;
        }

        .btn-primary:hover {
            background: #03a9f4;
        }

        .btn-back {
            width: 100%;
            display: block;
            text-align: center;
            text-decoration: none;
            color: #999;
            padding: 0.75rem;
            background: #f5f5f5;
            border-radius: 5px;
            margin-top: 0.5rem;
            font-size: 0.9rem;
        }

        .btn-back:hover {
            background: #e5e5e5;
            color: #666;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 80px;
        }

        select.form-control {
            appearance: none;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24"><path fill="%23999" d="M7 10l5 5 5-5z"/></svg>') no-repeat right 0.75rem center;
            background-size: 12px;
        }

        /* 隐藏文件输入框的默认提示 */
        input[type="file"] {
            display: none;
        }
    </style>
</head>
<body>
<div class="main">
    <h2 class="form-title">个人信息修改</h2>
    <form action="userUpdateServlet" method="post" enctype="multipart/form-data">
        <% User user = (User) session.getAttribute("user"); %>

        <div class="profile-container">
            <div class="profile-avatar">
                <img src="<%=user.getUserImgPath()%>" alt="头像">
                <div class="avatar-overlay">
                    <span>更换头像</span>
                </div>
                <input type="file" name="userImg" id="avatar-upload" onchange="previewAvatar(event)">
            </div>
            <div class="username-container">
                <input class="form-control username" name="userName" type="text" value="<%=user.getUserName()%>"
                       maxlength="20">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">性别</label>
            <div>
                <div class="form-check form-check-inline">
                    <input type="radio" name="userGender" id="man" class="form-check-input" value="男" checked>
                    <label class="form-check-label" for="man">男</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" name="userGender" id="woman" class="form-check-input" value="女">
                    <label class="form-check-label" for="woman">女</label>
                </div>
            </div>
        </div>

        <div class="mb-3">
            <label for="userEmail" class="form-label">邮箱</label>
            <input type="email" value="<%=user.getUserEmail()%>" name="userEmail" id="userEmail" class="form-control"
                   placeholder="请输入邮箱" readonly>
        </div>

        <div class="mb-3">
            <label for="userTel" class="form-label">联系电话</label>
            <input type="text" value="<%=user.getUserTel()%>" name="userTel" id="userTel" class="form-control"
                   placeholder="请输入联系电话">
        </div>

        <div class="mb-3">
            <label for="userAddress" class="form-label">地址</label>
            <input type="text" value="<%=user.getUserAddress()%>" name="userAddress" id="userAddress"
                   class="form-control" placeholder="请输入地址">
        </div>

        <div class="mb-3">
            <label for="question" class="form-label">密保</label>
            <select id="question" name="pwdQuestion" class="form-control">
                <option value="初恋的名字" selected>初恋的名字</option>
                <option value="小学校名">小学校名</option>
                <option value="玩的最好的朋友">玩的最好的朋友</option>
                <option value="喜欢看的电影">喜欢看的电影</option>
                <option value="您的母亲的名字">您的母亲的名字</option>
                <option value="出生地">出生地</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="pwdQuestionAnswer" class="form-label">密保答案</label>
            <input type="text" value="<%=user.getPwdReqAnswer()%>" name="pwdQuestionAnswer" id="pwdQuestionAnswer"
                   class="form-control" placeholder="输入密保答案">
        </div>

        <div class="mb-3">
            <label for="personal_signature" class="form-label">个性签名</label>
            <textarea name="personalSignature" id="personal_signature" class="form-control" placeholder="定义个性签名"
                      rows="3"><%=user.getPersonalSignature()%></textarea>
        </div>

        <button type="submit" class="btn btn-primary">更新信息</button>
        <a href="index.jsp" class="btn-back">取消</a>
    </form>
</div>
<script>
    const avatarContainer = document.querySelector('.profile-avatar');
    const avatarInput = document.getElementById('avatar-upload');
    const avatarImg = document.querySelector('.profile-avatar img');

    // 点击头像时触发文件选择框
    avatarContainer.addEventListener('click', () => avatarInput.click());

    // 上传头像后预览
    function previewAvatar(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => avatarImg.src = e.target.result;
            reader.readAsDataURL(file);
        }
    }
</script>
</body>
</html>