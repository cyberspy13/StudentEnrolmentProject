table 50500 "Student Information"
{
    Caption = 'Student Information';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No"; Code[20])
        {
            Caption = 'Student No';
            Editable = false;
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }
        field(3; "Second Name"; Text[100])
        {
            Caption = 'Second Name';
        }
        field(4; "Date Of Birth (DOB)"; Date)
        {
            Caption = 'Date Of Birth (DOB)';

            trigger OnValidate()
            var
                Age: Integer;
            begin
                Age := Date2DMY(Today, 3) - Date2DMY("Date Of Birth (DOB)", 3);
                if Age < 18 then
                    Error('You must be at least 18 years old to be a student.');
            end;
        }
        field(5; Email; Text[100])
        {
            Caption = 'Email';
        }
        field(6; "Phone No."; Text[20])
        {
            Caption = 'Phone No.';
        }
        field(7; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(8; Postcode; Code[10])


        {
            Caption = 'Postcode';
        }
        field(9; Country; Code[5])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
    }
    keys
    {
        key(PK; "Student No")
        {
            Clustered = true;
        }
    }
    //  trigger OnInsert()
    // var
    //     StudentInformation: Record "Student Information";
    //     LastNo: Integer;
    //     UniPrefix: Text[20];
    //     LastStudentNo: Code[20];
    //     NumericPart: Integer;
    // begin
    //     // Only assign if it's not already set (e.g. via import or manually)
    //     if Rec."Student No" = '' then begin
    //         UniPrefix := 'LANCASTER';
    //         if StudentInformation.FindLast() then begin
    //             LastStudentNo := StudentInformation."Student No";
    //             // Try to extract the numeric part from the last student number
    //             Evaluate(NumericPart, CopyStr(LastStudentNo, StrLen(UniPrefix) + 1)); //ensures you start copying from after the word "LANCASTER".
    //             LastNo := NumericPart + 1;
    //         end else
    //             LastNo := 1; // First student

    //         Rec."Student No" := UniPrefix + Format(LastNo);
    //     end;
    // end;
}
