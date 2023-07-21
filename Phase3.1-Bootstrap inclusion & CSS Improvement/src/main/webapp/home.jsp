<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>

<%
// Check if the user is logged in
boolean isLoggedIn = false;

// Check if the loggedIn attribute is set to true in the session
if (request.getSession().getAttribute("loggedIn") != null && (boolean) request.getSession().getAttribute("loggedIn")) {
	isLoggedIn = true;
}

// If the user is not logged in, redirect to the login page
if (!isLoggedIn) {
	response.sendRedirect("login.jsp");
} else {
	// Connect to the database
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/swing_demo", "root", "root");

		String sql = "SELECT * FROM testable";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<style>
nav {
            background-color: #333333;
            padding: 10px;
            color: #ffffff;
        }
        
        nav ul {
            margin: 0;
            padding: 0;
            list-style-type: none;
            display: flex;
            justify-content: space-between;
        }
        
        nav li {
            display: inline;
            margin-right: 10px;
        }
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">
<title>Home</title>
<script>
	var countdownInterval;

	function setRefreshInterval() {
		var intervalInput = document.getElementById("refreshInterval");
		var interval = parseInt(intervalInput.value);
		if (isNaN(interval) || interval <= 0) {
			alert("Please enter a valid refresh interval in seconds.");
			return;
		}
		clearInterval(countdownInterval);
		var refreshURL = "home.jsp?refreshInterval=" + interval;
		window.location.href = refreshURL;
	}

	function startCountdown() {
		var count =
<%=request.getParameter("refreshInterval")%>
	;
		var countDisplay = document.getElementById("countdown");
		countdownInterval = setInterval(function() {
			count--;
			if (count >= 0) {
				countDisplay.innerText = count;
			} else {
				window.location.reload();
			}
		}, 1000);
	}

	function resetTimer() {
		clearInterval(countdownInterval);
		var intervalInput = document.getElementById("refreshInterval");
		intervalInput.value = "";
		var refreshURL = "home.jsp?refreshInterval=0";
		window.location.href = refreshURL;
	}

	window.onload = function() {
		var refreshInterval =
<%=request.getParameter("refreshInterval")%>
	;
		if (refreshInterval > 0) {
			startCountdown();
		}
	};
</script>

</head>
<body>
	<nav>
		<ul>
			<li>Logged-In Successfully</li>
			<li><a class="btn btn-warning" href="test.jsp"><i class="bi bi-exclamation-triangle"></i> Diagnostics</a></li>	
			<li>
				<%
				if (isLoggedIn) {
				%> <a class="btn btn-danger" href="logout.jsp"><i class="bi bi-exclamation-octagon"></i> Logout</a>
				<%
				}
				%>
			</li>
		</ul>
	</nav>
	<section class="section">
		<div class="row">
			<div class="col-lg-12">

				<div class="card">
					<div class="card-body">
						<h5 class="card-title">Data from Database</h5>

						<!-- Table with stripped rows -->
						<div
							class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
							<div class="datatable-container">
								<table class="table datatable datatable-table">
									<thead>
										<tr>
											<th data-sortable="true"style=" width: 9.25925925925926%;"><a
												href="#" >#</a></th>
											<th data-sortable="true" style="width: 26.234567901234566%;"><a
												href="#" >Name</a></th>
											<th data-sortable="true" style="width: 29.938271604938272%;"><a
												href="#" >Surname</a></th>
											<th data-sortable="true" style="width: 15.432098765432098%;"><a
												href="#" >City</a></th>
											<th data-sortable="true" style="width: 19.1358024691358%;"><a
												href="#" >University</a></th>
										</tr>
									</thead>
									<tbody>
									<%
									int i=0;
			while (rs.next()) {
				i++;
			%>
			<tr><td><%out.print(i); %>
				<td><%=rs.getString("Name")%></td>
				<td><%=rs.getString("Surname")%></td>
				<td><%=rs.getString("City")%></td>
				<td><%=rs.getString("University")%></td>
			</tr>
			<%
			}
			%>
										
									</tbody>
								</table>
							</div>
						</div>
						<!-- End Table with stripped rows -->
					</div>
				</div>

			</div>
		</div>
	</section>
	
	<div class="refresh-interval">
		<label for="refreshInterval">Refresh Interval (seconds):</label> <input
			type="number" id="refreshInterval" name="refreshInterval" min="1"
			value="<%=request.getParameter("refreshInterval")%>">
		<button onclick="setRefreshInterval()">Set Refresh Interval</button>
		<div class="countdown">
			Countdown: <span id="countdown"></span>
		</div>
		<button class="reset-button" onclick="resetTimer()">Reset
			Timer</button>
	</div>

	<!-- Vendor JS Files -->
	<script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/chart.js/chart.umd.js"></script>
	<script src="assets/vendor/echarts/echarts.min.js"></script>
	<script src="assets/vendor/quill/quill.min.js"></script>
	<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="assets/js/main.js"></script>

</body>
</html>

<%
} catch (Exception e) {
e.printStackTrace();
} finally {
// Close the database resources
try {
	if (rs != null)
		rs.close();
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
} catch (SQLException e) {
	e.printStackTrace();
}
}
}
%>
