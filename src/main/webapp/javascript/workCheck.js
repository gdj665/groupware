/**
 * 
 */
$(document).ready(function(){	
		
		const x = [];
		const y1 = [];
		const y2 = [];
		const y3 = [];
		
		
		// 동기호출로 x,y값을 셋팅
		$.ajax({
			async : false, // true(비동기:기본값), false(동기)
			url : '/group/member/restWorkCheckList',
			data : {targetMonth : $("#targetMonth").val(),
					targetYear : $("#targetYear").val()}, 
			type : 'get',
			success : function(model) {
				
				model.forEach(function(item, index){
					let member = item.memberId + '(' + item.memberName + ')' 
					// chart모델 생성
					x.push(member);
					y1.push(item.workBeginLate);
					y2.push(item.workEndFast);
					y3.push(item.useAnnual);
					
				});

			}
		});

		new Chart("target2", {
		  type: "bar",
		  data: {
		    labels: x, // 사원 번호
		    datasets: [
		    {
		    	label: '지각', // 작은 분류
		    	backgroundColor: 'rgb(255, 99, 132)', // 바 색상
                data: y1 // 들어갈 데이터
		    },
		    {
		    	label: '조퇴',
		    	backgroundColor: 'rgb(99, 99, 132)',
                data: y2
		    },
		    {
		    	label: '연차',
		    	backgroundColor: 'rgb(132, 99, 132)',
                data: y3
		    },
		    ]
		  },
		  options : {
			  scales : {
				  yAxes : [
					  {tics : {
						  beginAtZero : true
					  }}
				  ]
			  }
		  
		  }
		});
	});