# Remote check script by Joe OE5JFE
#

# As sysop run:
# node_mgmt ls to show connect file list
# node_mgmt cat nodefilename to show content of connect file
# node_mgmt startup to show startup file
# node_mgmt cron to show start_connect entries in cron file

use DXDebug;
use strict;
use warnings;


my $self = shift;
my $command = shift;

return (1) unless $self->priv >= 9;

my $res;
my @out;

if ($command eq "ls") {  # List all connect files
        my $data = qx(ls /spider/connect);
        $res = "List connect files: \n$data";
        dbg("DXCron::spawn: $res.") if isdbg('cron');
        push @out, $res; 
    } elsif ($command eq "cron") {
        my $data = qx(cat /spider/local_cmd/crontab | grep start_connect);
        $res = "Crontab node connect lines: \n$data";
        dbg("DXCron::spawn: $res.") if isdbg('cron');
        push @out, $res; 
    } elsif ($command eq "startup") {
        my $data = qx(cat /spider/scripts/startup);
        $res = "Startup file: \n$data";
        dbg("DXCron::spawn: $res.") if isdbg('cron');
        push @out, $res; 
    } elsif ($command =~ /^cat /) {
        my $nodename = substr($command, 4);
        my $data = "________Node file: $nodename _________________\n";
        open(FH, "/spider/connect/$nodename") or ($data = "File $nodename not found in /spider/connect");
        # Reading the file till FH reaches EOF
        while(<FH>){
        $data = "$data $_ \n";
        }
        close;
        $res = "$data";
        dbg("DXCron::spawn: $res.") if isdbg('cron');
        push @out, $res; 
    }


return (1, @out)