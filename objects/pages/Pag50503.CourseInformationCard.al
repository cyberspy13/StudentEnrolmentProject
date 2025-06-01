page 50503 "Course Information Card"
{
    ApplicationArea = All;
    Caption = 'Course Information';
    PageType = Card;
    SourceTable = "Course Information";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Course ID"; Rec."Course ID")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Course ID field.', Comment = '%';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ToolTip = 'Specifies the value of the Course Name field.', Comment = '%';
                }
                field("Course Details"; Rec."Course Details")
                {
                    ToolTip = 'Specifies the value of the Course Details field.', Comment = '%';
                    MultiLine = true;
                }
                field("Course Overview"; Rec."Course Overview")
                {
                    ToolTip = 'Specifies the value of the Course Overview field.', Comment = '%';
                    MultiLine = true;
                }
                field("Study Options"; Rec."Study Options")
                {
                    ToolTip = 'Specifies the value of the Study Options field.', Comment = '%';
                }
                field(Capacity; Rec.Capacity)
                {
                    ToolTip = 'Specifies the value of the Capacity field.', Comment = '%';
                }
                field(CapacityBoolIndicator; Rec.CapacityBoolIndicator)
                {
                    ToolTip = 'Specifies the value of the Capacity Indicators field.', Comment = '%';
                }
                field(StudentID; Rec.StudentID)
                {
                    ToolTip = 'Specifies the value of the Student ID field.', Comment = '%';
                    TableRelation = "Student Information"."Student No";
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Enroll")
            {
                ApplicationArea = All;
                Caption = 'Enrol';
                Promoted = true;
                PromotedCategory = Process;
                Image = Entry;
                ToolTip = 'Enrol to the course.';

                trigger OnAction()
                var
                    EnrolmentTable: Record "Enrolment Request";
                begin
                    EnrolmentTable.Init();
                    EnrolmentTable."Course ID" := Rec."Course ID";
                    EnrolmentTable."Student No." := Rec.StudentID;
                    EnrolmentTable."Request Date" := Today();
                    EnrolmentTable.Status := EnrolmentTable.Status::Pending;
                    EnrolmentTable.Insert(true);
                    Commit();
                    Message('You have successfully enrolled in the course %1.', Rec."Course Name");
                end;
            }
        }
    }
}
