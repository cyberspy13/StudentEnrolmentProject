codeunit 50501 AssignStudentId
{
    procedure AssignStudentIdToCourse(StudentNo: Code[20]; CourseID: Code[10])
    var
        CourseInformationTable: Record "Course Information";
    begin
        if CourseInformationTable.StudentID = '' then begin
            CourseInformationTable.Get(CourseID);
            CourseInformationTable.StudentID := StudentNo;
            CourseInformationTable.Modify(true);
            Commit();
            if CourseInformationTable.StudentID <> '' then begin
                Message('Student ID %1 has been assigned to the course %2.', StudentNo, CourseID);
            end else
                Message('Failed to assign Student ID to the course %2.', StudentNo, CourseID);
        end;
    end;

    procedure AssignStudentIdToWaitlistedCourse(StudentNo: Code[20]; CourseID: Code[10])
    var
        WaitlistedCourseInformationTable: Record "Waitlisted Courses";
    begin
        if WaitlistedCourseInformationTable.StudentID = '' then begin
            WaitlistedCourseInformationTable.Get(CourseID);
            WaitlistedCourseInformationTable.StudentID := StudentNo;
            WaitlistedCourseInformationTable.Modify(true);
            Commit();
            if WaitlistedCourseInformationTable.StudentID <> '' then begin
                Message('Student ID %1 has been assigned to the course %2.', StudentNo, CourseID);
            end else
                Message('Failed to assign Student ID to the course %2.', StudentNo, CourseID);
        end;
    end;
}
