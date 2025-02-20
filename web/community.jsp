<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/12/2 0002
  Time: 20:05
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
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .main {
            width: 1200px;
            height: 1000px;
            margin: 0 auto;
        }

        .file-introduction {
            width: 1000px;
            margin: 25px auto;
            height: 200px;
            border-bottom: 1px solid #dedede;
        }

        .file-introduction h1 {
            text-align: center;
        }

        .message {
            width: 1000px;
            height: 70px;
        }

        .message td {
            padding: 10px 10px 10px 0px;
        }

        .message a {
            float: right;
        }

        .news_info {
            color: #898a8b;
            font-size: 18px;
            line-height: 30px;
            height: 60px;
            max-height: 60px;
            overflow: hidden;
            /* 超出的文本隐藏 */
            text-overflow: ellipsis;
            /* 溢出用省略号显示 */
            display: -webkit-box;
            /* 将对象作为弹性伸缩盒子模型显示 */
            -webkit-box-orient: vertical;
            /* 这个属性不是css的规范属性，需要组合上面两个属性，表示显示的行数 */
            -webkit-line-clamp: 2;
            /*  从上到下垂直排列子元素（设置伸缩盒子的子元素排列方式） */
        }

        .box {
            width: 500px;
            height: 40px;
            border: 2px solid red;
            margin: auto;
        }

        .input {
            float: left;
            width: 400px;
            font-size: 15px;
            /*宽400*/
            height: 40px;
            /*高38（因为文本框内外边框要占用1像素所以总体高度减2，其他盒子同理）*/
            outline: none;
            border: none;
            /*取消文本框内外边框*/
        }

        .button {
            float: left;
            width: 100px;
            height: 40px;
            color: white;
            background-color: red;
            /*将按钮背景设置为红色，字体设置为白*/
            border: none;
            outline: none;
            /*取消边框和外边框将按钮边框去掉*/
        }
    </style>
</head>

<body>
<div class="main">
    <div class="box">
        <form action="communityListServlet">
            <input type="text" class="input" name="searchContent" placeholder="请输入文件名" id="searchContent">
            <input type="submit" value="搜索" class="button" id="search">
        </form>
    </div>
    <div class="file-introduction" id="filesContent">
        <c:forEach items="${pages.list}" var="file">
            <h1>${file.fileName}</h1>
            <h3>文件介绍</h3>
            <p class="news_info">${file.fileIntroduction}</p>
            <div class="message">
                <table>
                    <tr>
                        <td>点赞数${file.fileVote}</td>
                        <td>收藏数${file.fileCollect}</td>
                        <td>下载数${file.fileDownloadAmount}</td>
                        <td>所属俱乐部:${file.clubName},俱乐部编号:${file.clubId}</td>
                    </tr>
                </table>
                <a href="transferServlet?fileId=${file.fileId}">点击进入</a>
            </div>
        </c:forEach>
    </div>
    <div>
        <!-- <%--显示首页，上一页，如果当前页是第一页则不显示超链接--%> -->
        <c:if test="${pages.pageNum== 1}">
            <label style="color:gray;">首页</label>
            <label style="color:gray;">上一页</label>
        </c:if>
        <c:if test="${pages.pageNum> 1}">
            <a href="communityListServlet?pageNum=1">首页</a>
            <a href="communityListServlet?pageNum=${pages.pageNum - 1}">上一页</a>
        </c:if>

        <!-- <%--显示页码和总页数--%> -->
        当前第${pages.pageNum}页/共${pages.pageCount}页

        <!-- <%--显示下一页和尾页--%> -->
        <c:if test="${pages.pageNum < pages.pageCount}">
            <a href="communityListServlet?pageNum=${pages.pageNum + 1}">下一页</a>
            <a href="communityListServlet?pageNum=${pages.pageCount}">尾页</a>
        </c:if>
        <c:if test="${pages.pageNum == pages.pageCount}">
            <label style="color:gray;">下一页</label>
            <label style="color:gray;">尾页</label>
        </c:if>
    </div>
</div>
</body>
<script>
    <%--    <%--%>
    <%--        String searchContent = request.getParameter("searchContent");--%>
    <%--    %>--%>
    <%--    $("#search").click(function () {--%>
    <%--        $("searchContent").html("<input type= 'text' class='input' name='searchContent' placeholder='请输入文件名' id='searchContent' value='" + "<%=searchContent%>" + "'>");--%>
    <%--    })--%>
</script>
</html>