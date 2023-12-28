<%@ page import="DTO.User" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/21 0021
  Time: 13:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <title>Document</title>
    <style>
        * {
            box-sizing: border-box;
        }

        /* body 样式 */
        body {
            margin: 0;
        }

        /* 标题 */
        .header {
            padding: 30px;
            text-align: center;
            background: #1abc9c;
            color: white;
        }

        /* 标题字体加大 */
        .header h1 {
            font-size: 40px;
        }

        /* 导航 */
        .navbar {
            overflow: hidden;
            background-color: #333;
            height: 92px;
        }

        /* 导航栏样式 */
        .navbar > a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }

        /* 右侧链接*/
        .navbar .right {
            float: right;
            color: white;
            height: 92px;
            text-align: center;
            line-height: 92px;
            margin-right: 50px;
        }

        .navbar .right a {
            color: white;
            text-decoration: none;
            /* padding: 14px 20px; */
            margin: 0 25px;
        }

        .headA {
            display: inline-block;
            height: 92px;
            width: 50px;
        }

        .headImg {
            height: 50px;
            width: 50px;
            border-radius: 30px;
            vertical-align: middle;
        }

        /* 鼠标移动到链接的颜色 */
        .navbar a:hover {
            /* background-color: #ddd; */
            color: black;
        }

        /* 列容器 */
        .row {
            display: -ms-flexbox;
            /* IE10 */
            display: flex;
            -ms-flex-wrap: wrap;
            /* IE10 */
            flex-wrap: wrap;
        }

        /* 创建两个列 */
        /* 边栏 */
        .side {
            -ms-flex: 30%;
            /* IE10 */
            flex: 20%;
            background-color: #f1f1f1;
            padding: 20px;
        }

        .side ul {
            margin: 30px auto;
        }

        .side li a {
            display: block;
            width: 180px;
            height: 50px;
            line-height: 50px;
            text-decoration: none;
            color: black;
            font-size: 1.2em;
            text-align: center;
            /* 设置超链接的背景色 */
            background-color: #F8F8F8;
            /* 添加超链接的过渡效果 */
            transition: transform 0.5s ease-in-out;
            /* 边框圆角 */
            border-radius: 5px;
            /* 边框样式 */
            border: 1px solid #333;
            margin-bottom: 30px;
        }

        .side li a:hover {
            /* 设置鼠标悬停时超链接的背景色 */
            background-color: #FFD700;
            /* 在鼠标悬停时旋转超链接 */
            /*transform: rotate(360deg);*/
        }

        /* 主要的内容区域 */
        .main {
            -ms-flex: 80%;
            /* IE10 */
            flex: 70%;
            background-color: white;
            padding: 20px;
        }

        .main h5 {
            font-size: 1em;
        }

        #bg {
            width: 100%;
            height: 300px;
            /* background: url(imgs/精品展示.jpg); */
        }

        #sm {
            /*滚动对象样式*/
            overflow: hidden;
            /*隐藏Div中多余的内容，增加图片会一起滚动*/
            width: 960px;
            height: 300px;
            margin: 0 auto;
            padding-top: 30px;
        }

        /* 底部 */
        .footer {
            padding: 20px;
            text-align: center;
            background: #ddd;
        }

        /* 响应式布局 - 在屏幕设备宽度尺寸小于 700px 时, 让两栏上下堆叠显示 */
        @media screen and (max-width: 700px) {
            .row {
                flex-direction: column;
            }
        }

        /* 响应式布局 - 在屏幕设备宽度尺寸小于 400px 时, 让导航栏目上下堆叠显示 */
        @media screen and (max-width: 400px) {
            .navbar a {
                float: none;
                width: 100%;
            }
        }
    </style>
</head>

<body>
<div class="header">
    <h1>欢迎来到共享界面</h1>
    <p>一起来分享吧!</p>
</div>

