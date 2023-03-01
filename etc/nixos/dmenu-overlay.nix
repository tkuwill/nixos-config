(self: super: {
    dmenu = super.dmenu.overrideAttrs (oldAttrs: {
    pname = "dmenu-tku";
    version = "1.0.0";
    src = /home/will/dmenu ;
       });
})

