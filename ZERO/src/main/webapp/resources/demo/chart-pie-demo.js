// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';



$.ajax({
    type: "post", 
    url: "secondhand_auction_deal_ratio", 
    dataType: "json"
})
.done(function(data) {
    // Pie Chart를 그리기 위한 데이터 전처리
    const labels = Object.keys(data);
    const values = Object.values(data);

    // Pie Chart 그리기
    var ctx = document.getElementById("secondhandAuctionDealRatioChart");
    var secondhandAuctionDealRatioChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: values,
                backgroundColor: ['#ffb3ba', '#ffdfba', '#ffffba', '#baffc9'],
            }],
        },
    });

})
.fail(function() {
    alert("요청 실패!");
});