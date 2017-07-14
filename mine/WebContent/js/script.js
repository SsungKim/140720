// d-day
$(document).ready( function() {
	setViewTime = function (){ //함수로 만들어 준다.
		//아래 부분 입력창에서 가져오지 않고 그냥 셋팅해도 된다.
		var getYear = 2014;
		var getMonth = 7;
		var getDay = 20;
        
		var dat1 = new Date(); //현재날짜
		var dat2 = new Date(getYear, getMonth-1, getDay); //월에서 1 빼줘야 함
    
		var diff = dat2 - dat1; //날짜 빼기
        
		var currSec = 1000; // 밀리세컨
		var currMin = 60 * 1000; // 초 * 밀리세컨
		var currHour = 60 * 60 * 1000; // 분 * 초 * 밀리세컨
		var currDay = 24 * 60 * 60 * 1000; // 시 * 분 * 초 * 밀리세컨
        
		var day = parseInt(diff/currDay); //d-day 일
		var hour = parseInt(diff/currHour); //d-day 시
		var min = parseInt(diff/currMin); //d-day 분
		var sec = parseInt(diff/currSec); //d-day 초
        
		var viewHour = (day*24)-hour;
		var viewMin = (hour*60)-min;
		var viewSec = (min*60)-sec;
        
		//시분초 말고 일까지만 보여주면 day만 노출하면 된다.
		var viewStr = day+"일 "+viewHour+"시 "+viewMin+"분 "+viewSec+"초";
		$("#day").html(-day+1);
		$("#hour").html(viewHour);
		$("#minute").html(viewMin);
		$("#second").html(viewSec);
	}
	setInterval('setViewTime()',1000);
});

// header top login slide
$(document).ready(function(){
	var topNum = 0;
	$(".login_txt").click(function(){
		var width = $(window).width();
		if(topNum==0){
			$(".login_container").css("margin-right", "0");
			topNum++;
		} else {
			if(width<750){
				$(".login_container").css("margin-right", "-315px");
			} else {
				$(".login_container").css("margin-right", "-410px");
			}
			topNum = 0;
		}
	});
});

// main slide
$(document).ready(function(){
	var slideNum = 1;
	setInterval(function(){
		$("#main_slide"+slideNum).fadeOut(500);
		slideNum++;
		if(slideNum==4){
			slideNum = 1;
		}
		$("#main_slide"+slideNum).fadeIn(500);
	}, 3000);
});

// visitors - mail clear
function mail_clear(){
	$("#mail_title").val("");
	$("#mail_mail").val("");
	$("#mail_phone").val("");
	$("#mail_content").val("");
}

// login - keydown 'enter' at login_pw
$(document).ready(function(){
	$("#login_pw").on("keydown", function(evt){
		if(evt.keyCode == 13){
			login();
		}
	});
});

// login
function login(){
	var id = $("#login_id").val();
	var pw = $("#login_pw").val();
	$.ajax({
		type : "post",
		url : "/login/"+id+"/"+pw,
		async : false,
		success : function(txt){
			if(txt){
				location.reload();
			} else {
				alert("아이디 / 비밀번호를 확인해주세요.");
			}
		}
	});
}

// logout
function logout(){
	location.href="/logout";
}

// travel - course clear
function travel_clear(){
	for(var i=1; i<=12; i++){
		$("#travel_course"+i).html("");
	}
	travel_num = 0;
}

