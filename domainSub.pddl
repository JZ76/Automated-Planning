(define (domain domainSub)
    (:requirements
        :strips :conditional-effects :typing
    )

    (:predicates
        ;define submarine as MARKII, and two mini-submarines
        (markII ?s)
        (drillingMiniSubs ?ms)
        (explorationMiniSubs ?ms)
        
        ;define different people
        (captain ?m)
        (engineers ?m)
        (scienceOfficers ?m)
        (securityPersonnel ?m)
        (navigators ?m)
        (baseLeader ?p)
        (Atlantean ?p)
        
        ;define the cabin of submarine
        (bridge ?c)
        (launchBay ?c)
        (scienceLab ?c)
        (sickbay ?c)
        (combatInformationCenter ?c)
        
        ;which two cabin are connected
        (door ?c1 ?c2)
        
        ;define seaport and under sea base
        (seaPort ?b)
        (base ?b)
        
        ;which crew in which cabin
        (in ?m ?c)
        
        ;where the mini-sub is
        (deployedTo ?ms ?r)
        
        ;is the mini-sub connects with submarine
        (docked ?ms ?s)
        
        ;where the submarine is
        (into ?s ?r)
        
        ;is the submarine at seaport
        (at ?s ?b)
        
        ;is the crew health
        (health ?m)
        
        ;is the navigators received order from captain
        (receivedOrder ?m1 ?m2)
        
        ;which region will at if the submarine into vortex
        (hyperspaceJump ?s ?r)
        
        ;which crew in which mini-sub
        (inMiniSub ?m ?ms)
        
        ;which side taking base now
        (lead ?p ?b)
        
        ;which region contain which kind of mineral
        (contain ?r ?mine)
        
        ;is the drillingMiniSubs got the mineral sample
        (ownSample ?ms ?mine)
        
        ;which sensor we got
        (sensor ?sen)
        
        ;which vortex
        (vortex ?r)
        
        ;get the report of a mineral sample
        (reportofMine ?mine)
        
        ;a sensor has been installed
        (sensorOnline ?sen ?r)
        
        ;the status report of a base
        (statusReport ?m ?r)
        
        ;the report of a vortex
        (reportOfVortex ?r)
        
        ;a vortex or base in which region
        (locatedIn ?r1 ?r2)
        
        
        ;which region has naval mine
        (hasx ?r ?nm)
        
        ;which torpedo
        (torpedo ?t)
        
        ;which ballistic missile
        (missile ?mi)
        
        ;a base at a shore
        (shorebase ?b)
        
        ;which region is in the range of launch missile 
        (inRange ?r)
        
        ;what has been destroyed
        (destroy ?x)
        
        ;a Atlantean's submarine
        (enemySub ?s)
    )

    (:types
        submarine
        minisubs
        member
        cabin
        region
        base
        mineral
        npc
        weapon
        mine
    )
    
    ;the submarine move to which region except seaport
    (:action move
        :parameters
            (?m1 - member ?m2 - member ?ms1 - minisubs ?ms2 - minisubs ?s - submarine ?r1 - region ?r2 - region)
        :precondition
            (and
                (markII ?s)
                (into ?s ?r1)
                (receivedOrder ?m1 ?m2)
                (deployedTo ?ms1 ?r1)
                (deployedTo ?ms2 ?r1)
                (docked ?ms1 ?s)
                (docked ?ms2 ?s)
                (drillingMiniSubs ?ms1)
                (explorationMiniSubs ?ms2)
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(into ?s ?r1))
                (into ?s ?r2)
                (deployedTo ?ms1 ?r2)
                (not(deployedTo ?ms1 ?r1))
                (deployedTo ?ms2 ?r2)
                (not(deployedTo ?ms2 ?r1))
                (docked ?ms1 ?s)
                (docked ?ms2 ?s)
            )
    )
    
    ;the submarine move to which region from seaport
    (:action setoff
        :parameters
            (?m1 - member ?m2 - member ?ms1 - minisubs ?ms2 - minisubs ?s - submarine ?b - base ?r2 - region)
        :precondition
            (and
                (markII ?s)
                (at ?s ?b)
                (seaPort ?b)
                (receivedOrder ?m1 ?m2)
                (deployedTo ?ms1 ?b)
                (deployedTo ?ms2 ?b)
                (docked ?ms1 ?s)
                (docked ?ms2 ?s)
                (drillingMiniSubs ?ms1)
                (explorationMiniSubs ?ms2)
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(at ?s ?b))
                (into ?s ?r2)
                (deployedTo ?ms1 ?r2)
                (not(deployedTo ?ms1 ?b))
                (deployedTo ?ms2 ?r2)
                (not(deployedTo ?ms2 ?b))
                (docked ?ms1 ?s)
                (docked ?ms2 ?s)
            )
    )
    
    ;the submarine return to seaport
    (:action returnToBase
        :parameters
            (?m1 - member ?m2 - member ?ms1 - minisubs ?ms2 - minisubs ?s - submarine ?b - base ?r2 - region)
        :precondition
            (and
                (markII ?s)
                (into ?s ?r2)
                (seaPort ?b)
                (receivedOrder ?m1 ?m2)
                (docked ?ms1 ?s)
                (docked ?ms2 ?s)
                (drillingMiniSubs ?ms1)
                (explorationMiniSubs ?ms2)
    
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(into ?s ?r2))
                (at ?s ?b)
                (docked ?ms1 ?s)
                (docked ?ms2 ?s)
            )
    )
    
    ;a crew go into a cabin
    (:action goInto
        :parameters
            (?m - member ?c1 - cabin ?c2 - cabin)
        :precondition
            (and
                (in ?m ?c1)
                (door ?c1 ?c2)
            )
        :effect
            (and
                (in ?m ?c2)
                (not(in ?m ?c1))
            )
    )
    
    ;the captain gives an order
    (:action order
        :parameters
            (?m1 - member ?m2 - member ?c - cabin)
        :precondition
            (and
                (bridge ?c)
                (in ?m1 ?c)
                (in ?m2 ?c)
                (captain ?m1)
                (navigators ?m2)
            )
        :effect
                (receivedOrder ?m1 ?m2)
    )
    
    ;a crew get in a mini-sub
    (:action getInminiSub
        :parameters
            (?m - member ?ms - minisubs ?c - cabin ?s - submarine)
        :precondition
            (and
                (launchBay ?c)
                (explorationMiniSubs ?ms)
                (docked ?ms ?s)
                (in ?m ?c)
                (markII ?s)
            )
        :effect
            (and
                (inMiniSub ?m ?ms)
                (not(in ?m ?c))
                ;(docked ?ms ?s)
            )
    )
    
    ;a mini-sub disconnects with submarine
    (:action detachMiniSub
        :parameters
            (?ms - minisubs ?s - submarine ?r - region)
        :precondition
            (and
                (docked ?ms ?s)
                (into ?s ?r)
                (deployedTo ?ms ?r)
                (markII ?s)
            )
        :effect
                (not(docked ?ms ?s))
    )
    
    ;a mini-sub connects with submarine
    (:action returnToSub
        :parameters
            (?ms - minisubs ?s - submarine ?r - region)
        :precondition
            (and
                (deployedTo ?ms ?r)
                (into ?s ?r)
                (markII ?s)
            )
        :effect
                (docked ?ms ?s)
    )
    
    ;a crew get out of a mini-sub
    (:action getOffminiSub
        :parameters
            (?m - member ?ms - minisubs ?c - cabin ?s - submarine)
        :precondition
            (and
                (launchBay ?c)
                (explorationMiniSubs ?ms)
                (docked ?ms ?s)
                (inMiniSub ?m ?ms)
                (markII ?s)
            )
        :effect
            (and
                (not(inMiniSub ?m ?ms))
                (in ?m ?c)
                ;(docked ?ms ?s)
            )
    )
    
    ;a sensor has been installed in a region
    (:action installSensor
        :parameters
            (?ms - minisubs ?r - region ?m - member ?s - submarine ?sen)
        :precondition
            (and
                (engineers ?m)
                (explorationMiniSubs ?ms)
                (inMiniSub ?m ?ms)
                (deployedTo ?ms ?r)
                (into ?s ?r)
                (markII ?s)
                (sensor ?sen)
                (not(docked ?ms ?s))
            )
        :effect
            (and
                (sensorOnline ?sen ?r)
                (not(sensor ?sen))
                (deployedTo ?ms ?r)
            )
    )
    
    ;checking a base captured by Atlanteans and securityPersonnel is present
    (:action checkBaseCaptured
        :parameters
            (?ms - minisubs ?m - member ?m1 - member ?p - npc ?b  - base ?r2 - region ?s - submarine ?c - cabin)
        :precondition
            (and
                (captain ?m)
                (inMiniSub ?m ?ms)
                (not(docked ?ms ?s))
                (explorationMiniSubs ?ms)
                (deployedTo ?ms ?r2)
                (lead ?p ?b)
                (locatedIn ?b ?r2)
                (into ?s ?r2)
                (markII ?s)
                (securityPersonnel ?m1)
                (combatInformationCenter ?c)
                (in ?m1 ?c)
                (Atlantean ?p)
                
            )
        :effect
                (statusReport ?m ?b)
    )
    
    ;checking a base captured by Atlanteans but securityPersonnel isn't present
    (:action checkBaseCapturedI
        :parameters
            (?ms - minisubs ?m - member ?p - npc ?b  - base ?r2 - region ?s - submarine ?m1 - member ?c - cabin)
        :precondition
            (and
                (captain ?m)
                (inMiniSub ?m ?ms)
                (not(docked ?ms ?s))
                (explorationMiniSubs ?ms)
                (deployedTo ?ms ?r2)
                (lead ?p ?b)
                (locatedIn ?b ?r2)
                (into ?s ?r2)
                (markII ?s)
                (Atlantean ?p)
                (securityPersonnel ?m1)
                (combatInformationCenter ?c)
                (not(in ?m1 ?c))
            )
        :effect
            (and
                (statusReport ?m ?b)
                (not(health ?m))
            )
    )
    
    ;checking a base is in our side
    (:action checkBase
        :parameters
            (?ms - minisubs ?m - member ?p - npc ?b  - base ?r2 - region ?s - submarine)
        :precondition
            (and
                (captain ?m)
                (inMiniSub ?m ?ms)
                (not(docked ?ms ?s))
                (explorationMiniSubs ?ms)
                (deployedTo ?ms ?r2)
                (lead ?p ?b)
                (locatedIn ?b ?r2)
                (into ?s ?r2)
                (markII ?s)
                (baseLeader ?p)
            )
        :effect
                (statusReport ?m ?b)
    )
    
    ;the drillingMiniSubs got a mineral sample
    (:action getMineralSamples
        :parameters
            (?ms - minisubs ?r - region ?mine - mineral ?m1 - member ?m2 - member ?c - cabin ?s - submarine)
        :precondition
            (and
                (drillingMiniSubs ?ms)
                (deployedTo ?ms ?r)
                (contain ?r ?mine)
                (into ?s ?r)
                (in ?m1 ?c)
                (in ?m2 ?c)
                (launchBay ?c)
                (engineers ?m1)
                (scienceOfficers ?m2)
                (markII ?s)
                (not(docked ?ms ?s))
            )
        :effect
            (and
                (not(contain ?r ?mine))
                (ownSample ?ms ?mine)
            )
    )
    
    ;the scienceOfficers study mineral sample and give a report
    (:action StudyMineralSamples
        :parameters
            (?m - member ?mine - mineral ?c - cabin ?ms - minisubs ?s - submarine)
        :precondition
            (and
                (scienceOfficers ?m)
                (scienceLab ?c)
                (in ?m ?c)
                (ownSample ?ms ?mine)
                (drillingMiniSubs ?ms)
                (docked ?ms ?s)
                (markII ?s)
            )
        :effect
                (reportofMine ?mine)
    )
    
    ;the scienceOfficers study a vortex in scienceLab and give a report
    (:action StudyVortex
        :parameters
            (?m - member ?c - cabin ?s - submarine ?r - region ?r1  - region)
        :precondition
            (and
                (scienceOfficers ?m)
                (scienceLab ?c)
                (into ?s ?r)
                (markII ?s)
                (locatedIn ?r1 ?r)
                (vortex ?r1)
                (in ?m ?c)
            )
        :effect
            
                (reportOfVortex ?r1)
            
    )
    
    ;a crew get healed in sickbay
    (:action healing
        :parameters
            (?m - member ?c - cabin)
        :precondition
            (and
                (in ?m ?c)
                (sickbay ?c)
            )
        :effect
            
                (health ?m)
            
    )
    
    ;the submarine go into a vortex
    (:action hyperspaceJump
        :parameters
            (?s - submarine ?r - region ?r1 - region ?r2 - region ?m1 - member ?m2 - member ?m3 - member ?ms1 - minisubs ?ms2 - minisubs ?c - bridge)
        :precondition
            (and
                (markII ?s)
                (into ?s ?r)
                (vortex ?r1)
                (locatedIn ?r1 ?r)
                (receivedOrder ?m1 ?m2)
                (hyperspaceJump ?s ?r2)
                (deployedTo ?ms1 ?r)
                (deployedTo ?ms1 ?r)
                (drillingMiniSubs ?ms1)
                (explorationMiniSubs ?ms2)
                (engineers ?m3)
                (in ?m3 ?c)
                (bridge ?c)
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(into ?s ?r))
                (into ?s ?r2)
                (deployedTo ?ms1 ?r2)
                (not(deployedTo ?ms1 ?r))
                (deployedTo ?ms2 ?r2)
                (not(deployedTo ?ms2 ?r))
            )
    )
    
    ;the submarine go into a vortex in DLC
    (:action hyperspaceJumpx
        :parameters
            (?s - submarine ?r - region ?r1 - region ?r2 - region ?m1 - member ?m2 - member ?m3 - member ?c - cabin ?nm - mine)
        :precondition
            (and
                (markII ?s)
                (into ?s ?r)
                (vortex ?r1)
                (locatedIn ?r1 ?r)
                (receivedOrder ?m1 ?m2)
                (hyperspaceJump ?s ?r2)
                (hasx ?r2 ?nm)
                (engineers ?m3)
                (in ?m3 ?c)
                (bridge ?c)
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(into ?s ?r))
                (into ?s ?r2)
                
            )
    )
    
    ;move in DLC
    (:action movex
        :parameters
            (?m1 - member ?m2 - member ?s - submarine ?r1 - region ?r2 - region ?nm - mine)
        :precondition
            (and
                (markII ?s)
                (into ?s ?r1)
                (receivedOrder ?m1 ?m2)
                (not(hasx ?r2 ?nm))
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(into ?s ?r1))
                (into ?s ?r2)
            )
    )
    
    ;set off in DLC
    (:action setoffx
        :parameters
            (?m1 - member ?m2 - member ?s - submarine ?b - base ?r2 - region ?mi - weapon ?t - weapon ?nm - mine)
        :precondition
            (and
                (markII ?s)
                (at ?s ?b)
                (seaPort ?b)
                (receivedOrder ?m1 ?m2)
                (missile ?mi)
                (torpedo ?t)
                (not(hasx ?r2 ?nm))
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(at ?s ?b))
                (into ?s ?r2)
            )
    )
    
    ;return to seaport in DLC
    (:action returnToBasex
        :parameters
            (?m1 - member ?m2 - member ?s - submarine ?b - base ?r2 - region ?mi - weapon)
        :precondition
            (and
                (markII ?s)
                (into ?s ?r2)
                (seaPort ?b)
                (receivedOrder ?m1 ?m2)
                (missile ?mi)
            )
        :effect
            (and
                (not(receivedOrder ?m1 ?m2))
                (not(into ?s ?r2))
                (at ?s ?b)
            )
    )
    
    ;launch ballistic missile
    (:action launchMissile
        :parameters
            (?s - submarine ?b - base ?m - member ?c - cabin ?r - region ?w - weapon ?nm - mine)
        :precondition
            (and
                (markII ?s)
                (missile ?w)
                (shorebase ?b)
                (into ?s ?r)
                (inRange ?r)
                (securityPersonnel ?m)
                (combatInformationCenter ?c)
                (in ?m ?c)
                
            )
        :effect
            (and
                (destroy ?b)
                (not(missile ?w))
                (forall (?r - region)
                    (not(hasx ?r ?nm))
                )
            )
    )
    
    ;launch torpedo to a submarine
    (:action launchTorpedo
        :parameters
            (?s1 - submarine ?s2 - submarine ?r - region ?m - member ?c - cabin ?t - weapon)
        :precondition
            (and
                (markII ?s1)
                (enemySub ?s2)
                (into ?s1 ?r)
                (into ?s2 ?r)
                (securityPersonnel ?m)
                (combatInformationCenter ?c)
                (in ?m ?c)
                (torpedo ?t)
            )
        :effect
            (and
                (not(torpedo ?t))
                (destroy ?s2)
            )
    )
    
    ;launch torpedo to a outpost
    (:action launchTorpedox
        :parameters
            (?s - submarine ?b - base ?r - region ?m - member ?c - cabin ?t - weapon ?p - npc)
        :precondition
            (and
                (markII ?s)
                (locatedIn ?b ?r)
                (base ?b)
                (into ?s ?r)
                (lead ?p ?b)
                (Atlantean ?p)
                (torpedo ?t)
                (securityPersonnel ?m)
                (combatInformationCenter ?c)
                (in ?m ?c)
            )
        :effect
            (and
                (not(torpedo ?t))
                (destroy ?b)
            )
    )
)