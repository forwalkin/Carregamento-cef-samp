#include <a_samp>
#include <cef>
#include <foreach>
#include <fmt>
#include <sscanf2>
#include <streamer>
#include <Pawn.CMD>

#define CARREGANDO_BROWSER_ID 98
#define CARREGANDO_URL "C://Users//computador//Documents//tes//cef_sa-mp_3.50//cef sa-mp 3.50//tata//html//metro//index.html"

public OnCefInitialize(player_id, success)
{
    if (success)
    {
        cef_create_browser(player_id, CARREGANDO_BROWSER_ID, CARREGANDO_URL, false, true);

        // Mensagem inicial
        cef_emit_event(player_id, "set_loading_text", "Sincronizando dados...");

        // Progresso inicial
        cef_emit_event(player_id, "set_progress", "10");

        // Simulação de progresso (exemplo apenas)
        SetTimerEx("FakeProgress", 4000, false, "i", player_id);
    }
}

forward FakeProgress(playerid);
public FakeProgress(playerid)
{
    cef_emit_event(playerid, "set_loading_text", "Carregando mapa...");
    cef_emit_event(playerid, "set_progress", "60");

    SetTimerEx("FinishProgress", 3000, false, "i", playerid);
}

forward FinishProgress(playerid);
public FinishProgress(playerid)
{
    cef_emit_event(playerid, "set_loading_text", "Finalizando...");
    cef_emit_event(playerid, "set_progress", "100");

    SetTimerEx("CloseLoading", 2000, false, "i", playerid);
}

forward CloseLoading(playerid);
public CloseLoading(playerid)
{
    cef_emit_event(playerid, "hide_loading");
    cef_focus_browser(playerid, CARREGANDO_BROWSER_ID, false);
    cef_hide_browser(playerid, CARREGANDO_BROWSER_ID, true);
    cef_destroy_browser(playerid, CARREGANDO_BROWSER_ID);
  	TogglePlayerControllable(playerid, 1);
}

