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
import utils.PasswordUtil;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");
        
        try {
            DBHandler db = new DBHandler();
            db.prepareStatement("SELECT * FROM users WHERE email = ? AND senha = ?");
            db.setString(1, email);
            db.setString(2, PasswordUtil.hashPassword(senha));
            db.executeQuery();
            
            if (db.next()) {
                User user = new User(db.getInt("id"));
                user.setName(db.getString("nome"));
                user.setEmail(db.getString("email"));
                
                HttpSession session = req.getSession();
                session.setAttribute("loggedUser", user);
                resp.sendRedirect(req.getContextPath() + "/");
            } else {
                req.setAttribute("error", "E-mail ou senha inválidos.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}