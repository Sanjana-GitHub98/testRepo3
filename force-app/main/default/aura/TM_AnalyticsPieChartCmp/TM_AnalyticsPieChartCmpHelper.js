({
    doInit : function(component, event, helper) 
    {
        var action = component.get("c.pieChartData"); 
        action.setCallback(this, function(response) { 
            var state = response.getState(); 
            if (state === "SUCCESS") { 
                var dataObj= response.getReturnValue(); 
                console.log('===='+dataObj);
                component.set("v.data",dataObj);
                helper.piechart(component,event,helper);
            } 
        });
        $A.enqueueAction(action);
    },
    piechart : function(component,event,helper) {
        var jsonData = component.get("v.data");
        var dataObj = JSON.parse(jsonData);
        
        new Highcharts.Chart({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: false,
                plotShadow: false,
                renderTo: component.find("chart").getElement(),
                type: 'pie'
            },
            title: {
                text: component.get("v.chartTitle")
            },
           // subtitle: {
             //   text: component.get("v.chartSubTitle")
            //},
            xAxis: {
                categories: component.get("v.xAxisCategories"),
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: 
                {
                    text: component.get("v.yAxisParameter")
                }
            },
            tooltip: {
                pointFormat: '{series.name}: ${point.y}B <br>{point.percentage:.1f}% of total'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    showInLegend: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false,
                        format: '<b>{point.name}</b>: {point.y} ',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                    
                }
            },
            exporting: {
                enabled: false
            },
            series: [{
                name:'Series 1',
                data:dataObj
            }]
            
        });
        
    },
    
})