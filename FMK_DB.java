package main.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * FileMaker 데이터베이스에 연결하여 회원 정보를 관리하는 클래스입니다.
 */
public class FMK_DB {

	private static final String DB_URL = "jdbc:filemaker://xcd006.cafe24.com:2399/KSY_MypageDB";
	private static final String DB_USER = "admin";
	private static final String DB_PASSWORD = "2211";

	// JDBC 드라이버 로드
	static {
		try {
			Class.forName("com.filemaker.jdbc.Driver");
			System.out.println("FileMaker JDBC 드라이버 로드 성공");
		} catch (ClassNotFoundException e) {
			System.err.println("JDBC 드라이버 로드 실패: " + e.getMessage());
		}
	}

	/**
	 * 회원가입: 모든 회원 정보를 받아 데이터베이스에 삽입합니다.
	 * @param name 이름 (name_kr 필드)
	 * @param passportFirstName 영어 이름 (name_en 필드)
	 * @param passportLastName 영어 성 (en_name 필드)
	 * @param email 이메일
	 * @param phone 휴대폰 번호
	 * @param birthdate 생년월일
	 * @param gender 성별
	 * @return 성공 시 true, 실패 시 false
	 */
	public static boolean registerMember(String name, String passportFirstName, String passportLastName, String email, String phone, String birthdate, String gender) {
		// 테이블 필드명: name_kr, en_name, Gender, email, birth_Date, phone, name_en
		String sql = "INSERT INTO \"javaDB\" (\"name_kr\", \"en_name\", \"name_en\", \"Gender\", \"email\", \"birth_Date\", \"phone\") VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		     PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, name); // name_kr (한글 이름)
			pstmt.setString(2, passportLastName); // en_name (영어 성)
			pstmt.setString(3, passportFirstName); // name_en (영어 이름)
			pstmt.setString(4, gender); // Gender
			pstmt.setString(5, email); // email
			pstmt.setString(6, birthdate); // birth_Date
			pstmt.setString(7, phone); // phone

			int affected = pstmt.executeUpdate();
			return affected > 0;

		} catch (SQLException e) {
			System.err.println("회원가입 오류: " + e.getMessage());
			System.err.println("SQLState: " + e.getSQLState());
			System.err.println("Error Code: " + e.getErrorCode());
			e.printStackTrace();
			return false;
		}
	}
}
