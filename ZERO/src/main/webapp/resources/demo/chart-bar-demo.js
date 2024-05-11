// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';



$.ajax({
    type: "post", 
    url: "daily_deal_count", 
    dataType: "json"
})
.done(function(data) {
    // 데이터 전처리
    const labels = data.map(item => item.transaction_date);
    const counts = data.map(item => item.transaction_count);

    // Bar Chart 그리기
    var ctx = document.getElementById("dailyDealCountChart");
    var dailyDealCountChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: "거래 수",
                backgroundColor: "rgba(2,117,216,1)",
                borderColor: "rgba(2,117,216,1)",
                data: counts,
            }],
        },
        options: {
            scales: {
                x: {
                    type: 'time', // 시간 기반의 X축
                    time: {
                        unit: 'day', // 날짜 단위로 표시
                        displayFormats: {
                            day: 'YYYY-MM-DD', // 날짜 형식
                        },
                    },
                    grid: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 10
                    }
                },
                y: {
                    min: 0,
                    max: Math.max(...counts),
                    ticks: {
                        stepSize: 1
                    },
                    grid: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                },
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
})
.fail(function() {
    alert("요청 실패!");
});



$.ajax({
    type: "post", 
    url: "daily_deal_amount", // 데이터를 가져올 엔드포인트
    dataType: "json"
})
.done(function(data) {
    // 데이터 전처리
    const labels = data.map(item => item.transaction_date);
    const amounts = data.map(item => item.total_amount);

    // Y축 최댓값 설정
    const maxValue = Math.max(...amounts);
    const yMaxValue = maxValue + (maxValue * 0.1); // 최댓값보다 약간 더 큰 값으로 설정

    // Bar Chart 그리기
    var ctx = document.getElementById("dailyTransactionChart").getContext("2d");
    var dailyTransactionChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: "거래액",
                backgroundColor: "rgba(2,117,216,1)",
                borderColor: "rgba(2,117,216,1)",
                data: amounts,
            }],
        },
        options: {
            scales: {
                x: {
                    type: 'time', // 시간 기반의 X축
                    time: {
                        unit: 'day', // 날짜 단위로 표시
                        displayFormats: {
                            day: 'YYYY-MM-DD', // 날짜 형식
                        },
                    },
                    grid: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 10
                    }
                },
                y: {
                    min: 0,
                    max: yMaxValue, // 최댓값 설정
                    ticks: {
                        stepSize: 1000, // 필요에 따라 조절
                    },
                    grid: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                },
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
})
.fail(function() {
    alert("요청 실패!");

});



 $.ajax({
    type: "post", 
    url: "daily_member_registration", // 데이터를 가져올 엔드포인트
    dataType: "json"
})
.done(function(data) {
    // 데이터 전처리
    const labels = data.map(item => item.registration_date);
    const counts = data.map(item => item.member_count);

    // Bar Chart 그리기
    var ctx = document.getElementById("dailyMemberChart").getContext("2d");
    var dailyMemberChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: "가입자 수",
                backgroundColor: "rgba(2,117,216,1)",
                borderColor: "rgba(2,117,216,1)",
                data: counts,
            }],
        },
        options: {
            scales: {
                x: {
                    type: 'time', // 시간 기반의 X축
                    time: {
                        unit: 'day', // 날짜 단위로 표시
                        displayFormats: {
                            day: 'YYYY-MM-DD', // 날짜 형식
                        },
                    },
                    grid: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 10
                    }
                },
                y: {
                    min: 0,
                    max: Math.max(...counts),
                    ticks: {
                        stepSize: 1,
                    },
                    grid: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                },
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
})
.fail(function() {
    alert("요청 실패!");
});