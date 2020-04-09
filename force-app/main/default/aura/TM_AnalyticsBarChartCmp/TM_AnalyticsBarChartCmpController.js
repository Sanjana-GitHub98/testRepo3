({
    doInit: function(cmp, event, helper) {
        // Call Chart data
        var temp = [];
        var action = cmp.get("c.getBarChartData");
        action.setCallback(this, function(response){ 
            if(response.getState() === 'SUCCESS' && response.getReturnValue()){
                temp = JSON.parse(response.getReturnValue()); 
            } 
            var dict = []; 
            
            for(var a=0; a< temp.length; a++){ 
                dict.push({
                    name: temp[a]["year"],
                    y: temp[a]["Value"]
                });
            } 
            
            
            Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'TOTAL OBLIGATIONS'
                },
                
                xAxis: {
                    type: 'category',
                    title: {
                        text: 'Fiscal Year'
                    }
                },
                yAxis: {
                    title: {
                        text: 'DOLLARSE OBLICATED'
                    }
                    
                },
                legend: {
                    enabled: false
                },
                plotOptions: {
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            format: '${point.y:.1f}B'
                        }
                    }
                },
                
                tooltip: {
                    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                    pointFormat: '<span style="color:{point.color}">{point.name}<br></span>DOLLARSE OBLICATED: <b>${point.y:.2f}B</b><br/>'
                },
                exporting: {
                    enabled: false
                },
                "series": [
                    {
                        "name": "FY",
                        "colorByPoint": true,
                        "data":dict
                    }
                ],
                
            });
        });
        
        $A.enqueueAction(action);
        
    },
    
})