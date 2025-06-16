codeunit 50503 CourseInformCapacityFunction
{
    procedure GetCourseCapacityInfo(CourseIDCodVar: Code[20]; StudentIDCodVar: Code[20])
    var
        CourseInformation: Record "Course Information";
        CourseAdditionalInformation: Record CourseAdditionalInformation;
        CapacityBoolIndicator: Boolean;
        CapacityNumber: Integer;
    begin
        CourseInformation.SetRange(CourseInformation."Course ID", CourseIDCodVar);
        if CourseInformation.FindFirst() then begin
            if CourseInformation.CapacityBoolIndicator = true then begin
                CourseInformation.Capacity -= 1;
                CourseInformation.CapacityBoolIndicator := false;
            end else if CourseInformation.CapacityBoolIndicator = false then begin
                CourseInformation.Capacity -= 1;
                CourseInformation.CapacityBoolIndicator := false;
            end;
            CourseInformation.Modify(true);
        end;
    end;

}
