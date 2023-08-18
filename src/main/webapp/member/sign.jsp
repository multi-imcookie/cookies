<%--
  Created by IntelliJ IDEA.
  User: ohlocal
  Date: 2023-08-04
  Time: 오전 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>전과자</title>
    <%@ include file="../link.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#signUp-btn").click(function () {

                // 빈 문자열을 null로 변환, 빈 문자열로 데이터에 저장되지 않기 위해
                let formIsValid = true;
                $(".signup-form input[required]").each(function () {
                    if ($(this).val() == "") {
                        formIsValid = false;
                        $(this).val(null);
                    }
                });

                // 입력값이 null일 경우
                if (formIsValid) {
                    // 생일 월, 일 값 두개를 합치기
                    let member_birthday = $("#member_birthday1").val() + "월 " + $("#member_birthday2").val() + "일";

                    // 이메일, 이메일 주소 값 두개를 합치기
                    let member_email = $("#member_email1").val() + "@" + $("#member_email2").val();

                    // 아이디 중복 여부 확인
                    let member_signId = $("#member_signId").val();

                    $.ajax({
                        type: "post",
                        url: "checkId",
                        data: {
                            member_signId: member_signId
                        },
                        success: function (response) {
                            // 아이디 중복체크
                            if (response !== 0) {
                                alert("이미 사용 중인 아이디입니다.");
                            } else {
                                // 비밀번호 일치 확인
                                if ($("#member_pw").val() === $("#member_pwChk").val()) {
                                    $.ajax({
                                        type: "post",
                                        url: "sign",
                                        dataType: "text",
                                        data: {
                                            member_signId: member_signId,
                                            member_nickname: $("#member_nickname").val(),
                                            member_pw: $("#member_pw").val(),
                                            member_birthday: member_birthday,
                                            member_age: $("input[name='member_age']:checked").val(),
                                            member_gender: $("input[name='member_gender']:checked").val(),
                                            member_email: member_email
                                        },
                                        success: function (response) {
                                            if (response > 0) {
                                                alert("회원가입 완료! 로그인 페이지로 이동합니다.");
                                            }
                                        },
                                        error: function () {
                                            alert("회원가입에 실패하였습니다.");
                                        }
                                    });
                                } else {
                                    alert("비밀번호가 일치하지 않습니다.");
                                }
                            }
                        },
                        error: function () {
                            alert("아이디 중복 확인에 실패하였습니다.");
                        }
                    });
                } else {
                    alert("필수 입력값을 모두 입력해주세요.");
                }
            });

            // 아이디 중복 확인 실시간 반영
            $("#member_signId").keyup(function () {
                let member_signId = $(this).val();

                $.ajax({
                    type: "post",
                    url: "checkId",
                    data: {
                        member_signId: member_signId
                    },
                    success: function (response) {
                        if (response !== 0) {
                            $(".id_chk").text("이미 사용 중인 아이디입니다.").css("color", "#E04C47");
                        } else {
                            $(".id_chk").text("사용 가능한 아이디입니다.").css("color", "#78CA5B");
                        }
                    },
                    error: function () {
                        $(".id_chk").text("아이디 중복 확인에 실패하였습니다.").css("color", "#E04C47");
                    }
                });
            });

            // 비밀번호 확인 실시간 반영
            $("#member_pwChk").keyup(function () {
                if ($("#member_pw").val() === $(this).val()) {
                    $(".pw_chk").text("비밀번호가 일치합니다.").css("color", "#78CA5B");
                } else {
                    $(".pw_chk").text("비밀번호가 일치하지 않습니다.").css("color", "#E04C47");
                }
            });

            // 비밀번호 규칙 실시간 반영
            $("#member_pw").keyup(function () {
                if ($(this).val().length < 8 || $(this).val().length > 16) { // 비밀번호 문자열의 입력 길이 검사
                    $(".pw_rule").text("비밀번호는 8자리 이상 16자리 이하만 가능합니다.").css("color", "#E04C47");
                } else if (!/[0-9]/.test($(this).val())) { // 비밀번호 문자열에 숫자 존재 여부 검사
                    $(".pw_rule").text("숫자를 입력해 주세요.").css("color", "#E04C47");
                } else if (!/[a-zA-Z]/.test($(this).val())) { // 비밀번호 문자열에 영문 소문자 존재 여부 검사
                    $(".pw_rule").text("영문을 입력해 주세요.").css("color", "#E04C47");
                } else if (!/[~!@#$%^&*()_+|<>?:{}]/.test($(this).val())) { // 비밀번호 문자열에 특수문자 존재 여부 검사
                    $(".pw_rule").text("특수문자를 입력해 주세요.").css("color", "#E04C47");
                } else {
                    $(".pw_rule").text("사용하시기 좋은 비밀번호 입니다.").css("color", "#78CA5B"); // 모든 조건을 만족할 경우
                }
            })
        }) // function

    </script>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="sub-center">
    <h3 class="s-h-imcre24">회원가입</h3>
    <form class="signup-form form-style" method="post">
        <div class="input-section">
            <label class="label-wrap" for="member_signId">아이디<span class="require-val">*</span></label>
            <input type="text" id="member_signId" name="member_signId" placeholder="아이디를 입력하세요." required>
            <span class="guide id_chk"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_nickname">닉네임<span class="require-val">*</span></label>
            <input type="text" id="member_nickname" name="member_nickname" placeholder="전과자에서 사용하실 닉네임을 입력하세요."
                   required>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_pw">비밀번호 입력<span class="require-val">*</span></label>
            <input type="password" id="member_pw" name="member_pw" placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합" required>
            <span class="guide pw_rule"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_pwChk">비밀번호 확인<span class="require-val">*</span></label>
            <input type="password" id="member_pwChk" name="member_pwChk" placeholder="비밀번호를 한 번 더 입력하세요." required>
            <span class="guide pw_chk"></span>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_birthday1">생일 / 연령대<span class="require-val">*</span></label>
            <div class="input-section-left">
                <input type="text" id="member_birthday1" name="member_birthday1" placeholder="MM" required>
                <input type="text" id="member_birthday2" name="member_birthday2" placeholder="DD" required>
            </div>
            <div class="input-section-right">
                <div class="label-wrap">
                    <input type="radio" id="member_age1" name="member_age" value="10-19"><label
                        for="member_age1">10대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age2" name="member_age" value="20-29"><label
                        for="member_age2">20대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age3" name="member_age" value="30-39"><label
                        for="member_age3">30대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age4" name="member_age" value="40-49"><label
                        for="member_age4">40대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age5" name="member_age" value="50-59"><label
                        for="member_age5">50대</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_age6" name="member_age" value="60-"><label for="member_age6">60대
                    이상</label>
                </div>
            </div>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_gender1">성별<span class="require-val">*</span></label>
            <div class="input-section-right">
                <div class="label-wrap">
                    <input type="radio" id="member_gender1" name="member_gender" value="여성"><label
                        for="member_gender1">여성</label>
                </div>
                <div class="label-wrap">
                    <input type="radio" id="member_gender2" name="member_gender" value="남성"><label
                        for="member_gender2">남성</label>
                </div>
            </div>
        </div>
        <div class="input-section">
            <label class="label-wrap" for="member_email1">이메일<span class="require-val">*</span></label>
            <input type="text" id="member_email1" name="member_email1" placeholder="이메일을 입력하세요." required>
            <span class="email-at">@</span>
            <input type="text" id="member_email2" name="member_email2" placeholder="이메일 주소를 입력하세요." required>
        </div>
        <input type="button" id="signUp-btn" class="fill-submit-btn" value="회원가입">
    </form>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>
