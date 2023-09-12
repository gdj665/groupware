/**
 * 
 */
$(document).ready(function () {	
        const x = [];
        const y1 = [];		
        const y2 = [];		
		
        // 동기호출로 x, y값을 셋팅
        $.ajax({
            url : '/group/rest/getMyWorkCheckCntList',
            type : 'get',
            success : function(model) {
                model.forEach(function(item, index){
                    // chart모델 생성
                    x.push(item.memberId);
                    y1.push(item.workCnt);
                    y2.push(item.annualCnt);
                });

                // 차트 생성
                new Chart("target2", {
                    type: "bar",
                    data: {
                        labels: x,
                        datasets: [
                            {
                                label: '근무일',
                                backgroundColor: 'rgb(255, 99, 132)',
                                data: y1
                            },
                            {
                                label: '연차 사용',
                                backgroundColor: 'rgb(132, 99, 132)',
                                data: y2
                            },
                        ]
                    },
                    options : {
                        scales : {
                            yAxes : [
                                {
                                    ticks : {
                                        beginAtZero : true,
                                        min: 0,
                                        max: 14
                                    }
                                }
                            ]
                        }
                    }
                });
            }
        });
    });