Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF545C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 20:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8314564F0C
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 20:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhCOUoN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhCOUoB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Mar 2021 16:44:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558AC06174A
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 13:44:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p21so21167846pgl.12
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dk1GgzHdHhGnwGN+xI1nLq54vR49Ec8B0mVf2wTPUSA=;
        b=dP0z5gaZ0eVEber6aiqZ+Y5EJAx35FezV5Y9frZS1O4xHzXCaO9jJ4/S/9l5oLCE26
         CsbbxIqb/h7E3j7XGAaZhU83tJrc/npmEGCdVvyODBtRk/r1enmjjiD9e/VBqCLjy5rR
         TFdYZk6BEuQv/+RiVPo1/nl2eapFbCCUg2jds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dk1GgzHdHhGnwGN+xI1nLq54vR49Ec8B0mVf2wTPUSA=;
        b=fiXUWO6Uq7uOxmN/SKBWIICGpGydiRHw3X30KnFogBZCExAoMcDM1uFXD92P00eIxq
         Fyhi5/Rm/cfEp1ANlBAbZq5sQ4hZwHQP90mSt1vc7NCVc7RRpcQmrtvk+Y6OMLqc6c/n
         Nb+kjbW9No9tlA95rIJrTS76j3epYE2YcRHo8LBHFMVCVOUQMNWr1EgPzchgo3IoRh9R
         UBTBFwMg0WRG0A2MJxhDgexPe/rZB/YGRrqfglUzibKLiA96SQN9tG4MZIxItry+a+sf
         ROBR0DC+wLUTdkH55uHGJqdeSunYrYizR/bdI/jfC6LOfw2utsTf0mHiQH6/FZJhbchb
         hwDQ==
X-Gm-Message-State: AOAM533Ona1y+WROLirCTHLDowSwRiOlKEeTPwFa6lnNDawpGsqDlqkB
        PXzI69pA1dMeUX+3C3faayEDLg==
X-Google-Smtp-Source: ABdhPJx4EokcC+hK3QaQtFBxmi4b8ZigEYKMCtbw9ScjeGv01tzTDNAo0flFEHhuvMHtSQipI/jLig==
X-Received: by 2002:a63:ce48:: with SMTP id r8mr823950pgi.62.1615841040984;
        Mon, 15 Mar 2021 13:44:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w26sm14368416pfn.33.2021.03.15.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:44:00 -0700 (PDT)
Date:   Mon, 15 Mar 2021 13:43:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103151336.78360DB34D@keescook>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 15, 2021 at 06:33:10PM +0000, Al Viro wrote:
> On Mon, Mar 15, 2021 at 10:48:51AM -0700, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile, as seen
> > with some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows. This seems justified given that
> > seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
> > larger allocation, has allocations are normally short lived, and is not
> > normally on a performance critical path.
> 
> You are attacking the wrong part of it.  Is there any reason for having
> seq_get_buf() public in the first place?

Completely agreed. seq_get_buf() should be totally ripped out.
Unfortunately, this is going to be a long road because of sysfs's ATTR
stuff, there are something like 5000 callers, and the entire API was
designed to avoid refactoring all those callers from
sysfs_kf_seq_show().

However, since I also need to entirely rewrite the sysfs vs kobj APIs[1]
for CFI, I'm working on a plan to fix it all at once, but based on my
experience refactoring the timer struct, it's going to be a very painful
and long road.

So, in the meantime, I'd like to make this change so we can get bounds
checking for free on seq_file (since it's almost always PAGE_SIZE
anyway).

-Kees

[1] https://lore.kernel.org/lkml/202006112217.2E6CE093@keescook/

-- 
Kees Cook
