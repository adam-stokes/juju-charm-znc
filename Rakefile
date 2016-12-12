require 'charmkit'


namespace :znc do
  desc "Install ZNC"
  task :install do
    package ['znc', 'znc-perl', 'znc-tcl', 'znc-python'], :update_cache
    hook_path = EVN['JUJU_CHARM_DIR']

    inline_template('znc.service',
                    '/etc/systemd/system/znc.service')

    mkdir_p '/srv/znc/.znc/configs'
    inline_template('znc.conf',
                    '/srv/znc/.znc/configs/znc.conf',
                    port: config('port'),
                    admin_user: config('admin_user'),
                    admin_password: config('admin_password'))
    cmd.run 'systemctl restart znc'
  end

  desc "Configure ZNC"
  task :config_changed do
    out, err = run 'znc --version'
    if match = out.match(/^ZNC\s(\d\.\d\.\d)/i)
      version = match.captures
      cmd.run 'application-version-set #{version}'
    else
      cmd.run 'application-version-set Unknown'
    end
    inline_template('znc.conf',
                    '/srv/znc/.znc/configs/znc.conf',
                    port: config('port'),
                    admin_user: config('admin_user'),
                    admin_password: config('admin_password'))
    cmd.run 'systemctl restart znc'
    status :active, "ZNC is ready"
  end

  desc "Test ZNC Charm"
  task :test do
    cmd.run './tests/00-run'
  end
end

__END__

@@ znc.service
[Unit]
Description=znc, and advanced IRC bouncer
After=network-online.target

[Service]
ExecStart=/usr/bin/znc -f --datadir=/srv/znc/.znc
User=ubuntu
Group=ubuntu

[Install]
WantedBy=multi-user.target

@@ znc.conf
Version = 1.6.3
<Listener l>
	  Port = <%= $port %>
          IPv4 = true
          IPv6 = false
          SSL = false
</Listener>
LoadModule = webadmin

<User <%= admin_user %>
	Pass       = <%= admin_password %>
	Admin      = true
	Nick       = <%= admin_user %>
	AltNick    = <%= admin_user %>_
	Ident      = <%= admin_user %>
	RealName   = ZNC Managed by Juju
	LoadModule = chansaver
	LoadModule = controlpanel
</User>
