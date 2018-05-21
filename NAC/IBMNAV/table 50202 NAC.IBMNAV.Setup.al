

table 50202 "NAC.IBMNAV.Setup"
{
    DataPerCompany=false;
    Description = 'Contains Setup Information for Integration';

    fields
    {
        field(1;PrimaryKey;Code[10])
        {
        }
        field(10;DataBatchFileName;Text[250])
        {
            
        }
        field(20;DataResponseFileName;Text[250])
        {
            
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