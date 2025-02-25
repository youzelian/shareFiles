<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
        }

        .main h1 {
            text-align: center;
            margin: 15px auto;
        }

        .content {
            width: 375px;
            margin: 0 auto;
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
            background-color: rgba(241, 241, 241, .98); /* hui白色背景 */
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
        }
    </style>
</head>

<body>
<div class="main">
    <h1>创建俱乐部</h1>
    <div class="content">
        <form action="clubSaveServlet" method="post" enctype="multipart/form-data">
            <div class="photo">
                <input type="file" name="clubImg" id="clubImg" style="display: none;"/>
                <label for="clubImg" class="upload-label" id="submit-photo"><span>添加头像</span></label>
            </div>
            <p>俱乐部名称<span> *</span></p>
            <input type="text" name="clubName" class="clubName" placeholder="主体清晰,一秒get~">
            <p>成员称号<span> *</span></p>
            <input type="text" name="clubMembership" class="clubMembership"
                   placeholder="取一个我们才懂的称号๑乛◡乛๑">
            <p>俱乐部简介<span> *</span></p>
            <textarea name="clubIntroduction" cols="30" rows="10" class="introduce"
                      placeholder="给你的俱乐部做个自我介绍,让大家能够了解俱乐部的宗旨，引导俱乐部成员一起分享~"></textarea>
            <input type="submit" value="立即创建" class="submit">
        </form>
    </div>
</div>
</body>
<script>
    // // 上传文件前判断是否有文件
    // $("#submit-photo").click(function () {
    //     if ($("#upload_file").val() == "") {
    //         alert("请选择文件后上传！");
    //         return false;
    //     } else {
    //         return true;
    //     }
    // })

    // // 上传俱乐部头像后预览
    // function previewAvatar(event) {
    //     var file = event.target.files[0];
    //     var reader = new FileReader();
    //     reader.onload = function (e) {
    //         document.querySelector('.photo img').src = e.target.result;
    //     };
    //     reader.readAsDataURL(file);
    // }
</script>
</html>