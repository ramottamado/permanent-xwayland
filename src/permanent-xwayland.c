#include <X11/Xlib.h>

#define NIL (0)

int main()
{
    Display *dpy = XOpenDisplay(NIL);
    return 0;
}
