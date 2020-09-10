{ lib, ... }: {
  console.keyMap = "uk";

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "gb,us";
    XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/Copenhagen";
}
