_str = (([] CALL NEARESTVILLAGE) + "Task"); 
if (isNil{SaOkSaOkmissionnamespace getvariable _str}) then {
//CONVERSATION
(player getvariable "CivC") SPAWN {
_aika = time + 6;
if (!isNil{player getvariable "LastW"}) then {
waitUntil {sleep 0.1; player kbWasSaid [_this, "PlaV", (player getvariable "LastW"), 3] || {_aika < time}};
} else {sleep 6;};
[_this,player, "PlaV", "CivT7"]SPAWN SAOKKBTELL;
};
_head = "I cant go any where, I am totally lost! My car have broken wheel but there is no mechanic in this doomed village. I cant drive to meet my relatives and even my cat is missing or just ignoring me";
_toChoose = ["I see what can I do","Pull yourself together, man","Anything else I could do?"];
_nul = [_head, _toChoose,"S",[["V17"],["V6"],["V13","V14","V16","V40"]],(player getvariable "CivC")] SPAWN FConversationDialog;
//TASK TAKEN
waitUntil {sleep 0.5; scriptdone _nul};
if (isNil"LineSelected") exitWith {};
if (LineSelected == 0) then {
[player,"TaskRepair",false,false] spawn BIS_fnc_MP;

} else {
//ANOTHER TASK
if (LineSelected == 2) then {
_nV = [player] CALL NEARESTVILLAGE;
_tasks = ["VillageTasks\TaskCrate.sqf","VillageTasks\TaskCivPOW.sqf","VillageTasks\TaskEscort.sqf"];
if ({isNil{_x getvariable "Ghost"}} count (nearestObjects [getmarkerpos _nV, ["Land_BarrelWater_F"], 50]) == 0) then {_tasks = _tasks + ["VillageTasks\TaskWater.sqf"];};
if (count ((getposATL  player) nearEntities [["C_SUV_01_F","C_Van_01_box_F","C_Van_01_transport_F","C_Hatchback_01_sport_F","C_Hatchback_01_F","C_Offroad_01_F","C_Quadbike_01_F"], 50]) > 0) then {_tasks = _tasks + ["VillageTasks\TaskRepair.sqf"];};
if ({getmarkercolor _x == "ColorRed" && getmarkerpos _x distance vehicle player < 300 && {alive _x && {side _x == EAST}} count (getmarkerpos _x nearEntities [["Man"],80]) > 0} count FORTRESSESMM > 0) then {_tasks = ["VillageTasks\TaskFortress.sqf"];};
if !((getmarkerpos _nV) distance (getposATL ([getmarkerpos _nV] CALL RETURNGUARDPOST)) < 500) then {_tasks = _tasks + ["VillageTasks\TaskGuardPost.sqf"];};

if (count _this > 0) then {_tasks = _tasks - [_this select 0];};
_picked = _tasks call RETURNRANDOM;
if (!isNil{SaOkmissionnamespace getvariable "TaskChosen"} && {SaOkmissionnamespace getvariable "TaskChosen" != "Random Task"}) then {_picked = SaOkmissionnamespace getvariable "TaskChosen";};

_nul = [_picked] SPAWN SAOKSTARTTASK;
};
};

} else {
"You havent completed previous task yet for this village" SPAWN HINTSAOK;
};