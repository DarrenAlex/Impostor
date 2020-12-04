import "dotenv/config";
export const enum LobbyRegion {
    ASIA = "Asia",
    NORTH_AMERICA = "North America",
    EUROPE = "Europe",
}

export const enum SessionState {
    LOBBY = "lobby",
    PLAYING = "playing",
    DISCUSSING = "discussing",
}

export const SERVER_IPS = {
    [LobbyRegion.EUROPE]: "172.105.251.170",
    [LobbyRegion.NORTH_AMERICA]: "198.58.99.71",
    [LobbyRegion.ASIA]: "139.162.111.196",
};

export const SHORT_REGION_NAMES = {
    [LobbyRegion.EUROPE]: "EU",
    [LobbyRegion.NORTH_AMERICA]: "NA",
    [LobbyRegion.ASIA]: "AS",
};

export const COLOR_EMOTES: { [key: number]: string } = {
    [0]: "crewmate_red:770647336795373610",
    [1]: "crewmate_blue:770647334550765588",
    [2]: "crewmate_green:770647335751122994",
    [3]: "crewmate_pink:770647336132673537",
    [4]: "crewmate_orange:770647336434139146",
    [5]: "crewmate_yellow:770647337675784272",
    [6]: "crewmate_black:770647333167693845",
    [7]: "crewmate_white:770647338041344020",
    [8]: "crewmate_purple:770647336233861131",
    [9]: "crewmate_brown:770647335088291851",
    [10]: "crewmate_cyan:770647335276773417",
    [11]: "crewmate_lime:770647335838810123",
};

export const DEAD_COLOR_EMOTES: { [key: number]: string } = {
    [0]: "crewmate_red_dead:770647337450209311",
    [1]: "crewmate_blue_dead:770647334434504725",
    [2]: "crewmate_green_dead:770647336186544178",
    [3]: "crewmate_pink_dead:770647336778727454",
    [4]: "crewmate_orange_dead:770647336497446912",
    [5]: "crewmate_yellow_dead:770647338007658497",
    [6]: "crewmate_black_dead:770647334215745577",
    [7]: "crewmate_white_dead:770647337948545055",
    [8]: "crewmate_purple_dead:770647336342388767",
    [9]: "crewmate_brown_dead:770647335532625970",
    [10]: "crewmate_cyan_dead:770647335579418634",
    [11]: "crewmate_lime_dead:770647336187592745",
};

export const BOT_INVITE_LINK = process.env.BOT_INVITE_LINK;
export const COLOR_EMOTE_IDS = Object.values(COLOR_EMOTES).map(x => x.split(":")[1]);
export const EMOTE_IDS_TO_COLOR: { [key: string]: number } = {};
Object.entries(COLOR_EMOTES).forEach(x => (EMOTE_IDS_TO_COLOR[x[1].split(":")[1]] = +x[0]));
export const GROUPING_DISABLED_EMOJI = "<:impostor_grouping_disabled:770647337117810709>";
export const GROUPING_ENABLED_EMOJI = "<:impostor_grouping_enabled:770647337549955072>";
export const GROUPING_TOGGLE_EMOJI = "toggle_impostor_grouping:770647338523557939";
export const LEAVE_EMOJI = "leave_lobby:770665534793842708";
