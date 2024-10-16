<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
    response.setContentType("text/html; charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    // 로그인 여부 확인
    Boolean isLoggedIn = (Boolean) request.getAttribute("isLoggedIn");
    String myPageInfo = (String) request.getAttribute("myPageInfo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/product.css" type="text/css">
<style type="text/css">

/* 헤더 스타일 */
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
	background-color: #fff;
	border-bottom: 1px solid #e0e0e0;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
	width: 98.5%;
	overflow: hidden;
}

/* 내비게이션 메뉴 */
.nav-bar {
	display: flex;
	gap: 10px;
}

.nav-bar a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	padding: 8px 12px;
	transition: background-color 0.3s, color 0.3s;
	border-radius: 5px;
}

.nav-bar a:hover {
	background-color: #f0f0f0;
	color: #007BFF;
}

/* 검색 바 */
.search-bar {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%; /* 전체 너비를 차지하도록 설정 */
	max-width: 300px; /* 검색 바의 최대 너비 */
	margin: 0 auto; /* 중앙에 위치하도록 설정 */
}

.search-bar input {
	flex-grow: 1;
	max-width: 200px; /* 검색 바의 최대 너비 */
	padding: 10px;
	border-radius: 20px;
}

.search-bar button {
	background-color: #007BFF;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.search-bar button:hover {
	background-color: #0056b3;
}

/* 유저 메뉴 */
.user-menu {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-left: auto; /* 유저 메뉴를 오른쪽 끝으로 보내기 위한 설정 */
}

.user-menu a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	transition: color 0.3s;
}

.user-menu a:hover {
	color: #007BFF;
}

#prodwrap {
	max-width: 1000px;
	margin: 0 auto;
	border: 1px solid #cdcdcd;
	padding: 30px;
}

a {
	text-decoration: none;
	font-size: 15px;
	color: #9e9e9e;
}

.pag {
	margin: 10px;
	padding: 5px;
	color: #9e9e9e;
}

#current_pag {
	margin: 10px;
	width: 30px;
	font-size: 18px;
}

#prodinfowrap {
	display: flex;
}

#collft {
	margin: 20px
}

.toCartBtn {
	display: inline-block;
	padding: 10px 20px;
	background-color: #196ab3;
	color: white;
	text-decoration: none;
	border-radius: 5px;
}

.tobuyBtn {
	display: inline-block;
	padding: 10px 20px;
	background-color: #199db3;
	color: white;
	text-decoration: none;
	border-radius: 5px;
}

