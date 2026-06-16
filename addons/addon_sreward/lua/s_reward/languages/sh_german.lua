--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

if CLIENT then
    slib.setLang("sreward", "de", "general", "Allgemein")
    slib.setLang("sreward", "de", "tasks", "Aufgaben")
    slib.setLang("sreward", "de", "referral", "Empfehlungen")
    slib.setLang("sreward", "de", "shop", "Shop")
    slib.setLang("sreward", "de", "leaderboard", "Bestenliste")
    slib.setLang("sreward", "de", "coupons", "Gutscheine")

    slib.setLang("sreward", "de", "main_title", "Server-Name - Belohnungs-System")
    slib.setLang("sreward", "de", "title_admin", "Server-Name - Admin")

    slib.setLang("sreward", "de", "rewards_title", "%s - Belohnungen")
    slib.setLang("sreward", "de", "coupon_title", "Gutscheine")

    slib.setLang("sreward", "de", "coupon_receive_title", "Neuer Gutschein!")
    slib.setLang("sreward", "de", "coupon_receive", "Sie haben einen neuen Gutschein erhalten, \n    Überprüfen Sie Ihren Coupon-Bestand!") --- Had to fine tune like that :(

    slib.setLang("sreward", "de", "copied_clipboard", "In die Zwischenablage kopiert!")
    slib.setLang("sreward", "de", "no_coupons", "Sie haben keine Gutscheine!")
    slib.setLang("sreward", "de", "no_rewards", "Es gibt keine Belohnungen!")

    slib.setLang("sreward", "de", "delete", "Löschen")
    slib.setLang("sreward", "de", "yes", "Ja")
    slib.setLang("sreward", "de", "no", "Nein")

    slib.setLang("sreward", "de", "top_3", "Top 3")

    slib.setLang("sreward", "de", "you", "Du")
    slib.setLang("sreward", "de", "friend", "Freund")

    slib.setLang("sreward", "de", "referr_with_code", "Mit Code empfehlen")

    slib.setLang("sreward", "de", "are_you_sure", "Bist du dir sicher?")
    slib.setLang("sreward", "de", "manage", "Verwalten")

    slib.setLang("sreward", "de", "tokens", "Tokens")
    slib.setLang("sreward", "de", "select_reward", "Wählen Sie Belohnung aus")
    slib.setLang("sreward", "de", "number", "Nummer")

    slib.setLang("sreward", "de", "submit", "Einreichen")
    slib.setLang("sreward", "de", "name", "Name")
    slib.setLang("sreward", "de", "uses", "Verwendungen")
    slib.setLang("sreward", "de", "used", "Eingelöst")
    slib.setLang("sreward", "de", "task", "Aufgabe")
    slib.setLang("sreward", "de", "verify", "Verifizieren")
    slib.setLang("sreward", "de", "total_tokens", "Token insgesamt")
    slib.setLang("sreward", "de", "referrals", "Empfehlungen")

    slib.setLang("sreward", "de", "rewards", "Belohnung")
    slib.setLang("sreward", "de", "price", "Preis")
    slib.setLang("sreward", "de", "imgur_id", "Imgur ID")

    slib.setLang("sreward", "de", "edit_rewards", "Belohnungen bearbeiten")
    slib.setLang("sreward", "de", "save", "Speichern")

    slib.setLang("sreward", "de", "insert_imgur_id", "Imgur ID Einfügen")
    slib.setLang("sreward", "de", "insert_name", "Namen eingeben")
    slib.setLang("sreward", "de", "insert_price", "Preis einfügen")

    slib.setLang("sreward", "de", "create_coupon", "Gutschein erstellen")
    slib.setLang("sreward", "de", "coupon_name", "Gutscheinname")

    slib.setLang("sreward", "de", "create_shopitem", "Shop-Artikel erstellen")
    slib.setLang("sreward", "de", "item_name", "Artikelname")

    slib.setLang("sreward", "de", "this_will_cost", "'%s' wird dich: %s tokens kosten!")
    slib.setLang("sreward", "de", "coupon_delete_confirm", "Dadurch wird der Gutschein gelöscht: '%s'?")
    slib.setLang("sreward", "de", "this_delete", "Dies wird gelöscht: '%s'")
    slib.setLang("sreward", "de", "no_data", "Keine Daten")

    slib.setLang("sreward", "de", "manage_item", "Artikel verwalten")

    slib.setLang("sreward", "de", "discord_failed_application_com", "Die Kommunikation mit Ihrer Discord-Anwendung ist fehlgeschlagen. Stellen Sie sicher, dass sie ausgeführt wird!")
    slib.setLang("sreward", "de", "discord_error_retrieving_data", "Beim Abrufen von Daten aus Discord ist ein Problem aufgetreten. Bitte informieren Sie die Teammitglieder darüber!")
else
    slib.setLang("sreward", "de", "cooldown", "Sie befinden sich in einer Verifizierungsabklingzeit, bitte warten Sie: %s Sekunden!")

    slib.setLang("sreward", "de", "added_queue", "Sie wurden zur Warteschlange hinzugefügt für: '%s' du erhälst eine Antwort in: %s Sekunden!")

    slib.setLang("sreward", "de", "added_steamgroup_queue", "Sie wurden der Warteschlange für die Überprüfung der Steamgruppe hinzugefügt. Sie erhalten innerhalb dieser Frist eine Antwort: %s Sekunden!")
    slib.setLang("sreward", "de", "didnt_find_steamgroup", "Wir konnten Sie in der Steamgruppe nicht finden, bitte versuchen Sie es erneut!")
    slib.setLang("sreward", "de", "failed_verification", "Anscheinend konnten wir die Prämie nicht verifizieren: '%s', Stellen Sie sicher, dass Sie die Aufgabe ordnungsgemäß ausführen.")
    
    slib.setLang("sreward", "de", "discord_error_retrieving_data", "Wir konnten Discord nicht kontaktieren, bitte versuchen Sie es später erneut!")
    slib.setLang("sreward", "de", "checking_wait", "Bitte warten Sie, während wir die Prämie überprüfen: '%s' für dich!")

    slib.setLang("sreward", "de", "steam_unsuccessfull", "Wir konnten Steam nicht kontaktieren, bitte versuchen Sie es später erneut!")
    slib.setLang("sreward", "de", "steam_private", "Die Überprüfung Ihrer Steam-Gruppen ist fehlgeschlagen. Stellen Sie sicher, dass Ihr Profil öffentlich ist, damit wir dies überprüfen können!")
    slib.setLang("sreward", "de", "success_reward", "Sie haben die: '%s' Belohnung erhalten!")

    slib.setLang("sreward", "de", "already_referred", "Sie haben diese Person bereits geworben!")
    slib.setLang("sreward", "de", "referral_limit", "Sie haben das maximale Empfehlungslimit erreicht!")
    slib.setLang("sreward", "de", "referred_person", "Sie haben eine Belohnung für das anwerben erhalten: %s")
    slib.setLang("sreward", "de", "referred_by", "Sie haben eine Belohnung für die Empfehlung erhalten %s!")
    slib.setLang("sreward", "de", "referring_person", "Sie haben eine Belohnung für die Empfehlung einer Person erhalten!")
    slib.setLang("sreward", "de", "cannot_referr_again", "Sie können diese Person nicht erneut empfehlen!")
    slib.setLang("sreward", "de", "raferring_ratelimit", "Ihre Rate wurde begrenzt, warten Sie, bis Ihre erste Empfehlungsanfrage abgeschlossen ist!")

    slib.setLang("sreward", "de", "mysql_successfull", "Wir haben uns erfolgreich mit der Datenbank verbunden!")
    slib.setLang("sreward", "de", "mysql_failed", "Die Verbindung zur Datenbank ist fehlgeschlagen!")
    slib.setLang("sreward", "de", "cannot_afford", "Du kannst dir das nicht leisten!")
    slib.setLang("sreward", "de", "successfull_purchase", "Sie haben erfolgreich: '%s' gekauft!")

    slib.setLang("sreward", "de", "taken_tokens", "jemand hat: %s tokens von dir genommen, dein guthaben ist: %s!")
    slib.setLang("sreward", "de", "given_tokens", "Jemand hat dir: %s tokens gegeben, dein guthaben ist: %s!")
    slib.setLang("sreward", "de", "given_reward", "Jemand hat dir die Belohnung gegeben: '%s'!")
    slib.setLang("sreward", "de", "you_got_tokens", "Du hast %s Tokens erhalten, dein neues Guthaben beträgt: %s!")

    slib.setLang("sreward", "de", "performed_admin_action", "Sie haben eine Administratoraktion ausgeführt für: '%s' mit dem Wert von '%s'")
    slib.setLang("sreward", "de", "coupon_out_of_stock", "Wir sind derzeit nicht vorrätig für '%s' Coupons, wenden Sie sich bitte an die Teammitglieder, damit wir diese auffüllen können!")
end

slib.setLang("sreward", "de", "on_cooldown", "Sie befinden sich in einer Abklingzeit: %s Sekunden, um diese Belohnung erneut zu verwenden!")

slib.setLang("sreward", "de", "max_use_reached", "Sie haben das maximale Verwendungslimit dieser Belohnung erreicht!")

slib.setLang("sreward", "de", "sr_tokens", "sR Tokens")

slib.setLang("sreward", "de", "darkrp_money", "DarkRP Geld")

slib.setLang("sreward", "de", "reward_rank", "Rang")

slib.setLang("sreward", "de", "coupon", "Gutschein")

slib.setLang("sreward", "de", "give_weapon", "Waffe geben")

slib.setLang("sreward", "de", "basewars_money", "Basewars Geld")
slib.setLang("sreward", "de", "basewars_level", "Basewars Level")

slib.setLang("sreward", "de", "vrondakis_level", "Level")
slib.setLang("sreward", "de", "vrondakis_xp", "XP")

slib.setLang("sreward", "de", "glorified_level", "Level")
slib.setLang("sreward", "de", "glorified_xp", "XP")

slib.setLang("sreward", "de", "essentials_level", "Level")
slib.setLang("sreward", "de", "essentials_xp", "XP")

slib.setLang("sreward", "de", "elite_xp", "XP")
slib.setLang("sreward", "de", "elevel_xp", "XP")

slib.setLang("sreward", "de", "elevel_xp", "XP")

slib.setLang("sreward", "de", "wos_level", "wOS Level")
slib.setLang("sreward", "de", "wos_xp", "wOS XP")
slib.setLang("sreward", "de", "wos_points", "wOS Punkte")
slib.setLang("sreward", "de", "wos_giveitem", "wOS item geben")

slib.setLang("sreward", "de", "ps1_points", "PS1 Punkte")

slib.setLang("sreward", "de", "ps2_standard_points", "PS2 Standard Punkte")
slib.setLang("sreward", "de", "ps2_premium_points", "PS2 Premium Punkte")

slib.setLang("sreward", "de", "sh_ps_standard_points", "SH PS Standard Punkte")
slib.setLang("sreward", "de", "sh_ps_premium_points", "SH PS Premium Punkte")

slib.setLang("sreward", "de", "give_tokens", "Gebe Tokens")
slib.setLang("sreward", "de", "give_reward", "Gebe Belohnung")
slib.setLang("sreward", "de", "take_tokens", "Nehme Tokens")

slib.setLang("sreward", "de", "invalid_sid64", "Ungültige SteamID64")
slib.setLang("sreward", "de", "cannot_referr_yourself", "Du kannst dich nicht selbst Empfehlen!!")

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
