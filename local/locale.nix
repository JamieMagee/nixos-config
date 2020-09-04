{ lib, ... }: {
  console.keyMap = "uk";

  # environment.sessionVariables = {
  #   XKB_DEFAULT_LAYOUT = "uk,us";
  # };

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/Copenhagen";
}
