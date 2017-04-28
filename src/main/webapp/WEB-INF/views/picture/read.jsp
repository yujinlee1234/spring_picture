<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">READ PAGE</h3>
				</div>
				<div class="box-body">
					<form method="post" id="form1">
						<input type="hidden" name="bno" value="${boardVO.bno }">
						<input type="hidden" name="page" value="${cri.page }">
						<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
						<input type="hidden" name="SearchType" value="${cri.searchType }">
					</form>
					<div class="form-group">
						<label>Title</label>
						<input type="text" readonly="readonly" value="${boardVO.title }" class="form-control">
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea rows="5" cols="" readonly="readonly" class="form-control">
							${boardVO.content }
						</textarea>
					</div>
					<div class="form-group">
						<label>Writer</label>
						<input type="text" readonly="readonly" class="form-control" value="${boardVO.writer }">
					</div>	
					<c:if test="${!empty boardVO.files }">	
						<div class="form-group">
							<c:forEach items="${boardVO.files }" var="file">
								<img alt="" src="displayFile?filename=${file }">
							</c:forEach>
						</div>	
					</c:if>				
				</div>
				<div class="box-footer">
					<button id="btnMod" class="btn btn-success">수정하기</button>
					<button id="btnDel" class="btn btn-warning">삭제하기</button>
					<button id="btnReturn" class="btn btn-primary">돌아가기</button>
				</div>
			</div>
		</div>
	</div>
<script>
	
/* 	var result = "${result}";*/
	if("${result}"=="modifySuccess"){
		alert("수정되었습니다.");
	} 
	
	$(function(){		
		$("#btnReturn").click(function(){
			$("#form1").attr("action","${pageContext.request.contextPath }/sboard/list");
			$("#form1").attr("method","get");
			$("#form1").submit();			
		});
		$("#btnMod").click(function(){
			$("#form1").attr("action","${pageContext.request.contextPath }/sboard/modify");
			$("#form1").attr("method","get");
			$("#form1").submit();	
		});
		$("#btnDel").click(function(){
			if(confirm("삭제하시겠습니까?")){
				$("#form1").attr("action","${pageContext.request.contextPath }/sboard/remove");
				$("#form1").submit();
			}
		});
		
		getPageList(1);
		
	});
</script>
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				<div class="box-body">
					<label>Writer</label>
					<input type="text" placeholder="User ID" id="newReplyWriter" class="form-control">
					<label>Reply Text</label>
					<input type="text" placeholder="Reply Text" id="newReplyText" class="form-control">
				</div>
				<div class="box-footer">
					<button type="button" class="btn btn-primary" id="btnReplyAdd">ADD REPLY</button>
				</div>
			</div>
			<ul class="timeline">
				<li class="time-label" id="repliesDiv">
					<span class="bg-green">Replies List [<small id="replycnt"></small>]</span>
				</li>
			</ul>
			<div class="text-center">
				<ul class="pagination">
					
				</ul>
			</div>
			
			<!-- modify용 modal -->
			<div id="modifyModal" class="modal modal-primary fade" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title"></h4>
						</div>
						<div class="modal-body" data-rno>
							<p><input type="text" id="replytext" class="form-control" required="required"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-info" id="btnReplyMod">Modify</button>
							<button type="button" class="btn btn-danger" id="btnReplyDel">Delete</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
