table 50504 "waitlisted Courses"
{
    Caption = 'waitlisted Courses';
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

   
}
