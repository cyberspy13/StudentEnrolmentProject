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
            action("Enrol")
            {
                ApplicationArea = All;
                Caption = 'Enrol';
                Promoted = true;
                PromotedCategory = Process;
                Image = Entry;
                ToolTip = 'Enrol to the course.';

                trigger OnAction()
                begin
                    CourseInformationTable.Get(Rec."Course ID");
                    CourseAdditionalInformationTable.Get(Rec."Course ID");
                    EnrolmentTable.SetRange("Student No.", Rec.StudentID);
                    EnrolmentTable.SetRange("Course ID", Rec."Course ID");
                    Case true of
                        (CourseInformationTable.StudentID = ''):
                            Message('You can not be enrolled on this course as it is not assigned to any student.');

                        (CourseInformationTable.CapacityBoolIndicator = true):
                            Message('You can not be enrolled on this course as it is does not have valid Capacity Indicator status.');

                        (CourseInformationTable.Capacity = CourseAdditionalInformationTable."Capacity "):
                            begin
                                //Message('You can not be enrolled on this course as the limit of capacity has been reached.');
                                Message('Please configure Additional Information Capacity Indicator for this course.');
                            end;

                        (EnrolmentTable.FindFirst()):
                            begin
                                Message('%2 is already enrolled in the course %1.', Rec."Course Name", EnrolmentTable."Student No.");
                                CourseInformationTable.StudentID := '';
                                CourseInformationTable.Modify(true);
                                Exit;
                            end;
                        else begin
                            EnrolmentTable.Init();
                            EnrolmentTable."Course ID" := Rec."Course ID";
                            EnrolmentTable."Student No." := Rec.StudentID;
                            EnrolmentTable."Request Date" := Today();
                            EnrolmentTable.Status := EnrolmentTable.Status::Pending;
                            EnrolmentTable.Insert(true);
                            Message('You have successfully enrolled in the course %1.', Rec."Course Name");

                            if EnrolmentTable."Student No." <> '' then begin
                                CourseInformationTable.StudentID := '';
                                CourseInformationTable.Capacity += 1;
                                if CourseInformationTable.Capacity = CourseAdditionalInformationTable."Capacity " then begin
                                    CourseInformationTable.CapacityBoolIndicator := true;
                                end;
                                CourseInformationTable.Modify(true);
                            end;
                        end;
                    End;
                end;
            }
            action("Additional Information")
            {
                ApplicationArea = All;
                Caption = 'Additional Information';
                Promoted = true;
                PromotedCategory = Process;
                Image = Info;
                ToolTip = 'View additional information about the course.';

                trigger OnAction()
                var
                    CourseID: Code[20];
                begin
                    CourseAdditionalInformationTable.ParseCourseID(Rec."Course ID");
                end;
            }
            action("Reset Fields")
            {
                ApplicationArea = All;
                Caption = 'Reset Fields';
                Promoted = true;
                PromotedCategory = Process;
                Image = ResetStatus;
                ToolTip = 'Reset Fields';

                trigger OnAction()
                begin
                    CourseInformationTable.Get(Rec."Course ID");
                    CourseAdditionalInformationTable.Get(Rec."Course ID");
                    CourseInformationTable.StudentID := '';
                    CourseInformationTable.CapacityBoolIndicator := false;
                    CourseInformationTable.Modify(true);
                    Message('Fields have been reset successfully.');
                end;
            }
        }
    }
    var
        EnrolmentTable: Record "Enrolment Request";
        CourseInformationTable: Record "Course Information";
        CourseAdditionalInformationTable: Record CourseAdditionalInformation;
        CapacityFieldCodeunit: Codeunit "CapacityField";
}