</section>
<script id="template" type="text/x-handlebars-template">
	
	{{#each.}}
	<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comments bg-blue"></i>
		<div class="timeline-item">
			<span class="time">
				<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
			</span>
			<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
			<div class="timeline-body">
				{{replytext}}
			</div>
			<div class="timeline-footer">
				<a class="btn btn-primary btn-xs btnModify" data-toggle="modal" data-target="#modifyModal">Modify</a>
				<a class="btn btn-warning btn-xs btnDelete">Delete</a>
			</div>
		</div>	
	</li>
	{{/each}}
</script>
<script>
Handlebars.registerHelper("prettifyDate", function(t) {
	
	var days = ["일","월","화","수","목","금","토"];
	var dateObj = new Date(t);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth()+1;
	var date = dateObj.getDate();
	var day = dateObj.getDay();
	return year+"-"+month+"-"+date+" "+days[day]+"요일";
});
	
	var nowPage = 1;
	var bno = ${boardVO.bno };
	function getPageList(page){
		$.ajax({
			url:"${pageContext.request.contextPath }/replies/"+bno+"/"+page,
			type:"get",
			dataType:"json",
			success:function(data){
				var source = $("#template").html();
				var temp = Handlebars.compile(source);
				var html = temp(data.list);
				$(".replyLi").remove();
				$("#repliesDiv").after(html);		
				
				var page = data.pageMaker;
				$("#replycnt").text(page.totalCount);
				setPagination(page);
			}
		});
	}
	$(document).on("click","#repliesDiv",function(){
		getPageList(1);
	});

	$("#btnReplyAdd").click(function(){
		var writer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();
		if(writer.trim().length > 0 && replytext.trim().length > 0){
			$.ajax({
				url:"${pageContext.request.contextPath }/replies",
				type:"post",
				dataType:"text",
				data:JSON.stringify({bno:bno, replyer:writer, replytext:replytext }),
				headers:{
					"Content-Type":"application/json"
				},
				success:function(data){
					console.log(data)
					if(data=="SUCCESS"){
						alert("성공적으로 등록되었습니다.");
						getPageList(1);
						$("#newReplyWriter").val("");
						$("#newReplyText").val("");
					}
				}
			});
		}else{
			alert("작성자와 내용을 모두 입력해 주세요.");
		}
	});
	
	//댓글 수정
	$("#btnReplyMod").click(function(){
		var rno = $("#modifyModal .modal-body").attr("data-rno");
		var content = $("#modifyModal #replytext").val();
		var sendData = JSON.stringify({replytext:content});//json형태의 String으로 변형
		console.log(rno);
		
		$.ajax({
			url:"${pageContext.request.contextPath }/replies/"+rno,
			type:"put",
			dataType:"text",
			data:sendData,
			headers:{
				"Content-Type":"application/json"//@RequestBody
			},
			success:function(result){
				alert(result);
				if(result=="SUCCESS"){
					getPageList(nowPage);
					$("#modifyModal .modal-title").text("");
					$("#modifyModal #replytext").val("");
					$("#modifyModal .modal-body").attr("data-rno", "");
					$("#modifyModal").modal("hide");//modal 숨기기
				}
			}
		});			
	});
	
	$("#btnReplyDel").click(function(){
		var rno = $("#modifyModal .modal-body").attr("data-rno");
		if(confirm("댓글을 삭제하시겠습니까?")){
			deleteReply(rno);	
			$("#modifyModal .modal-title").text("");
			$("#modifyModal #replytext").val("");
			$("#modifyModal .modal-body").attr("data-rno", "");
			$("#modifyModal").modal("hide");//modal 숨기기
		}		
	});
	
	//댓글 내 modify버튼 클릭 시 
	$(document).on("click", ".btnModify", function(){		
		var $parent = $(this).parents("li.replyLi");
		var rno = $parent.attr("data-rno");
		var replytext = $parent.find("div.timeline-body").text().trim();
		
		$("#modifyModal .modal-title").text(rno);
		$("#modifyModal #replytext").val(replytext);
		$("#modifyModal .modal-body").attr("data-rno",rno);		
	});
	//아직 인식 못하는듯--확인 필요
	$(document).on("click",".btnDelete", function(){
		var $parent = $(this).parents("li.replyLi");
		var rno = $parent.attr("data-rno");
		
		if(confirm("댓글을 삭제하시겠습니까?")){
			deleteReply(rno);
		}
	});
	
	function deleteReply(rno){
		var bno  = $("#form1").find("input[name='bno']").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/replies/"+rno+"?bno="+bno,
			type:"delete",
			dataType:"text",
			async: false,
			success:function(data){
				console.log(data);
				alert(data);
				if(data=="SUCCESS"){
					getPageList(nowPage);					
				}
			}
		});
	}
	
	function setPagination(pageMaker){
		console.log(pageMaker);
		console.log(pageMaker.prev);
		var pageForm = "";
		if(pageMaker.prev){
			pageForm +='<li><a href="1" titile="첫페이지">&laquo;</a></li>';
			pageForm +='<li><a href="'+(pageMaker.startPage-pageMaker.displayPageNum)+'" title="이전 페이지">&lt;</a></li>';
		}
		for(var idx=pageMaker.startPage; idx<=pageMaker.endPage;idx++){
			if(pageMaker.cri.page==idx){
				pageForm += '<li class="active"}><a>'+idx+'</a></li>';	
				
			}else{
				pageForm += '<li><a href="'+idx+'">'+idx+'</a></li>';
			}			
		}
		
		
		if(pageMaker.next){
			pageForm += '<li><a href="'+pageMaker.endPage+1+'" title="다음 페이지">&gt;</a></li>';
			pageForm += '<li><a href="'+pageMaker.maxPage+'" title="마지막 페이지">&raquo;</a></li>';
		}
		
		$(".pagination").html(pageForm);
	}
	
	$(document).on("click",".pagination a", function(e){
		e.preventDefault();//a 태그 링크 차단 
		
		nowPage = $(this).attr("href");
		
		getPageList(nowPage);
		
	});
</script>
<%@ include file="../include/footer.jsp" %>