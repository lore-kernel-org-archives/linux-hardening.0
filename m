Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF970C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Mar 2021 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EC664F44
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Mar 2021 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhCQOom (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:44:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhCQOoT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Mar 2021 10:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615992257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5oYQBPwSUCBk46zBID0wDOfR5utauYkYQdugS8kdWI=;
        b=UaxFj88wguuVXcmhIBLsovpWrAiI2Qcy5W5yyV6wEmPwo1VKUQjJYaEEpGVovjw1CMwRlk
        Iv75VKm+d0HqAgqtmmvmQua2217CUInpC683WfQwEq/dxLTNFSMx8xBjsTk65sH79ZCOvW
        vBLQD/1EpbRxXgqMG8PNPKEhslZcXlw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BFD2ACA8;
        Wed, 17 Mar 2021 14:44:17 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:44:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIFY7mj65sStba1@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed 17-03-21 14:34:27, Greg KH wrote:
> On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > Btw. I still have problems with the approach. seq_file is intended to
> > provide safe way to dump values to the userspace. Sacrificing
> > performance just because of some abuser seems like a wrong way to go as
> > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > manipulate the buffer directly? I do realize this might be more tricky
> > for reasons mentioned in other emails but this is definitely worth
> > doing.
> 
> We have to provide a buffer to "write into" somehow, so what is the best
> way to stop "abuse" like this?

What is wrong about using seq_* interface directly?

> Right now, we do have helper functions, sysfs_emit(), that know to stop
> the overflow of the buffer size, but porting the whole kernel to them is
> going to take a bunch of churn, for almost no real benefit except a
> potential random driver that might be doing bad things here that we have
> not noticed yet.

I am not familiar with sysfs, I just got lost in all the indirection but
replacing buffer by the seq_file and operate on that should be possible,
no?

-- 
Michal Hocko
SUSE Labs
