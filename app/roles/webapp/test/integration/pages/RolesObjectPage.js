sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'roles',
            componentId: 'RolesObjectPage',
            contextPath: '/Roles'
        },
        CustomPageDefinitions
    );
});