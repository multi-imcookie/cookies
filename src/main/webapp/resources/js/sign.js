$(document).ready(function () {
    // 회원가입 script 시작
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
            // 핸드폰 번호 값 합치기
            let member_phone = $("#member_phone1").val() + "-" + $("#member_phone2").val() + "-" + $("#member_phone3").val();
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
                                type : "post",
                                url : "sign",
                                dataType : "text",
                                data : {
                                    member_signId : member_signId,
                                    member_nickname : $("#member_nickname").val(),
                                    member_pw : $("#member_pw").val(),
                                    member_birthday : member_birthday,
                                    member_age : $("input[name='member_age']:checked").val(),
                                    member_gender : $("input[name='member_gender']:checked").val(),
                                    member_email : member_email,
                                    member_phone : member_phone
                                },
                                success: function (response) {
                                    if (response != 0) {
                                        modalShow();
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
                    inputRuleGuide(".id_chk", "이미 사용 중인 아이디입니다.", "#E04C47");
                } else if (member_signId.length <= 5 || member_signId.length >= 13) { // 아이디 문자열의 입력 길이 검사
                    inputRuleGuide(".id_chk", "아이디는 6자리 이상 12자리 이하만 가능합니다.", "#E04C47");
                } else if (/[~!@#$%^&*()_+|<>?:{}]/.test(member_signId)) { // 아이디 문자열에 특수문자 존재 여부 검사
                    inputRuleGuide(".id_chk", "아이디는 특수문자를 사용할 수 없습니다.", "#E04C47");
                } else if (!/[0-9]/.test(member_signId) || !/[a-zA-Z]/.test(member_signId)) { // 아이디 문자열에 숫자와 영문 존재 여부 검사
                    inputRuleGuide(".id_chk", "아이디는 숫자와 영문을 함께 조합해야 합니다.", "#E04C47");
                } else { // 모든 조건을 만족할 경우
                    inputRuleGuide(".id_chk", "사용 가능한 아이디입니다.", "#78CA5B");
                }
            },
            error: function () {
                inputRuleGuide(".id_chk", "아이디 중복 확인에 실패하였습니다.", "#E04C47");
            }
        });
    });

    // 비밀번호 확인 실시간 반영
    $("#member_pwChk").keyup(function () {
        if ($("#member_pw").val() === $(this).val()) {
            inputRuleGuide(".pw_chk", "비밀번호가 일치합니다.", "#78CA5B");
        } else {
            inputRuleGuide(".pw_chk", "비밀번호가 일치하지 않습니다.", "#E04C47");
        }
    });

    // 비밀번호 규칙 실시간 반영
    $("#member_pw").keyup(function () {
        if ($(this).val().length <= 7 || $(this).val().length >= 17) { // 비밀번호 문자열의 입력 길이 검사
            inputRuleGuide(".pw_rule", "비밀번호는 8자리 이상 16자리 이하만 가능합니다.", "#E04C47")
        } else if (!/[0-9]/.test($(this).val()) || !/[a-zA-Z]/.test($(this).val())) { // 비밀번호 문자열에 숫자와 영문 존재 여부 검사
            inputRuleGuide(".pw_rule", "비밀번호는 숫자와 영문을 함께 조합해야 합니다.", "#E04C47")
        } else if (!/[~!@#$%^&*()_+|<>?:{}]/.test($(this).val())) { // 비밀번호 문자열에 특수문자 존재 여부 검사
            inputRuleGuide(".pw_rule", "특수문자를 입력해 주세요.", "#E04C47")
        } else { // 모든 조건을 만족할 경우
            inputRuleGuide(".pw_rule", "사용 가능한 비밀번호 입니다.", "#78CA5B")
        }
    });

    // 회원가입 script 끝
});

// 타입이 number인 input 문자열 길이 제어
function maxLengthChk(object) {
    if (object.value.length > object.maxLength) {
        object.value = object.value.slice(0, object.maxLength);
    }
}