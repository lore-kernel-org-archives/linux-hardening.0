Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A0CC6FA82
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiI0OHm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiI0OHh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Sep 2022 10:07:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41A1B261F
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 07:07:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b23so9764138pfp.9
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bZMxWAC+LHys6lv035SqnZh6LxG78CMqqD7T8X44m5s=;
        b=AWTSS9q0IWgLXo3UA7tSmdMqfI+w2/bt92CD5o35I/G9txXgpFt7FCObhybkrrk1zz
         jl9z+hTHHBQD6X1Byh7EQM9oGNg4+baMSDh+L/mhwvL3VqWeezjYr4awl2wsgfKYHKrM
         wakB3ki1KAzt9gzbsnAlIV2Qm9Z40qXZuP5E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bZMxWAC+LHys6lv035SqnZh6LxG78CMqqD7T8X44m5s=;
        b=xJuzyoBuUDvplcdQbsxIA/9jcIexlneuVkAFjC9s11ZUVTDfCIVHP7mTYI2V1Vqs1r
         tkkB9txV2YH4T6IxIt980Z/T8J0EsyjsMd8a09fYUIU7wfZdYrXULIHIFuh2Zn3YmOyA
         Uvm/HyXaH6I377loh/XjYNwioy5hSoJN6JBvIC1AaUxFrD5tpk+/i7WRjnl49EXRiCBn
         XGCdJbs8zNTnYBVYz3pIBce6LnLEMiuGE/Kw22TabASzk52yjjicg+zf24CZKpbFBcfB
         DdrqaAs4NHErdYlpf650qIGQ6Ma3PhfcA3EHy9GdMUni6nkCFdyKxNIiZyyuOWXVQ4IP
         GgIw==
X-Gm-Message-State: ACrzQf3LsdnFO0L6KXZfusZwifWzGv+i81So5hYQaq0m+OwhfJ1NpnW/
        Bp3nthZdZn9uMkkFBhVkKOTQjA==
X-Google-Smtp-Source: AMsMyM5ONlFy4ihyw0vSWPzLSFmq3N2mYdTChbGyXsf3a6NizQTc+G5MDCsu42tigb3y5Fzyi4364A==
X-Received: by 2002:a05:6a00:1a55:b0:557:b7a3:6738 with SMTP id h21-20020a056a001a5500b00557b7a36738mr17337479pfv.61.1664287649636;
        Tue, 27 Sep 2022 07:07:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b00177faf558b5sm1607088plx.250.2022.09.27.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:07:29 -0700 (PDT)
Date:   Tue, 27 Sep 2022 07:07:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, yashsri421@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Don't count URLs for "line too long"
Message-ID: <202209270706.DADC6346@keescook>
References: <20220927021517.1952202-1-keescook@chromium.org>
 <91bb341a01ad5cfe4269ef6857387cf3db9619d0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bb341a01ad5cfe4269ef6857387cf3db9619d0.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 10:40:50PM -0700, Joe Perches wrote:
> On Mon, 2022-09-26 at 19:15 -0700, Kees Cook wrote:
> > URLs (not in a Link: field) should be ignored for "line too long"
> > warnings. Allow any line containing "https://" or "http://".
> 
> More generally, this should be for any URI
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3175,6 +3175,8 @@ sub process {
> >  					# file delta changes
> >  		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
> >  					# filename then :
> > +		      $line =~ /https?:\/\// ||
> > +					# URLs
> >  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
> >  					# A Fixes: or Link: line or signature tag line
> >  		      $commit_log_possible_stack_dump)) {
> 
> And I don't recollect why this wasn't applied, but I think it's a rather better,
> more complete, patch:
> 
> https://lore.kernel.org/lkml/20210114073513.15773-2-yashsri421@gmail.com/
> 
> I believe I did ack it and forward it to Andrew Morton, but I don't
> see it on a lore list.

Many patches have internal references in the commit log (that aren't
appropriate for "Link:") like:

[1] https://some.domain/path/

It seems more flexible to just ignore lines with "http" in it...

-Kees

-- 
Kees Cook
