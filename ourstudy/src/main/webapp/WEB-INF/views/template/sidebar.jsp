<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 메인 시작 -->
 <!-- Bootstrap core CSS -->
<link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<div>
	<div class="flex-shrink-0 p-3 bg-white" style="width: 280px;">
		<a href="/"
			class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
			<svg class="bi pe-none me-2" width="30" height="24"></svg>
			<span class="fs-5 fw-semibold">OurStudy</span>
		</a>
		<ul class="list-unstyled ps-0">
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#home-collapse"
					aria-expanded="false">이용권 구매</button>
				<div class="collapse show" id="home-collapse">
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#dashboard-collapse"
					aria-expanded="false">좌석 선택</button>
				<div class="collapse show" id="home-collapse">
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#orders-collapse"
					aria-expanded="false">물품대여</button>
				<div class="collapse show" id="home-collapse">
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#account-collapse"
					aria-expanded="true">커뮤니티</button>
				<div class="collapse" id="account-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="#"
							class="link-dark d-inline-flex text-decoration-none rounded">안내사항</a></li>
						<li><a href="#" class="link-dark d-inline-flex text-decoration-none rounded">자주
								묻는 질문</a></li>
						<li><a href="#"	class="link-dark d-inline-flex text-decoration-none rounded">분실물 찾기</a></li>
						<li><a href="#"	class="link-dark d-inline-flex text-decoration-none rounded">이용후기</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#orders-collapse"
					aria-expanded="false">마이페이지</button>
			</li>
		</ul>
	</div>
</div>
<!-- 메인 끝 -->
