table 50503 CourseAdditionalInformation
{
    Caption = 'Course Additional Information';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CourseAdditionId"; Code[20])
        {
            Caption = 'Course ID';
            Editable = false;
            //TableRelation = "Course Information"."Course ID" where("Course ID" = field("CourseAdditionId"));
        }
        field(2; "Capacity "; Integer)
        {
            Caption = 'Capacity ';
        }
    }
    keys
    {
        key(PK; "CourseAdditionId")
        {
            Clustered = true;
        }
    }

    procedure ParseCourseID(CourseID: Code[20])
    var
        CourseAdditionalInformationPage: Page CourseAdditionPage;
        CourseAdditionalInformationTable: Record CourseAdditionalInformation;
    begin
        CourseAdditionalInformationTable.SetRange("CourseAdditionId", CourseID);

        if not CourseAdditionalInformationTable.FindFirst() then begin
            CourseAdditionalInformationTable.Init();
            CourseAdditionalInformationTable."CourseAdditionId" := CourseID;
            CourseAdditionalInformationTable."Capacity " := 0;
            CourseAdditionalInformationTable.Insert(true);
            Commit();
        end;
        CourseAdditionalInformationPage.SetRecord(CourseAdditionalInformationTable);
        CourseAdditionalInformationPage.Run();
    end;
}
