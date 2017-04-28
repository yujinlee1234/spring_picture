<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">REGISTER PAGE</h3>
				</div>
				<div class="box-body">
					<form role="form" action="${pageContext.request.contextPath }/picture/add" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>Image File</label>
							<input type="file" name="imagefiles" multiple="multiple" class="form-control">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">사진 추가</button>
							<button type="reset" class="btn btn-primary">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>