use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Egg::Plugin::SessionKit::Bind::URI',
    VERSION_FROM      => 'lib/Egg/Plugin/SessionKit/Bind/URI.pm', # finds $VERSION
    PREREQ_PM         => { "HTML::StickyQuery" => 0.12 , NEXT => 0.60, Egg::Plugin::SessionKit => 0.01}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Egg/Plugin/SessionKit/Bind/URI.pm', # retrieve abstract from module
       AUTHOR         => 'Akira Horimoto <emperor.kurt@gmail.com>') : ()),
);
