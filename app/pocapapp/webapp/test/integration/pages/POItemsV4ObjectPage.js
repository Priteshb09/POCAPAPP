sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'pocapapp',
            componentId: 'POItemsV4ObjectPage',
            contextPath: '/POsV4/Items'
        },
        CustomPageDefinitions
    );
});