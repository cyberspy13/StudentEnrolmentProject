page 50501 "Student Information Card Page"
{
    ApplicationArea = All;
    Caption = 'Student Information Card';
    PageType = Card;
    SourceTable = "Student Information";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Student No"; Rec."Student No")
                {
                    ToolTip = 'Specifies the value of the Student No field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Second Name"; Rec."Second Name")
                {
                    ToolTip = 'Specifies the value of the Second Name field.', Comment = '%';
                }
                field("Date Of Birth (DOB)"; Rec."Date Of Birth (DOB)")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth (DOB) field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field(Postcode; Rec.Postcode)
                {
                    ToolTip = 'Specifies the value of the Postcode field.', Comment = '%';
                }
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Find Course")
            {
                ApplicationArea = All;
                Caption = 'Find Course';
                Promoted = true;
                PromotedCategory = Process;
                Image = Agreement;

                trigger OnAction()
                var
                    CourseInformationRecord: Record "Course Information";
                    CourseInformationPage: Page "Course Information List";
                begin
                    CourseInformationRecord.SetRange(CapacityBoolIndicator, false);
                    Page.Run(Page::"Course Information List", CourseInformationRecord);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        StudentNoValidCodeunit: Codeunit "StudInfo Codeunit";
    begin
        StudentNoValidCodeunit.ValidateStudentNo(Rec);
    end;
}
