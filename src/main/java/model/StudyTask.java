package model;

import java.util.Date;

public class StudyTask {
    private int id;
    private String subject;
    private String professor; // <-- NOVO CAMPO
    private Date studyDate;
    private String status;
    private String notes;
    private User user; // <-- Este é o Aluno (Utilizador)

    public StudyTask() {
        this(0);
    }

    public StudyTask(int id) {
        this.id = id;
        this.user = new User();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getProfessor() { return professor; }
    public void setProfessor(String professor) { this.professor = professor; }

    public Date getStudyDate() { return studyDate; }
    public void setStudyDate(Date studyDate) { this.studyDate = studyDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}