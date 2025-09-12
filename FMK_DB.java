package main.web;

import java.sql.*;
import java.io.File;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

public class FMK_DB {
    
    static {
        try {
            Class.forName("com.filemaker.jdbc.Driver");
            System.out.println("✅ FileMaker JDBC 드라이버 로드 성공");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ FileMaker JDBC 드라이버 로드 실패: " + e.getMessage());
        }
    }
    
    private static final String DB_URL = "jdbc:filemaker://xcd006.cafe24.com:2399/KSY_MypageDB";
    private static final String DB_USER = "admin";
    private static final String DB_PASSWORD = "2211";

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // 실제 DB 구조에 맞춘 MemberProfile 클래스
    public static class MemberProfile {
        private String memberId;
        private String name;        // name_kr (한글 이름)
        private String engName;     // name_en (영어 이름)
        private String engLastName; // en_name (영어 성)
        private String korName;     // name_kr과 동일
        private String email;
        private String phone;
        private String birthDate;
        private String gender;
        private String grade;
        private String passportNo;

        // 모든 필드의 Getter/Setter
        public String getMemberId() { return memberId; }
        public void setMemberId(String memberId) { this.memberId = memberId; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getEngName() { return engName; }
        public void setEngName(String engName) { this.engName = engName; }

        public String getEngLastName() { return engLastName; }
        public void setEngLastName(String engLastName) { this.engLastName = engLastName; }

        public String getKorName() { return korName; }
        public void setKorName(String korName) { this.korName = korName; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }

        public String getBirthDate() { return birthDate; }
        public void setBirthDate(String birthDate) { this.birthDate = birthDate; }

        public String getGender() { return gender; }
        public void setGender(String gender) { this.gender = gender; }

        public String getGrade() { return grade; }
        public void setGrade(String grade) { this.grade = grade; }

        public String getPassportNo() { return passportNo; }
        public void setPassportNo(String passportNo) { this.passportNo = passportNo; }

        // 전체 영어 이름 반환
        public String getFullEngName() {
            if (engName != null && engLastName != null) {
                return engName + " " + engLastName;
            } else if (engName != null) {
                return engName;
            } else if (engLastName != null) {
                return engLastName;
            }
            return "";
        }
    }

    // 이메일 중복 체크
    public static boolean existsEmail(String email) {
        String sql = "SELECT COUNT(*) FROM javaDB WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.err.println("[existsEmail] SQL 오류: " + e);
            return false;
        }
    }

    // 실제 DB 필드명에 맞춘 회원가입
    public static boolean registerMember(String name, String passportFirstName, String passportLastName, 
                                        String email, String phone, String birthdate, 
                                        String gender, String password) {
        String sql = "INSERT INTO javaDB (name_kr, name_en, en_name, email, phone, birth_Date, Gender, Password, Member_grade) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);                  // name_kr (한글 이름)
            ps.setString(2, passportFirstName);     // name_en (영어 이름)
            ps.setString(3, passportLastName);      // en_name (영어 성)
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, birthdate);
            ps.setString(7, gender);
            ps.setString(8, password);
            ps.setString(9, "일반회원");
            
            int result = ps.executeUpdate();
            System.out.println("[registerMember] 회원가입 성공: " + email);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("[registerMember] SQL 오류: " + e);
            return false;
        }
    }

    // 로그인 인증
    public static boolean authenticate(String email, String password) {
        String sql = "SELECT Password FROM javaDB WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("Password");
                boolean success = password.equals(dbPassword);
                System.out.println("[authenticate] " + email + " 로그인 " + (success ? "성공" : "실패"));
                return success;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("[authenticate] SQL 오류: " + e);
            return false;
        }
    }

    // 실제 DB 필드명에 정확히 맞춘 회원 정보 조회
    public static MemberProfile getMemberByEmail(String email) {
        String sql = "SELECT member_id, name_kr, name_en, en_name, email, phone, birth_Date, Gender, Member_grade, passport FROM javaDB WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                MemberProfile profile = new MemberProfile();
                profile.setMemberId(rs.getString("member_id"));
                profile.setName(rs.getString("name_kr"));           // 한글 이름
                profile.setKorName(rs.getString("name_kr"));        // 한글 이름 (동일)
                profile.setEngName(rs.getString("name_en"));        // 영어 이름
                profile.setEngLastName(rs.getString("en_name"));    // 영어 성
                profile.setEmail(rs.getString("email"));
                profile.setPhone(rs.getString("phone"));
                profile.setBirthDate(rs.getString("birth_Date"));
                profile.setGender(rs.getString("Gender"));
                profile.setGrade(rs.getString("Member_grade"));
                profile.setPassportNo(rs.getString("passport"));
                return profile;
            }
        } catch (SQLException e) {
            System.err.println("[getMemberByEmail] SQL 오류: " + e);
        }
        return null;
    }

    // 정회원 신청
    public static boolean registerRegularMember(String email, String passportNo,
                                               MultipartFile passportImg, MultipartFile visaImg, MultipartFile feeImg) {
        String sql = "UPDATE javaDB SET Member_grade = ?, passport = ? WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            saveFile(passportImg, "passport_" + email);
            if (visaImg != null) saveFile(visaImg, "visa_" + email);
            if (feeImg != null) saveFile(feeImg, "fee_" + email);
            
            ps.setString(1, "신청중");  // 신청중으로 상태 변경
            ps.setString(2, passportNo);
            ps.setString(3, email);
            
            int result = ps.executeUpdate();
            System.out.println("[registerRegularMember] " + email + " 정회원 신청 완료 - 상태: 신청중");
            return result > 0;
        } catch (SQLException e) {
            System.err.println("[registerRegularMember] SQL 오류: " + e);
            return false;
        }
    }

    // 파일 저장
    private static void saveFile(MultipartFile file, String filename) {
        if (file != null && !file.isEmpty()) {
            try {
                String uploadDir = System.getProperty("user.home") + "/uploads/";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();	
                }
                String uploadPath = uploadDir + filename + "_" + file.getOriginalFilename();
                file.transferTo(new File(uploadPath));
                System.out.println("파일 저장: " + uploadPath);
            } catch (IOException e) {
                System.err.println("파일 저장 실패: " + e);
            }
        }
    }
    
    
    public static boolean approveMember(String email) {
        String sql = "SELECT Member_grade FROM javaDB WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String grade = rs.getString("Member_grade");
                    System.out.println("[approveMember] " + email + " 현재 등급: " + grade);
                    
                    // 정회원이면 true 반환 (이동 처리용)
                    if ("정회원".equals(grade)) {
                        System.out.println("[approveMember] " + email + " 이미 정회원입니다.");
                        return true;
                    } else {
                        System.out.println("[approveMember] " + email + " 아직 준회원입니다.");
                        return false;  // ✅ 추가!
                    }
                } else {
                    System.out.println("[approveMember] " + email + " 해당 회원이 없습니다.");
                    return false;
                }
            }
        } catch (SQLException e) {
            System.err.println("[approveMember] SQL 오류: " + e);
            return false;
        }
    }


}
