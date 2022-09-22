using Main as service from '../../srv/main';

annotate service.Events with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : descr,
            },
            {
                $Type : 'UI.DataField',
                Value : playersMax,
            },
            {
                $Type : 'UI.DataField',
                Label : 'coords_lat',
                Value : coords_lat,
            },
            {
                $Type : 'UI.DataField',
                Label : 'coords_lng',
                Value : coords_lng,
            },
            {
                $Type : 'UI.DataField',
                Label : 'address',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Value : timeStamp,
            },
            {
                $Type : 'UI.DataField',
                Value : isPublic,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
