<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>File List</title>
    <style>
        	body {
			background-color: #f2f2f2;
			font-family: Arial, sans-serif;
			font-size: 14px;
			}
			
			table {
			font-family: arial, sans-serif;
			border-collapse: collapse;
			width: 100%;
			font-size: 14px;
			}
			
			input[type="submit"] {
			width: 8%;
			background-color: #222;
			color: #fff;
			border: none;
			padding: 10px 20px;
			font-size: 16px;
			font-family: Arial, sans-serif;
			border-radius: 5px;
			cursor: pointer;
			}
			
			input[type="submit"]:hover {
			background-color: #333;
			}
			
			h1 {
			font-size: 28px;
			margin: 0;
			}
			
			h2{
			color: black;
			font-family: consolas;
			font-size: 30px;
			}
			
			header {
            background-color: #222;
			color: #fff;
			text-align: center;
			padding: 20px;
            }
			
			footer {
			color: black;
			font-family: consolas;
			text-align: center;
			font-size: 20px;
			}
			
			li {
			width: 6%;
            margin: 10px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
            }
            
            li:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
        	}
        	
        	a {
            color: #333;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
        	}	
        	
        	a:hover {
            color: #007bff;
        	}
			
			p, h2, h3{
			color: black;
			font-family: consolas;
			font-size: 20px;
			}
		</style>
</head>
	<header> 
		<h1> Employee File Sharing Server </h1>
	</header>
	
	<body>		
		<h2> Welcome to the employee file sharing server! </h2>
		<h2> You are logged in as <%= request.getParameter("emp_Email")%> </h2>
		<form action="index.html"> <input type="submit" value="Log Out"> </form>		

<ul>
	<%
	// Retrieve the variables from the session object
	boolean stockRead = (boolean) session.getAttribute("stockRead");
	boolean stockWrite = (boolean) session.getAttribute("stockWrite");
	boolean bondRead = (boolean) session.getAttribute("bondRead");
	boolean bondWrite = (boolean) session.getAttribute("bondWrite");
	boolean moneyRead = (boolean) session.getAttribute("moneyRead");
	boolean moneyWrite = (boolean) session.getAttribute("moneyWrite");
	
	// Retrieve files from stocksFolder
	String stocksFolderPath = application.getRealPath("WEB-INF/employeeFolders/stocksFolder/");
	File stocksFolder = new File(stocksFolderPath);
	File[] stocksFiles = stocksFolder.listFiles(new FilenameFilter() {
	    public boolean accept(File dir, String name) {
	        return name.toLowerCase().endsWith(".txt");
	    }
	});
	
	// Retrieve files from bondsFolder
	String bondsFolderPath = application.getRealPath("WEB-INF/employeeFolders/bondsFolder/");
	File bondsFolder = new File(bondsFolderPath);
	File[] bondsFiles = bondsFolder.listFiles(new FilenameFilter() {
	    public boolean accept(File dir, String name) {
	        return name.toLowerCase().endsWith(".txt");
	    }
	});
	
	// Retrieve files from moneyFolder
	String moneyFolderPath = application.getRealPath("WEB-INF/employeeFolders/moneyFolder/");
	File moneyFolder = new File(moneyFolderPath);
	File[] moneyFiles = moneyFolder.listFiles(new FilenameFilter() {
	    public boolean accept(File dir, String name) {
	        return name.toLowerCase().endsWith(".txt");
	    }
	});
	
	// Display the files in each folder
	if ((stocksFiles != null) && (stockRead)) {
	    out.println("<h3> Stocks Files: </h3>");
	    out.println("<ul>");
	    for (File file : stocksFiles) {
	        if (file.isFile()) {
	            String fileName = file.getName();
	            out.println("<li><a href=\"download.jsp?folder=stocksFolder&file=" + fileName + "\">" + fileName + "</a></li>");
	        }
	    }

	    out.println("</ul>");
	}
	
	if ((bondsFiles != null) && (bondRead)) {
	    out.println("<h3> Bonds Files: </h3>");
	    out.println("<ul>");
	    for (File file : bondsFiles) {
	        if (file.isFile()) {
	            String fileName = file.getName();
	            out.println("<li><a href=\"download.jsp?folder=bondsFolder&file=" + fileName + "\">" + fileName + "</a></li>");
	        }
	    }
	    out.println("</ul>");
	}
	
	if ((moneyFiles != null) && (moneyRead)) {
	    out.println("<h3> Money Files: </h3>");
	    out.println("<ul>");
	    for (File file : moneyFiles) {
	        if (file.isFile()) {
	            String fileName = file.getName();
	                out.println("<li><a href=\"download.jsp?folder=moneyFolder&file=" + fileName + "\">" + fileName + "</a></li>");
	        }
	    }
	    out.println("</ul>");
	}
	%>
</ul>
</body>
</html>
