$(document).ready(function () {

    // 비밀번호 변경 모달창
    $(".pw-edit").click(function () {
        modalShow();
    });
    $(".modal-close").click(function () {
        modalHide();
    });

    // 마이페이지 내가 쓴 리뷰 탭
    $("#myReviewBtn").click(function () {
        $("#mypageReview").css("display", "flex");
        $("#mypageBoard").css("display", "none");
        $(this).addClass("active");
        $("#myBoardBtn").removeClass("active");
    })

    // 마이페이지 내가 쓴 게시글 탭
    $("#myBoardBtn").click(function () {
        $("#mypageReview").css("display", "none");
        $("#mypageBoard").css("display", "flex");
        $(this).addClass("active");
        $("#myReviewBtn").removeClass("active");
    })

    // 회원정보 수정 페이지 접근 전 비밀번호 체크
    $(".edit-MyInfo").click(function () {
        $.ajax({
            type: "POST",
            url: "/checkMyPw",
            dataType: "text",
            data: {
                member_id: $("#member_id").val(),
                chkMemberPw: $("#chkMemberPw").val()
            },
            success: function (result) {
                console.log(result);
                alert("비밀번호 변경 페이지로 이동합니다");
            },
            error: function () {
                // 에러 발생 시 에러 메시지 표시
                alert("비밀번호 확인 중 오류가 발생하였습니다.");
                window.location.reload();
            }
        });
    });


    // 회원정보 수정 페이지
    $("#editMyInfo-btn").click(function () {

        // 빈 문자열을 null로 변환, 빈 문자열로 데이터에 저장되지 않기 위해
        let formIsValid = true;
        $(".editMyinfo-form input[required]").each(function () {
            if ($(this).val() == "") {
                formIsValid = false;
                $(this).val(null);
            }
        });

        // 입력값이 null일 경우
        if (formIsValid) {
            // 비밀번호 일치 확인
            if ($("#member_pw").val() === $("#member_pwChk").val()) {
                $.ajax({
                    type: "post",
                    url: "/updateMemberInfo",
                    dataType: "text",
                    data: {
                        member_id: $("#member_id").val(),
                        member_nickname: $("#member_nickname").val(),
                        member_pw: $("#member_pw").val() !== "" ? $("#member_pw").val() : null,
                        member_email: $("#member_email").val(),
                        member_phone: $("#member_phone").val()
                    },
                    success: function (response) {
                        if (response !== 0) {
                            modalShow();
                        }
                    },
                    error: function () {
                        alert("회원 정보 수정에 실패하였습니다.");
                    }
                });
            } else {
                alert("비밀번호가 일치하지 않습니다.");
            }
        } else {
            alert("필수 입력값을 모두 입력해주세요.");
        }
    });

    // 이메일 형식 실시간 반영
    $("#member_email").keyup(function () {
        let email = $(this).val();
        let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (!emailPattern.test(email)) {
            inputRuleGuide(".email_chk", "올바른 이메일 형식이 아닙니다.", "#E04C47");
        } else {
            inputRuleGuide(".email_chk", "올바른 이메일 형식입니다.", "#78CA5B");
        }
    })

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
});

