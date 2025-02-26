<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Collected Files</title>
    <script type="text/javascript" src="JS/jquery-3.7.1.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="fonts/font_back/iconfont.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .file-table {
            width: 100%;
            border-collapse: collapse;
        }

        .file-table th {
            background-color: #6c63ff;
            color: #ffffff;
            padding: 15px;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 1px;
        }

        .file-table td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #e9ecef;
            font-size: 0.95em;
            color: #333;
        }

        .file-table tr {
            transition: background-color 0.3s ease;
        }

        .file-table tr:hover {
            background-color: #f8f9fa;
        }

        .file-link {
            color: #6c63ff;
            text-decoration: none;
            font-weight: 600;
        }

        .file-link:hover {
            text-decoration: underline;
        }

        .styled-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #28a745;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .styled-link:hover {
            background-color: #218838;
        }

        .intro-text {
            max-width: 200px;
            margin: 0 auto;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .pagination {
            padding: 20px;
            text-align: center;
            background-color: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }

        .pagination a, .pagination span {
            margin: 0 10px;
            text-decoration: none;
            color: #6c63ff;
            font-weight: 600;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .pagination a:hover {
            background-color: #6c63ff;
            color: #ffffff;
        }

        .pagination span.disabled {
            color: #adb5bd;
            pointer-events: none;
        }

        /* 新增：返回按钮样式 */
        .back-button {
            display: inline-block;
            padding: 8px 16px;
            background-color: #8f8cff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
            margin: 0 0 20px 20px; /* 距离容器左边和下方的间距 */
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        .back-button:hover {
            background-color: #6c63ff;
        }
    </style>
</head>
<body>
<a href="index.jsp" class="back-button iconfont">&#xe6a4; 返回</a>
<div class="container">
    <table class="file-table">
        <thead>
        <tr>
            <th>文件编号</th>
            <th>文件名称</th>
            <th>文件类型</th>
            <th>下载地址</th>
            <th>点赞数</th>
            <th>收藏数</th>
            <th>下载数量</th>
            <th>俱乐部</th>
            <th>介绍</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${user_FilePageHelper.list}" var="User_File">
            <tr>
                <td><a href="transferServlet?fileId=${User_File.fId}" class="file-link">${User_File.fId}</a></td>
                <td>${User_File.fileName}</td>
                <td>${User_File.fileType}</td>
                <td>
                    <a href="${User_File.fileDownloadLink}" class="styled-link download-link"
                       data-fileid="${User_File.fId}" download="${User_File.fileDownloadLink}">Download</a>
                </td>
                <td>${User_File.fileVote}</td>
                <td>${User_File.fileCollect}</td>
                <td class="downloadNum" data-fileid="${User_File.fId}">${User_File.fileDownloadAmount}</td>
                <td>${User_File.clubName}</td>
                <td><span class="intro-text">${User_File.fileIntroduction}</span></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- <%--显示分页效果及页码切换--%> -->
    <div class="pagination">
        <!-- <%--显示首页，上一页，如果当前页是第一页则不显示超链接--%> -->
        <c:if test="${user_FilePageHelper.pageNum== 1}">
            <span style="color:#adb5bd;">首页</span>
            <span style="color:#adb5bd;">上一页</span>
        </c:if>
        <c:if test="${user_FilePageHelper.pageNum> 1}">
            <a href="myFilesListServlet?pageNum=1">首页</a>
            <a href="myFilesListServlet?pageNum=${user_FilePageHelper.pageNum - 1}">上一页</a>
        </c:if>

        <!-- <%--显示页码和总页数--%> -->
        <span class="current-page">第${user_FilePageHelper.pageNum}页 / 共${user_FilePageHelper.pageCount}页</span>

        <!-- <%--显示下一页和尾页--%> -->
        <c:if test="${user_FilePageHelper.pageNum < user_FilePageHelper.pageCount}">
            <a href="myFilesListServlet?pageNum=${user_FilePageHelper.pageNum + 1}">下一页</a>
            <a href="myFilesListServlet?pageNum=${user_FilePageHelper.pageCount}">尾页</a>
        </c:if>
        <c:if test="${user_FilePageHelper.pageNum == user_FilePageHelper.pageCount}">
            <span style="color:#adb5bd;">下一页</span>
            <span style="color:#adb5bd;">尾页</span>
        </c:if>
    </div>
</div>
</body>
<script>
    // 为所有下载链接绑定点击事件
    $(".download-link").click(function (e) {
        var fileId = $(this).data("fileid"); // 获取 fileId
        var $downloadNumCell = $(this).closest("tr").find(".downloadNum[data-fileid='" + fileId + "']");
        // 发送 AJAX 请求
        $.post("interactServlet", {type: "download", fileId: fileId}, function (res) {
            // 更新下载数量
            $downloadNumCell.text(res.fileDownloadAmount);
        }, "json");
    });
</script>
</html>