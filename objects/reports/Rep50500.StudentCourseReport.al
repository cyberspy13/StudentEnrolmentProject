report 50500 "Student Course Report"
{
    ApplicationArea = All;
    Caption = 'Student Course Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = MyWordLayout;

    dataset
    {
        dataitem(EnrolmentRequest; "Enrolment Request")
        {
            column(ApprovalDate; "Approval Date")
            {
            }
            column(ApprovedID; "Approved ID")
            {
            }
            column(CourseID; "Course ID")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(Notificationsent; "Notification sent")
            {
            }
            column(RequestDate; "Request Date")
            {
            }
            column(Status; Status)
            {
            }
            column(StudentNo; "Student No.")
            {
            }
        }
    }
    rendering
    {
        layout(MyWordLayout)
        {
            Type = Word;
            Caption = 'Student Course Information Word';
            LayoutFile = 'Student Course Information Word.docx';
        }
    }
}
