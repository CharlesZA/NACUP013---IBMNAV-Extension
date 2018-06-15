/// This table represents the return file that gets send to IBM after processing. 
/// Field names have been keep similiar to IBM for clarity. 

table 50205 "NAC.IBMNAV.IFRET"
{
    //DataClassification = CustomerContent;
    DataPerCompany = true;
    Description = 'Represents return information sent back to IBM';
    
    fields
    {

        /// Primary Key Fields
        field(1;ID;Integer){ Description='Transaction ID';  }
        field(2;TID;Code[10]){ Description='Transaction Code'; } /// SOPI, LOPI and so forth
        field(3;SEQ;Integer){ Description='Transaction Sequence'; }

        /// Secondary Fields
        field(10;RESCD;Code[10]){ Description='Status ID'; } /// Success or Fail
        field(11;RESDS;Text[128]){ Description='Message'; } /// Success or truncated error message
        field(12;DATE;Date){ Description='Transaction Date'; }
        field(13;TIME;Time){ Description='Transaction Time'; }
        
    }

    keys
    {
        key(PK;ID,TID,SEQ)
        {
            Clustered = true;
        }
    }
}