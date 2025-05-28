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
            }
        }
    }
}
