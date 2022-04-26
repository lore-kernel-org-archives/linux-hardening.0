Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1CEC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Apr 2022 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbiDZOuL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiDZOuK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Apr 2022 10:50:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDCB289AD;
        Tue, 26 Apr 2022 07:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8A63BCE1EC7;
        Tue, 26 Apr 2022 14:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43544C385AA;
        Tue, 26 Apr 2022 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650984417;
        bh=/8WlzJeTBNWdeEvwIpkR3MrSpPzIdcQR58JBfllQbg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyl4AjDWt4sAcE0/gUSdiGR9zz7nOQhSkgWk1ASyVK9yCRxCprkpHuqQe3Z4id9uI
         FCODM7zTPKCMycIuYtkkm1jcXYto3ecXJ20nCwoAxsFez+VvteusBDERbXvzA/neCi
         LGCys4wkcjT+nSFCFpgHaZsDUEaT2eM4cldtVaV97EaAfwo4RDEw1/Y0391jGsS1ox
         9fvD0q2Wtc660LK7txzDJ/ULatEpwmnExFwruNPYPa3jRW/ddai33rMKvlBXF/bMvJ
         qNprdx9WAXaGaHLKlZUJdu7osDtCR/hD8fZ9JejObeeCRyrV9IvjfdEJKM+klrzvI6
         qWQ01xNl7d3Rw==
Date:   Tue, 26 Apr 2022 09:55:54 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] checkpatch: add new alloc functions to alloc with
 multiplies check
Message-ID: <20220426145554.GA7712@embeddedor>
References: <20220426062043.GA19970@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426062043.GA19970@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 26, 2022 at 01:20:43AM -0500, Gustavo A. R. Silva wrote:
> kvmalloc() and kvzalloc() functions have now 2-factor multiplication
> argument forms kvmalloc_array() and kvcalloc(), correspondingly.
> 
> Add alloc-with-multiplies checks for these new functions.
> 
> Link: https://github.com/KSPP/linux/issues/187
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I've taken this in my -next tree for 5.19:

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-next/kspp-checkpatch

Thanks
--
Gustavo

> ---
>  scripts/checkpatch.pl | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 577e02998701..503e8abbb2c1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7033,14 +7033,16 @@ sub process {
>  			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
>  		}
>  
> -# check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
> +# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> -		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
> +		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
>  			my $oldfunc = $3;
>  			my $a1 = $4;
>  			my $a2 = $10;
>  			my $newfunc = "kmalloc_array";
> +			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
> +			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
>  			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
>  			my $r1 = $a1;
>  			my $r2 = $a2;
> @@ -7057,7 +7059,7 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt == 1 &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
>  				}
>  			}
>  		}
> -- 
> 2.27.0
> 
