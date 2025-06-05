codeunit 50502 CapacityField
{
    procedure GetCapacityField(CourseIDCodVar: Code[20]; var CapacityRec: Integer; var CapIndicator: Boolean)
    var
        AdditionalTable: Record "CourseAdditionalInformation";
        CourseInformationTable: Record "Course Information";
        CapacityLimit: Integer;
    begin
        AdditionalTable.SetRange("CourseAdditionId", CourseIDCodVar);
        if AdditionalTable.FindFirst() then begin
            CourseInformationTable.SetRange("Course ID", CourseIDCodVar);
            if CourseInformationTable.FindFirst() then begin
                CapacityLimit := AdditionalTable."Capacity ";
                if CapacityRec > CapacityLimit then begin
                    CapIndicator := true;
                    Message('Capacity limit reached for course %1.', CourseIDCodVar);
                end else begin
                    CapIndicator := false;
                end;
                CourseInformationTable.Modify(true);
            end else
                Error('Course with ID %1 not found.', CourseIDCodVar);
        end;
    end;

}
