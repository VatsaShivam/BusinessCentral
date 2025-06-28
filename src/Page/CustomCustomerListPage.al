page 50109 "Custom Customer List"
{
    PageType = List;
    CardPageId = "Custom Customer Card";
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Custom Customer";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Id; Rec."Customer Id") { }
                field(Name; Rec.Name) { }
                field(City; Rec.City) { }
                field(Country; Rec.Country) { }
                field(Email; Rec.Email) { }
                field("Date of Birth"; Rec."Date of Birth") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SetSelectionFilter)
            {
                Caption = 'Selection Filter';
                Image = FilterLines;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                end;
            }

            group(Marked)
            {
                action(Mark)
                {
                    Caption = 'Mark&MarkedOnly';
                    Image = Action;

                    trigger OnAction()
                    begin
                        Rec.SetRange("Customer Id", 'CUST001', 'CUST005');
                        if Rec.FindSet() then
                            repeat
                                if Rec.City = 'Delhi' then
                                    Rec.Mark(true);
                            until Rec.Next() = 0;
                        Rec.MarkedOnly(true);
                    end;
                }

                action(ClearMark)
                {
                    Caption = 'Clear Mark';
                    Image = ClearFilter;

                    trigger OnAction()
                    begin
                        Rec.ClearMarks();
                    end;
                }
            }
        }
    }
}