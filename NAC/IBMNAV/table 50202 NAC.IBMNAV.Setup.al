

table 50202 "NAC.IBMNAV.Setup"
{
    DataPerCompany = true;
    //DataClassification=CustomerContent;
    Description = 'Contains Setup Information for Integration';

    fields
    {
        field(1; PrimaryKey; Code[10]) { }

        field(10; DataDefinitionPath; Text[250])
        {
            Caption = 'Data Definition Path';
            Description = 'The folder on the server where the iSeries dttx and dtfx files are located. No spaces';
        }
        field(11; DataDefinitionBatchFileName; Text[250])
        {
            Caption = 'Data Definition Batch File Name';
            Description = 'This is typically a file with a dtfx extension.';
        }
        field(12; DataDefinitionResponseFileName; Text[250])
        {
            Caption = 'Data Definition Response File Name';
            Description = 'These is typically a file with a dttx extension.';
        }

        field(20; DataStagingPath; Text[250])
        {
            Caption = 'Data Staging Path';
            Description = 'The folder on the server where import and export files are saved.';
        }
        field(21; DataStagingBatchFileName; Text[250])
        {
            Caption = 'Data Staging Batch File Name';
            Description = 'File name of the received from the IBM Server';
        }
        field(22; DataStagingResponseFileName; Text[250])
        {
            Caption = 'Data Staging Response File Name';
            Description = 'File name of the file to send to the IBM Server';
        }
        field(30; GenJnlTemplate; code[10])
        {
            Caption = 'General Journal Template';
            Description = 'Specify the Templated Code used for Posting';
        }
        field(31; GenJnlBatchCode; code[10])
        {
            Caption = 'General Journal Batch Code';
            Description = 'General journal batch code used for Posting';
        }

        field(50; EnableIFXRATE; Boolean)
        {
            Caption = 'Enable Exchange Rate Integration';
            Description = 'Let the IBM.NAV Integration know that this company can recieve exchange rate updates.';
        }

        field(51; IFXRateDataDefinitionFileName; Text[250])
        {
            Caption = 'IFXRATE Data Definition File Name';
            Description = 'This is typically a file with a dtfx extension.';
        }
        field(52; IFXRateDataStagingFileName; Text[250])
        {
            Caption = 'IFXRATE Data Staging File Name';
            Description = 'File name of the received from the IBM Server';
        }
        field(60; EnableIFXTHIRD; Boolean)
        {
            Caption = 'Enable Third Integration';
            Description = 'Let the IBM.NAV Integration know that this company can send cust-vend updates.';
        }

        field(61; IFXThirdDataDefinitionFileName; Text[250])
        {
            Caption = 'IFXTHIRD Data Def. Response File Name';
            Description = 'These is typically a file with a dttx extension.';
        }
        field(62; IFXThirdDataResponseFileName; Text[250])
        {
            Caption = 'IFXTHIRD Data Response File Name';
            Description = 'File name of the file to send to the IBM Server';
        }

        // field(100;ImportMode;Option)
        // {
        //     OptionMembers = "ImportToJournal:ImportAndPost";
        //     Caption='Import Mode';
        //     Description='This is used for debugging purposes.';
        // }

        field(200; Locked; Boolean)
        {
            Caption = 'Locked';
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        TestField(Locked, false);
    end;

    procedure SetupDefaults();
    begin
        /// This procedure is used to default the fields.
        /// Values used here were determined during implementation
        DataDefinitionPath := 'E:\IBM_DATA_TRANSFER_DEFINITIONS';
        DataDefinitionBatchFileName := '<DATALIB_FILE>.dtfx';
        DataDefinitionResponseFileName := '<DATALIB_FILE>.dttx';

        DataStagingPath := 'E:\IBM DATA TRANSFER DATA';
        DataStagingBatchFileName := '<DATALIB_FILE>.txt';
        DataStagingResponseFileName := '<DATALIB_FILE>.txt';

        GenJnlTemplate := 'GENERAL';
        GenJnlBatchCode := 'IBMNAV';
    end;


}