Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66EEEAA42
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 03:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjIODbM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjIODbL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 23:31:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFFB1981
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:31:06 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a9f88b657eso1013740b6e.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694748666; x=1695353466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnEn8W0O/WfG3E9V7fJqsFVq0qD6qmcTquL57RIMtfY=;
        b=j9ostkM2cpktexFKWCQEBUUK48aRRmBf7EV/0NiTGWTNAD2hximSl6oxYq8PvstS9y
         3J1T8KoD5C05rCe0zIhL/3sgwPcFDvghHyujD/pev3oTL45CcfcJe93TU8YE+vRO5ni2
         WpO7Hg6UDP1YePHB/jzsIeJPLvdpQP0G/DlAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748666; x=1695353466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnEn8W0O/WfG3E9V7fJqsFVq0qD6qmcTquL57RIMtfY=;
        b=h6u/RD5wMyDm/W1/CKwoSWhP4HvJOr4sD+LSGWA55cO4m34S5Qk772IBUXhDpKOrL2
         nBbtLu+ukTqG9EhFeDpZ3zRxOgV6KQfIraN5y6VE/2jsK+hLEKduW9s9o5EKNex/aDa+
         dFQXS5X76Vd8m2y5h5EqTiU8olui7h0ECLA8qpVPeGg8SR2atjySBxvjjFLvxOocN/h4
         MOG+xT8msdMWE1nmb+9Q2oG5qrylmEd2NQvaVxC5tjGHNtYKIfNGZFAJ+kusyQjmrV7j
         N+qvU2qC8plxdMZpzVbx1WNVEaBtntgU4jklchTFcKikhnM7f0YvnwdZ/EE72cBL3Lfd
         ml1w==
X-Gm-Message-State: AOJu0YzxhyWZom9G5IfionvYi7nRugtPPZhvJwebg9+SGPrkyhzG2DKU
        W6Xl06uLhJIsk3Ek5G8eRDKF8g==
X-Google-Smtp-Source: AGHT+IFES3K1o6pJgXt1OFIm2ewVAPmS8TaHwIT0fHMBkd3ogq2E/I42VTS+VP8iaGRKtIf/uLyF7Q==
X-Received: by 2002:a05:6808:118:b0:3a7:5cc1:69b0 with SMTP id b24-20020a056808011800b003a75cc169b0mr525444oie.7.1694748666242;
        Thu, 14 Sep 2023 20:31:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78b50000000b0068883728c16sm2073190pfd.144.2023.09.14.20.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:31:05 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:31:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] checkpatch: add a couple new alloc functions to
 alloc with multiplies check
Message-ID: <202309142030.23EFD5D@keescook>
References: <ZQCaO+tYycDxVLy7@work>
 <5d72679f634080c8df3c2269495267171cf72f66.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d72679f634080c8df3c2269495267171cf72f66.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 12, 2023 at 10:51:22AM -0700, Joe Perches wrote:
> On Tue, 2023-09-12 at 11:04 -0600, Gustavo A. R. Silva wrote:
> > vmalloc() and vzalloc() functions have now 2-factor multiplication
> > argument forms vmalloc_array() and vcalloc(), correspondingly.
> 
> > Add alloc-with-multiplies checks for these new functions.
> > 
> > Link: https://github.com/KSPP/linux/issues/342
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  scripts/checkpatch.pl | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 7d16f863edf1..45265d0eee1b 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -7207,17 +7207,19 @@ sub process {
> >  			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
> >  		}
> >  
> > -# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
> > +# check for (kv|k|v)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/vmalloc_array/kvcalloc/kcalloc/vcalloc
> >  		if ($perl_version_ok &&
> >  		    defined $stat &&
> > -		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
> > +		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,?/) {
> >  			my $oldfunc = $3;
> >  			my $a1 = $4;
> >  			my $a2 = $10;
> >  			my $newfunc = "kmalloc_array";
> >  			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
> > +			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
> >  			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
> >  			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
> > +			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
> >  			my $r1 = $a1;
> >  			my $r2 = $a2;
> >  			if ($a1 =~ /^sizeof\s*\S/) {
> > @@ -7233,7 +7235,7 @@ sub process {
> >  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
> >  				    $cnt == 1 &&
> >  				    $fix) {
> > -					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> > +					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> >  				}
> >  			}
> >  		}
> 
> Seems ok.  Dunno how many more of these there might be like
> devm_ variants, but maybe it'd be better style to use a hash
> with replacement instead of the repeated if block
> 
> Something like:
> ---
>  scripts/checkpatch.pl | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1c..bacb63518be14 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -854,6 +854,23 @@ foreach my $entry (keys %deprecated_apis) {
>  }
>  $deprecated_apis_search = "(?:${deprecated_apis_search})";
>  
> +our %alloc_with_multiply_apis = (
> +	"kmalloc"		=> "kmalloc_array",
> +	"kvmalloc"		=> "kvmalloc_array",
> +	"vmalloc"		=> "vmalloc_array",
> +	"kvzalloc"		=> "kvcalloc",
> +	"kzalloc"		=> "kcalloc",
> +	"vzalloc"		=> "vcalloc",
> +);

Yeah, this seems more readable. Gustavo can you send a v2 with this
rework?

Thanks!

-Kees

> +
> +#Create a search pattern for all these strings to speed up a loop below
> +our $alloc_with_multiply_search = "";
> +foreach my $entry (keys %alloc_with_multiply_apis) {
> +	$alloc_with_multiply_search .= '|' if ($alloc_with_multiply_search ne "");
> +	$alloc_with_multiply_search .= $entry;
> +}
> +$alloc_with_multiply_search = "(?:${alloc_with_multiply_search})";
> +
>  our $mode_perms_world_writable = qr{
>  	S_IWUGO		|
>  	S_IWOTH		|
> @@ -7210,14 +7227,11 @@ sub process {
>  # check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> -		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
> +		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*($alloc_with_multiply_search)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
>  			my $oldfunc = $3;
> +			my $newfunc = $alloc_with_multiply_apis{$oldfunc};
>  			my $a1 = $4;
>  			my $a2 = $10;
> -			my $newfunc = "kmalloc_array";
> -			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
> -			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
> -			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
>  			my $r1 = $a1;
>  			my $r2 = $a2;
>  			if ($a1 =~ /^sizeof\s*\S/) {
> @@ -7233,7 +7247,7 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt == 1 &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*($alloc_with_multiply_search)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
>  				}
>  			}
>  		}
> 

-- 
Kees Cook
