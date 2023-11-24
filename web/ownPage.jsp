<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/22 0022
  Time: 19:40
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
            width: 800px;
            margin: 0 auto;
            clear: both;
            position: relative;
        }

        .gen-form {
            margin-top: 30px;
            text-align: center;
        }

        #edit-avatar {
            cursor: pointer;
            background: rgba(153, 216, 252, .22);
            box-shadow: 1px 1px 2px rgba(0, 0, 0, .08);
            border-radius: 50%;
            width: 80px;
            float: left;
        }

        .gen-form .row {
            width: 100px;
        }

        .gen-form label {
            display: block;
            width: 100px;
            float: left;
            margin-bottom: 2px;
            margin-top: 4px;
            margin-right: 8px;
            font-size: 1em;
            line-height: 1.5em;
            font-weight: 400;
            text-align: left;
        }

        label {
            cursor: pointer;
        }

        .form-field {
            padding: 8px 0;
            border-bottom: 1px solid #dedede;
        }

        .form-field .sex {
            float: left;
            margin-bottom: 2px;
            margin-top: 8px;
            margin-right: 8px;
        }

        .inputWrapper {
            padding: 0px;
            margin: 0px;
            height: 31px;
            float: left;
        }

        .inputInner {
            height: 31px;
            margin: 0px 0px 0px 8px;
        }

        .form-field fieldset {
            height: 32px;
            border: 0px;
        }

        .row {
            float: left;
            margin-top: 4px;
            margin-bottom: 2px;
            margin-right: 8px;
            font-size: 1em;
            line-height: 1.5em;
            font-weight: 400;
            text-align: left;
        }

        .inputWrapper {
            float: left;
            width: 310px;
            height: 32px;
            width: 310px;
            border: 1.2px solid #d8d8d8;
        }

        .inputWrapper input {
            width: 300px;
            border: 0px;
            font-size: 14px;
            line-height: 18px;
            height: 30px;
            color: #404040;
            border: none;
            background: transparent;
        }

        #personal_signature {
            float: left;
            border: 0;
            border-radius: 5px;
            background-color: rgba(241, 241, 241, .98);
            width: 355px;
            height: 100px;
            padding: 10px;
            resize: none;
        }

        #submit {
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
    </style>
</head>

<body>
<div class="main">
    <form action="userUpdateServlet" method="" class="gen-form">
        <!-- 头像 -->
        <div class="form-field">
            <fieldset style="height: 80px;">
                <label class="row">头像</label>
                <img src="imgs/1.jpg" alt="" id="edit-avatar">
                <input type="file" name="userImg" id="" style="float: left;">
            </fieldset>
        </div>
        <!-- 昵称 -->
        <div class="form-field">
            <fieldset>
                <label class="row">昵称</label>
                <div class="inputWrapper">
                    <div class="inputInner">
                        <input type="text" name="userName" value="${userName}">
                    </div>
                </div>
            </fieldset>
        </div>
        <!-- 性别 -->
        <div class="form-field">
            <fieldset>
                <label class="row">性别</label>
                <input type="radio" name="userGender" class="sex">
                <label>男</label>
                <input type="radio" name="userGender" class="sex">
                <label>女</label>
            </fieldset>
        </div>
        <!-- 邮箱 -->
        <div class="form-field">
            <fieldset>
                <label class="row">邮箱</label>
                <div class="inputWrapper">
                    <div class="inputInner">
                        <input type="text" value="${userEmail}" name="userEmail">
                    </div>
                </div>
            </fieldset>
        </div>
        <!-- 联系电话 -->
        <div class="form-field">
            <fieldset>
                <label class="row">联系电话</label>
                <div class="inputWrapper">
                    <div class="inputInner">
                        <input type="text" value="${userTel}" name="userTel">
                    </div>
                </div>
            </fieldset>
        </div>
        <!-- 地址 -->
        <div class="form-field">
            <fieldset>
                <label class="row">地址</label>
                <div class="inputWrapper">
                    <div class="inputInner">
                        <input type="text" value="${userAddress}" name="userAddress">
                    </div>
                </div>
            </fieldset>
        </div>
        <!-- 个性签名 -->
        <div class="form-field">
            <fieldset style="height: 120px;">
                <label class="row">个性签名</label>
                <textarea name="personalSignature" id="personal_signature" cols="30" rows="10"
                          placeholder="定义个性签名"></textarea>
            </fieldset>
        </div>
        <!-- 提交按钮 -->
        <div class="form-field" style="border: 0px;">
            <fieldset>
                <label></label>
                <input type="submit" value="更新信息" id="submit">
            </fieldset>
        </div>
    </form>
</div>

</body>

</html>
