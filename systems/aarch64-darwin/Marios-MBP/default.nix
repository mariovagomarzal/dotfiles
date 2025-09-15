###################################################
# Mario's MacBook Pro (Marios-MBP) Darwin system. #
###################################################
{systems, ...}: {
  system.stateVersion = 6;

  # Specific host information.
  host = {
    hostname = "Marios-MBP";
    computername = "Mario's MacBook Pro";
  };

  # Specific users information.
  system.primaryUser = "mariovagomarzal";
}
