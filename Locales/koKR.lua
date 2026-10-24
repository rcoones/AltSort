local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "koKR")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "가방 / 은행 정렬"
L["bags"] = "가방"
L["bank"] = "은행"
L["warband bank"] = "전쟁부대 은행"
L["Can't sort in combat."] = "전투 중에는 정렬할 수 없습니다."
L["Drop the item on your cursor first."] = "먼저 커서에 있는 아이템을 내려놓으세요."
L["Open your bank first."] = "먼저 은행을 여세요."
L["Sorting the %s isn't available on this client."] = "이 클라이언트에서는 %s 정렬을 사용할 수 없습니다."
L["Sorting failed: %s"] = "정렬 실패: %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s 키는 이미 사용 중입니다. 단축키 설정 > Alt Sort에서 '가방 / 은행 정렬'을 지정하세요."
L["Reset. %s is bound to Sort Bags / Bank."] = "초기화했습니다. %s 키가 '가방 / 은행 정렬'에 지정되었습니다."
L["Reset. %s will be bound when combat ends."] = "초기화했습니다. 전투가 끝나면 %s 키가 지정됩니다."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - 가방을 정렬하고, 은행이 열려 있으면 은행을 정렬합니다 (기본 키 %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - 은행 정렬 (은행이 열려 있어야 함)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - 기본 단축키 %s 다시 적용"
L["/altsort help - show this list"] = "/altsort help - 이 목록 표시"
L["Sort order"] = "정렬 순서"
L["Ascending"] = "오름차순"
L["Descending"] = "내림차순"
L["ascending"] = "오름차순"
L["descending"] = "내림차순"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "오름차순은 첫 번째 칸부터 가방을 채우고, 내림차순은 마지막 칸부터 채웁니다."
L["Sort order: %s"] = "정렬 순서: %s"
L["Use /altsort order ascending or /altsort order descending."] = "/altsort order ascending 또는 /altsort order descending 을(를) 사용하세요."
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - 정렬 순서 설정 (현재: %s)"
