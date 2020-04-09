({
    init: function (cmp) {
        var items = [{
            "label": "A",
            "name": "1",
            "expanded": true,
            "items": [{
                "label": "A1",
                "name": "2",
                "expanded": true,
                "items" :[{
                    "label": "AA-1",
                    "name": "3",
                    "expanded": true,
                    "items" :[]
                },{
                    "label": "AA-2",
                    "name": "4",
                    "expanded": true,
                    "items" :[]
                }]
            }]
        }, 
                     {
            "label": "B",
            "name": "5",
            "expanded": false,
            "items": [{
                "label": "B1",
                "name": "6",
                "expanded": true,
                "items" :[{
                    "label": "BB-1",
                    "name": "7",
                    "expanded": true,
                    "items" :[]
                }, {
                    "label": "BB-2",
                    "name": "8",
                    "expanded": true,
                    "items" :[]
                }]
            }]
        }, 
                     {
            "label": "C",
            "name": "9",
            "expanded": true,
            "items": [{
                "label": "C1",
                "name": "10",
                "expanded": true,
                "items" :[{
                    "label": "CC-1",
                    "name": "11",
                    "expanded": true,
                    "items" :[]
                }, {
                    "label": "CC-2",
                    "name": "12",
                    "expanded": true,
                    "items" :[]
                }]
            },{
                "label": "D",
                "name": "13",
                "expanded": false,
                "items" :[{
                    "label": "D1",
                    "name": "14",
                    "expanded": true,
                    "items" :[]
                }, {
                    "label": "D2",
                    "name": "15",
                    "expanded": true,
                    "items" :[]
                }]
            }]
        }];
        cmp.set('v.items', items);
    }
})