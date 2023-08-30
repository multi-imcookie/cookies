<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>



<c:forEach var="tmp" items="${clist }">

    <c:choose>
        <c:when test="${sessionScope.nick ne tmp.send_nick }">
            <!-- 받은 메세지 -->
            <div class="incoming_msg">
                <div class="incoming_msg_img">
                    <a href="other_profile.do?other_nick=${tmp.send_nick }">
                        <img src="./upload/profile/${tmp.profile }" alt="보낸사람 프로필">
                    </a>
                </div>
                <div class="received_msg">
                    <div class="received_withd_msg">
                        <p>${tmp.content }</p>
                        <span class="time_date"> ${tmp.send_time }</span>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- 보낸 메세지 -->
            <div class="outgoing_msg">
                <div class="sent_msg">
                    <p>${tmp.content }</p>
                    <span class="time_date"> ${tmp.send_time }</span>
                </div>
            </div>
        </c:otherwise>
    </c:choose>


</c:forEach>

