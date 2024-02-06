sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'roles/test/integration/FirstJourney',
		'roles/test/integration/pages/RolesList',
		'roles/test/integration/pages/RolesObjectPage'
    ],
    function(JourneyRunner, opaJourney, RolesList, RolesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('roles') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheRolesList: RolesList,
					onTheRolesObjectPage: RolesObjectPage
                }
            },
            opaJourney.run
        );
    }
);