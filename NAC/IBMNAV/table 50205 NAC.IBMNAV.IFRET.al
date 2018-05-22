/// This table represents the return file that gets send to IBM after processing. 
/// Field names have been keep similiar to IBM for clarity. 

table 50205 "NAC.IBMNAV.IFRET"
{
    DataClassification = CustomerContent;
    DataPerCompany = FALSE;
    Description = 'Represents return information sent back to IBM';
    
    fields
    {

        /// Primary Key Fields
        field(1;IRID;Integer){ Description='Transaction ID';  }
        field(2;IRTID;Code[10]){ Description='Transaction Code'; } /// SOPI, LOPI and so forth
        field(3;IRSEQ;Integer){ Description='Transaction Sequence'; }

        /// Secondary Fields
        field(10;IRRESCD;Code[10]){ Description='Status ID'; } /// Success or Fail
        field(11;IRRESDS;Text[128]){ Description='Message'; } /// Success or truncated error message
        field(12;IRDATE;Date){ Description='Transaction Date'; }
        field(13;IRTIME;Time){ Description='Transaction Time'; }
        
    }

    keys
    {
        key(PK;IRID,IRTID,IRSEQ)
        {
            Clustered = true;
        }
    }
}