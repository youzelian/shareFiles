<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/23 0023
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>上传文件</title>
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        html {
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            min-height: 100vh;
        }

        body {
            color: #333;
            line-height: 1.6;
            height: auto;
        }

        .main {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            gap: 30px;
            padding: 0 20px;
        }

        .content {
            flex: 2;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .sidebar {
            flex: 1;
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            max-height: 400px;
            overflow-y: auto;
        }

        .gen-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .file_title, .file_content, .file_club, .file_file, .file_submit {
            border: none;
            padding: 0;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
            color: #2c3e50;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #dfe6e9;
            border-radius: 8px;
            font-size: 14px;
            background: #f9fbfc;
            transition: all 0.3s ease;
        }

        input[type="text"]:hover, textarea:hover, select:hover {
            border-color: #3498db;
            background: #eef2f5;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        input[type="text"]:focus, textarea:focus, select:focus {
            border-color: #3498db;
            background: #fff;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
            outline: none;
        }

        textarea {
            resize: none;
            min-height: 120px;
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            padding-right: 36px;
        }

        .custom-file-upload {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            padding: 12px;
            border: 2px dashed #dfe6e9;
            border-radius: 8px;
            background: #f9fbfc;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .custom-file-upload:hover {
            border-color: #3498db;
            background: #eef2f5;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .custom-file-upload:active {
            transform: scale(0.98);
        }

        .custom-file-upload .iconfont {
            font-size: 20px;
            color: #3498db;
            margin-right: 10px;
        }

        .custom-file-upload .file-text {
            flex: 1;
            color: #2c3e50;
            font-size: 14px;
            font-weight: 500;
        }

        .custom-file-upload input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .custom-file-upload input[type="file"]:valid + .file-text {
            color: #27ae60;
        }

        input[type="submit"] {
            background: linear-gradient(90deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.2);
        }

        input[type="submit"]:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(52, 152, 219, 0.3);
        }

        input[type="submit"]:active {
            transform: translateY(1px);
            box-shadow: 0 2px 5px rgba(52, 152, 219, 0.1);
        }

        .back-button {
            display: inline-block;
            text-align: center;
            text-decoration: none;
            background: linear-gradient(90deg, #bdc3c7, #95a5a6);
            color: white;
            padding: 10px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }

        .back-button:hover {
            background: linear-gradient(90deg, #95a5a6, #7f8c8d);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .back-button:active {
            transform: translateY(1px);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }

        th {
            background: #3498db;
            color: white;
            font-weight: 600;
        }

        td {
            background: #f9fbfc;
            transition: background 0.3s ease;
        }

        tr:hover td {
            background: #eef2f5;
        }

        @media (max-width: 768px) {
            .main {
                flex-direction: column;
                margin: 20px auto;
            }

            .content, .sidebar {
                width: 100%;
            }
        }

        /* 按钮容器 */
        .description-buttons {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }

        /* 添加按钮样式 */
        .add-button {
            background: linear-gradient(90deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(52, 152, 219, 0.2);
        }

        .add-button:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391);
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.3);
        }

        .add-button:active {
            transform: translateY(1px);
            box-shadow: 0 1px 3px rgba(52, 152, 219, 0.1);
        }

        /* 图片预览样式 */
        .image-preview-item {
            position: relative;
            width: 60px;
            height: 60px;
        }

        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 4px;
        }

        .image-preview-item .remove-btn {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            line-height: 16px;
            text-align: center;
            cursor: pointer;
            font-size: 12px;
        }

        .image-preview-item .remove-btn:hover {
            background: #c0392b;
        }
    </style>
</head>

