quitprompt: {

    show "Do you really want to quit? (Y/N)";
    prompt: read0 0;
    if[prompt[0] in ("Y";"y"); end::1]
 
 }