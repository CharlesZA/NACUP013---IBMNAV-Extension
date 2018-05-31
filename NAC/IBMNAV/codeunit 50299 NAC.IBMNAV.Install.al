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
        integrationSetup:Record"NAC.IBMNAV.Setup";
        TransactionType:Record"NAC.IBMNAV.TransactionType";
        sourceCode:Record"Source Code";
        sourceCodeSetup:Record"Source Code Setup";
        company:Record"Company";
        genJnlBatch:Record"Gen. Journal Batch";
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
        if company.FindFirst() then begin
            repeat

                integrationSetup.ChangeCompany(company.Name);              
                integrationSetup.init;
                integrationSetup.SetupDefaults();
                integrationSetup.Insert(false);

                TransactionType.ChangeCompany(company.Name);
                TransactionType.SetupDefaults(company.Name);

                sourceCode.ChangeCompany(company.Name);
                sourceCode.Init;
                sourceCode.Code := 'NAC.IBMNAV';
                sourceCode.Description := 'NAC.IBMNAV Transactions';
                if sourceCode.Insert(false) then begin end;

                sourceCodeSetup.ChangeCompany(company.Name);
                if sourceCodeSetup.get() then begin
                    sourceCodeSetup."NAC.IBMNAV" := 'NAC.IBMNAV';
                    sourceCodeSetup.Modify(false);
                end;

                genJnlBatch.ChangeCompany(company.Name);
                if genJnlBatch.Get('GENERAL','IBMNAV') = false then begin
                    genJnlBatch.init;
                    genJnlBatch."Journal Template Name" := 'GENERAL';
                    genJnlBatch.Name := 'IBMNAV';
                    genJnlBatch.Description := 'NAC.IBMNAV Transactions';
                    genJnlBatch.Insert(FALSE);
                end;
            until company.Next = 0;
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