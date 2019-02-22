/// This codeunit used as a fail codeunit to insert general journal lines for NAC.IBMNAV 

codeunit 50204 "NAC.IBMNAV.InsertGenJnlLine"
{
    TableNo = "NAC.IBMNAV.IFBAT";

    var
        genJnlLine: Record "Gen. Journal Line";
        iBMNAVSetup: Record "NAC.IBMNAV.Setup";
        gLSetup: Record "General Ledger Setup";
        sourceCodeSetup: Record "Source Code Setup";
        transactionHelper: Codeunit "NAC.IBMNAV.TransactionHelper";

    trigger OnRun()
    begin
        iBMNAVSetup.get;
        gLSetup.get;
        sourceCodeSetup.get;

        genJnlLine.init;
        genJnlLine."Journal Template Name" := iBMNAVSetup.GenJnlTemplate;
        genJnlLine."Journal Batch Name" := iBMNAVSetup.GenJnlBatchCode;
        ;
        genJnlLine."Line No." := rec.SEQ;
        genJnlLine.Insert;

        genJnlLine.SetHideValidation(true);

        genJnlLine."NAC.IBMNAV Sequence No." := rec.SEQ;
        genJnlLine."NAC.IBMNAV Transaction Code" := rec.TID;
        genJnlLine."NAC.IBMNAV Transaction No." := rec.ID;

        genJnlLine."Source Code" := sourceCodeSetup."NAC.IBMNAV";
        genJnlLine."System-Created Entry" := true;

        /// Add validation fields here.
        Evaluate(genJnlLine."Document Type", Rec.DOCTYP);
        genJnlLine.validate("Document Type");

        genJnlLine.Validate("Document No.", rec.DOCNO);

        genJnlLine.Validate("Posting Date", rec.POSTDAT);
        genJnlLine.Validate("Document Date", rec.DOCDAT);

        Evaluate(genJnlLine."Account Type", transactionHelper.SetAccType(rec.ACCTYP));
        genJnlLine.Validate("Account Type");

        genJnlLine.Validate("Account No.", rec.ACCTNO);

        IF genJnlLine."Document Type" in [genJnlLine."Document Type"::"Credit Memo", genJnlLine."Document Type"::Invoice] then begin
            genJnlLine.Validate("External Document No.", rec.DOCNO);
        end
        else begin
            genJnlLine.Validate("External Document No.", rec.EXTDOC);
        end;

        genJnlLine.Validate(Description, rec.TRND);

        if rec.CURR <> '' then begin
            if rec.CURR <> gLSetup."LCY Code" then begin
                genJnlLine.Validate("Currency Code", rec.CURR);
                if (rec.XRATE <> 0) then begin
                    genJnlLine.Validate("Currency Factor", 1 / rec.XRATE);
                end;
            end;
        end;

        genJnlLine.Validate(Amount, rec.VALUE);

        /// The VAT Product Posting Group       ----    
        IF genJnlLine."Document Type" in [genJnlLine."Document Type"::"Credit Memo", genJnlLine."Document Type"::Invoice] then begin
            if genJnlLine."Account Type" = genJnlLine."Account Type"::"G/L Account" then begin
                if IsThisASalesTransaction() then begin
                    genJnlLine.Validate("Gen. Posting Type", genJnlLine."Gen. Posting Type"::Sale);
                end
                else begin
                    genJnlLine.Validate("Gen. Posting Type", genJnlLine."Gen. Posting Type"::Purchase);
                end;
                genJnlLine.Validate("Gen. Bus. Posting Group", GetBusinessPostingGroup());
                genJnlLine.Validate("VAT Bus. Posting Group", GetVATBusinessPostingGroup());
            end;
            genJnlLine.Validate("VAT Prod. Posting Group", rec.VATGRP);
        end
        else begin
            // Ensure VAT and Business are blank for plane general journal
            genJnlLine."Gen. Posting Type" := genJnlLine."Gen. Posting Type"::" ";
            genJnlLine."Gen. Bus. Posting Group" := '';
            genJnlLine."Gen. Prod. Posting Group" := '';
            genJnlLine."VAT Bus. Posting Group" := '';
            genJnlLine."VAT Prod. Posting Group" := '';
        end;


        genJnlLine.Modify();



        /// Dimensions
        if rec.DIM1 <> '' then if gLSetup."Shortcut Dimension 1 Code" <> '' then begin
                OnBeforeValidateDimCode(1, rec.DIM1);
                genJnlLine.validate("Shortcut Dimension 1 Code", rec.DIM1);
                //genJnlLine.Modify();
            end;

        if rec.DIM2 <> '' then if gLSetup."Shortcut Dimension 2 Code" <> '' then begin
                OnBeforeValidateDimCode(2, rec.DIM2);
                genJnlLine.validate("Shortcut Dimension 2 Code", rec.DIM2);
                //genJnlLine.Modify();
            end;

        if rec.DIM3 <> '' then if gLSetup."Shortcut Dimension 3 Code" <> '' then begin
                OnBeforeValidateDimCode(3, rec.DIM3);
                genJnlLine.ValidateShortcutDimCode(3, rec.DIM3);
                //genJnlLine.Modify();
            end;
        if rec.DIM4 <> '' then if gLSetup."Shortcut Dimension 4 Code" <> '' then begin
                OnBeforeValidateDimCode(4, rec.DIM4);
                genJnlLine.ValidateShortcutDimCode(4, rec.DIM4);
                //genJnlLine.Modify();
            end;
        if rec.DIM5 <> '' then if gLSetup."Shortcut Dimension 5 Code" <> '' then begin
                OnBeforeValidateDimCode(5, rec.DIM5);
                genJnlLine.ValidateShortcutDimCode(5, rec.DIM5);
                //genJnlLine.Modify();
            end;
        if rec.DIM6 <> '' then if gLSetup."Shortcut Dimension 6 Code" <> '' then begin
                OnBeforeValidateDimCode(6, rec.DIM6);
                genJnlLine.ValidateShortcutDimCode(6, rec.DIM6);
                //genJnlLine.Modify();
            end;
        if rec.DIM7 <> '' then if gLSetup."Shortcut Dimension 7 Code" <> '' then begin
                OnBeforeValidateDimCode(7, rec.DIM7);
                genJnlLine.ValidateShortcutDimCode(7, rec.DIM7);
                //genJnlLine.Modify();
            end;
        if rec.DIM8 <> '' then if gLSetup."Shortcut Dimension 8 Code" <> '' then begin
                OnBeforeValidateDimCode(8, rec.DIM8);
                genJnlLine.ValidateShortcutDimCode(8, rec.DIM8);
                //genJnlLine.Modify();
            end;


        genJnlLine.Modify();

        /// The Sales/Purchase LCY for Reporting       ----    
        IF genJnlLine."Document Type" in [genJnlLine."Document Type"::"Credit Memo", genJnlLine."Document Type"::Invoice] then begin
            if genJnlLine."Account Type" = genJnlLine."Account Type"::"G/L Account" then begin
                UpdateSalesPurchLCY(genJnlLine."VAT Amount (LCY)");
            end;
        end

    end;

    /// Created function to determine sales or purchase
    local procedure IsThisASalesTransaction(): Boolean
    var
        _genJnlLine: Record "Gen. Journal Line";
    begin
        iBMNAVSetup.get;
        _genJnlLine.SetRange("Journal Template Name", iBMNAVSetup.GenJnlTemplate);
        _genJnlLine.SetRange("Journal Batch Name", iBMNAVSetup.GenJnlBatchCode);
        _genJnlLine.SetFilter("Document Type", '%1|%2', _genJnlLine."Document Type"::Invoice, _genJnlLine."Document Type"::"Credit Memo");
        _genJnlLine.SetFilter("Account Type", '%1|%2', _genJnlLine."Account Type"::Customer, _genJnlLine."Account Type"::Vendor);

        if _genJnlLine.IsEmpty() then exit(false);

        _genJnlLine.FindFirst();
        // Get the info from the customer/vendor
        if _genJnlLine."Account Type" = _genJnlLine."Account Type"::Customer then begin
            exit(true);
        end;
        if _genJnlLine."Account Type" = _genJnlLine."Account Type"::Vendor then begin
            exit(false);
        end;
    end;

    /// Created function to return the correct business posting group for invoices and credit memos
    local procedure GetBusinessPostingGroup(): Code[20]
    var
        _genJnlLine: Record "Gen. Journal Line";
        cust: Record Customer;
        vend: Record Vendor;
    begin
        iBMNAVSetup.get;
        _genJnlLine.SetRange("Journal Template Name", iBMNAVSetup.GenJnlTemplate);
        _genJnlLine.SetRange("Journal Batch Name", iBMNAVSetup.GenJnlBatchCode);
        _genJnlLine.SetFilter("Document Type", '%1|%2', _genJnlLine."Document Type"::Invoice, _genJnlLine."Document Type"::"Credit Memo");
        _genJnlLine.SetFilter("Account Type", '%1|%2', _genJnlLine."Account Type"::Customer, _genJnlLine."Account Type"::Vendor);

        if _genJnlLine.IsEmpty() then exit('');

        _genJnlLine.FindFirst();
        // Get the info from the customer/vendor
        if _genJnlLine."Account Type" = _genJnlLine."Account Type"::Customer then begin
            if cust.get(_genJnlLine."Account No.") then begin
                exit(cust."Gen. Bus. Posting Group");
            end;
        end;
        if _genJnlLine."Account Type" = _genJnlLine."Account Type"::Vendor then begin
            if vend.get(_genJnlLine."Account No.") then begin
                exit(vend."Gen. Bus. Posting Group");
            end;
        end;
        exit(_genJnlLine."Gen. Bus. Posting Group");
    end;

    /// Created function to return the correct VAT business posting group for invoices and credit memos
    local procedure GetVATBusinessPostingGroup(): Code[20]
    var
        _genJnlLine: Record "Gen. Journal Line";
        cust: Record Customer;
        vend: Record Vendor;
    begin
        iBMNAVSetup.get;
        _genJnlLine.SetRange("Journal Template Name", iBMNAVSetup.GenJnlTemplate);
        _genJnlLine.SetRange("Journal Batch Name", iBMNAVSetup.GenJnlBatchCode);
        _genJnlLine.SetFilter("Document Type", '%1|%2', _genJnlLine."Document Type"::Invoice, _genJnlLine."Document Type"::"Credit Memo");
        _genJnlLine.SetFilter("Account Type", '%1|%2', _genJnlLine."Account Type"::Customer, _genJnlLine."Account Type"::Vendor);

        if _genJnlLine.IsEmpty() then exit('');

        _genJnlLine.FindFirst();
        // Get the info from the customer/vendor
        if _genJnlLine."Account Type" = _genJnlLine."Account Type"::Customer then begin
            if cust.get(_genJnlLine."Account No.") then begin
                exit(cust."VAT Bus. Posting Group");
            end;
        end;
        if _genJnlLine."Account Type" = _genJnlLine."Account Type"::Vendor then begin
            if vend.get(_genJnlLine."Account No.") then begin
                exit(vend."VAT Bus. Posting Group");
            end;
        end;
        exit(_genJnlLine."VAT Bus. Posting Group");
    end;


    /// Update Sales/Purchase(LCY) on Customer/Vendor journal line
    local procedure UpdateSalesPurchLCY(VATAmount: Decimal)
    var
        _genJnlLine: Record "Gen. Journal Line";
    begin
        iBMNAVSetup.get;
        _genJnlLine.SetRange("Journal Template Name", iBMNAVSetup.GenJnlTemplate);
        _genJnlLine.SetRange("Journal Batch Name", iBMNAVSetup.GenJnlBatchCode);
        _genJnlLine.SetFilter("Document Type", '%1|%2', _genJnlLine."Document Type"::Invoice, _genJnlLine."Document Type"::"Credit Memo");
        _genJnlLine.SetFilter("Account Type", '%1|%2', _genJnlLine."Account Type"::Customer, _genJnlLine."Account Type"::Vendor);

        if _genJnlLine.IsEmpty() then exit;

        _genJnlLine.FindFirst();

        if (_genJnlLine."Sales/Purch. (LCY)" = 0) then begin
            _genJnlLine."Sales/Purch. (LCY)" := _genJnlLine."Amount (LCY)";
        end;

        _genJnlLine."Sales/Purch. (LCY)" += VATAmount;
        _genJnlLine.Modify();

    end;

    /// Created event to take action on missing dimension values
    [IntegrationEvent(false, false)]
    procedure OnBeforeValidateDimCode(fieldNum: Integer; valueCode: Code[20]);
    begin
    end;
}