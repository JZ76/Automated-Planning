(define (problem problemSub1)
    (:domain domainSub)

    (:objects
        captain engineers scienceOfficers securityPersonnel navigators - member
        MARKII - submarine
        drillingMiniSubs explorationMiniSubs - minisubs
        bridge launchBay scienceLab sickbay combatInformationCenter - cabin
        ridge1 ridge2 ridge3 abyssalPlain1 abyssalPlain2 abyssalPlain3 abyssalPlain4 vortex1 vortex2 - region
        base1 base2 seaPort - base
        baseLeader Atlantean - npc
    )
    
    (:init
        ;these are static initial constants
        (markII MARKII)
        (captain captain)
        (engineers engineers)
        (scienceOfficers scienceOfficers)
        (securityPersonnel securityPersonnel)
        (navigators navigators)
        (Atlantean Atlantean)
        (baseLeader baseLeader)
        
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
        (in captain bridge)
        (in navigators bridge)
        (in scienceOfficers scienceLab)
        (in engineers launchBay)
        (in securityPersonnel combatInformationCenter)
        
        (drillingMiniSubs drillingMiniSubs)
        (explorationMiniSubs explorationMiniSubs)
        (docked drillingMiniSubs MARKII)
        (docked explorationMiniSubs MARKII)
        (deployedTo drillingMiniSubs seaPort)
        (deployedTo explorationMiniSubs seaPort)
        
        (health captain)
        (health navigators)
        (health scienceOfficers)
        (health engineers)
        (health securityPersonnel)
        
        ;these shows what specific things and initial constants in this problem
        (locatedIn base1 abyssalPlain3)
        (locatedIn base2 abyssalPlain1)
        (locatedIn vortex1 abyssalPlain1)
        (locatedIn vortex2 ridge3)
        (lead Atlantean base1)
        (lead baseLeader base2)
        (vortex vortex1)
        (vortex vortex2)
        (seaPort seaPort)
        (base base1)
        (base base2)
        
        
    )
    
    (:goal
        (and
            ;these are specific goals in this problem
            (reportOfVortex vortex1)
            (reportOfVortex vortex2)
            (statusReport captain base1)
            (statusReport captain base2)
            
            ;these are goals that always need to achieve
            (docked drillingMiniSubs MARKII)
            (docked explorationMiniSubs MARKII)
            (health captain)
            (health navigators)
            (health scienceOfficers)
            (health engineers)
            (health securityPersonnel)
            (at MARKII seaPort)
        )
    )
)