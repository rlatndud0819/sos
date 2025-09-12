package main.web;

public class MemberVO {
    private String name;               // 한글 이름
    private String passportFirstName;  // 영어 이름
    private String passportLastName;   // 영어 성  
    private String email;
    private String phone;
    private String birthdate;          // 소문자 d (JSP와 일치)
    private String gender;
    private String Password;           // 대문자 P (JSP name="Password"와 일치)

    // 모든 필드의 Getter/Setter
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPassportFirstName() { return passportFirstName; }
    public void setPassportFirstName(String passportFirstName) { this.passportFirstName = passportFirstName; }

    public String getPassportLastName() { return passportLastName; }
    public void setPassportLastName(String passportLastName) { this.passportLastName = passportLastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getBirthdate() { return birthdate; }
    public void setBirthdate(String birthdate) { this.birthdate = birthdate; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPassword() { return Password; }
    public void setPassword(String Password) { this.Password = Password; }
}
