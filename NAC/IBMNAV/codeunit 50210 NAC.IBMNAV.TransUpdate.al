// This codeunit is used to update existing transaction data from the history

codeunit 50210 "NAC.IBMNAV.TransUpdate"
{
    Permissions = tabledata "G/L Entry"=m;
    trigger OnRun()
    begin
        if Confirm('Do you want to update extended tables with transaction history information?\\This will take a moment to run through.') then begin
            UpdateGLEntries();
            UpdateCustEntries();
            UpdateVendEntries();
        end;
    end;

    local procedure UpdateGLEntries()
    var
        EntryTable: Record "G/L Entry";
        History: Record "NAC.IBMNAV.TransactionEntry";
        Window: Dialog;
        iCounter: Integer;
    begin
        Window.Open('Updating Table #1############\\Progress #2###### of #3######');
        Window.Update(1, EntryTable.TableCaption());
        Window.Update(3, EntryTable.Count());
        if EntryTable.FindFirst() then begin
            repeat
                iCounter += 1;
                Window.Update(2, iCounter);
                if EntryTable."NAC.IBMNAV Transaction No." <> 0 then begin
                    if History.get(EntryTable."NAC.IBMNAV Transaction No.", EntryTable."NAC.IBMNAV Transaction Code", EntryTable."NAC.IBMNAV Sequence No.") then begin
                        // Update information here
                        EntryTable.TC := History.TC;
                        EntryTable.DIM1 := History.DIM1;
                        EntryTable.DIM2 := History.DIM2;
                        EntryTable.DIM3 := History.DIM3;
                        EntryTable.DIM4 := History.DIM4;
                        EntryTable.DIM5 := History.DIM5;
                        EntryTable.DIM6 := History.DIM6;
                        EntryTable.DIM7 := History.DIM7;
                        EntryTable.DIM8 := History.DIM8;

                        EntryTable.DOCNO := History.DOCNO;
                        EntryTable.ENV := History.ENV;
                        EntryTable.POSTDAT := History.POSTDAT;
                        EntryTable.DOCDAT := History.DOCDAT;
                        EntryTable.DOCTYP := History.DOCTYP;

                        EntryTable.ACCTNO := History.ACCTNO;
                        EntryTable.ACCTYP := History.ACCTYP;
                        EntryTable.TRND := History.TRND;
                        EntryTable.EXTDOC := History.EXTDOC;

                        EntryTable.CURR := History.CURR;
                        EntryTable.XRATE := History.XRATE;
                        EntryTable.VALUE := History.VALUE;
                        EntryTable.VATGRP := History.VATGRP;

                        EntryTable.TUSER := History.TUSER;
                        EntryTable.TDATE := History.TDATE;
                        EntryTable.TTIME := History.TTIME;

                        EntryTable.PDF := History.PDF;

                        EntryTable.ERR := History.ERR;
                        EntryTable.RESCD := History.RESCD;

                        EntryTable.Modify(false);
                    end;
                end;
            until EntryTable.next() = 0;
        end;
        Window.Close();
    end;

    local procedure UpdateVendEntries()
    var
        EntryTable: Record "Vendor Ledger Entry";
        History: Record "NAC.IBMNAV.TransactionEntry";
        Window: Dialog;
        iCounter: Integer;
    begin
        Window.Open('Updating Table #1############\\Progress #2###### of #3######');
        Window.Update(1, EntryTable.TableCaption());
        Window.Update(3, EntryTable.Count());
        if EntryTable.FindFirst() then begin
            repeat
                iCounter += 1;
                Window.Update(2, iCounter);
                if EntryTable."NAC.IBMNAV Transaction No." <> 0 then begin
                    if History.get(EntryTable."NAC.IBMNAV Transaction No.", EntryTable."NAC.IBMNAV Transaction Code", EntryTable."NAC.IBMNAV Sequence No.") then begin
                        // Update information here
                        EntryTable.TC := History.TC;
                        EntryTable.DIM1 := History.DIM1;
                        EntryTable.DIM2 := History.DIM2;
                        EntryTable.DIM3 := History.DIM3;
                        EntryTable.DIM4 := History.DIM4;
                        EntryTable.DIM5 := History.DIM5;
                        EntryTable.DIM6 := History.DIM6;
                        EntryTable.DIM7 := History.DIM7;
                        EntryTable.DIM8 := History.DIM8;

                        EntryTable.DOCNO := History.DOCNO;
                        EntryTable.ENV := History.ENV;
                        EntryTable.POSTDAT := History.POSTDAT;
                        EntryTable.DOCDAT := History.DOCDAT;
                        EntryTable.DOCTYP := History.DOCTYP;

                        EntryTable.ACCTNO := History.ACCTNO;
                        EntryTable.ACCTYP := History.ACCTYP;
                        EntryTable.TRND := History.TRND;
                        EntryTable.EXTDOC := History.EXTDOC;

                        EntryTable.CURR := History.CURR;
                        EntryTable.XRATE := History.XRATE;
                        EntryTable.VALUE := History.VALUE;
                        EntryTable.VATGRP := History.VATGRP;

                        EntryTable.TUSER := History.TUSER;
                        EntryTable.TDATE := History.TDATE;
                        EntryTable.TTIME := History.TTIME;

                        EntryTable.PDF := History.PDF;

                        EntryTable.ERR := History.ERR;
                        EntryTable.RESCD := History.RESCD;

                        EntryTable.Modify(false);
                    end;
                end;
            until EntryTable.next() = 0;
        end;
        Window.Close();
    end;

    local procedure UpdateCustEntries()
    var
        EntryTable: Record "Cust. Ledger Entry";
        History: Record "NAC.IBMNAV.TransactionEntry";
        Window: Dialog;
        iCounter: Integer;
    begin
        Window.Open('Updating Table #1############\\Progress #2###### of #3######');
        Window.Update(1, EntryTable.TableCaption());
        Window.Update(3, EntryTable.Count());
        if EntryTable.FindFirst() then begin
            repeat
                iCounter += 1;
                Window.Update(2, iCounter);
                if EntryTable."NAC.IBMNAV Transaction No." <> 0 then begin
                    if History.get(EntryTable."NAC.IBMNAV Transaction No.", EntryTable."NAC.IBMNAV Transaction Code", EntryTable."NAC.IBMNAV Sequence No.") then begin
                        // Update information here
                        EntryTable.TC := History.TC;
                        EntryTable.DIM1 := History.DIM1;
                        EntryTable.DIM2 := History.DIM2;
                        EntryTable.DIM3 := History.DIM3;
                        EntryTable.DIM4 := History.DIM4;
                        EntryTable.DIM5 := History.DIM5;
                        EntryTable.DIM6 := History.DIM6;
                        EntryTable.DIM7 := History.DIM7;
                        EntryTable.DIM8 := History.DIM8;

                        EntryTable.DOCNO := History.DOCNO;
                        EntryTable.ENV := History.ENV;
                        EntryTable.POSTDAT := History.POSTDAT;
                        EntryTable.DOCDAT := History.DOCDAT;
                        EntryTable.DOCTYP := History.DOCTYP;

                        EntryTable.ACCTNO := History.ACCTNO;
                        EntryTable.ACCTYP := History.ACCTYP;
                        EntryTable.TRND := History.TRND;
                        EntryTable.EXTDOC := History.EXTDOC;

                        EntryTable.CURR := History.CURR;
                        EntryTable.XRATE := History.XRATE;
                        EntryTable.VALUE := History.VALUE;
                        EntryTable.VATGRP := History.VATGRP;

                        EntryTable.TUSER := History.TUSER;
                        EntryTable.TDATE := History.TDATE;
                        EntryTable.TTIME := History.TTIME;

                        EntryTable.PDF := History.PDF;

                        EntryTable.ERR := History.ERR;
                        EntryTable.RESCD := History.RESCD;

                        EntryTable.Modify(false);
                    end;
                end;
            until EntryTable.next() = 0;
        end;
        Window.Close();
    end;
}