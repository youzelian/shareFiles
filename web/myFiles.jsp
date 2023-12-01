<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/23 0023
  Time: 14:44
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
    <title>Document</title>
    <style>
        .form-list table {
            width: 100%;
            margin: 15px 0;
            border: 0;
        }

        .form-list th {
            background-color: #FF5675;
            color: #FFFFFF
        }

        .form-list,
        .form-list th,
        .form-list td {
            font-size: 0.95em;
            text-align: center;
            padding: 4px;
            border-collapse: collapse;
        }

        .form-list th,
        .form-list td {
            border: 1px solid #fe2047;
            border-width: 1px 0 1px 0;
            border: 2px inset #ffffff;
        }

        .form-list tr {
            border: 1px solid #ffffff;
        }

        .form-list tr:nth-child(odd) {
            background-color: #fec6d1;
        }

        .form-list tr:nth-child(even) {
            background-color: #ffffff;
        }

        a.styled-link {
            text-decoration: none;
            /* 去除下划线 */
            color: #333;
            /* 文字颜色 */
            padding: 5px 10px;
            /* 内边距 */
            border: 1px solid #333;
            /* 边框样式 */
            border-radius: 4px;
            /* 边框圆角 */
            background-color: #f1f1f1;
            /* 背景颜色 */
            transition: background-color 0.3s ease-in-out;
            /* 过渡效果 */
            cursor: pointer;
            /* 鼠标样式为手型 */
        }

        a.styled-link:hover {
            background-color: yellow;
            /* 鼠标悬停时的背景颜色 */
        }


        p {
            width: 150px;
            word-wrap: break-word;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>

<body>
<table class=form-list width="90%" align="center">
    <tr>
        <th>文件编号</th>
        <th>文件名称</th>
        <th>文件类型</th>
        <th>文件下载地址</th>
        <th>点赞数</th>
        <th>收藏数</th>
        <th>下载数量</th>
        <th>隶属于俱乐部</th>
        <th>介绍</th>
    </tr>
    <%--    <c:forEach items="${bookPageHelper.list}" var="book">--%>
    <tr>
        <td><a href="transferServlet?fileId=3">3</a></td>
        <td>${file.fileName}</td>
        <td>${file.fileType}</td>
        <th><a href="${file.fileDownloadLink}" class="styled-link">下载地址</a></th>
        <td>${file.fileVote}</td>
        <td>${file.fileCollect}</td>
        <td>${file.fileDownloadAmount}</td>
        <td>${file.fileOfClub}</td>
        <th>
            <p>${file.fileIntroduction}</p>
        </th>
    </tr>
    <%--    </c:forEach>--%>
    <!-- <%--显示分页效果及页码切换--%> -->
    <tr height="50">
        <td colspan="9" align="center">
            <!-- <%--显示首页，上一页，如果当前页是第一页则不显示超链接--%> -->
            <c:if test="${filePageHelper.pageNum== 1}">
                <label style="color:gray;">首页</label>
                <label style="color:gray;">上一页</label>
            </c:if>
            <c:if test="${filePageHelper.pageNum> 1}">
                <a href="FileListServlet?pageNum=1">首页</a>
                <a href="FileListServlet?pageNum=${filePageHelper.pageNum - 1}">上一页</a>
            </c:if>

            <!-- <%--显示页码和总页数--%> -->
            当前第${bookPageHelper.pageNum}页/共${bookPageHelper.pageCount}页

            <!-- <%--显示下一页和尾页--%> -->
            <c:if test="${filePageHelper.pageNum < filePageHelper.pageCount}">
                <a href="FileListServlet?pageNum=${filePageHelper.pageNum + 1}">下一页</a>
                <a href="FileListServlet?pageNum=${filePageHelper.pageCount}">尾页</a>
            </c:if>
            <c:if test="${filePageHelper.pageNum == filePageHelper.pageCount}">
                <label style="color:gray;">下一页</label>
                <label style="color:gray;">尾页</label>
            </c:if>
        </td>
    </tr>
</table>
</body>

</html>