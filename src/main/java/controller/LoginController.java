package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.dao.DBHandler;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        
        try {
            DBHandler db = new DBHandler();
            db.prepareStatement("SELECT * FROM users WHERE email = ?");
            db.setString(1, email);
            db.executeQuery();
            
            if (db.next()) {
                User user = new User(db.getInt("id"));
                user.setName(db.getString("nome"));
                user.setEmail(db.getString("email"));
                
                HttpSession session = req.getSession();
                session.setAttribute("loggedUser", user);
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                req.setAttribute("error", "Usuário não encontrado. Verifique seu e-mail.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}