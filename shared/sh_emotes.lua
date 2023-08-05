Config.Emotes = {
    ["drink"] = {
        Dict = 'mech_inventory@drinking@coffee',
        Anim = 'action',
        Options = {
            Prop = "p_mugcoffee01x",
            Bone = "SKEL_R_FINGER12",
            Placement = { 0.0, -0.05, 0.03, 0.0, 180.0, 180.0 },
        }
    },

    ["eat"] = {
        Dict = 'mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese',
        Anim = 'quick_right_hand',
        Options = {
            Prop = "p_bread06x",
            Bone = "SKEL_R_FINGER12",
            Placement = { 0.03, -0.03, 0.0, 0.0, 0.0, 0.0 },
        }
    },

    ["cigarette"] = {
        Dict = 'amb_wander@code_human_smoking_wander@cigar@male_a@base',
        Anim = 'base',
        Options = {
            Prop = "p_cigarette_cs01x",
            Bone = "SKEL_R_FINGER12",
            Placement = { 0.0, 0.03, 0.01, 0.0, 180.0, 90.0 },
        }
    },

    ["cigar"] = {
        Dict = 'amb_wander@code_human_smoking_wander@cigar@male_a@base',
        Anim = 'base',
        Options = {
            Prop = "p_cigar01x",
            Bone = "SKEL_R_FINGER12",
            Placement = { 0.0, 0.03, 0.0, 0.0, 0.0, 0.0 },
        }
    },

    ["beer"] = {
        Dict = 'mech_dynamic@world_player_drinking@beer@male_a@idle_action@med',
        Anim = 'idle_drink_a',
        Options = {
            Prop = "p_bottlebeer01a",
            Bone = "SKEL_R_FINGER12",
            Placement = { 0.035, -0.035, 0.07, 0.0, 180.0, 0.0 },
        }
    },
}