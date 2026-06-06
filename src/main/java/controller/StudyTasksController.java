package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelException;
import model.StudyTask;
import model.User;
import model.dao.DAOFactory;
import model.dao.StudyTaskDAO;
import model.dao.UserDAO;

@WebServlet(urlPatterns = {"/study-tasks"})
public class StudyTasksController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {

            if (action == null || action.equals("list")) {

                listTasks(req, resp);

            } else if (action.equals("new")) {

                showForm(req, resp, new StudyTask());

            } else if (action.equals("edit")) {

                int id = Integer.parseInt(req.getParameter("id"));

                StudyTaskDAO dao = DAOFactory.createDAO(StudyTaskDAO.class);

                showForm(req, resp, dao.findById(id));

            } else if (action.equals("delete")) {

                int id = Integer.parseInt(req.getParameter("id"));

                StudyTaskDAO dao = DAOFactory.createDAO(StudyTaskDAO.class);

                StudyTask task = new StudyTask(id);

                dao.delete(task);

                resp.sendRedirect(req.getContextPath() + "/study-tasks");
            }

        } catch (ModelException e) {

            throw new ServletException(e);

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");

        int id = (idParam != null && !idParam.isEmpty())
                ? Integer.parseInt(idParam)
                : 0;

        StudyTask task = new StudyTask(id);

        task.setSubject(req.getParameter("subject"));
        task.setProfessor(req.getParameter("professor")); 
        task.setStatus(req.getParameter("status"));
        task.setNotes(req.getParameter("notes"));

        User user = new User(Integer.parseInt(req.getParameter("userId")));
        task.setUser(user);

        try {

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            Date studyDate = sdf.parse(req.getParameter("studyDate"));

            task.setStudyDate(studyDate);

            StudyTaskDAO dao = DAOFactory.createDAO(StudyTaskDAO.class);

            if (id == 0) {
                dao.save(task);
            } else {
                dao.update(task);
            }

            resp.sendRedirect(req.getContextPath() + "/study-tasks");

        } catch (ParseException | ModelException e) {

            throw new ServletException(e);

        }
    }

    private void listTasks(HttpServletRequest req, HttpServletResponse resp)
            throws ModelException, ServletException, IOException {

        StudyTaskDAO dao = DAOFactory.createDAO(StudyTaskDAO.class);

        List<StudyTask> tasks = dao.listAll();

        String search = req.getParameter("search");

        if (search != null && !search.trim().isEmpty()) {

            String termo = search.toLowerCase();

            tasks.removeIf(task ->
                !(task.getSubject().toLowerCase().contains(termo)
                || task.getStatus().toLowerCase().contains(termo)
                || task.getUser().getName().toLowerCase().contains(termo))
            );
        }

        req.setAttribute("tasks", tasks);

        req.getRequestDispatcher("/study-tasks.jsp")
           .forward(req, resp);
    }

    private void showForm(HttpServletRequest req,
                          HttpServletResponse resp,
                          StudyTask task)
            throws ModelException, ServletException, IOException {

        UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);

        req.setAttribute("task", task);
        req.setAttribute("users", userDAO.listAll());

        req.getRequestDispatcher("/form-study-task.jsp")
           .forward(req, resp);
    }
    
    
}