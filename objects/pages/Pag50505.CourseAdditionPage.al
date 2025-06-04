page 50505 CourseAdditionPage
{
    ApplicationArea = All;
    Caption = 'Course Addition Page';
    PageType = Card;
    SourceTable = CourseAdditionalInformation;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("CourseAdditionId"; Rec."CourseAdditionId")
                {
                    ToolTip = 'Specifies the value of the Course ID field.', Comment = '%';
                }
                field("Capacity "; Rec."Capacity ")
                {
                    ToolTip = 'Specifies the value of the Capacity field.', Comment = '%';
                }
            }
        }
    }

}
