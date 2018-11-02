/// This codeunit is designed to be setup on the Job Queue system. 


codeunit 50208 "NAC.IBMNAV.ThridSync"
{
    Description = 'This codeunit runs the integration for customer and vendor sync.';
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin

    end;
}