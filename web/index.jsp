<%@ page import="DTO.User" %>
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
    <title>共享界面</title>
    <!-- 引入 Font Awesome 图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        /* body 样式 */
        body {
            margin: 0;
            background-color: #f8f9fa;
        }

        /* 标题 */
        .header {
            padding: 30px;
            text-align: center;
            background: #1abc9c;
            color: white;
        }

        .header h1 {
            font-size: 40px;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .header p {
            font-size: 18px;
            margin: 5px 0 0;
            opacity: 0.9;
            font-style: italic;
        }

        /* 导航 */
        .navbar {
            overflow: hidden;
            background-color: #333;
            height: 92px;
        }

        .navbar > a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }

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
            border-radius: 50%;
            vertical-align: middle;
        }

        /* 首字母头像样式 */
        .initial-avatar {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 50px;
            width: 50px;
            border-radius: 50%;
            color: white;
            font-size: 20px;
            font-weight: bold;
            text-transform: uppercase;
            vertical-align: middle;
        }

        .navbar a:hover {
            color: black;
        }

        /* 列容器 */
        .row {
            display: flex;
            flex-wrap: wrap;
        }

        /* 侧边栏 */
        .side {
            flex: 20%;
            background-color: #ecf0f1;
            padding: 20px;
            border-right: 1px solid #ddd;
            min-height: calc(100vh - 192px); /* 确保侧边栏高度与主内容对齐 */
        }

        .side h3 {
            font-size: 20px;
            color: #2c3e50;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #1abc9c;
            font-weight: 600;
        }

        .side ul {
            list-style: none;
            padding: 0;
            margin: 0 0 30px 0;
        }

        .side li {
            margin-bottom: 15px;
        }

        .side li a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            text-decoration: none;
            color: #2c3e50;
            font-size: 16px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .side li a:hover {
            background-color: #1abc9c;
            color: white;
            transform: translateX(5px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .side li a i {
            font-size: 18px;
        }

        /* 主要内容区域 */
        .main {
            flex: 70%;
            background-color: white;
            padding: 20px;
        }

        .main h2 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 10px;
            position: relative;
        }

        .main h2::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 3px;
            background: #1abc9c;
            bottom: -5px;
            left: 0;
        }

        .main h5 {
            font-size: 1em;
            font-style: italic;
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        .main p {
            font-size: 16px;
            line-height: 1.8;
            color: #34495e;
            margin-bottom: 15px;
        }

        #bg {
            width: 100%;
            height: 300px;
        }

        #sm {
            overflow: hidden;
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

        /* 响应式布局 */
        @media screen and (max-width: 700px) {
            .row {
                flex-direction: column;
            }

            .side {
                border-right: none;
                border-bottom: 1px solid #ddd;
            }
        }

        @media screen and (max-width: 400px) {
            .navbar a {
                float: none;
                width: 100%;
            }

            .side li a {
                font-size: 14px;
                padding: 10px 12px;
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
            String userName = user != null ? user.getUserName() : "Guest";
            String userImgPath = user != null ? user.getUserImgPath() : "null";
            boolean hasImage = userImgPath != null && !userImgPath.equals("null") && !userImgPath.equals("http://localhost:8080/shareFiles/userImg/null") && !userImgPath.equals("http://localhost:8080/shareFiles/null");
        %>
        <a href="ownPage.jsp" class="headA">
            <% if (hasImage) { %>
            <img src="<%=userImgPath%>" title="点击进入我的主页" class="headImg" id="headImg">
            <% } else { %>
            <div class="initial-avatar" id="initialAvatar"><%=userName.charAt(0)%></div>
            <% } %>
        </a>
        <span><%=userName%></span>
        <a href="logoutServlet">登出</a>
    </div>
</div>

<div class="row">
    <div class="side">
        <h3>社区</h3>
        <ul>
            <li><a href="communityListServlet" title="点击查看详情"><i class="fas fa-users"></i> 动态广场</a></li>
            <li><a href="clubListServlet?web=club.jsp"><i class="fas fa-building"></i> 俱乐部广场</a></li>
        </ul>
        <h3>我的</h3>
        <ul>
            <li><a href="myFilesListServlet"><i class="fas fa-folder"></i> 我的文件夹</a></li>
            <li><a href="myClubsListServlet"><i class="fas fa-users-cog"></i> 我的俱乐部</a></li>
            <li><a href="clubListServlet?web=addFile.jsp"><i class="fas fa-upload"></i> 上传文件</a></li>
            <li><a href="addClub.jsp"><i class="fas fa-plus-circle"></i> 创建俱乐部</a></li>
            <li><a href="changePwd.jsp"><i class="fas fa-key"></i> 修改密码</a></li>
        </ul>
    </div>
    <div class="main">
        <h2>在这里，所有你想得到的东西这里都能找到</h2>
        <h5>Everything you want can be found here</h5>
        <center>
            <div id="bg">
                <div id="sm">
                    <table>
                        <tr>
                            <td id="Pic1">
                                <table>
                                    <tr>
                                        <td><img src="images/1.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/2.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/3.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/4.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/5.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/6.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/7.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/8.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
                                        <td><img src="images/9.jpg" onmouseover="mouseover(this)" onmouseout="mouseout(this)" style="height: 300px;"/></td>
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

<script>
    // 动态设置首字母头像的背景色
    function generateColorFromChar(char) {
        const colors = [
            "#FF6F61", "#6B5B95", "#88B04B", "#F7CAC9", "#92A8D1",
            "#955251", "#B565A7", "#009B77", "#DD4124", "#45B8AC"
        ];
        const charCode = char.toUpperCase().charCodeAt(0);
        const index = charCode % colors.length;
        return colors[index];
    }

    // 如果用户没有头像，设置首字母头像
    $(document).ready(function() {
        var $avatar = $("#initialAvatar");
        if ($avatar.length) {
            var initial = $avatar.text();
            var bgColor = generateColorFromChar(initial);
            $avatar.css("background-color", bgColor);
        }
    });

    // 图片滚动逻辑
    Pic2.innerHTML = Pic1.innerHTML;
    function scrolltoleft() {
        sm.scrollLeft++;
        if (sm.scrollLeft >= Pic1.scrollWidth) {
            sm.scrollLeft = 0;
        }
    }

    var MyMar = setInterval(scrolltoleft, 15);

    function mouseover(x) {
        x.style.width = "210";
        x.style.height = "256";
        x.style.cursor = "pointer";
    }

    function mouseout(x) {
        x.style.width = "105";
        x.style.height = "128";
    }

    sm.onmouseover = function () {
        clearInterval(MyMar);
    }

    sm.onmouseout = function () {
        MyMar = setInterval(scrolltoleft, 15);
    }
</script>
</body>
</html>