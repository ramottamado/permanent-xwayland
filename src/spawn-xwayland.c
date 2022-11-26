#include <string.h>
#include <glib-2.0/glib.h>
#include <X11/Xlib.h>

#define NIL (0)

int main()
{
    Display *dpy = XOpenDisplay(NIL);
    XHostAddress host_entry;
    XServerInterpretedAddress siaddr;

    siaddr.type = (char *)"localuser";
    siaddr.typelength = strlen(siaddr.type);
    siaddr.value = (char *)g_get_user_name();
    siaddr.valuelength = strlen(siaddr.value);

    host_entry.family = FamilyServerInterpreted;
    host_entry.address = (char *)&siaddr;

    XAddHost(dpy, &host_entry);
    XCloseDisplay(dpy);

    return 0;
}
