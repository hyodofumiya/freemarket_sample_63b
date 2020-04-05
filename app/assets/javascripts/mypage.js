window.addEventListener('turbolinks:load', addEventMypageTabs);

function addEventMypageTabs()
{
    const tabs= document.getElementById("mypage_tabs_for_js");
    if(tabs)
    {
        tabs.addEventListener("click",mypageTabController);
    }
}

function mypageTabController(event)
{
    const TABS_CLASS = "mypage_tabs__tab__button";//すべてのタブについているクラス
    const TAB_INACTIVE_CLASS = "mypage_tabs__tab__button--inactive";//非アクティブなタブについているクラス

    const LIST_CLASS = "mypage_users_items";//商品リストについているクラス
    const LIST_INACTIVE_CLASS = "mypage_users_items--inactive";//非アクティブな商品リストについているクラス

    const inactiveTab = document.querySelector(`.${TAB_INACTIVE_CLASS}`);
    if(event.target == inactiveTab)
    {
        //ボタンのクラス入れ替え
        mypageToggleInactiveClass(TABS_CLASS, TAB_INACTIVE_CLASS);
        //リストのクラス入れ替え
        mypageToggleInactiveClass(LIST_CLASS, LIST_INACTIVE_CLASS);
    }
}

function mypageToggleInactiveClass(commonClass, inactiveClass)
{
    const tabs = document.getElementsByClassName(commonClass);
    for(let i=0; i < tabs.length; i++)
    {
        if(tabs[i].classList.contains(inactiveClass))
        {
            tabs[i].classList.remove(inactiveClass);
        }
        else
        {
            tabs[i].classList.add(inactiveClass);
        }
    }
}