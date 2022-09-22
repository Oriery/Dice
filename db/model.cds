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

annotate Events with {
    name       @(Common : {Label : '{i18n>PropertyName}'});
    descr      @(Common : {Label : '{i18n>PropertyDescr}'});
    isPublic   @(Common : {Label : '{i18n>PropertyIsPublic}'});
    timeStamp      @(Common : {Label : '{i18n>PropertyTimeStamp}'});
    playersMax @(
        Common        : {Label : '{i18n>PropertyPlayersMax}'},
        Measures.Unit : '{i18n>MeasurePlayers}'
    );
};

annotate Events with @(
    UI : {
        HeaderInfo : {
            $Type : 'UI.HeaderInfoType',
            TypeName : '{i18n>TypeNameSingularEvents}',
            TypeNamePlural : '{i18n>TypeNamePluralEvents}',
            Title: {$Type: 'UI.DataField', Value: name},
            Description: {$Type: 'UI.DataField', Value: ID}
        },
        SelectionFields : [ID, name, descr, timeStamp, organizer.username, isPublic, playersMax],
        LineItem : [
            {$Type: 'UI.DataField', Value: name},
            {$Type: 'UI.DataField', Value: descr},
            {$Type: 'UI.DataField', Value: timeStamp},
            {$Type: 'UI.DataField', Value: organizer.username, Label : '{i18n>PropertyOrganizerName}'},
            {$Type: 'UI.DataField', Value: isPublic},
            {$Type: 'UI.DataField', Value: playersMax}
        ],
        HeaderFacets : [
            {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Common', Label: '{i18n>GroupCommon}'},
            {$Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#Descr'}
        ],
        DataPoint#Descr : {
            $Type : 'UI.DataPointType',
            Value : descr,
            Title : '{i18n>PropertyDescr}'
        },
        FieldGroup#Common : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {$Type: 'UI.DataField', Value: timeStamp},
                {$Type: 'UI.DataField', Value: organizer.username, Label : '{i18n>PropertyOrganizerName}'},
                {$Type: 'UI.DataField', Value: isPublic},
                {$Type: 'UI.DataField', Value: playersMax}
            ]
        },
    },
    odata.draft.enabled: true
);
