package main.web;

/**
 * 회원 정보를 담는 VO (Value Object) 클래스입니다.
 * 폼 데이터를 자동으로 바인딩하기 위해 사용됩니다.
 */
public class MemberVO {

    private String name;
    private String passportFirstName;
    private String passportLastName;
    private String email;
    private String phone;
    private String birthdate;
    private String gender;

    // Getter와 Setter 메서드
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassportFirstName() {
        return passportFirstName;
    }

    public void setPassportFirstName(String passportFirstName) {
        this.passportFirstName = passportFirstName;
    }

    public String getPassportLastName() {
        return passportLastName;
    }

    public void setPassportLastName(String passportLastName) {
        this.passportLastName = passportLastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
