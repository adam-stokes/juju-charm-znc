require 'charmkit'


namespace :znc do
  desc "Install ZNC"
  task :install do
    package ['znc', 'znc-perl', 'znc-tcl', 'znc-python'], :update_cache
    hook_path = ENV['JUJU_CHARM_DIR']

    log "Creating ZNC user"
    if cmd.run!('useradd --create-home -d /var/lib/znc --system --shell /sbin/nologin --comment "Account to run ZNC daemon" --user-group znc').failure?
      log "This user already exists, skipping"
    end
    inline_template('znc.service',
                    '/etc/systemd/system/znc.service')

    mkdir_p '/var/lib/znc/configs'
  end

  desc "Configure ZNC"
  task :config_changed do

    admin_user = config 'admin_user'
    admin_password = config 'admin_password'
    if (admin_user.nil? or admin_user.empty?) or (admin_password.nil? or admin_password.empty?)
      status :blocked, "Waiting for an admin username and password to be set, see juju config znc"
      exit 0
    end

    # Need to parse admin password into proper variables for znc
    admin_password_salt = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
    admin_password_hash = Digest::SHA256.hexdigest(admin_password + admin_password_salt)

    inline_template('znc.conf',
                    '/var/lib/znc/configs/znc.conf',
                    port: config('port'),
                    admin_user: config('admin_user'),
                    admin_password: config('admin_password'),
                    admin_password_salt: admin_password_salt,
                    admin_password_hash: admin_password_hash)

    chown_R "znc", "znc", "/var/lib/znc"
    cmd.run 'systemctl daemon-reload'
    cmd.run 'systemctl restart znc'

    out, err = cmd.run 'znc --version'
    if match = out.match(/^ZNC\s(\d\.\d\.\d)/i)
      version = match.captures
      cmd.run "application-version-set #{version}"
    else
      cmd.run 'application-version-set Unknown'
    end

    status :active, "ZNC is ready"
  end

  desc "Test ZNC Charm"
  task :test do
    cmd.run 'bundle exec ./tests/verify'
  end
end

__END__

@@ znc.service
[Unit]
Description=znc, and advanced IRC bouncer
After=network-online.target

[Service]
ExecStart=/usr/bin/znc -f --datadir=/var/lib/znc
User=znc
Group=znc

[Install]
WantedBy=multi-user.target

@@ znc.conf
Version = 1.6.3
<Listener l>
	  Port = <%= port %>
          IPv4 = true
          IPv6 = false
          SSL = false
</Listener>
LoadModule = webadmin

<User <%= admin_user %>>
	Admin      = true
	Nick       = <%= admin_user %>
	AltNick    = <%= admin_user %>_
	Ident      = <%= admin_user %>
	RealName   = ZNC Managed by Juju
	LoadModule = chansaver
	LoadModule = controlpanel
        <Pass <%= admin_password %>>
          hash = <%= admin_password_hash %>
          method = sha256
          salt = <%= admin_password_salt %>
        </Pass>
</User>
