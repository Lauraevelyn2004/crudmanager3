package model.dao;

import java.util.List;
import model.ModelException;
import model.StudyTask;

public interface StudyTaskDAO {
    boolean save(StudyTask task) throws ModelException;
    boolean update(StudyTask task) throws ModelException;
    boolean delete(StudyTask task) throws ModelException;
    List<StudyTask> listAll() throws ModelException;
    StudyTask findById(int id) throws ModelException;
}