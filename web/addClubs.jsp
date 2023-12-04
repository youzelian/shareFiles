<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/12/4 0004
  Time: 15:47
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

        .content .clubName {
            margin-bottom: 10px;
            width: 361px;
            padding: 5px;
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
            margin-bottom: 10px;
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
            /* font-weight: 550; */
            /* transform: scale(1.05); */
        }
    </style>
</head>

<body>
<div class="main">
    <h1>创建俱乐部</h1>
    <div class="content">
        <form action="clubSaveServlet">
            <p>俱乐部名称<span> *</span></p>
            <input type="text" name="clubName" class="clubName" placeholder="主体清晰,一秒get~">
            <p>俱乐部介绍<span> *</span></p>
            <textarea name="clubIntroduction" cols="30" rows="10" class="introduce"
                      placeholder="给你的俱乐部做个自我介绍,让大家能够了解俱乐部的宗旨，引导俱乐部成员一起分享~"></textarea>
            <input type="submit" value="立即创建" class="submit">
        </form>
    </div>
</div>
</body>

</html>