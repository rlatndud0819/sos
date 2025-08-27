package main.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 회원 관련 요청을 처리하는 컨트롤러 클래스입니다.
 */
@Controller
public class memberController {

	/*
	 * 회원등록 화면으로 이동
	 */
	@RequestMapping("/memberWrite.do")
	public String memberWrite() {
		return "member/memberWrite";  // /WEB-INF/jsp/member/memberWrite.jsp
	}

	/*
	 * 회원가입 화면으로 이동 (signup 버전)
	 */
	@RequestMapping("/signup.do")
	public String signup() {
		return "member/signup";  // /WEB-INF/jsp/member/signup.jsp
	}

	/**
	 * GET 요청 처리: 회원가입 폼으로 리다이렉트합니다.
	 * @return 리다이렉트 URL
	 */
	@GetMapping("/join.do")
	public String joinForm() {
		return "redirect:/memberWrite.do";
	}

	/**
	 * POST 요청 처리: 회원가입 폼 제출을 처리하고 회원 정보를 데이터베이스에 저장합니다.
	 * @param request HTTP 요청 객체
	 * @param model 모델 객체 (뷰로 데이터를 전달하기 위해 사용)
	 * @return 성공 시 success.jsp, 실패 시 fail.jsp 뷰 이름
	 */
	@PostMapping("/join.do")
	public String join(HttpServletRequest request, Model model) {
		// 폼 데이터를 추출하여 MemberVO 객체 생성
		String name = request.getParameter("name");
		String passportFirstName = request.getParameter("passportFirstName");
		String passportLastName = request.getParameter("passportLastName"); 
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String birthdate = request.getParameter("birthdate");
		String gender = request.getParameter("gender");

		// 폼 전송 확인 디버깅
		System.out.println("=== 폼 전송 확인 ===");
		System.out.println("request.getParameter('passportFirstName'): [" + passportFirstName + "]");
		System.out.println("request.getParameter('passportLastName'): [" + passportLastName + "]");

		// null 체크 및 빈 문자열 처리
		if (passportFirstName == null || passportFirstName.trim().isEmpty()) {
			passportFirstName = "";
		}
		if (passportLastName == null || passportLastName.trim().isEmpty()) {
			passportLastName = "";
		}

		// MemberVO 객체 생성
		MemberVO memberVo = new MemberVO(name, passportFirstName, passportLastName, email, phone, birthdate, gender);

		try {
			// 디버깅을 위해 콘솔에 출력
			System.out.println("=== 회원가입 요청 데이터 ===");
			System.out.println("이름: " + memberVo.getName());
			System.out.println("영어 이름: " + memberVo.getPassportFirstName());
			System.out.println("영어 성: " + memberVo.getPassportLastName());
			System.out.println("이메일: " + memberVo.getEmail());
			System.out.println("휴대폰 번호: " + memberVo.getPhone());
			System.out.println("생년월일: " + memberVo.getBirthdate());
			System.out.println("성별: " + memberVo.getGender());

			// DB에 회원 정보 저장
			boolean success = FMK_DB.registerMember(name, passportFirstName, passportLastName, email, phone, birthdate, gender);

			if (success) {
				// 회원가입 성공 시, memberVo 객체를 Model에 추가하여 JSP로 전달
				System.out.println("회원가입 성공!");
				model.addAttribute("memberVo", memberVo);
				// 표준 Spring MVC 방식으로 뷰 리턴
				return "member/success";  // /WEB-INF/jsp/member/success.jsp
			} else {
				// 회원가입 실패 시
				System.out.println("회원가입 실패!");
				return "member/fail"; // 실패 페이지로 이동
			}

		} catch (Exception e) {
			System.err.println("회원가입 처리 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
			return "member/fail"; // 예외 발생 시 실패 페이지로 이동
		}
	}

	/**
	 * 회원 정보를 담는 VO(Value Object) 클래스
	 */
	public class MemberVO {
		private String name;
		private String passportFirstName;
		private String passportLastName;
		private String email;
		private String phone;
		private String birthdate;
		private String gender;

		public MemberVO(String name, String passportFirstName, String passportLastName, String email, String phone, String birthdate, String gender) {
			this.name = name;
			this.passportFirstName = passportFirstName;
			this.passportLastName = passportLastName;
			this.email = email;
			this.phone = phone;
			this.birthdate = birthdate;
			this.gender = gender;
		}

		// Getters
		public String getName() { return name; }
		public String getPassportFirstName() { return passportFirstName; }
		public String getPassportLastName() { return passportLastName; }
		public String getEmail() { return email; }
		public String getPhone() { return phone; }
		public String getBirthdate() { return birthdate; }
		public String getGender() { return gender; }
	}
}
