require 'etc'

module PrivilegeHelpers
  # Change UID/GID to the specified user.
  # Best practice: drop GID before UID since we need root privileges to change GID.
  # See: https://docs.ruby-lang.org/en/master/Process/UID.html
  module_function def change_user(user)
    user_info = Etc.getpwnam(user)

    # Drop GID first (requires root), then UID
    Process::GID.change_privilege(user_info.gid)
    Process::UID.change_privilege(user_info.uid)

    # Set environment for the target user
    ENV['HOME'] = user_info.dir
    ENV['USER'] = user
    ENV['LOGNAME'] = user
  end
end
