(define (problem problemSub3)
    (:domain domainSub)

    (:objects
        captain engineers scienceOfficers securityPersonnel navigators - member
        MARKII - submarine
        drillingMiniSubs explorationMiniSubs - minisubs
        bridge launchBay scienceLab sickbay combatInformationCenter - cabin
        ridge2 abyssalPlain1 abyssalPlain2 abyssalPlain3 abyssalPlain4 vortex1 - region
        seaPort - base
        thorium - mineral
        sensor1 sensor2 sensor3
    )
    
    (:init
        ;these are static initial constants
        (markII MARKII)
        (captain captain)
        (engineers engineers)
        (scienceOfficers scienceOfficers)
        (securityPersonnel securityPersonnel)
        (navigators navigators)
        
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
        (contain ridge2 thorium)
        (sensor sensor1)
        (sensor sensor2)
        (sensor sensor3)
        (locatedIn vortex1 ridge2)
        (vortex vortex1)
        (seaPort seaPort)
    )
    
    (:goal
        (and
            ;these are specific goals in this problem
            (reportOfVortex vortex1)
            (sensorOnline sensor1 abyssalPlain1)
            (sensorOnline sensor2 abyssalPlain2)
            (sensorOnline sensor3 abyssalPlain4)
            (reportofMine thorium)
            
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