<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	div.pItem{width:200px; float: left; margin: 10px;}
	.pItem .pCheck{display: none;}
	div#noItem figure{width: 100%; text-align: center;}
</style>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body">		
					<button id="searchBtn" class="btn btn-warning">전체 삭제</button>
					<button id="newBtn" class="btn btn-primary">선택 삭제</button>				
				</div>
			</div>
			<div class="box">
				<div class="box-header with-border">
				</div>
				<div class="box-body">
					<c:if test="${!empty picList }">
						<c:forEach items="${picList }" var="pic">
							<div class="pItem">
								<p><input type="checkbox" class="pCheck">${pic.regdateText }</p>
								<a href="#" class="showImage"><img alt="" src="display?filename=${pic.fullname }"></a>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty picList }">
						<div id="noItem">
							<figure>
								<img alt="" src="${pageContext.request.contextPath }/resources/dist/img/empty-folder.png">
								<figcaption> 등록된 사진이 없습니다. </figcaption>
							</figure>
						</div>						
					</c:if>
				</div>
				<div class="box-footer">
					
				</div>
			</div>
		</div>
	</div>
</section>
<script>
 	//var result = "${result}";
	if("${result}"=="success"){
		alert("성공적으로 등록되었습니다.");
	}else if("${result}"=="removeSuccess"){
		alert("성공적으로 삭제되었습니다.");
	}
	
	$(function(){
		
		
	});//ready
</script>
<%@ include file="../include/footer.jsp" %>