<div class="navbar">
    <a href="https://github.com/youzelian/shareFiles"><img src="images/text-image.jpg" title="点击进入我的Github"></a>
    <div class="right">
        <%
            User user = (User) session.getAttribute("user");
        %>
        <a href="ownPage.jsp" class="headA"><img src="<%=user.getUserImgPath()%>" title="点击进入我的主页" class="headImg"
                                                 id="headImg"></a>
        <!-- 用户名 -->
        <span><%=user.getUserName()%></span>
        <!-- 登出 -->
        <a href="logoutServlet">登出</a>
    </div>
</div>

<div class="row">
    <div class="side">
        社区
        <ul style="list-style:none">
            <li><a href="communityListServlet" title="点击查看详情">动态广场</a></li>
            <li><a href="clubListServlet?web=club.jsp">俱乐部</a></li>
        </ul>
        我的
        <ul style="list-style:none">
            <li><a href="myFilesListServlet">我的文件夹</a></li>
            <li><a href="myClubsListServlet">我的俱乐部</a></li>
            <li><a href="clubListServlet?web=addFile.jsp">上传文件</a></li>
            <li><a href="addClub.jsp">创建俱乐部</a></li>
            <li><a href="changePwd.jsp">修改密码</a></li>
        </ul>
    </div>
    <div class="main">
        <h2>在这里，所有你想得到的东西这里都能找到</h2>
        <h5>Everything you want can be found here</h5>
        <center>
            <div id="bg">
                <div id="sm">
                    <!--滚动div-->
                    <table>
                        <!--外表格1x2,且第2单元格是空的-->
                        <tr>
                            <td id="Pic1">
                                <table>
                                    <!--内表格1x9,存放9张图片-->
                                    <tr>
                                        <td><img src="images/1.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/2.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/3.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/4.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/5.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/6.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/7.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/8.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                        <td><img src="images/9.jpg" onmouseover="mouseover(this)"
                                                 onmouseout="mouseout(this)" style="height: 300px;"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td id="Pic2"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </center>
        <br>
        <h2>在这里，分享会得到更多</h2>
        <h5>Here, share a share, the result is more</h5>
        <p>分享有种魔力，分享一份快乐会得到两份快乐,分享一份悲伤,悲伤会减少一半。</p>
        <p>在这里，你可以分享你的午餐，分享你的快乐，分享你的想法，分享你的悲伤...</p>
        <p>在这里,你也可以体验他人的悲伤快乐,他人的想法经验,还能找到志同道合的朋友</p>
        <p>在这里,你无所不能！</p>
    </div>
</div>
<div class="footer">
    <h2 style="color:#6e7781">Copyright belongs to YouZeLian</h2>
</div>

</body>
<script>
    // 如果该用户没有头像则赋予一个初始头像
    var src = $("#headImg")[0].src;
    if (src == "http://localhost:8080/shareFiles/userImg/null" || src == "http://localhost:8080/shareFiles/null") {
        $("#headImg").attr('src', "http://localhost:8080/shareFiles/images/flower1.jpg");
    }
    Pic2.innerHTML = Pic1.innerHTML;//复制一组图片，但被隐藏
    function scrolltoleft() {//定义向左移动的方法
        sm.scrollLeft++;//改变层的水平坐标，实现向左移动
        if (sm.scrollLeft >= Pic1.scrollWidth)//需要复位
            sm.scrollLeft = 0;//层的位置复位，浏览器窗口的宽度有限的
    }

    var MyMar = setInterval(scrolltoleft, 15); //定时器，方法名后不可加()

    function mouseover(x) {//放大图片
        x.style.width = "210";
        x.style.height = "256"
        x.style.cursor = "pointer"
    }

    function mouseout(x) {//图片复原
        x.style.width = "105";
        x.style.height = "128"
    }

    //两面两行是用方法响应对象的事件
    sm.onmouseover = function () {//匿名方法（函数）
        clearInterval(MyMar);//停止滚动
    }

    sm.onmouseout = function () {
        MyMar = setInterval(scrolltoleft, 15);//继续滚动
    }
</script>

</html>
