Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD5C433E0
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Mar 2021 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A52C6513A
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Mar 2021 19:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhCPTIR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbhCPTIF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Mar 2021 15:08:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252FC06175F
        for <linux-hardening@vger.kernel.org>; Tue, 16 Mar 2021 12:08:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j6so17399457plx.6
        for <linux-hardening@vger.kernel.org>; Tue, 16 Mar 2021 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8AoKzKPSw2tvyexd5NcXY+l1zYIQb/v5kLzQvhcVl08=;
        b=hp0QAMcH2/+hAfF/v1msV9oc8S1hs4aD8wPtqsPN7CylkDbiC2m1t4yKCOjfkK0mT1
         FH1k7n42emJvCQMg1E9+DdPPp7Jr8+UmkHBy5HPI7dHQP0de8TCmIAmALPbozA+obtPG
         GNhpP5Hyv66XRv0RRDMyxY15UjtX3yzT9CtmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8AoKzKPSw2tvyexd5NcXY+l1zYIQb/v5kLzQvhcVl08=;
        b=NvYt0twGxYQONlRGTtoNd/uTshgW+I0sBN9ehiMZZn2a9kVproXCtaq+B+SXy01Tff
         kdd/V2BwfXqrvnddETIZWUF6cV7D2iI73003PK3G9XUJyxySxyF/Tx5uOEjMpX9nGIGn
         O1CXTOuve7Yua0CYTgMRq79IWjMuZ2lQARXKaQOmAlbACotYiwFCpxkif90/WJg/ezN+
         TJoYq3bnQsul56gAhZmG2pia9ETy7qEnOpj2es4DXV709w3FZI6rcWzgFsAp6rLpX1t+
         3vG6emC+eZEIbcuLiEqHKEacqvBDM4qwqvga0ZmRAn41ecGDnWQSfDQJJkWkEC2UeGmP
         QD3w==
X-Gm-Message-State: AOAM533A8o/fcT4tpOmVxi73K9BYoozo+s8HBm5FEdm7Ipgks6Uzj0Pj
        WxxwpRTx9cbRU9JSj4JvloBkbQ==
X-Google-Smtp-Source: ABdhPJwgNNfhDgUxxbbcJYMpgOpJMkOQakG4DPMXgYCnO/0AdsbjMLkkKC7Uuv2O2Z+6Y5Z6LdNrsw==
X-Received: by 2002:a17:902:c382:b029:e4:7015:b646 with SMTP id g2-20020a170902c382b02900e47015b646mr922259plg.83.1615921684270;
        Tue, 16 Mar 2021 12:08:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v126sm17079279pfv.163.2021.03.16.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:08:03 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:08:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103161205.B2181BDE38@keescook>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFBs202BqG9uqify@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Mar 16, 2021 at 09:31:23AM +0100, Michal Hocko wrote:
> On Mon 15-03-21 10:48:51, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile, as seen
> > with some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows. This seems justified given that
> > seq_file already uses kvmalloc(), is almost always using a PAGE_SIZE or
> > larger allocation, has allocations are normally short lived, and is not
> > normally on a performance critical path.
> 
> I have already objected without having my concerns really addressed.

Sorry, I didn't mean to ignore your comments!

> Your observation that most of buffers are PAGE_SIZE in the vast majority
> cases matches my experience and kmalloc should perform better than
> vmalloc. You should check the most common /proc readers at least.

Yeah, I'm going to build a quick test rig to see some before/after
timings, etc.

> Also this cannot really be done for configurations with a very limited
> vmalloc space (32b for example). Those systems are more and more rare
> but you shouldn't really allow userspace to deplete the vmalloc space.

This sounds like two objections:
- 32b has a small vmalloc space
- userspace shouldn't allow depletion of vmalloc space

I'd be happy to make this 64b only. For the latter, I would imagine
there are other vmalloc-exposed-to-userspace cases, but yes, this would
be much more direct. Is that a problem in practice?

> I would be also curious to see how vmalloc scales with huge number of
> single page allocations which would be easy to trigger with this patch.

Right -- what the best way to measure this (and what would be "too
much")?

-- 
Kees Cook
