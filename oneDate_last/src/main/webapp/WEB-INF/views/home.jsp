<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
<script type="text/javascript">

	location.replace('toMain?userId=${userId}');
</script>
</head>
<body>
	<form action="toMain">
		<input type="text" name="userId"> <input type="submit">
	</form>
</body>
</html>
