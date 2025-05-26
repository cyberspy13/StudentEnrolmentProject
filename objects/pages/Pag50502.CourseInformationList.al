page 50502 "Course Information List"
{
    ApplicationArea = All;
    Caption = 'Course Information';
    PageType = List;
    SourceTable = "Course Information";
    UsageCategory = Lists;
    CardPageId = "Course Information Card";

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
            }
        }
    }
}
