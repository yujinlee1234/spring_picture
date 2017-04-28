<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#dropBox .item{float: left; position: relative; margin: 5px;}
	.item .del{position: absolute; right: 3px; top: 3px; font-weight: bold; background: white; border:1px solid black;}
	.item .fName{width: 100%; position: absolute; padding-left:2px; bottom:-5px; font-weight: bold; background: rgba(0,0,0,0.5); color: white;}
</style>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">MODIFY PAGE</h3>
				</div>
				<div class="box-body">
					<form method="post" id="form1" enctype="multipart/form-data">
						<input type="hidden" name="bno" value="${boardVO.bno }">
						<input type="hidden" name="page" value="${cri.page }">
						<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
						<input type="hidden" name="SearchType" value="${cri.searchType }">
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="title" value="${boardVO.title }" class="form-control">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea rows="5" cols="" name="content" class="form-control">
								${boardVO.content }
							</textarea>
						</div>
						<div class="form-group">
							<label>Writer</label>
							<input type="text" readonly="readonly" name="writer" class="form-control" value="${boardVO.writer }">
						</div>
						<div class="form-group">
							<label>Image File</label>
							<input type="file" name="imagefiles" multiple="multiple" class="form-control">
						</div>	
						<c:if test="${!empty boardVO.files }">	
							<div class="form-group" id="dropBox">
								<c:forEach items="${boardVO.files }" var="file">								
									<div class="item">
										<img alt="" src="displayFile?filename=${file }">
										<button class="del" type="button">X<input type="hidden" value="${file }" name = "fileNames"></button>
										<span class="fName">${file.substring(file.lastIndexOf("_")+1) }</span>	
									</div>								
								</c:forEach>
							</div>	
						</c:if>	
					</form>					
				</div>
				<div class="box-footer">
					<button id="btnMod" class="btn btn-success">수정하기</button>
					<button id="btnReturn" class="btn btn-primary">돌아가기</button>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	$(function(){
		$("#btnReturn").click(function(){
			location.href="${pageContext.request.contextPath }/sboard/read?bno=${boardVO.bno }&page=${cri.page}&perPageNum=${cri.perPageNum}&searchType=${cri.searchType}&keyword=${cri.keyword}";
		});
		$("#btnMod").click(function(){
			if(confirm("수정 하시겠습니까?")){
				$("#form1").attr("action","${pageContext.request.contextPath }/sboard/modify");
				$("#form1").submit();
			}
		});
		
		$(document).on("click",".del",function(){
			var item = $(this).parent(".item");
			item.remove();
		});
	});
</script>
<%@ include file="../include/footer.jsp" %>