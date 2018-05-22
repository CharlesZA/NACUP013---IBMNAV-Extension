/// This codeunit is responsible for installing the extension to the database.

codeunit 50299 "NAC.IBMNAV.Install"
{
    Subtype = Install;
    Description = 'Extension Install Codeunit';

    trigger OnInstallAppPerCompany()
	begin
		// Code for company related operations
	end;

	trigger OnInstallAppPerDatabase()
    var
        myAppInfo : ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(myAppInfo); // Get info about the currently executing module

        if myAppInfo.DataVersion = Version.Create(0,0,0,0) then // A 'DataVersion' of 0.0.0.0 indicates a 'fresh/new' install
            HandleFreshInstall
        else
            HandleReinstall; // If not a fresh install, then we are Re-installing the same version of the extension
    end;

    local procedure HandleFreshInstall();
    var
        IntegrationSetup:Record"NAC.IBMNAV.Setup";
        IBMTransaction:Record"NAC.IBMNAV.IBMTransactionType";
        Company:Record"Company";
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
        if Company.FindFirst() then begin
            repeat
                IntegrationSetup.ChangeCompany(Company.Name);
                IBMTransaction.ChangeCompany(Company.Name);

                IntegrationSetup.init;
                IntegrationSetup.SetupDefaults();
                IntegrationSetup.Insert(false);

                IBMTransaction.SetupDefaults(Company.Name);
            until Company.Next = 0;
        end;
    end;

    local procedure HandleReinstall();
    begin
        // Do work needed when reinstalling the same version of this extension back on this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patchup' work, for example, detecting if new 'base' records have been changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access.
    end;
   
}