sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'pocapapp',
            componentId: 'POsV4List',
            contextPath: '/POsV4'
        },
        CustomPageDefinitions
    );
});