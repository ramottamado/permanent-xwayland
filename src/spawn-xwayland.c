#include <X11/Xlib.h>

#define NIL (0)

int main()
{
    Display *dpy = XOpenDisplay(NIL);
    XCloseDisplay(dpy);
    return 0;
}
