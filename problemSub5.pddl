(define (problem problemSub5)
    (:domain domainSub)

    (:objects
        captain engineers scienceOfficers securityPersonnel navigators - member
        MARKII AtlanSub - submarine
        bridge launchBay scienceLab sickbay combatInformationCenter - cabin
        empty1 ridge1 ridge2 abyssalPlain1 abyssalPlain2 abyssalPlain3 abyssalPlain4 vortex1 shore1 - region
        base1 base2 base3 seaPort - base
        Atlantean - npc
        torpedo1 torpedo2 torpedo3 torpedo4 missile1 missile2 - weapon
        navalMine - mine
    )
    
    (:init
        ;these are static initial constants
        (markII MARKII)
        (enemySub AtlanSub)
        (captain captain)
        (engineers engineers)
        (scienceOfficers scienceOfficers)
        (securityPersonnel securityPersonnel)
        (navigators navigators)
        (Atlantean Atlantean)
        
        (bridge bridge)
        (launchBay launchBay)
        (scienceLab scienceLab)
        (sickbay sickbay)
        (combatInformationCenter combatInformationCenter)

        (door bridge combatInformationCenter)
        (door combatInformationCenter scienceLab)
        (door scienceLab sickbay)
        (door sickbay launchBay)
        (door combatInformationCenter bridge)
        (door scienceLab combatInformationCenter)
        (door sickbay scienceLab)
        (door launchBay sickbay)

        (at MARKII seaPort)
        (into AtlanSub abyssalPlain2)
        (in captain bridge)
        (in navigators bridge)
        (in scienceOfficers scienceLab)
        (in engineers launchBay)
        (in securityPersonnel combatInformationCenter)
        
        ;these shows what specific things and initial constants in this problem
        (locatedIn vortex1 empty1)
        (locatedIn base1 abyssalPlain1)
        (locatedIn base2 abyssalPlain2)
        (locatedIn base3 shore1)
        (lead Atlantean base1)
        (lead Atlantean base2)
        
        (hyperspaceJump MARKII abyssalPlain4)
        (vortex vortex1)
        (seaPort seaPort)
        (base base1)
        (base base2)
        (shorebase base3)
        
        (torpedo torpedo1)
        (torpedo torpedo2)
        (torpedo torpedo3)
        (torpedo torpedo4)
        (missile missile1)
        (missile missile2)
        
        (hasx ridge1 navalMine)
        (hasx ridge2 navalMine)
        (hasx abyssalPlain3 navalMine)
        (hasx abyssalPlain4 navalMine)
        (inRange abyssalPlain3)
        (inRange abyssalPlain4)
    )
    
    (:goal
        (and
            ;destroy all enemy and don't get killed
            (destroy base1)
            (destroy base2)
            (destroy base3)
            (destroy AtlanSub)
            (at MARKII seaPort)
        )
    )
)