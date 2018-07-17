/// NACUP013 - Business Integrations

/// Created codeunit to assist with incoming transaction data when creating general journal lines.codeunit


codeunit 50206 "NAC.IBMNAV.TransactionHelper"
{
    Description = 'Helper codeunit for processing general journal lines';
    trigger OnRun()
    begin
        
    end;

    procedure SetAccType(accType:Code[10]):Code[20]
    begin
        /// Integration specific stuff
        if accType = 'GL' then exit('G/L Account');
        if accType = 'CUSTOMER' then exit('Customer');
        if accType = 'VENDOR' then exit('Vendor');

        exit(accType);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"NAC.IBMNAV.InsertGenJnlLine", 'OnBeforeValidateDimCode', '', false, FALSE)]
    procedure ProcessDimValue(fieldNum: Integer; valueCode: Code[20]);
        var
        DimMgt: Codeunit DimensionManagement;
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        DimCode: Code[20];
    begin
        GLSetup.get;
        Case FORMAT(FieldNum) of
            '1' :
                            DimCode := GLSetup."Shortcut Dimension 1 Code";
            '2' :
                            DimCode := GLSetup."Shortcut Dimension 2 Code"; 
            '3' :
                            DimCode := GLSetup."Shortcut Dimension 3 Code";
            '4' :
                            DimCode := GLSetup."Shortcut Dimension 4 Code";
            '5' :
                            DimCode := GLSetup."Shortcut Dimension 5 Code";
            '6' :
                           DimCode := GLSetup."Shortcut Dimension 6 Code";
            '7' :
                            DimCode := GLSetup."Shortcut Dimension 7 Code";
            '8' :
                            DimCode := GLSetup."Shortcut Dimension 8 Code";
        END;
        IF DimCode = '' THEN
            Error('Shortcut Dimension not defined for number ' + FORMAT(FieldNum));

        IF NOT DimVal.GET(DimCode, valueCode) THEN BEGIN
            DimVal.INIT;
            DimVal.VALIDATE(DimVal."Dimension Code", DimCode);
            DimVal.VALIDATE(DimVal.Code, ValueCode);
            DimVal.VALIDATE(DimVal.Name, ValueCode);
            DimVal.INSERT(TRUE);
        end;
    end;

}