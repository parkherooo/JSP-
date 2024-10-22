<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구구단</title>
    <style>
        h1 {
            text-align: center;
            color: #fc7d07;
        }
        table {
        	border-radius: 20px;
            width: 80%;
            margin: 20px auto;
            text-align: center;
            font-size: 18px;
        }
        th {
     	   border-radius: 20px;
            background-color: #fbad64;
            color: white;
            padding: 10px;
            margin: 10px;
        }
        td {
        	border-radius: 20px;
            background-color: #fbe39c;
            padding: 10px;
            margin: 10px;
        }
        tr:hover td {
            background-color: #a3e4ee;
        }
        .image-container {
            text-align: center; 
            margin: 20px;
        }
        img {
            width: 150px;
            height: auto;
        }
    </style>
</head>
<body>
      <h1>구구단</h1>
   	  <div class="image-container">
        <img alt="춘식" src="춘식.jpg">
    </div>

    <table border="1">
    <%
        for (int i = 2; i < 10; i++) {
    %>
        <tr>
            <th><%= i %>단</th>
    <%
            for (int j = 1; j < 10; j++) {
    %>
            <td><%= i %> x <%= j %> = <%= i * j %></td>
    <%
            }
    %>
        </tr>
    <%
        }
    %>
    </table>
</body>
</html>
