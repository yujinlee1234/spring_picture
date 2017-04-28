<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#pwCheck{
		color: red;
	}
</style>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">회원 가입</h3>
				</div>
				<div class="box-body">
					<form role="form" id="form1" action="${pageContext.request.contextPath }/user/join" method="post">
						<div class="form-group">
							<label>아이디</label>
							<div class="input-group">
								<input type="text" placeholder="Enter ID" name="uid" class="form-control" style="width: 70%;" required="required">
								<span class="input-group-btn" style="width:10%;">
									<button type="button" class="btn btn-primary" id="chkID">중복 확인</button>
								</span>
							</div>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" placeholder="Enter Password" name="upw" class="form-control inputPw" required="required">
						</div>
						<div class="form-group">
							<label>비밀번호 확인</label>
							<input type="password" placeholder="Enter Password" class="form-control inputPw" id="upwChk">
							<span id="pwCheck"></span>
						</div>						
						<div class="form-group">
							<label>이름</label>
							<input type="text" placeholder="Enter Name" name="uname" class="form-control" required="required">
						</div>
						<div class="form-group">
							<label>이메일</label>
							<input type="text" placeholder="Enter Email" name="uemail" class="form-control" required="required">
						</div>
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" placeholder="Enter Phone Number" name="utel" class="form-control" required="required">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	$("#chkID").click(function(){
		//중복확인 버튼 클릭
		var result = checkID();
		if(result != undefined){
			if(result == true){
				alert("가입가능한 아이디 입니다.");
				$("input[name='upw']").focus();
			}else{
				alert("이미 존재하는 아이디 입니다.");
				$("input[name='uid']").val("");
				$("input[name='uid']").focus();
			}
		}
	});	
	
	$("#form1").submit(function(){		
		//비밀번호 확인 input이 focus를 잃었을 때
		var oPW = $("input[name='upw']").val();
		var cPW = $("#upwChk").val();
		
		//case1. 비밀번호가 입력 안되어있을 때		
		if(cPW.length==0||cPW == null){
			$("#pwCheck").text("비밀번호를 입력해 주세요.");
			$("#upwChk").focus();
			return false;
		}else if(oPW != cPW){
			$("#pwCheck").text("비밀번호가 일치하지 않습니다.");
			$("#upwChk").focus();
			return false;
		}else if(checkID() != undefined && checkID() == false){
			alert("이미 존재하는 아이디 입니다.");
			$("input[name='uid']").val("");
			$("input[name='uid']").focus();
			return false;
		}	
	});
	
function checkID(){
	var result;
	var checkId = $("input[name='uid']").val();
	if(checkId.length>0){
		$.ajax({
			url:"check/"+checkId,
			type:"get",
			dataType:"text",
			async:false,
			success:function(data){
				console.log(data);
				if(data == "SUCCESS"){
					result = true;					
				}else{
					result = false;					
				}
			}
		});
	}else{
		alert("아이디를 입력해 주세요.");
		$("input[name='uid']").focus();
	}
	
	return result;
}
</script>
<%@ include file="../include/footer.jsp" %>