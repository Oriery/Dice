using {io.dice} from '../db/model';

service Main {

    entity Events as projection on dice.Events;
    entity Users  as projection on dice.Users;

}
