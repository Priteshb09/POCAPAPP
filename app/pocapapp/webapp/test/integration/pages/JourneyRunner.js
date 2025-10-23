sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"pocapapp/test/integration/pages/POsV4List",
	"pocapapp/test/integration/pages/POsV4ObjectPage",
	"pocapapp/test/integration/pages/POItemsV4ObjectPage"
], function (JourneyRunner, POsV4List, POsV4ObjectPage, POItemsV4ObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('pocapapp') + '/test/flp.html#app-preview',
        pages: {
			onThePOsV4List: POsV4List,
			onThePOsV4ObjectPage: POsV4ObjectPage,
			onThePOItemsV4ObjectPage: POItemsV4ObjectPage
        },
        async: true
    });

    return runner;
});

