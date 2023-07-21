import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scada", "root", "root");
            String username = request.getParameter("txtName");
            String password = request.getParameter("txtPwd");
            PreparedStatement ps = con.prepareStatement("SELECT uname FROM login WHERE uname=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Set the loggedIn attribute in the session to true
                HttpSession session = request.getSession();
                session.setAttribute("loggedIn", true);

                response.sendRedirect("home.jsp");
            } else {
                out.println("<html><head><title>Login Failed</title></head><body>");
                out.println("<h2 style='color: red;'>Login Failed</h2>");
                out.println("<p>The username or password is incorrect.</p>");
                out.println("<p><a href='login.jsp'>Click here to retry</a></p>");
                out.println("<p>You will be redirected to the login page in <span id='countdown'>15</span> seconds.</p>");
                out.println("</body></html>");

                // Automatic redirection after 15 seconds
                out.println("<script type='text/javascript'>");
                out.println("var countdown = 15;");
                out.println("var countdownDisplay = document.getElementById('countdown');");
                out.println("var countdownInterval = setInterval(function() {");
                out.println("    countdown--;");
                out.println("    countdownDisplay.textContent = countdown;");
                out.println("    if (countdown <= 0) {");
                out.println("        clearInterval(countdownInterval);");
                out.println("        window.location.href = 'login.jsp';");
                out.println("    }");
                out.println("}, 1000);");
                out.println("</script>");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
