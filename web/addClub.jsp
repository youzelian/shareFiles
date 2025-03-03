<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>创建俱乐部</title>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            word-wrap: break-word;
            font-family: 微软雅黑;
            font-size: 14px;
            color: #444;
            outline: none;
        }

        .main {
            width: 1000px;
            margin: 0 auto;
            background: #fff;
            border-radius: 12px; /* 整体内容区域加圆角 */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 添加阴影 */
        }

        /* 顶部导航栏样式 */
        .header {
            width: 100%;
            background-color: #8bcfff; /* 浅蓝色，与 submit 按钮颜色一致 */
            border-radius: 12px 12px 0 0; /* 顶部圆角 */
            padding: 10px 0;
            position: relative; /* 为了绝对定位返回按钮和标题 */
        }

        .back-button {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            text-decoration: none;
            color: #fff;
            font-size: 20px; /* 增大图标大小 */
            padding: 5px 15px; /* 增加内边距 */
            transition: color 0.3s ease;
        }

        .back-button:hover {
            color: #e9f7fe; /* 悬停时颜色稍亮 */
        }

        .header h1 {
            text-align: center;
            color: #fff;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
        }

        .content {
            width: 375px;
            margin: 0 auto;
            padding: 20px; /* 增加内容区域内边距 */
        }

        .content p {
            margin: 5px auto;
        }

        .clubName, .clubMembership {
            margin-bottom: 10px;
            width: 355px;
            padding: 10px;
            border-radius: 5px;
            background-color: rgba(241, 241, 241, .98);
            border: 0;
        }

        p span {
            color: red;
        }

        .introduce {
            border: 0;
            border-radius: 5px;
            background-color: rgba(241, 241, 241, .98);
            width: 355px;
            height: 100px;
            padding: 10px;
            resize: none;
        }

        .submit {
            margin: 20px 0 0 0;
            width: 375px;
            height: 35px;
            padding: 5px;
            border-radius: 18px;
            background-color: #8bcfff;
            color: #e9f7fe;
            border: none;
            transition: all 0.2s linear 0s;
            cursor: pointer;
        }

        .submit:hover {
            color: white;
        }

        .upload-label {
            display: inline-block;
            width: 80px; /* 设置宽度为正方形 */
            height: 80px; /* 设置高度为正方形 */
            background-color: rgba(241, 241, 241, .98); /* 灰白色背景 */
            border-radius: 10px; /* 圆角 */
            font-size: 14px;
            font-weight: 300;
            color: #555; /* 文字颜色 */
            text-align: center;
            cursor: pointer;
            border: 2px solid #ddd; /* 边框 */
            transition: background-color 0.3s, border-color 0.3s;
            position: relative; /* 为了定位加号 */
        }

        .upload-label:hover {
            background-color: #f0f0f0; /* 鼠标悬停时背景色 */
            border-color: #bbb;
        }

        .upload-label:active {
            background-color: #e0e0e0; /* 点击时背景色 */
            border-color: #999;
        }

        .upload-label::before {
            content: "+"; /* 加号 */
            position: absolute;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 50px; /* 调整加号大小 */
            color: #d9d9db; /* 加号颜色 */
        }

        .upload-label span {
            display: block; /* 文字放在加号下面 */
            position: absolute;
            bottom: 15%;
            left: 50%;
            transform: translateX(-50%);
            font-size: 12px;
            width: 50px;
        }

        .photo {
            text-align: center;
            position: relative; /* 确保预览图片能覆盖上传按钮 */
        }

        .preview-img {
            display: none; /* 初始隐藏预览图片 */
            width: 80px; /* 与 upload-label 相同大小 */
            height: 80px; /* 与 upload-label 相同大小 */
            border-radius: 10px; /* 与 upload-label 相同圆角 */
            object-fit: cover; /* 保持图片比例填充 */
            position: absolute;
            top: 0;
            left: 50%;
            margin-left: -40px;
            z-index: 1; /* 确保预览图片在 upload-label 之上 */
            cursor: pointer; /* 添加指针样式，表示可点击 */
        }

        /* 隐藏上传按钮的加号和文字，但保留点击功能 */
        .upload-label.preview-active {
            background-color: transparent;
            border-color: transparent;
        }

        .upload-label.preview-active::before,
        .upload-label.preview-active span {
            display: none; /* 隐藏加号和文字 */
        }
    </style>
</head>

<body>
<div class="main">
    <div class="header">
        <a href="index.jsp" class="back-button iconfont">&#xe789; 关闭</a>
        <h1>创建俱乐部</h1>
    </div>
    <div class="content">
        <form action="clubSaveServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="photo">
                <input type="file" name="clubImg" id="clubImg" style="display: none;" accept="image/*"
                       onchange="previewAvatar(this)"/>
                <label for="clubImg" class="upload-label" id="submit-photo"><span>添加头像</span></label>
                <img class="preview-img" id="preview" alt="预览头像">
            </div>
            <p>俱乐部名称<span> *</span></p>
            <input type="text" name="clubName" class="clubName" placeholder="主体清晰,一秒get~" required>
            <p>成员称号<span> *</span></p>
            <input type="text" name="clubMembership" class="clubMembership"
                   placeholder="取一个我们才懂的称号๑乛◡乛๑" required>
            <p>俱乐部简介<span> *</span></p>
            <textarea name="clubIntroduction" cols="30" rows="10" class="introduce"
                      placeholder="给你的俱乐部做个自我介绍,让大家能够了解俱乐部的宗旨，引导俱乐部成员一起分享~"
                      required></textarea>
            <input type="submit" value="立即创建" class="submit">
        </form>
    </div>
</div>
</body>
<script>
    // 上传俱乐部头像后预览
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                let previewImg = document.getElementById('preview');
                let uploadLabel = document.getElementById('submit-photo');
                previewImg.src = e.target.result;
                previewImg.style.display = 'block'; // 显示预览图片
                // 添加类以隐藏加号和文字，但保留点击功能
                uploadLabel.classList.add('preview-active');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    // 允许点击预览图片重新上传
    document.getElementById('preview').addEventListener('click', function () {
        let previewImg = this;
        let uploadLabel = document.getElementById('submit-photo');
        // 清除当前预览图片
        previewImg.style.display = 'none';
        previewImg.src = ''; // 清空图片源
        // 移除隐藏类，恢复上传按钮的加号和文字
        uploadLabel.classList.remove('preview-active');
        // 触发文件选择对话框
        document.getElementById('clubImg').click();
    });

    // 表单提交验证
    function validateForm() {
        let previewImg = document.getElementById('preview');
        if (previewImg.style.display === 'none' || previewImg.src === '') {
            alert('请选择头像');
            return false; // 阻止表单提交
        }
        return true; // 允许表单提交
    }
</script>
</html>