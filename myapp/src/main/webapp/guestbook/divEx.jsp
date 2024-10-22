<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show/Hide Div Example</title>
    <style>
        #myDiv {
            display: none; /* 처음에 안 보이게 설정 */
            width: 200px;
            height: 100px;
            background-color: lightblue;
            padding: 10px;
            text-align: center;
        }
    </style>
    <script>
        function toggleDiv() {
            var div = document.getElementById("myDiv");
            if (div.style.display === "none") {
                div.style.display = "block"; // 보이게 설정
            } else {
                div.style.display = "none"; // 안 보이게 설정
            }
        }
    </script>
</head>
<body>

    <button onclick="toggleDiv()">Toggle Div</button>

    <div id="myDiv">
        이 영역은 버튼을 클릭하면 보이거나 안 보입니다.
    </div>

</body>
</html>