#submitReviewBtn {
	background-color: #007bff; /* 버튼 배경색 */
	color: white; /* 글자색 */
	border: none; /* 테두리 제거 */
	border-radius: 5px; /* 모서리 둥글게 */
	padding: 10px 20px; /* 패딩 */
	font-size: 16px; /* 글자 크기 */
	cursor: pointer; /* 마우스 커서 변경 */
	transition: background-color 0.3s, transform 0.2s; /* 효과 전환 */
}
</style>
</head>
<body>
	<header>
		<!-- 네비게이션 바 -->
		<div class="nav-bar">
			<a href="?category=DOMESTIC">국내도서</a> <a href="?category=FOREIGN">외국도서</a>
			<a href="?category=USED">중고도서</a> <a href="?category=EBOOK">eBook</a>
			<a href="?category=CAT005">크레마클럽</a> <a href="?category=CD/LP">CD/LP</a>
		</div>

		<!-- 검색 바 -->
		<div class="search-bar">
			<input type="text" placeholder="예비중학 필수! 1등 초등 세계사">
			<button>검색</button>
		</div>

		<!-- 유저 메뉴 -->
		<div class="user-menu">
			<%
			if (isLoggedIn != null && isLoggedIn) {
			%>
			<a href="#">마이페이지</a> <a href="/BooKorn/cart">장바구니</a> <a
				href="/BooKorn/logout">로그아웃</a>
			<%
			} else {
			%>
			<a href="/BooKorn/login">로그인</a>
			<%
			}
			%>
		</div>
	</header>

	<div id="prodwrap">

		<div id="prodinfowrap">
			<div id="collft">
				<img src="${prod.product_image }" alt="상세이미지" width="200px">
			</div>
			<div id="colrgt">
				<h2>${prod.product_name }</h2>
				<p>${prod.product_author }저 | ${prod. product_company}</p>
				<h3>평균별점 : ${prod.product_grade *2}</h3>
				<hr>
				<h2>판매가 : ${prod.product_price } 원</h2>
				<div id="btnwrap">
					<a onclick="addToCart(event)" data-product-id="${prod.product_id}"
						class="toCartBtn">카트에 넣기</a> <a href="#" class="tobuyBtn">바로
						구매</a>
				</div>
			</div>
		</div>

		<hr>
		<br>
		<p>${prod.product_detail }</p>
		<br>
		<hr>
		<div id="reviewwrap">

			<h2>한줄평</h2>

			<!-- 한 줄 평 입력 영역 -->
			<div id="insertreviewarea">
				<form id="reviewForm">
					<input type="hidden" id="product_id" value="${prod.product_id}" />
					<textarea id="comment_text" rows="4" cols="50"
						placeholder="한줄평을 작성해주세요" style="resize: none;"></textarea>
					<br /> <label for="rating">평점:</label> <select id="rating">
						<option value="1">★☆☆☆☆</option>
						<option value="2">★★☆☆☆</option>
						<option value="3">★★★☆☆</option>
						<option value="4">★★★★☆</option>
						<option value="5">★★★★★</option>
					</select> <br>
					<br>
					<button type="button" id="submitReviewBtn" onclick="submitReview()">한줄평
						등록</button>
				</form>
				<br>
			</div>
			<hr>
			<!-- 한 줄 평 리스트 -->
			<div id="reviewlist"></div>

			<!-- 페이징 처리 -->
			<div id="reivewpag"></div>
		</div>



	</div>

	<script>
    // 현재 페이지 번호 저장
    var currentPage = 1;

    // 제품 ID 저장
    var product_id = $('#product_id').val();
    
    var firstLoad = true;
    
    

    // 한 줄 평 리스트와 페이징을 불러오는 함수
    function loadReviews(page) {
        $.ajax({
            url: "comments",
            method: "POST",
            data: {
               product_id: product_id,
                page: page
            },
            success: function(response) {
                // 리뷰 리스트 업데이트
                $('#reviewlist').empty();
                $.each(response.comments, function(index, comment) {
                    $('#reviewlist').append(
                        '<div class="comment">' +
                        '<p><strong>' + comment.filtered_userid + '</strong></p>' +
                        '<p>평점: ' + comment.rating*2 + '</p>' +
                        '<p>' + comment.comment_text + '</p>' +
                        '<p><small>' + comment.formatDate + '</small></p>' +
                        '</div><hr/>'
                    );
                });
                
                currentPage = response.currentPage;
            
                // 페이징 업데이트
                $('#reivewpag').empty();
                if (currentPage > 1) {
                    $('#reivewpag').append('<a href="#" onclick="loadReviews(' + (currentPage - 1) + ')">  이전  </a>');
                }

                for (var i = 1; i <= response.totalPages; i++) {
                    if (i == response.currentPage) {
                        $('#reivewpag').append('<span id="current_pag">' + i + '</span>');
                    } else {
                        $('#reivewpag').append('<a href="#" onclick="loadReviews(' + i + ')" class ="pag">' + i + '</a>');
                    }
                }

                if (currentPage < response.totalPages) {
                    $('#reivewpag').append('<a href="#" onclick="loadReviews(' + (currentPage + 1) + ')">  다음  </a>');
                }
                
                if (!firstLoad) {
                    var bottomPosition = $('#reivewpag').offset().top + $('#reivewpag').outerHeight();
                    $(window).scrollTop(bottomPosition);
                } else {
                    firstLoad = false; // 첫 로드가 완료됨
                }
            }
        });
    }

    // 첫 페이지 로드
    $(document).ready(function() {
       var bottomPosition = $('#reivewpag').offset().top + $('#reivewpag').outerHeight();
        $(window).scrollTop(bottomPosition);
        loadReviews(currentPage);
    });
   
    function submitReview() {
        var commentText = $('#comment_text').val();
        var rating = $('#rating').val();

        $.ajax({
            url: "insertcomment", // 리뷰 등록 서블릿으로 요청 보냄
            method: "POST",
            data: {
               product_id: product_id,
                comment_text: commentText,
                rating: rating
            },
            success: function(response) {
                if (response.status === "success") {
                    alert("리뷰가 등록되었습니다!");
                    $('#comment_text').val(''); // 입력 필드 초기화
                    loadReviews(currentPage);    // 현재 페이지 리뷰 다시 불러오기
                } else {
                    // 에러 메시지 처리
                    alert(response.message || "알 수 없는 오류가 발생했습니다.");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // 서버에서 오류가 발생한 경우
                alert("리뷰 등록에 실패했습니다. 다시 시도해주세요.");
            }
        });
    }
 
    
    function addToCart(event) {
        const productId = event.currentTarget.getAttribute('data-product-id'); // data-product-id에서 상품 ID 가져오기
        const data = new URLSearchParams();
        data.append('product_id', productId); // 상품 ID 추가
 

        fetch('addToCart', {
            method: 'POST',
            body: data
        })
        .then(response => {
            if (response.ok) {
 
                alert('상품이 카트에 추가되었습니다.');
                // 추가 동작이 필요하면 여기에 작성
                window.location.href = '/BooKorn/home';
            } else {
 
                alert('카트에 추가하는 데 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('오류가 발생했습니다.');
        });
    }
 
 
    
</script>

</body>
</html>