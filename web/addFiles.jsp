<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/23 0023
  Time: 9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            outline: none;
            word-wrap: break-word;
            font-family: 微软雅黑;
            font-size: 14px;
            color: #444;
        }

        .main {
            position: relative;
        }

        .content {
            border: 1px solid pink;
            margin: 0 auto;
            width: 700px;
            height: 600px;
        }

        .gen-form {
            margin-top: 30px;
            /* border: 1px solid greenyellow; */
        }

        .form-field {
            height: 32px;
            padding: 8px 0;
            border-bottom: 1px solid #dedede;
        }

        .form-field fieldset {
            border: 0;
        }

        .form-field label {
            width: 100px;
            height: 21px;
            float: left;
            margin-right: 30px;
            margin-top: 5px;
            margin-left: 3px;
            cursor: pointer;
        }

        .form-field .inputWrapper {
            width: 310px;
            float: left;
            border: 1.2px solid #d8d8d8;
        }

        .form-field .inputInner {
            width: 302px;
            margin-left: 8px;
        }

        .form-field .inputInner input {
            width: 302px;
            border: 0px;
            font-size: 14px;
            line-height: 18px;
            height: 30px;
            color: #404040;
            border: none;
            background: transparent;
        }

        #file-type {
            float: left;
            height: 33px;
            line-height: 30px;
            margin-right: 20px;
        }

        #submit-file {
            float: left;
            width: 94px;
            height: 32px;
            line-height: 28px;
            font-size: 16px;
            color: #fff;
            border-radius: 3px;
            cursor: pointer;
            text-shadow: none;
            text-decoration: none;
            text-align: center;
            font-size: 14px;
            border-radius: 18px;
            background-color: #00c7e1;
            box-shadow: 0 2px 4px 0 rgba(0, 188, 212, .28);
            border: solid 3px rgba(255, 255, 255, .4);
        }

        .sidebar {
            border: 1px solid rgba(30, 30, 224, 0.742);
            width: 300px;
            height: 800px;
            position: absolute;
            right: 0;
            top: 0;
        }

        .out-table {
            width: 270px;
            margin: 10px auto;
            border: 1px solid red;
        }

        table {
            margin: 0 auto;
        }

        td,
        th {
            padding: 10px 10px;
        }
    </style>
</head>

<body>
<div class="main">
    <div class="content">
        <form action="fileSaveServlet" method="post" enctype="multipart/form-data" class="gen-form">
            <!-- 文件名 -->
            <div class="form-field">
                <fieldset>
                    <label>文件名</label>
                    <div class="inputWrapper">
                        <div class="inputInner">
                            <input type="text" placeholder="填写文件名称" name="fileName">
                        </div>
                    </div>
                </fieldset>
            </div>
            <!-- 文件类型 -->
            <div class="form-field">
                <fieldset>
                    <label>文件类型</label>
                    <select id="file-type" name="fileType">
                        <!--selected设置默认选中-->
                        <option value="图片" selected="selected">图片</option>
                        <option value="视频">视频</option>
                        <option value="exe文件">exe文件</option>
                        <option value="apk文件">apk文件</option>
                        <option value="pdf文件">pdf文件</option>
                        <option value="ppt文件">ppt文件</option>
                        <option value="word文件">word文件</option>
                        <option value="压缩包">压缩包</option>
                    </select>
                    <%--                    <div class="inputWrapper">--%>
                    <%--                        <div class="inputInner">--%>
                    <%--                            <input type="text" placeholder="选择文件类型">--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                </fieldset>
            </div>
            <!-- 文件描述 -->
            <div class="form-field">
                <fieldset>
                    <label>文件描述</label>
                    <div class="inputWrapper">
                        <div class="inputInner">
                            <input type="text" placeholder="描述" name="fileIntroduction">
                        </div>
                    </div>
                </fieldset>
            </div>
            <!-- 选择你的俱乐部 -->
            <div class="form-field">
                <fieldset>
                    <label>俱乐部</label>
                    <div class="inputWrapper">
                        <div class="inputInner">
                            <input type="text" placeholder="投入到哪个俱乐部" name="fileOfClub">
                        </div>
                    </div>
                </fieldset>
            </div>
            <!-- 提交文件 -->
            <div class="form-field">
                <fieldset>
                    <label>文件选择</label>
                    <div class="inputWrapper" style="border: none;">
                        <div class="inputInner">
                            <input type="file" name="file" id="upload_file">
                        </div>
                    </div>
                </fieldset>
            </div>
            <!-- 提交按钮 -->
            <div class="form-field" style="border: 0px;">
                <fieldset>
                    <label></label>
                    <input type="submit" value="提交文件" id="submit-file">
                </fieldset>
            </div>
        </form>
    </div>
    <div class="sidebar">
        <div class="out-table">
            <table>
                <thead>
                <tr>
                    <th>俱乐部名</th>
                    <th>俱乐部人数</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${club.clubName}</td>
                    <td>${club.numbers}</td>
                </tr>
                <tr>
                    <td>${club.clubName}</td>
                    <td>${club.numbers}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
<script>
    // 上传文件前判断是否有文件
    $("#submit-file").click(function () {
        if ($("#upload_file").val() == "") {
            alert("请选择文件后上传！");
            return false;
        } else {
            return true;
        }
    })
</script>
</html>
