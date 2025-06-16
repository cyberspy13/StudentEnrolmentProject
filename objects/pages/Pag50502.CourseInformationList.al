page 50502 "Course Information List"
{
    ApplicationArea = All;
    Caption = 'Course Information';
    PageType = List;
    SourceTable = "Course Information";
    UsageCategory = Lists;
    CardPageId = "Course Information Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Course ID"; Rec."Course ID")
                {
                    ToolTip = 'Specifies the value of the Course ID field.', Comment = '%';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ToolTip = 'Specifies the value of the Course Name field.', Comment = '%';
                }
                field("Course Overview"; Rec."Course Overview")
                {
                    ToolTip = 'Specifies the value of the Course Overview field.', Comment = '%';
                }
                field("Course Details"; Rec."Course Details")
                {
                    ToolTip = 'Specifies the value of the Course Details field.', Comment = '%';
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
                    //TableRelation = "Student Information"."Student No";
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Assign Student ID")
            {
                ApplicationArea = All;
                Caption = 'Assign Student ID';
                Promoted = true;
                PromotedCategory = Process;
                Image = Agreement;

                trigger OnAction()
                begin
                    if Rec.StudentID <> '' then begin
                        Message('Student ID %1 already assigned to the course %2.', Rec.StudentID, Rec."Course ID");
                    end else if Rec.CapacityBoolIndicator = true then begin
                        Message('Student ID cannot be assigned to the course %1 as the capacity limit has been reached.', Rec."Course ID");
                    end else
                        AssignStudentIdCodeunit.AssignStudentIdToCourse(StudentNumberInfo, Rec."Course ID");
                end;
            }
        }
    }

    var
        StudentNumberInfo: Code[20];
        AssignStudentIdCodeunit: Codeunit "AssignStudentId";

    procedure SetStudent(StudentNo: code[20])
    begin
        StudentNumberInfo := StudentNo;
    end;




}
