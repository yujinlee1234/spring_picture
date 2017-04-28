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
								<a href="#" class="showImage"><img alt="${pic.originalname }" src="display?filename=${pic.fullname }"></a>
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
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">사진 보기</h4>
      </div>
      <div class="modal-body">
        <img alt="" src="" id="modalImg">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
<style>
	#myModal .modal-dialog{width:70% !important;}
	#myModal .modal-dialog .modal-body{text-align: center;}
	#myModal .modal-dialog #modalImg{width: 80%;}
</style>
<script>
 	//var result = "${result}";
	if("${result}"=="SUCCESS"){
		alert("성공적으로 등록되었습니다.");
	}else if("${result}"=="rSUCCESS"){
		alert("성공적으로 삭제되었습니다.");
	}else if("${result}"=="FAIL"){
		alert("등록에 실패하였습니다.");
	}else if("${result}"=="rFAIL"){
		alert("삭제에 실패하였습니다.");
	}
	
	$(function(){
		$(".showImage").click(function(){
			var path = $(this).find("img").attr("alt");
			console.log("Path : "+path);
			$("#modalImg").attr("src","display?filename="+path);
			$(this).attr("data-toggle","modal").attr("data-target","#myModal");
			 //data-toggle="modal" data-target="#myModal"
		});
		
	});//ready
</script>
<%@ include file="../include/footer.jsp" %>