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
    lat : Decimal;
    lng : type of lat;
};

type MemberRole : Integer enum {
    Player    = 0;
    Spectator = 1;
    Master    = 2;
}

@restrict : [{grant : '*'}]
entity Events : cuid, managed {
    name       : SText;
    descr      : LText;
    playersMax : Integer;
    coords     : Coordinates;
    address    : MText;
    organizer  : Association to one Users;
    members    : Composition of many {
                     key user : Association to Users;
                         role : MemberRole;
                 }
    timeStamp  : DateTime;
    isPublic   : Boolean;
    chatID     : UUID;
}

@restrict : [{grant : '*'}]
entity Users : cuid {
    username    : String(16);
    bio         : LText;
    dateOfBirth : Date;
    sex         : Integer enum {
        Unknown = 0;
        Male    = 1;
        Female  = 2;
        Other   = 3;
    };
    email       : String(64);
    phoneNumber : String(16);
    salt        : String(8);
    passHash    : String(32);
}
