# -*- shell-script -*-

asn ()
{
    reverse=$(
	   echo $1 | awk -F. '{ print $4"."$3"."$2"."$1 }'
	   )

    host -t txt $reverse.origin.asn.cymru.com
    host -t txt $reverse.asn.routeviews.org
}
