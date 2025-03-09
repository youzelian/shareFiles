<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>客服</title>
    <link rel="stylesheet" type="text/css" href="../css/Cservice.css"/>
    <link rel="stylesheet" href="../css/base.css">
    <style type="text/css">
        body {
            background: rgb(46, 47, 61);
        }

        .wrap {
            width: 900px;
            height: 550px;
            background: #fff;
            margin: 100px auto;
            margin-top: 100px;
            margin-right: auto;
            margin-bottom: 100px;
            margin-left: auto;
            display: flex;
        }

        /* 左边 */
        .left {

            height: inherit;
            width: 30%;
            border-right: 1px solid #e1e1e1;
        }

        .UserHead {
            padding: 10px;
            background: rgb(255, 76, 71);
        }

        .UserTop {
            display: flex;
        }

        .UserTop img {
            width: 54px;
            margin-right: 14px;
        }

        .userT {
            font-size: 38px;
            margin-right: 10px;
        }

        .iconName {
            font-size: 16px;
        }

        .souSuo {
            display: flex;
            background: #fff;
            border-radius: 2px;
            margin-top: 10px;
            height: 30px;
        }

        .souSuo .sou {
            font-size: 24px;
        }

        .souSuo input {
            width: 100%;
            /* height:100% */
            border: none;
            box-shadow: 0px 0px 0px #fff;
            outline: none;

        }


        .left ul li {
            padding: 10px;
            font-size: 14px;
        }

        .left ul li span {
            font-size: 12px;
            padding: 2px 6px;
            background: yellow;
            float: right;
        }

        .xuanZhong {
            background-color: #0086B3;
        }


        .left ul .icon {
            font-size: 30px;
            vertical-align: middle;
            margin-right: 10px;
        }

        /* 右边 */
        .right {
            width: 70%;
            /* background: red; */
        }

        .Rhead {
            height: 12%;

            background: beige;
            line-height: 60px;
        }

        .Rhead .kefu {
            font-size: 44px;

            vertical-align: middle;
            margin: 0 10px;
        }

        .content {
            height: 88%;
            border-bottom: 1px solid #ccc;
        }

        .text {
            padding: 0 20px;
            position: relative;
        }

        .TextTop {
            height: 50px;
            position: relative;
            display: flex;
            align-items: center;
            font-size: 20px;
        }

        .clearfix {
            width: 22.5rem;
            height: 12rem;
            border: 1px solid #CCC;
            border-right: none;
            position: absolute;
            display: flex;
            flex-wrap: wrap;
            bottom: 50px;
            overflow-x: hidden;
            overflow-y: scroll;
            background: #fff;
            left: -8px;
        }

        .clearfix li {
            width: 28px;
            text-align: center;
            border-right: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            box-sizing: border-box;
        }

        .TextTop .icon {
            font-size: 20px;
            margin-right: 10px;

        }

        .TextTop .file {
            width: 25px;
            height: 18px;
            position: absolute;
            left: 28px;
            top: 15px;
            opacity: 0;
        }

        .fileImg {
            width: 12rem;

        }

        .dialogue {
            width: 100%;
            height: 64%;
            padding: 14px;
            box-sizing: border-box;
            overflow-x: hidden;
            overflow-y: scroll;
        }


        .textarea {
            min-height: 88px;
            outline: none;
            overflow-y: auto;
            font-size: 0.9em;
        }

        .textAlign {
            text-align: center;
        }

        .right2 {
            display: flex;
            flex-direction: row-reverse;
            margin-bottom: 0.625rem;
        }

        .huanHang {
            width: 200px;
            word-wrap: break-word;
        }

        .right2 > div {
            padding: 10px;
            word-wrap: break-word;
            white-space: normal;
            background: rgb(208, 233, 255);
        }

        .left2 {
            display: flex;
            margin-bottom: 0.625rem;
        }

        .left2 > div {
            padding: 10px;
            word-wrap: break-word;
            background: rgb(208, 233, 255);
        }

        .HeadPortrait {
            width: 2.2rem;
            height: 2.2rem;
            margin-left: 14px;
        }

        .HeadPortrait2 {
            width: 2.2rem;
            height: 2.2rem;
            margin-right: 14px;
        }

        .Enter {
            width: 42px;
            height: 19px;
            border: 1px solid #999;
            font-size: 14px;

            text-align: center;

            position: absolute;
            right: 20px;
            bottom: -27px;

        }

        .icon {
            width: 1em;
            height: 1em;
            vertical-align: -0.15em;
            fill: currentColor;
            overflow: hidden;
        }
    </style>

    <script type="text/javascript" src="//at.alicdn.com/t/font_2970465_b49mc7of9fp.js"></script>
    <script src="../js/emoji-lib/emoji-list-with-image.js"></script>