<body>
<div class="main">
    <%--内容--%>
    <div class="content">
        <form action="fileSaveServlet" method="post" enctype="multipart/form-data" class="gen-form" id="mainForm">
            <!-- 标题 -->
            <div class="file_title">
                <label>标题</label>
                <input type="text" placeholder="请填写标题" name="fileTitle" required>
            </div>

            <!-- 正文（文件描述） -->
            <div class="file_content">
                <label>文件描述</label>
                <textarea name="fileIntroduction" placeholder="请输入文件描述" rows="5" required
                          id="fileDescription"></textarea>
                <div class="description-buttons">
                    <button type="button" class="add-button add-image">添加图片</button>
                    <button type="button" class="add-button add-emoji">添加表情包</button>
                </div>
                <!-- 图片预览区域 -->
                <div id="imagePreview" style="margin-top:10px; display:flex; flex-wrap:wrap; gap:10px;"></div>
                <!-- 隐藏的文件输入框用于图片上传 -->
                <input type="file" id="imageUpload" accept="image/*" style="display:none;">
            </div>

            <!-- 俱乐部 -->
            <div class="file_club">
                <label>俱乐部</label>
                <select name="fileOfClub" required>
                    <option value="" disabled selected>请选择俱乐部</option>
                    <c:forEach items="${clubList}" var="club">
                        <option value="${club.clubId}">${club.clubName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- 上传文件 -->
            <div class="file_file">
                <label>文件选择</label>
                <div class="custom-file-upload">
                    <span class="iconfont"></span>
                    <span class="file-text">Choose a file</span>
                    <input type="file" name="file" id="file" required>
                </div>
            </div>

            <!-- 提交按钮 -->
            <div class="file_submit">
                <input type="submit" value="提交文件">
                <a href="index.jsp" class="back-button">返回</a>
            </div>
        </form>
    </div>
    <%--侧边栏--%>
    <div class="sidebar">
        <table>
            <thead>
            <tr>
                <th>俱乐部名</th>
                <th>俱乐部人数</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${clubList}" var="club">
                <tr>
                    <td>${club.clubName}</td>
                    <td>${club.clubNumbers}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<%-- 表情选择器 --%>
<div id="emoji-panel"
     style="display:none; position:absolute; background:#fff; border:1px solid #ccc; padding:10px; border-radius:8px; box-shadow:0 4px 10px rgba(0,0,0,0.1); max-height:200px; overflow-y:auto;"></div>
</body>
<script>
    $(document).ready(function () {
        // 显示选择的文件名
        $("#file").on("change", function () {
            var fileName = $(this).val().split("\\").pop();
            if (fileName) {
                $(this).siblings(".file-text").text(fileName);
            } else {
                $(this).siblings(".file-text").text("Choose a file");
            }
        });

        // 提交前的文件验证
        $("#mainForm").submit(function (e) {
            if ($("#file").val() === "") {
                alert("请选择文件后上传！");
                e.preventDefault();
                return false;
            }
        });

        // 图片上传和预览功能
        var imageCount = 0;
        var imageUrls = [];
        $(".add-image").click(function () {
            if (imageCount >= 9) {
                alert("最多只能上传 9 张图片！");
                return;
            }
            $("#imageUpload").click();
        });
        // 图片预览
        $("#imageUpload").change(function () {
            var file = this.files[0];
            if (file) {
                var formData = new FormData();
                formData.append("image", file);

                $.ajax({
                    url: "uploadImageServlet",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        if (response.success) {
                            var imageUrl = response.imageUrl;
                            var textarea = $("#fileDescription");
                            var currentText = textarea.val();
                            textarea.val(currentText + "[img]" + imageUrl + "[/img]");
                            imageUrls.push(imageUrl);
                            imageCount++;

                            // 添加预览缩略图
                            var previewItem = $('<div class="image-preview-item">' +
                                '<img src="' + imageUrl + '" alt="Preview">' +
                                '<button class="remove-btn" data-url="' + imageUrl + '">×</button>' +
                                '</div>');
                            $("#imagePreview").append(previewItem);
                        } else {
                            alert("图片上传失败：" + response.message);
                        }
                    },
                    error: function () {
                        alert("图片上传失败，请稍后重试！");
                    }
                });
            }
            this.value = "";
        });

        // 删除预览图片
        $("#imagePreview").on("click", ".remove-btn", function () {
            var url = $(this).data("url");
            var textarea = $("#fileDescription");
            var currentText = textarea.val();
            textarea.val(currentText.replace("[img]" + url + "[/img]", ""));
            imageUrls = imageUrls.filter(u => u !== url);
            imageCount--;
            $(this).parent().remove();
        });

        // 表情包功能
        var emojis = [];
        $.getJSON("emojis.json", function (data) {
            emojis = data;
        }).fail(function () {
            emojis = ["😊", "😂", "👍", "😍", "😢", "😡", "🙏", "👏", "❤️"];
        });

        $(".add-emoji").click(function (e) {
            var panel = $("#emoji-panel");
            panel.empty();
            emojis.forEach(function (emoji) {
                panel.append('<span class="emoji-option" style="font-size:20px; cursor:pointer; padding:5px;">' + emoji + '</span>');
            });
            panel.toggle().position({
                my: "left top",
                at: "left bottom",
                of: $(this)
            });
            e.stopPropagation();
        });

        $("#emoji-panel").on("click", ".emoji-option", function () {
            var emoji = $(this).text();
            var textarea = $("#fileDescription");
            textarea.val(textarea.val() + emoji);
            $("#emoji-panel").hide();
        });

        $(document).click(function (e) {
            if (!$(e.target).closest("#emoji-panel, .add-emoji").length) {
                $("#emoji-panel").hide();
            }
        });
    });
</script>
</html>