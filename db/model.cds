namespace io.dice;

using {
    cuid,
    managed
} from '@sap/cds/common';

type LText : String(1024);
type MText : String(64);
type SText : String(32);
type TText : String(16);

type Coordinates : {
    Lat : Decimal;
    Lng : type of Lat;
};

type MemberRole : Integer enum {
    Owner     = 0;
    Player    = 1;
    Spectator = 2;
    Master    = 3;
}

@restrict: [{grant: '*'}]
entity Events : cuid, managed {
    Name       : SText;
    Descr      : LText;
    PlayersMax : Integer;
    Coords     : Coordinates;
    Address    : MText;
    Organizer  : Association to one Users;
    members    : Composition of many {
                     key user : Association to Users;
                         role : MemberRole;
                 }
    TimeStamp  : DateTime;
    IsPublic   : Boolean;
    ChatId     : UUID;
}

@restrict: [{grant: '*'}]
entity Users : cuid {
    Username    : String(16);
    Bio         : LText;
    DateOfBirth : Date;
    Sex         : Integer enum {
        Unknown = 0;
        Male    = 1;
        Female  = 2;
        Other   = 3;
    };
    Email       : String(64);
    PhoneNumber : String(16);
    Salt        : String(8);
    PassHash    : String(32);
}
