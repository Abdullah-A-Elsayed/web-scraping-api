use WWW::Mechanize;
use strict;
use warnings;
use Data::Dumper;
use utf8;
use open qw(:std :utf8);

#==================== getting car data ==================================================#
my $filename = $ARGV[0];
open(my $fhr, '<:encoding(UTF-8)', $filename);
my $f_l = <$fhr>; my $s_l = <$fhr>; my $t_l = <$fhr>; my $nums = <$fhr>;
chomp $f_l ; chomp $s_l ; chomp $t_l ; chomp $nums ;
# print $f_l ; print $s_l ; print $t_l ; print $nums ;
close $fhr;
#========================================================================================#

#============================== scraping ================================================#
my $mech = WWW::Mechanize->new;

$mech->get('https://www.egypt.gov.eg/mobile/Services/NTPMOJ-GG/functions/PayFines.aspx');

# Submitting ..
my $response = $mech->submit_form(
  form_name => 'form1',
  fields => {
    'cSearch$txtPlateAlpaNum$txtFL' => $f_l ,
    'cSearch$txtPlateAlpaNum$txtSL' => $s_l ,
    'cSearch$txtPlateAlpaNum$txtTL' => $t_l ,
    'cSearch$txtPlateAlpaNum$txtDg' => $nums ,
  },
  button => 'cSearch$btnSearch',
);
#========================================================================================#


#========================================= reporting =====================================#
my $whole_report = $response->decoded_content(charset=>'utf8');

#succeded to bring it??
if ( $whole_report =~ m/<span id="cFinesSummary_lblTotalNew" class="keyword">(.+)?<\/span>/ ){
    # print "success\n" ;
    my $res =$1;
    if ($res =~ /لا يوجد/){
      print "no fines";
    }
    else{
      print $res;
    }
} else{
  print "failed getting car data";
}

#========================================================================================#


#========================================= debugging =====================================#
#get form names
# my $form =$mech->form_name('form1'); #hard coded
# my @inputfields = $form->param;
# foreach my $inputfield (@inputfields) {
#   print $inputfield."\n";
# }

# open(my $fh, '>', 'mroor-report.html');
# print $fh  $whole_report;
# close $fh;
# print "done\n";
#========================================================================================#
