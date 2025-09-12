package main.web;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.HashMap;
import java.util.Map;

@Controller
public class memberController {
    
    private String user(HttpServletRequest r){
        HttpSession s = r.getSession(false);
        return s != null ? (String)s.getAttribute("userEmail") : null;
    }

    @GetMapping("/signup.do")   
    public String signup(){return "member/signup";}
    
    @GetMapping("/login.do")    
    public String login(){return "member/login";}

    @GetMapping("/testJDBC.do")
    @ResponseBody
    public String testJDBC() {
        try {
            Class.forName("com.filemaker.jdbc.Driver");
            java.sql.Connection conn = java.sql.DriverManager.getConnection(
                "jdbc:filemaker://xcd006.cafe24.com:2399/KSY_MypageDB",
                "admin", "2211"
            );
            conn.close();
            return "✅ JDBC 연결 테스트 성공!";
        } catch (ClassNotFoundException e) {
            return "❌ 드라이버 로드 실패: " + e.getMessage();
        } catch (java.sql.SQLException e) {
            return "❌ DB 연결 실패: " + e.getMessage();
        }
    }

    @PostMapping("/join.do")
    public String join(MemberVO vo, Model m){
        String email = vo.getEmail().trim().toLowerCase();
        if(FMK_DB.existsEmail(email)){
            m.addAttribute("dupEmailMsg","이미 등록된 이메일입니다!");
            m.addAttribute("prefill_email",email);
            m.addAttribute("prefill_name", vo.getName());
            m.addAttribute("prefill_firstName", vo.getPassportFirstName());
            m.addAttribute("prefill_lastName", vo.getPassportLastName());
            m.addAttribute("prefill_phone", vo.getPhone());
            m.addAttribute("prefill_birthdate", vo.getBirthdate());
            m.addAttribute("prefill_gender", vo.getGender());
            return "member/signup";
        }
        
        boolean ok = FMK_DB.registerMember(
                vo.getName(), vo.getPassportFirstName(), vo.getPassportLastName(),   
                email, vo.getPhone(), vo.getBirthdate(), vo.getGender(), vo.getPassword());
        
        if(ok){
            m.addAttribute("memberVo",vo);
            return "member/success";
        }
        m.addAttribute("error","가입 실패"); 
        return "member/signup";
    }

    @PostMapping("/login.do")
    public String doLogin(HttpServletRequest req, Model m){
        String email = req.getParameter("email").trim().toLowerCase();
        String pw = req.getParameter("password");
        if(FMK_DB.authenticate(email,pw)){
            req.getSession(true).setAttribute("userEmail",email);
            return "redirect:/main.do";
        }
        m.addAttribute("loginError","로그인 실패");
        return "member/login";
    }

    @GetMapping("/regular_member.do")
    public String regularMember(HttpServletRequest r, Model m){
        String email = user(r); 
        if(email == null) return "redirect:/login.do";
        m.addAttribute("memberVo", FMK_DB.getMemberByEmail(email));
        return "member/regular_member";
    }

    @PostMapping("/member/upgrade.do")
    public String upgrade(@RequestParam String passportNo,
                          @RequestParam MultipartFile passportImg,
                          @RequestParam(required=false) MultipartFile visaImg,
                          @RequestParam(required=false) MultipartFile feeImg,
                          HttpServletRequest r, Model m){
        String email = user(r); 
        if(email == null) return "redirect:/login.do";
        
        boolean ok = FMK_DB.registerRegularMember(email, passportNo, passportImg, visaImg, feeImg);
        return ok ? "redirect:/late_regular_member.do" : "redirect:/regular_member.do";
    }

    @GetMapping("/late_regular_member.do")
    public String late(HttpServletRequest r, Model m){
        String email = user(r); 
        if(email == null) return "redirect:/login.do";
        m.addAttribute("memberVo", FMK_DB.getMemberByEmail(email));
        return "member/late_regular_member";
    }

    @GetMapping("/success_regular_member.do")
    public String success(HttpServletRequest r, Model m){
        String email = user(r); 
        if(email == null) return "redirect:/login.do";
        m.addAttribute("memberVo", FMK_DB.getMemberByEmail(email));
        return "member/success_regular_member";
    }

    @GetMapping("/member/checkStatus.do")
    @ResponseBody
    public Map<String, Object> checkStatus(HttpServletRequest r) {
        String email = user(r);
        Map<String, Object> result = new HashMap<>();
        
        if (email != null) {
            FMK_DB.MemberProfile profile = FMK_DB.getMemberByEmail(email);
            if (profile != null) {
                String grade = profile.getGrade();
                boolean isRegular = "정회원".equals(grade);
                result.put("isRegularMember", isRegular);
                result.put("currentGrade", grade);
            } else {
                result.put("isRegularMember", false);
                result.put("currentGrade", "조회 실패");
            }
        } else {
            result.put("isRegularMember", false);
            result.put("currentGrade", "로그인 필요");
        }
        return result;
    }
    
    @GetMapping("/main.do")
    public String main(HttpServletRequest r, Model m){
        String email = user(r); 
        if(email == null) return "redirect:/login.do";
        m.addAttribute("memberVo", FMK_DB.getMemberByEmail(email));
        return "member/main";
    }

    @GetMapping(value="/api/email-exists.do", produces="text/plain;charset=UTF-8")
    @ResponseBody
    public String emailExists(@RequestParam String email){
        return FMK_DB.existsEmail(email.trim().toLowerCase()) ? "true" : "false";
    }

    @GetMapping("/logout.do")
    public String logout(HttpServletRequest r){
        HttpSession s = r.getSession(false); 
        if(s != null) s.invalidate();
        return "redirect:/login.do";
    }

    @PostMapping("/admin/approveMember.do")
    public String approveMember(@RequestParam String email) {
        boolean isRegularMember = FMK_DB.approveMember(email);
        return isRegularMember ? "redirect:/success_regular_member.do" : "redirect:/admin/memberList.do";
    }

    @PostMapping("/checkApprovalStatus.do")
    public String checkApprovalStatus(HttpServletRequest r, RedirectAttributes redirectAttributes) {
        String email = user(r);
        if(email == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login.do";
        }
        
        try {
            FMK_DB.MemberProfile profile = FMK_DB.getMemberByEmail(email);
            
            if (profile != null) {
                String currentGrade = profile.getGrade();
                
                if ("정회원".equals(currentGrade)) {
                    redirectAttributes.addFlashAttribute("successMessage", 
                        "🎉 축하합니다! 정회원 승인이 완료되었습니다.");
                    return "redirect:/success_regular_member.do";
                } else {
                    redirectAttributes.addFlashAttribute("statusMessage", 
                        "현재 상태: " + currentGrade + " - 승인 검토 중입니다. 잠시만 더 기다려주세요.");
                    return "redirect:/late_regular_member.do";
                }
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "회원 정보를 조회할 수 없습니다. 다시 시도해주세요.");
                return "redirect:/late_regular_member.do";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "상태 확인 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            return "redirect:/late_regular_member.do";
        }
    }
}
