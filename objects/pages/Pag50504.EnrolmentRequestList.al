page 50504 "Enrolment Request"
{
    ApplicationArea = All;
    Caption = 'Enrolment Request';
    PageType = List;
    SourceTable = "Enrolment Request";
    UsageCategory = Lists;
    Editable = False;

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
                    DrillDownPageId = "Course Information Card";
                    LookupPageId = "Course Information List";
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                    DrillDownPageId = "Student Information Card Page";
                    LookupPageId = "Student Information Page";
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
                field("Notification sent"; Rec."Notification sent")
                {
                    ToolTip = 'Indicates whether a notification has been sent to the student.', Comment = '%';
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
                        if ApprovalEntry."Notification sent" = false then begin
                            StudentRecord.Get(ApprovalEntry."Student No.");
                            ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                            ApprovalEntry."Approved ID" := UserId();
                            ApprovalEntry."Approval Date" := CurrentDateTime();
                            ApprovalEntry."Notification sent" := true;
                            ApprovalEntry.Modify(true);
                            Commit();

                            Body := 'Dear ' + StudentRecord."First Name" + ',<br><br><br>' +
                                   'Your enrolment request for the course ' + ApprovalEntry."Course ID" + ' has been approved.' + '<br><br><br><br>' +
                                   'Best regards,' + '<br>' +
                                   '<em>' + 'Your University Team' + '</em>';

                            EmailItem.Init();
                            EmailItem."Send to" := StudentRecord.Email;
                            EmailItem.Subject := 'Your Enrolment Request has been  Approved';
                            EmailItem.SetBodyText(Body);
                            EmailItem.Body.CreateInStream(Ins);
                            EmailItem.ID := CreateGuid();
                            EmailItem.Insert(true);
                            EmailScenario := EmailScenario::Default;
                            Email.Send(EmailItem, EmailScenario);
                        end else
                            Message('Notification email has been sent already');
                    end
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
                        if ApprovalEntry."Notification sent" = false then begin
                            StudentRecord.Get(ApprovalEntry."Student No.");
                            ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                            ApprovalEntry."Approved ID" := UserId();
                            ApprovalEntry."Approval Date" := CurrentDateTime();
                            ApprovalEntry."Notification sent" := true;
                            ApprovalEntry.Modify(true);
                            Commit();

                            Body := 'Dear ' + StudentRecord."First Name" + ',<br><br><br>' +
                                   'Your enrolment request for the course ' + ApprovalEntry."Course ID" + ' has been rejected.' + '<br><br><br><br>' +
                                   'Best regards,' + '<br>' +
                                   '<em>' + 'Your University Team' + '</em>';

                            EmailItem.Init();
                            EmailItem."Send to" := StudentRecord.Email;
                            EmailItem.Subject := 'Your Enrolment Request has been  Rejected';
                            EmailItem.SetBodyText(Body);
                            EmailItem.Body.CreateInStream(Ins);
                            EmailItem.ID := CreateGuid();
                            EmailItem.Insert(true);
                            EmailScenario := EmailScenario::Default;
                            Email.Send(EmailItem, EmailScenario);
                        end else
                            Message('Notification email has been sent already');
                    end
                end;
            }
        }
        area(Navigation)
        {
            group("Cancel")
            {
                action("Cancel Request")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        EnrolmentRequest: Record "Enrolment Request";
                        CourseInformCapacityFunctionCodeunit: Codeunit CourseInformCapacityFunction;
                    begin
                        EnrolmentRequest.SetRange("Entry No.", Rec."Entry No.");
                        if EnrolmentRequest.FindFirst() then begin
                            if EnrolmentRequest.Status = EnrolmentRequest.Status::Pending then begin
                                CourseInformCapacityFunctionCodeunit.GetCourseCapacityInfo(Rec."Course ID", Rec."Student No.");
                                EnrolmentRequest.Delete(true);
                                Message('Enrolment request has been cancelled successfully.');
                            end else
                                Error('You can only cancel requests that are still pending.');
                        end else
                            Error('Enrolment request not found.');
                    end;
                }
            }
        }
    }
}
