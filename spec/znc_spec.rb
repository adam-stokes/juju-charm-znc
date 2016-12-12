require 'tty-command'
require 'socket'

describe "ZNC Charm:" do
  before(:all) do
    @cmd = TTY::Command.new(printer: :null)
    @port, err = @cmd.run('config-get port')
  end

  describe "config" do
    it "has a config file" do
      expect(File.exists?('/var/lib/znc/configs/znc.conf')).to be true
    end

    it "has a systemd service file" do
      expect(File.exists?('/etc/systemd/system/znc.service')).to be true
    end

    it "is running the ZNC service" do
      expect(@cmd.run('systemctl status znc.service').success?).to be true
    end

    # it "is listening on correct port" do
    #   expect(Socket.tcp("localhost", @port, connect_timeout: 5) {}).to be true
    # end

    it "has correct port in config" do
      znc_config = File.read '/var/lib/znc/configs/znc.conf'
      expect(znc_config).to include("Port = #{@port}")
    end
  end
end
