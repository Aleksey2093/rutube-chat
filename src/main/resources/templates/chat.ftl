<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat</title>
</head>
<style>

    #chat {
        width: 100%;
        height: 100%;
    }
    .message {
        width: 100%;
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }
    img {
        width: 22px;
        height: 22px;
        border-radius: 16px;
        padding: 2px;
    }
    .nick {
        padding: 2px;
    }
    .text {
        padding: 2px;
        width: 100%;
        word-break: break-word;
    }
</style>
<body>

<div id="chat">

</div>

<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script type="application/javascript">
    setInterval(function () {
        $('.message').each(function(index) {
            var x = this;
            var tsMessage = x.getAttribute("ts")
            var ts = new Date().getTime() / 1000;
            var t = Math.abs(tsMessage - ts);
            if (t > 30) {
                x.parentNode.removeChild(x);
            }
        });
    }, 5000);
    function iter(ts) {
        var m = $("#chat");
        var next =  ts;
        $.ajax({
            url: "/api/getMessages?chatId=${chatId}",
            dataType: "json",
            success: function (data, status) {
                console.log(data);
                console.log(status);
                if (status === "success") {
                    data.results.forEach(message => {
                        var tsMessage = message.created_ts_real;
                        var payload = message.payload;
                        var user = payload.user;
                        var avatar_url = user.avatar_url;
                        var name = user.name;
                        var text = payload.text;
                        if (tsMessage > ts) {
                            m.append("<div class='message' ts='" + tsMessage + "'>" +
                                "<img src='" + avatar_url + "' alt=''>" +
                                "<div class='nick'>" + name + "</div>" +
                                "<div class='text'>" + text + "</div>" +
                                "</div>")
                        }
                        if (tsMessage > next) {
                            next = tsMessage
                        }
                    });
                }
                setTimeout(function () {
                    iter(next);
                }, 2000);
            }
        });
    }
    iter(0);
</script>

</body>
</html>