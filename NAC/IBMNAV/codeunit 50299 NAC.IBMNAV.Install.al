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
        TransactionType:Record"NAC.IBMNAV.TransactionType";
        SourceCode:Record"Source Code";
        SourceCodeSetup:Record"Source Code Setup";
        Company:Record"Company";
        GenJnlBatch:Record"Gen. Journal Batch";
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
        if Company.FindFirst() then begin
            repeat

                IntegrationSetup.ChangeCompany(Company.Name);              
                IntegrationSetup.init;
                IntegrationSetup.SetupDefaults();
                IntegrationSetup.Insert(false);

                TransactionType.ChangeCompany(Company.Name);
                TransactionType.SetupDefaults(Company.Name);

                SourceCode.ChangeCompany(Company.Name);
                SourceCode.Init;
                SourceCode.Code := 'NAC.IBMNAV';
                SourceCode.Description := 'NAC.IBMNAV Transactions';
                if SourceCode.Insert(false) then begin end;

                SourceCodeSetup.ChangeCompany(Company.Name);
                if SourceCodeSetup.get() then begin
                    SourceCodeSetup."NAC.IBMNAV" := 'NAC.IBMNAV';
                    SourceCodeSetup.Modify(false);
                end;

                GenJnlBatch.ChangeCompany(Company.Name);
                if GenJnlBatch.Get('GENERAL','IBMNAV') = false then begin
                    GenJnlBatch.init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'IBMNAV';
                    GenJnlBatch.Description := 'NAC.IBMNAV Transactions';
                    GenJnlBatch.Insert(FALSE);
                end;
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