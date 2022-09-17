using {io.dice} from '../db/model';

@restrict: [{grant: '*'}]
service Main {
    
    entity Events @(restrict: [{grant: '*'}]) as projection on dice.Events;

    entity Users @(restrict: [{grant: '*'}]) as projection on dice.Users;

    action getUsersByIds(ids: array of String) returns array of Users;
}
