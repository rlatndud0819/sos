<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            list-style: none;
            text-decoration: none;
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            box-sizing: border-box;
        }
        
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f7f9fc;
        }
        
        .container {
            width: 400px;
            padding: 30px;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
        }
        
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
            font-size: 1.8em;
        }
        
        /* Tab menu styling */
        .tab-menu {
            display: flex;
            justify-content: space-around;
            margin-bottom: 25px;
            border-bottom: 2px solid #e9ecef;
        }
        
        .tab-menu a {
            color: #6c757d;
            padding: 12px 0;
            flex-grow: 1;
            text-align: center;
            font-weight: bold;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .tab-menu a.active {
            color: #20B2AA; /* Teal color for active tab */
            border-bottom: 2px solid #20B2AA; /* Teal color for active tab underline */
        }
        
        /* Form field styling */
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-size: 0.9em;
            color: #555;
        }
        
        .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 1em;
            transition: all 0.3s ease;
        }
        
        .input-field:focus {
            outline: none;
            border-color: #20B2AA; /* Teal color on focus */
            box-shadow: 0 0 5px rgba(32, 178, 170, 0.25); /* Teal shadow on focus */
        }
        
        .inline-fields {
            display: flex;
            gap: 10px;
        }
        
        .inline-fields .field-group {
            flex-grow: 1;
        }
        
        .gender-radio {
            display: flex;
            gap: 20px;
        }
        
        .gender-radio label {
            display: inline-flex;
            align-items: center;
            font-size: 1em;
        }
        
        /* Checkbox and link styling */
        .checkbox-group {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }
        
        .checkbox-group input {
            margin-right: 8px;
        }
        
        .agree-text {
            font-size: 0.9em;
            color: #555;
        }
        
        /* Submit button styling */
        .submit-button {
            width: 100%;
            padding: 15px;
            background-color: #20B2AA; /* Teal background color */
            color: #fff;
            font-size: 1.2em;
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 25px;
            transition: background-color 0.3s ease;
        }
        
        .submit-button:hover {
            background-color: #148F77; /* Slightly darker teal on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>회원가입</h2>
        
        <div class="tab-menu">
            <a href='index.jsp' class="active">일반회원</a>
            <a href='index2.jsp'>정회원</a>
            <a href='index3.jsp'>법인회원</a>
        </div>
        
        <form action="${pageContext.request.contextPath}/join.do" method="post">
            <div class="form-group">
                <label for="name">이름 (한글)</label>
                <input type="text" id="name" name="name" class="input-field" 
                       placeholder="이름 (한글)" required>
            </div>
            
            <div class="inline-fields">
                <div class="form-group field-group">
                    <label for="passportFirstName">여권 이름 (영문)</label>
                    <input type="text" id="passportFirstName" name="passportFirstName" 
                           class="input-field" placeholder="이름 (영문)" required>
                </div>
                <div class="form-group field-group">
                    <label for="passportLastName">여권 성 (영문)</label>
                    <input type="text" id="passportLastName" name="passportLastName" 
                           class="input-field" placeholder="성 (영문)" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" class="input-field" 
                       placeholder="이메일" required>
            </div>
            
            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <input type="tel" id="phone" name="phone" class="input-field" 
                       placeholder="휴대폰 번호" required oninput="autoHyphen(this)">
            </div>
            
            <div class="form-group">
                <label for="birthdate">생년월일</label>
                <input type="text" id="birthdate" name="birthdate" class="input-field" 
                       placeholder="YYYY.MM.DD" oninput="autoFormatDate(this)">
            </div>
            
            <div class="form-group">
                <label>성별</label>
                <div class="gender-radio">
                    <label>
                        <input type="radio" name="gender" value="남" required> 남
                    </label>
                    <label>
                        <input type="radio" name="gender" value="여"> 여
                    </label>
                </div>
            </div>
            
            <div class="checkbox-group">
                <input type="checkbox" id="agree" name="agree" required>
                <label for="agree" class="agree-text">개인정보 수집 이용에 동의합니다.</label>
            </div>
            
            <button type="submit" class="submit-button">가입하기</button>
        </form>
    </div>

    <!-- JavaScript for input formatting -->
    <script>
        /**
         * @param {HTMLInputElement} obj
         * @description 휴대폰 번호에 자동으로 하이픈을 추가합니다.
         */
        function autoHyphen(obj) {
            let value = obj.value.replace(/[^0-9]/g, '');
            let result = '';
            
            if (value.length > 3) {
                result += value.substring(0, 3);
                result += '-';
                if (value.length > 7) {
                    result += value.substring(3, 7);
                    result += '-';
                    result += value.substring(7);
                } else {
                    result += value.substring(3);
                }
            } else {
                result = value;
            }
            
            obj.value = result;
        }

        /**
         * @param {HTMLInputElement} obj
         * @description 생년월일(YYYY.MM.DD)에 자동으로 점(.)을 추가합니다.
         */
        function autoFormatDate(obj) {
            let value = obj.value.replace(/[^0-9]/g, '');
            let result = '';
            
            if (value.length > 4) {
                result += value.substring(0, 4);
                result += '.';
                if (value.length > 6) {
                    result += value.substring(4, 6);
                    result += '.';
                    result += value.substring(6, 8); // 'DD'는 2자리까지만 입력
                } else {
                    result += value.substring(4);
                }
            } else {
                result = value;
            }
            
            obj.value = result;
        }
    </script>
</body>
</html>
