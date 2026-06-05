package model.dao;

import java.util.ArrayList;
import java.util.List;
import model.ModelException;
import model.StudyTask;
import model.User;

public class MySQLStudyTaskDAO implements StudyTaskDAO {

    @Override
    public boolean save(StudyTask task) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "INSERT INTO study_tasks VALUES (DEFAULT, ?, ?, ?, ?, ?)";
        db.prepareStatement(sql);
        db.setString(1, task.getSubject());
        db.setDate(2, task.getStudyDate() != null ? new java.sql.Date(task.getStudyDate().getTime()) : null);
        db.setString(3, task.getStatus());
        db.setString(4, task.getNotes());
        db.setInt(5, task.getUser().getId());
        return db.executeUpdate() > 0;
    }

    @Override
    public boolean update(StudyTask task) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "UPDATE study_tasks SET subject=?, study_date=?, status=?, notes=?, user_id=? WHERE id=?";
        db.prepareStatement(sql);
        db.setString(1, task.getSubject());
        db.setDate(2, task.getStudyDate() != null ? new java.sql.Date(task.getStudyDate().getTime()) : null);
        db.setString(3, task.getStatus());
        db.setString(4, task.getNotes());
        db.setInt(5, task.getUser().getId());
        db.setInt(6, task.getId());
        return db.executeUpdate() > 0;
    }

    @Override
    public boolean delete(StudyTask task) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "DELETE FROM study_tasks WHERE id=?";
        db.prepareStatement(sql);
        db.setInt(1, task.getId());
        return db.executeUpdate() > 0;
    }

    @Override
    public List<StudyTask> listAll() throws ModelException {
        DBHandler db = new DBHandler();
        List<StudyTask> tasks = new ArrayList<>();
        String sql = "SELECT s.*, u.nome FROM study_tasks s INNER JOIN users u ON s.user_id = u.id";
        db.createStatement();
        db.executeQuery(sql);
        while (db.next()) {
            StudyTask task = createStudyTask(db);
            task.getUser().setName(db.getString("nome"));
            tasks.add(task);
        }
        return tasks;
    }

    @Override
    public StudyTask findById(int id) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "SELECT * FROM study_tasks WHERE id = ?";
        db.prepareStatement(sql);
        db.setInt(1, id);
        db.executeQuery();
        StudyTask task = null;
        if (db.next()) {
            task = createStudyTask(db);
        }
        return task;
    }

    private StudyTask createStudyTask(DBHandler db) throws ModelException {
        StudyTask task = new StudyTask(db.getInt("id"));
        task.setSubject(db.getString("subject"));
        task.setStudyDate(db.getDate("study_date"));
        task.setStatus(db.getString("status"));
        task.setNotes(db.getString("notes"));
        User user = new User(db.getInt("user_id"));
        task.setUser(user);
        return task;
    }
}