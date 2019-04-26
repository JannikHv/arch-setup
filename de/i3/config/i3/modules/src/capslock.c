#include <stdio.h>
#include <stdlib.h>
#include <X11/XKBlib.h>

//  

int main ()
{
    Display *display = XOpenDisplay(getenv("DISPLAY"));
    Status status;
    unsigned state;

    if (!display) {
        return 1;
    }

    if (XkbGetIndicatorState(display, XkbUseCoreKbd, &state) != Success) {
        return 2;
    }

    char *text = (state & 1) ? "" : "";

    printf(" %s ", text);
}
