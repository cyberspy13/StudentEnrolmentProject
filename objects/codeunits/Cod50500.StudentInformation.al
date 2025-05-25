codeunit 50500 "StudInfo Codeunit"
{
    procedure ValidateStudentNo(var StudentInformation: Record "Student Information")
    var
        LastNo: Integer;
        UniPrefix: Text[20];
        LastStudentNo: Code[20];
        NumericPart: Integer;
        StudentInformationRecord: Record "Student Information";
    begin
        // Only assign if it's not already set (e.g. via import or manually)
        if StudentInformation."Student No" = '' then begin
            UniPrefix := 'LANCASTER';
            if StudentInformationRecord.FindLast() then begin
                LastStudentNo := StudentInformationRecord."Student No";
                // Try to extract the numeric part from the last student number
                Evaluate(NumericPart, CopyStr(LastStudentNo, StrLen(UniPrefix) + 1)); //ensures you start copying from after the word "LANCASTER".
                LastNo := NumericPart + 1;
            end else
                LastNo := 1; // First student

            StudentInformation."Student No" := UniPrefix + Format(LastNo);

        end;
    end;
}
