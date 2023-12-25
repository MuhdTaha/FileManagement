<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Login</title>
		<style>
			table {
				position: absolute;
  				left: 50%;
  				top: 50%;
  				transform: translate(-50%, -50%);
			}
			body, a {
  				background-color: white;
  				color: black;
  				font-family: consolas;
  				text-align: center;
  				font-size: 20px;
			}
		</style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%
String EMAIL_PATTERN =
        "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@"
        + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
Pattern pattern = Pattern.compile(EMAIL_PATTERN);
String email = request.getParameter("emp_Email");
String passwd = request.getParameter("emp_Password");
String name = request.getParameter("emp_Name");
Matcher matcher = pattern.matcher(email);

//Get the folder access permission values.
// 0 means no access, 1 means read access, 2 means read and write access.
// Read and write the flags assigned default values
// Set values of the variables
boolean stockRead = false;
boolean stockWrite = false;
boolean bondRead = false;
boolean bondWrite = false;
boolean moneyRead = false;
boolean moneyWrite = false;

if(matcher.matches()){
	//Get session creation time.
	Date createTime = new Date(session.getCreationTime());
	session.setAttribute("emp_Email", email);
	session.setMaxInactiveInterval(3600);  //1 hour session
	Class.forName("com.mysql.cj.jdbc.Driver");  
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeeacess", "root", "abcd1234");
	PreparedStatement prepStmt = conn.prepareStatement("select * from user where emp_Email=? and emp_Password=?");
	prepStmt.setString(1, email);
	prepStmt.setString(2, passwd);
	ResultSet rs = prepStmt.executeQuery();
				
	if(rs.next()){  //make sure the user was found
		if(rs.getString(2).equals(passwd)){  //the user password is the 2nd column
			//grant access to the folders
			prepStmt = conn.prepareStatement("select stocks_FolderAccess, bonds_FolderAccess, money_FolderAccess from user where emp_Email=? and emp_Password=?");
			prepStmt.setString(1, email);
			prepStmt.setString(2, passwd);
			rs = prepStmt.executeQuery();
			
			if (rs.next()){
			  	int stocksAccess = rs.getInt("stocks_FolderAccess");
			    int bondsAccess = rs.getInt("bonds_FolderAccess");
			    int moneyAccess = rs.getInt("money_FolderAccess");

			    // Check the folder access permission values and set the flags accordingly.
			    if (stocksAccess == 1 || stocksAccess == 2) {
			        stockRead = true;
			    }
			    if (stocksAccess == 2) {
			        stockWrite = true;
			    }
			    if (bondsAccess == 1 || bondsAccess == 2) {
			        bondRead = true;
			    }
			    if (bondsAccess == 2) {
			        bondWrite = true;
			    }
			    if (moneyAccess == 1 || moneyAccess == 2) {
			        moneyRead = true;
			    }
			    if (moneyAccess == 2) {
			        moneyWrite = true;
			    }
			    
			 // Store the variables in the session object
			    session.setAttribute("stockRead", stockRead);
			    session.setAttribute("stockWrite", stockWrite);
			    session.setAttribute("bondRead", bondRead);
			    session.setAttribute("bondWrite", bondWrite);
			    session.setAttribute("moneyRead", moneyRead);
			    session.setAttribute("moneyWrite", moneyWrite);
			}
		}
			rs.close();
			prepStmt.close();
			conn.close();
			
			String redirectURL = "fileAccessPage.jsp?emp_Email="+email;
		 	response.sendRedirect(redirectURL);
		}
	
	else{
		rs.close();
		prepStmt.close();
		conn.close();
		out.println("Invalid password or email not found, try again!");
	}
}
else{
	out.println("Bad email format, try again!");
}
%>
		<table>
			<tr><th><a href = "index.html"> Employee Homepage </a></th></tr>
		</table>
	</body>
</html>