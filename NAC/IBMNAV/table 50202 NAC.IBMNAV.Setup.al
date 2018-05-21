

table 50202 "NAC.IBMNAV.Setup"
{
    DataPerCompany=true;
    Description = 'Contains Setup Information for Integration';

    fields
    {
        field(1;PrimaryKey;Code[10])
        {
        }
        field(10;DataBatchFileName;Text[250])
        {
            Caption='Data Batch File Name';
            
            
        }
        field(20;DataResponseFileName;Text[250])
        {
            Caption='Data Response File Name';
            
        }
        field(100;ImportMode;Option)
        {
            OptionMembers = "ImportToJournal;ImportAndPost";
            Caption='Import Mode';
        }
    }

    keys
    {
        key(PK;PrimaryKey)
        {
            Clustered = true;
        }
    }

    
}