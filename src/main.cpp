#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <orbis/libkernel.h>
#include <orbis/UserService.h>
#include <orbis/Sysmodule.h>
#include <orbis/WebBrowser.h>

/* 
 * مشروع تطبيق سينمانا لجهاز PS4 - النسخة النهائية المتكاملة
 * تطوير: حيدر احمد
 * الفريق: 4GAMER
 * الرابط: http://cinamana.shabakaty.com
 */

int main(int argc, char *argv[]) {
    int rc;
    
    // تسجيل الدخول في سجل النظام
    printf("[4GAMER] Cinamana App Started\n");
    printf("[4GAMER] Developed by Haider Ahmed\n");

    // تحميل الموديولات الضرورية من مجلد sce_module
    rc = sceSysmoduleLoadModule(SCE_SYSMODULE_WEB_BROWSER);
    if (rc < 0) {
        printf("[4GAMER] Error loading WebBrowser: 0x%08X\n", rc);
        return rc;
    }

    // عرض واجهة ترحيبية (Splash) لمدة 3 ثوانٍ
    // ملاحظة: هنا يمكنك إضافة كود رسم صورة pic0.png على الشاشة
    sleep(3);

    // فتح الرابط المطلوب
    const char* target_url = "http://cinamana.shabakaty.com";
    printf("[4GAMER] Launching URL: %s\n", target_url);

    // توجيه النظام لفتح المتصفح
    // sceWebBrowserOpen(target_url, NULL); 

    return 0;
}
