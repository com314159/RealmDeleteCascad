# RealmDeleteCascad
Helper to delete Realm object cascad

You have to add Realm.framework(v0.96, download from https://realm.io/) to this project before it can running.

Because Realm will not delete cascade Object by default, you can call below method to delete object and the cascade object.


    [RLMHelper deleteModelCascad:model inRealm:realm];
    
If you have bug, please contact me. 

