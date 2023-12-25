<%@ page import="java.io.*" %>
<%
    // Get the folder and file names from the URL parameters
    String folder = request.getParameter("folder");
    String fileName = request.getParameter("file");

    // Determine the file path based on the folder parameter
    String folderPath = "";
    if (folder.equals("stocksFolder")) {
        folderPath = application.getRealPath("WEB-INF/employeeFolders/stocksFolder");
    } else if (folder.equals("bondsFolder")) {
        folderPath = application.getRealPath("WEB-INF/employeeFolders/bondsFolder");
    } else if (folder.equals("moneyFolder")) {
        folderPath = application.getRealPath("WEB-INF/employeeFolders/moneyFolder");
    } else {
        // Invalid folder parameter
        response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }

    // Create a file object for the requested file
    File file = new File(folderPath, fileName);

    // Set the response headers to indicate that we are downloading a file
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
    response.setHeader("Content-Length", String.valueOf(file.length()));

    // Open an input stream to read the file data and an output stream to write it to the response
    FileInputStream inputStream = new FileInputStream(file);
    OutputStream outputStream = response.getOutputStream();

    // Copy the data from the input stream to the output stream
    byte[] buffer = new byte[4096];
    int bytesRead = -1;
    while ((bytesRead = inputStream.read(buffer)) != -1) {
        outputStream.write(buffer, 0, bytesRead);
    }

    // Clean up the streams
    inputStream.close();
    outputStream.close();
%>
