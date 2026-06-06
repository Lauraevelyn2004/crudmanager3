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
        // Agora com o campo 'professor' incluído no INSERT
        String sql = "INSERT INTO study_tasks (subject, professor, study_date, status, notes, user_id) VALUES (?, ?, ?, ?, ?, ?)";
        
        db.prepareStatement(sql);
        db.setString(1, task.getSubject());
        db.setString(2, task.getProfessor());
        
        if (task.getStudyDate() != null) {
            db.setDate(3, task.getStudyDate());
        } else {
            db.setNullDate(3);
        }
        
        db.setString(4, task.getStatus());
        db.setString(5, task.getNotes());
        db.setInt(6, task.getUser().getId());
        
        return db.executeUpdate() > 0;
    }

    @Override
    public boolean update(StudyTask task) throws ModelException {
        DBHandler db = new DBHandler();
        // Agora com o campo 'professor' incluído no UPDATE
        String sql = "UPDATE study_tasks SET subject=?, professor=?, study_date=?, status=?, notes=?, user_id=? WHERE id=?";
        
        db.prepareStatement(sql);
        db.setString(1, task.getSubject());
        db.setString(2, task.getProfessor());
        
        if (task.getStudyDate() != null) {
            db.setDate(3, task.getStudyDate());
        } else {
            db.setNullDate(3);
        }
        
        db.setString(4, task.getStatus());
        db.setString(5, task.getNotes());
        db.setInt(6, task.getUser().getId());
        db.setInt(7, task.getId());
        
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
    public List<StudyTask> search(String term) throws ModelException {
        DBHandler db = new DBHandler();
        List<StudyTask> tasks = new ArrayList<>();
        
        String sql = "SELECT s.*, u.nome FROM study_tasks s INNER JOIN users u ON s.user_id = u.id " +
                     "WHERE s.subject LIKE ? OR s.professor LIKE ? OR s.status LIKE ?";
        
        db.prepareStatement(sql);
        String parametro = "%" + term + "%";
        db.setString(1, parametro);
        db.setString(2, parametro);
        db.setString(3, parametro);
        
        db.executeQuery();
        
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
        
        // Agora o Java lê a coluna 'professor' do banco de dados
        task.setProfessor(db.getString("professor"));
        
        task.setStudyDate(db.getDate("study_date"));
        task.setStatus(db.getString("status"));
        task.setNotes(db.getString("notes"));
        
        User user = new User(db.getInt("user_id"));
        task.setUser(user);
        
        return task;
    }
}