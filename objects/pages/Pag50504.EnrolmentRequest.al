page 50504 "Enrolment Request"
{
    ApplicationArea = All;
    Caption = 'Enrolment Request';
    PageType = List;
    SourceTable = "Enrolment Request";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Course ID"; Rec."Course ID")
                {
                    ToolTip = 'Specifies the value of the Course ID field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.', Comment = '%';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approval Date field.', Comment = '%';
                }
                field("Approved ID"; Rec."Approved ID")
                {
                    ToolTip = 'Specifies the value of the Approved ID field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';


                trigger OnAction()
                var
                    ApprovalEntry: Record "Enrolment Request";
                    StudentRecord: Record "Student Information";
                    MailMessage: Codeunit "Email Message";
                    Email: Codeunit "Mail Management";
                    EmailItem: Record "Email Item";
                    EmailScenario: Enum "Email Scenario";
                    TempBlob: Codeunit "Temp Blob";
                    Body: Text;
                    Ins: InStream;
                begin
                    ApprovalEntry.SetRange("Entry No.", Rec."Entry No.");
                    if ApprovalEntry.FindFirst() then begin
                        StudentRecord.Get(ApprovalEntry."Student No.");
                        ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                        ApprovalEntry."Approved ID" := UserId();
                        ApprovalEntry."Approval Date" := CurrentDateTime();
                        ApprovalEntry.Modify(true);
                        Commit();

                        Body := 'Dear ' + StudentRecord."First Name" + ',' + '\n' +
                               'Your enrolment request for the course ' + ApprovalEntry."Course ID" + ' has been approved.' + '\n' +
                               'Best regards,' + '\n' +
                               'Your Team';
                        TempBlob.CreateOutStream().WriteText(Body);
                        TempBlob.CreateInStream(Ins);

                        EmailItem.Init();
                        EmailItem."Send to" := StudentRecord.Email;
                        EmailItem.Subject := 'Your Enrolment Request has been  Approved';
                        EmailItem.Body.CreateInStream(Ins);
                        EmailItem.Insert(true);
                        EmailScenario := EmailScenario::Default;
                        Email.Send(EmailItem, EmailScenario);
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Enrolment Request";
                begin
                    ApprovalEntry.SetRange("Entry No.", Rec."Entry No.");
                    if ApprovalEntry.FindFirst() then begin
                        ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                        ApprovalEntry."Approved ID" := UserId();
                        ApprovalEntry."Approval Date" := CurrentDateTime();
                        ApprovalEntry.Modify(true);
                        Commit();
                    end;
                end;
            }
        }
    }
}
