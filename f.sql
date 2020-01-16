Create or Replace Procedure makeReport(l_custid IN NUMBER, l_date IN DATE)

AS

BEGIN

OrderedAfter(l_custid,l_date);

dbms_output.put_line('Please type @OrderReport in command line to create/update an OrderReport.txt file with up to date information about Customer ' || l_custid || '''s purchases after ' || l_date);

END;
/
Show errors;
