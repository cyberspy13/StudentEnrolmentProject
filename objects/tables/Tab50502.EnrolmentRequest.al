table 50502 "Enrolment Request"
{
    Caption = 'Enrolment Request';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Information"."Student No";
        }
        field(3; "Course ID"; Code[20])
        {
            Caption = 'Course ID';
            TableRelation = "Course Information"."Course ID";
        }
        field(4; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(5; Status; Enum "EnrolmentStatus")
        {
            Caption = 'Status';
        }
        field(6; "Approved ID"; Code[20])
        {
            Caption = 'Approved ID';
        }
        field(7; "Approval Date"; DateTime)
        {
            Caption = 'Approval Date';
        }
        field(8; "Notification sent"; Boolean)
        {
            Caption = 'Notification sent';
            ToolTip = 'Indicates whether a notification has been sent to the student.';
            InitValue = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(FK; "Student No.", "Course ID")
        {
            Clustered = false;
        }
    }
    procedure CheckStatus(StudentNo: Code[20])
    var
        EnrolmentRequest: Record "Enrolment Request";
        EnrolmentRequestPage: Page "Enrolment Request";
    begin
        EnrolmentRequest.SetRange("Student No.", StudentNo);
        EnrolmentRequest.SetRange(Status, EnrolmentRequest.Status::Pending);
        if not EnrolmentRequest.FindFirst() then
            Error('No pending enrolment requests found for student %1.', StudentNo);
        EnrolmentRequestPage.SetTableView(EnrolmentRequest);
        EnrolmentRequestPage.Run();
        
    end;
}