// travel - list click
var travel_num = 0;
function travel_spot(element, contentId){
	if(travel_num == 12){
		alert("코스가 가득찼습니다.");
		return;
	}
	var listArray = new Array($("#travel_course1"), $("#travel_course2"), $("#travel_course3"), $("#travel_course4"), $("#travel_course5"),
			$("#travel_course6"), $("#travel_course7"), $("#travel_course8"), $("#travel_course9"), $("#travel_course10"),
			$("#travel_course11"), $("#travel_course12"));
	var spot = element.innerHTML;
	for(var i=0; i<listArray.length; i++){
		if(listArray[i].html() == spot){
			alert("이미 추가된 여행지입니다.");
			break;
		} else {
			if(listArray[i].html() == ""){
				if(spot.length>7){
					spot = spot.substring(0, 7)+"...";
				}
				listArray[i].html(spot);
				var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey="; 
				var serviceKey = "E6aCwnzt7GvaVyGPlnz90bCutYTfoKHWGPGINaGfrfJDy77fHN7rBpNKacZG7Cna0ctfURHJKReKGpJaWnND1w%3D%3D";
				url += serviceKey;
				url += "&MobileOS=ETC";
				url += "&MobileApp=140720";
				url += "&contentId="+contentId;
				url += "&defaultYN=Y";
				url += "&addrinfoYN=Y";
				url += "&overviewYN=Y";
				url += "&mapinfoYN=Y";
				$.ajax({
					type : "get",
					url : url,
					async : false,
					success : function(txt){
						var title = txt.getElementsByTagName("title")[0].firstChild.nodeValue;
						var addr = txt.getElementsByTagName("addr1")[0].firstChild.nodeValue;
						var mapx = txt.getElementsByTagName("mapx")[0].firstChild.nodeValue;
						var mapy = txt.getElementsByTagName("mapy")[0].firstChild.nodeValue;
						var overview = txt.getElementsByTagName("overview")[0].firstChild.nodeValue;
						$("#travel_info1").html(title);
						$("#travel_info2").html(addr);
						$("#travel_info3").html(overview);
						initMap(mapx, mapy, title);
					}
				});
				travel_num++;
				break;
			} else {
				continue;
			}
		}
	}
}

// diary - save
function diary_save(){
	var title = $("#diary_write_title").val();
	var folder = $("#diary_write_folder").val();
	if(title.length == 0){
		alert("제목을 입력해주세요.");
	} else if(folder == "choose"){
		alert("폴더를 선택해주세요.");
	} else {
		$("#diaryWriteForm").submit();
	}
}

// diary - search
function diary_search(){
	var folder = $("#diary_folder").val();
	var year = $("#diary_year").val();
	var month = $("#diary_month").val();
	if(folder == "choose"){
		alert("폴더를 선택해주세요.");
	} else {
		$.ajax({
			type : "post",
			url : "/diary/search/"+folder+"/"+year+"/"+month,
			async : false,
			success : function(txt){
				$("#diary_list_wrap").html(txt);
			}
		});
	}
}

// diary - view
function diary_view(num){
	$.ajax({
		type : "post",
		url : "/diary/view/"+num,
		async : false,
		success : function(txt){
			$("#diary_content_wrap").html(txt);
		}
	});
}

// diary - reply write
function diary_reply_submit(num){
	var reply = $("#diary_reply").val();
	if(reply.length == 0){
		alert("내용을 입력해주세요.");
	} else {
		$.ajax({
			type : "post",
			url : "/diary/reply/"+num+"/"+reply,
			async : false,
			success : function(txt){
				if(txt){
					alert("등록되었습니다.");
					location.reload();
				} else {
					alert("등록에 실패하였습니다.\n잠시후 다시 시도해주세요.");
				}
			}
		});
	}
}

// diary - modify
function diary_modify(num){
	var title = $("#diary_modify_title").val();
	var folder = $("#diary_modify_folder").val();
	if(title.length == 0){
		alert("제목을 입력해주세요.");
	} else if(folder == "choose"){
		alert("폴더를 선택해주세요.");
	} else {
		$("#diaryModifyForm").submit();
	}
}

// remove
var delete_type;
var delete_num;
function remove(type, num){
	$("#delete_popup1").show();
	$("#delete_popup2").show();
	$("body").css("overflow", "hidden");
	delete_type = type;
	delete_num = num;
}

// remove - yes
function remove_yes(){
	var url;
	switch(delete_type){
	case 'diary':
		url = "/diary/remove/";
		break;
	}
	$.ajax({
		type : "post",
		url : url+delete_num,
		async : false,
		success : function(txt){
			if(txt){
				alert("삭제되었습니다.");
			} else {
				alert("삭제에 실패하였습니다.\n잠시후 다시 시도해주세요.");
			}
			location.reload();
		}
	});
}