</head>
<body>
<div class="wrap">
    <div class="left">
        <div class="UserHead">
            <div class="UserTop">
                <svg class="icon userT" aria-hidden="true">
                    <use xlink:href="#icon-32"></use>
                </svg>
                <!-- <div class="name">123 <br> <svg class="icon iconName" aria-hidden="true">
                    <use xlink:href="#icon-32"></use>
                </svg></div> -->
            </div>
            <div class="souSuo">
                <svg class="icon sou" aria-hidden="true">
                    <use xlink:href="#icon-sousuo"></use>
                </svg>
                <input type="text">
            </div>
        </div>
        <ul>
            <li class="xuanZhong">
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-icon-test"></use>
                </svg>
                好友1 <span>官方</span></li>
            <li>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-icon-test1"></use>
                </svg>
                好友2
            </li>
            <li>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-icon-test2"></use>
                </svg>
                好友3
            </li>
        </ul>
    </div>
    <div class="right">

        <div class="Rhead">
            <svg class="icon kefu" aria-hidden="true">
                <use xlink:href="#icon-38"></use>
            </svg>
            杨杨
        </div>
        <div class="content">
            <div class="dialogue"></div>
            <div class="text">
                <div class="TextTop">
                    <!-- 表情 -->
                    <div class="emoji-cont">

                    </div>
                    <svg class="icon" aria-hidden="true" onclick="showEmoji()">
                        <use xlink:href="#icon-smiling"></use>
                    </svg>
                    <!-- 图片 -->
                    <input class="file" type="file" name="file" accept="image/*" onchange="selectImg(this)"/>
                    <svg class="icon" aria-hidden="true">
                        <use xlink:href="#icon-tupian"></use>
                    </svg>

                    <svg class="icon" aria-hidden="true">
                        <use xlink:href="#icon-jushoucang"></use>
                    </svg>
                </div>
                <div contenteditable="true" class="textarea"></div>
                <div class="Enter">发送</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var oIpt1 = document.querySelector(".textarea")   // 输入框
    var oIpt2 = document.querySelector(".Enter");  // 发送按钮
    var oText1 = document.querySelector(".dialogue");  // 内容【框


    var timeY = ''
    console.log(timeY)
    oIpt2.onclick = function () {
        faSong()
        cont.style.display = "none"
        fa = false
    }

    // 发送消息
    function faSong() {
        var timestamp = Date.parse(new Date()); // 获取时间戳
        var newDate = new Date();
        var nian = newDate.getFullYear() // 年
        var month = newDate.getMonth() // 月
        var tian = newDate.getDate() // 日
        var oHouer = newDate.getHours(); // 时
        var oMinutes = newDate.getMinutes(); // 分


        var box1 = document.createElement("div")
        var oDiv1 = document.createElement("div")
        var box2 = document.createElement("div")
        var oDiv2 = document.createElement("div")
        var miteBox = document.createElement("div")

        // 头像
        var HeadPortrait = document.createElement("img")
        var HeadPortrait2 = document.createElement("img")

        HeadPortrait.src = "../images/9.png"
        HeadPortrait2.src = "../images/mm.png"
        HeadPortrait.className = "HeadPortrait"
        HeadPortrait2.className = "HeadPortrait2"

        box1.className = "right2"
        box2.className = "left2"
        miteBox.className = "textAlign"


        oDiv1.innerHTML = oIpt1.innerText
        box1.appendChild(HeadPortrait);
        box1.appendChild(oDiv1);

        var html =
            `<div><span style="font-size:0px" class="shijianchuo">${timestamp}</span>${tian}号${oHouer}:${oMinutes}</div>`

        if (!timeY) { // 先定义一个开关 ， 第一次进入第一层判断
            console.log("1")
            timeY = timestamp // 将最新的时间戳放到开关里
            miteBox.innerHTML = html // 把最新的时间渲染到页面
        } else if (timestamp - timeY > 20000) { //  如果这一条件成立 说明消息上一条消息时间间隔已经大于预定的值了(可以间隔1分~xx分自己定) 需要把最新的时间渲染到页面 然后把最新的消息的时间变更为最新的时间

            console.log(timestamp - timeY)
            timeY = timestamp
            miteBox.innerHTML = html

        } else { // 如果上面的条件不成立 就说明消息在接连发送，不需要渲染最新的时间到页面  ，将最新的时间赋值到上一次发送消息的时间
            console.log("3")
            timeY = timestamp

        }


        oText1.appendChild(miteBox);
        oText1.appendChild(box1);

        if (oDiv1.offsetWidth > 200) { // 消息宽的长度超过 200px 就添加一个换行的类样式
            console.log(oDiv1.offsetWidth)
            oDiv1.className = "huanHang"
        }

        var iFtext = oIpt1.innerText
        oIpt1.innerText = ''

        // 聊天机器人

        if (iFtext == "你好") {
            oDiv2.innerText = "你好";

        } else if (iFtext == "给我讲个笑话" || iFtext == "笑话") {
            oDiv2.innerText = "哈哈哈哈哈哈哈哈"
        } else {
            oDiv2.innerText = "抱歉！我还需多加学习"
        }

        // 插入消息
        box2.appendChild(HeadPortrait2);
        box2.appendChild(oDiv2);
        oText1.appendChild(box2);

        // 每次有新消息滚动条都在最底部
        oText1.scrollTop = oText1.scrollHeight;

    }


    // 表情
    var fa = false
    //点击展示表情
    var cont = document.querySelector(".emoji-cont")
    console.log(cont)

    function showEmoji() {
        console.log("1111")
        if (fa) {
            cont.style.display = "none"
            fa = false
        } else {
            cont.style.display = "block"
            fa = true
        }

        let that = this

        this.renderEmoji();
        //点击表情将表情添加在emoji中

        var liArr = document.querySelectorAll(".emoji-icon")

        liArr.forEach(function (element) {

            element.onclick = function () {
                var code2 = this.getAttribute("unicode16")
                console.log(code2)
                var te = "&#" + parseInt(code2, 16) + ";"
                console.log(te)
                oIpt1.innerHTML += te;
            }
        });
    }

    //表情列表
    function renderEmoji() {
        var emos = getEmojiList()[0];
        console.log(emos)
        var html = '<ul class="clearfix">';
        for (var j = 0; j < emos.length; j++) {
            var emo = emos[j];
            // console.log("1")
            var data = 'data:image/png;base64,' + emo[2];
            if (j % 20 == 0) {
                // console.log("2")
                html += '<li >';
            } else {
                // console.log("3")
                html += '<li >';
            }
            html +=
                `<img style="display: inline;vertical-align: middle;" src="${data}"  unicode16="${emo[1]}"  class="emoji-icon"  /></li>`;
        }

        cont.innerHTML = html

    }

    //表情 通过该方法 可以直接把表情在输入框中显示出来。
    function parse(arg) {

        console.log(ioNull)
        if (typeof ioNull != 'undefined') {
            return ioNull.emoji.parse(arg);
        }
        return '';
    }


    // 发送图片
    var img = "";

    function selectImg(source) {
        var file = source.files[0];
        if (window.FileReader) {
            var fr = new FileReader();
            fr.onloadend = function (e) {
                // 通过img属性src设置显示区
                var img3 = document.createElement("img")
                var fileImgBox = document.createElement("div")

                // 头像
                var HeadPortrait = document.createElement("img")
                var HeadPortrait2 = document.createElement("img")

                HeadPortrait.src = "../images/9.png"
                HeadPortrait2.src = "../images/mm.png"
                HeadPortrait.className = "HeadPortrait"
                HeadPortrait2.className = "HeadPortrait2"

                img3.src = e.target.result;
                img3.className = "fileImg"

                fileImgBox.className = "right2"

                // document.querySelector("oText1")
                // img 作为传输到服务器的参数
                fileImgBox.appendChild(HeadPortrait);
                fileImgBox.appendChild(img3)
                oText1.appendChild(fileImgBox);
                // 每次有新消息滚动条都在最底部
                oText1.scrollTop = oText1.scrollHeight;

            };
            // 该方法将文件读取为一段以 data: 开头的字符串，
            // 这段字符串的实质就是 Data URL，Data URL是一种将小文件直接嵌入文档的方案
            // 通过fr用于把图片显示出来
            fr.readAsDataURL(file);
        }
    }
</script>
