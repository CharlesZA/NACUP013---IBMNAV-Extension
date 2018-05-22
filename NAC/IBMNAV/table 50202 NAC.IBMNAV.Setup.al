

table 50202 "NAC.IBMNAV.Setup"
{
    DataPerCompany=true;
    DataClassification=CustomerContent;
    Description = 'Contains Setup Information for Integration';

    fields
    {
        field(1;PrimaryKey;Code[10])
        {
        }
        field(10;DataBatchFileName;Text[250])
        {
            Caption='Data Batch File Name';
            Description='This is typically a file with a dtfx extension.';
        }
        field(20;DataResponseFileName;Text[250])
        {
            Caption='Data Response File Name';
            Description='These is typically a file with a dttx extension.';
            
        }
        field(30;DataStagingPath;Text[250])
        {
            Caption='Data Staging Path';
            Description='The folder on the server where import and export files are saved.';
        }
        field(40;DataDefinitionPath;Text[250])
        {
            Caption='Data Definition Path';
            Description='The folder on the server where the iSeries dttx and dtfx files are located. No spaces';
        }
        // field(100;ImportMode;Option)
        // {
        //     OptionMembers = "ImportToJournal:ImportAndPost";
        //     Caption='Import Mode';
        //     Description='This is used for debugging purposes.';
        // }
    }

    keys
    {
        key(PK;PrimaryKey)
        {
            Clustered = true;
        }
    }

    procedure SetupDefaults();
    begin
        /// This procedure is used to default the fields.
        /// Values used here were determined during implementation
        DataStagingPath := 'E:\IBM DATA TRANSFER DATA';
        DataDefinitionPath := 'E:\IBM_DATA_TRANSFER_DEFINITIONS';
        DataBatchFileName := '<DATALIB_FILE>.dtfx';
        DataResponseFileName := '<DATALIB_FILE>.dttx';
    end;

    
}