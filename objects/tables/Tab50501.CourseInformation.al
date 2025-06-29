table 50501 "Course Information"
{
    Caption = 'Course Information';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Course ID"; Code[10])
        {
            Caption = 'Course ID';
        }
        field(2; "Course Name"; Text[50])
        {
            Caption = 'Course Name';
        }
        field(3; "Course Overview"; Text[250])
        {
            Caption = 'Course Overview';
        }
        field(4; "Course Details"; Text[250])
        {
            Caption = 'Course Details';
        }
        field(5; "Study Options"; Enum "Study Options")
        {
            Caption = 'Study Options';
        }
        field(6; Capacity; Integer)
        {
            Caption = 'Capacity';
            MinValue = 0;
            Editable = false;
            trigger OnLookup()
            var
                CourseAdditionalInformationTable: Record "CourseAdditionalInformation";
                CapacityVar: Integer;
            begin
                If Rec."Course ID" = CourseAdditionalInformationTable.CourseAdditionId then begin
                    CapacityVar := CourseAdditionalInformationTable."Capacity ";
                    if CapacityVar <> 0 then begin
                        if Capacity > CapacityVar then
                            CapacityBoolIndicator := true
                        else
                            CapacityBoolIndicator := false;
                    end else
                        CapacityVar := 10;
                    if Capacity > CapacityVar then
                        CapacityBoolIndicator := true
                    else
                        CapacityBoolIndicator := false;
                end;
            end;
        }
        field(7; CapacityBoolIndicator; Boolean)
        {
            Caption = 'Capacity Indicator';
        }
        field(8; StudentID; Code[20])
        {
            Caption = 'Student ID';
            Editable = false;
            TableRelation = "Student Information"."Student No" where("Student No" = field(StudentID));
        }
    }
    keys
    {
        key(PK; "Course ID")
        {
            Clustered = true;
        }
        key(FK; StudentID)
        {
            Clustered = false;
        }
    }

    trigger OnInsert()
    begin
        if rec."Course ID" = '' then begin
            rec.TestField("Course ID");
        end;
    end;

    var
        CourseInformationTable: Record "Course Information";
        CourseInformationPageList: Page "Course Information List";

    procedure FindCourse(StudentNo: code[20])
    begin
        CourseInformationTable.SetRange(CapacityBoolIndicator, false);
        CourseInformationPageList.SetStudent(StudentNo);
        CourseInformationPageList.SetTableView(CourseInformationTable);
        CourseInformationPageList.Run();
    end;

    procedure FindWaitlistedCourses(StudentNo2: code[20])
    begin
        CourseInformationTable.SetRange(CapacityBoolIndicator, true);
        CourseInformationPageList.SetStudent(StudentNo2);
        CourseInformationPageList.SetTableView(CourseInformationTable);
        CourseInformationPageList.Run();
    end;

}
