/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50207 "NAC.IBMNAV.RateSync"
{
    Description = 'This codeunit runs the integration exchange rate sync.';
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin

    end;
}