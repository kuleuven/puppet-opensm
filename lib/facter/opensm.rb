# Fact: opensm_version
# Fact: opensm_ports
# Fact: has_opensm
#
# Purpose: Detect various OpenSM parameters
#
Facter.add("opensm_version") do
  confine :kernel => :linux
  setcode do
    out = Facter::Core::Execution.exec('opensm --version 2>/dev/null')

    # Debian adds release date into version number as well,
    # e.g.: '3.2.6_20090317'. This is stripped so that only
    # main version number '3.2.6' is returned
    if out and out =~ /^OpenSM ([\d\.]+)/i
      $1
    end
  end
end

Facter.add("opensm_ports") do
  confine :kernel => :linux
  setcode do
    out = Facter::Core::Execution.exec('ibstat -p 2>/dev/null')
    if out
      out.split()
    else
      []
    end
  end
end

Facter.add("has_opensm") do
  setcode do
    if Facter.value('opensm_version')
      true
    else
      false
    end
  end
end
