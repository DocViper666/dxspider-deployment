# Git update script by Joe OE5JFE
# Inspired by check_update script by Kin EA3CV
#

# As sysop run update_git to check for new remote git versions
# Run update_git Y to perform git pull and kill ttyd.
# Make sure that you have a restart: unless-stopped rule for your cluster container
# or another way to restart your container

use DXDebug;
use strict;
use warnings;


my $self = shift;
my $update = shift;

return (1) unless $self->priv >= 9;



system('cd /spider');

my $act = $main::gitversion;
$act =~ s/\[r\]//g;
my $res;
my $line = "cd /spider; git reset --hard; git pull";
my @out;

system('git reset --hard');
if ($update eq "Y") {
    my $data = qx(git pull);
    my $new = `git log --oneline | head -n 1`;
    if ($data =~ /Updating/) {
        $res = "There is a new build: $new";
        dbg("DXCron::spawn: $res: $line") if isdbg('cron');
        push @out, $res;
        system("pkill -SIGKILL ttyd");
    } elsif ($data =~ /Already|actualizado/) {
        $res = "There is no new build ($main::build  $act)";
        push @out, $res;
        dbg("DXCron::spawn: $res") if isdbg('cron');
    } 
} else {
        $res = "Hint: Use argument Y to perform git pull";
        push @out, $res;
        dbg("DXCron::spawn: $res") if isdbg('cron');
        my $old = `git log --oneline | head -n 1`;
        system('git fetch');
        my $latest = `git log origin/mojo --oneline | head -n 1`;
        if ($old ne $latest) {
            $res = "Update available from ($main::build  $old) to latest $latest available! Run update_git Y to do update"; 
        } else {
            $res = "You are on the latest version ($main::build  $old)"; 
        }
        dbg("DXCron::spawn: $res") if isdbg('cron');
        push @out, $res;
        }




return (1, @out)