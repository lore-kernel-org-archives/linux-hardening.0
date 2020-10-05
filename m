Return-Path: <SRS0=pEkV=DM=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03709C4363A
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0CB206CB
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RAY3cF0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgJEWXI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Oct 2020 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEWXI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Oct 2020 18:23:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4DC0613CE
        for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2020 15:23:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so7841788pfn.9
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2020 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPhtkZlBx0HdRndNHRRit3OePIrGP7PGyxoDKM6oYqo=;
        b=RAY3cF0iFH1QnO672paSRr4RtBc++9OTMUCz8WS4LK4K4+91RnuNMHoYwDKTb+3o7O
         5+OiiWS0+CYHD8lJOt5nB5OKEYjnBVuQYHBqg96q/6eavN6SocKqepecaprfrzwexPv0
         qsYjOWVoNntG414DZITG9fHym4p4Ww9X9txrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPhtkZlBx0HdRndNHRRit3OePIrGP7PGyxoDKM6oYqo=;
        b=B1GSpt4TLMBEG6phzUfSwyGwoegMRhfd0Wkh6PVjii8rnz3QoKkZSUtuLsGIvG+UOd
         JU9n07PBbcS0qmGRzRkDFlWBiu7y8ihc+mVujW5dCMqpLja1NiuQmasyycGxRjXhpABi
         cdx2B9OZ+3lOsTPEVl1tC/YhbstF5E4UBSXSbOZKYvRCDt2eXxa1gmmElZCfQErMPqyk
         kmpX3HiMXnuSPYRQdDnEl2wMUNbAZg4bfiLgE4kr4SuCC1pBo9rVjK6dFNrQP9Lnwp0P
         i6cmqHgiaPEMwKOu320mRvqdO6QOUQsL6WGy2AQDMlWdKrEut+WKtRpw0bkRehkcVYF6
         H/XA==
X-Gm-Message-State: AOAM531+K5StKG3iHpBHs0Re9rpAKxbM/T1XGXtGPrvNWcg3CDv5FW3j
        SfzD3uAfNNsrylxhMpe3TEtSKtfoyG9AOpvc
X-Google-Smtp-Source: ABdhPJyT3oH9/QjZZTD71sv57tdt3eBqvyidgczvfjn4oxbts3LGwIE5P7nmw+raOF/0Ghd1G6gHtw==
X-Received: by 2002:a65:5c03:: with SMTP id u3mr1410402pgr.452.1601936586852;
        Mon, 05 Oct 2020 15:23:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x16sm1012448pff.14.2020.10.05.15.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 15:23:06 -0700 (PDT)
Date:   Mon, 5 Oct 2020 15:23:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Solar Designer <solar@openwall.com>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Linux-specific kernel hardening
Message-ID: <202010051443.279CC265D@keescook>
References: <202009281907.946FBE7B@keescook>
 <20200929192517.GA2718@openwall.com>
 <202009291558.04F4D35@keescook>
 <20200930090232.GA5067@openwall.com>
 <20201005141456.GA6528@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005141456.GA6528@openwall.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 05, 2020 at 04:14:56PM +0200, Solar Designer wrote:
> On Wed, Sep 30, 2020 at 11:02:32AM +0200, Solar Designer wrote:
> > Messages that are auto-approved don't create any work for either of us,
> > and that's the majority of them.  Messages that are held for moderation
> > (until I add the sender to moderation bypass) do involve some work, but
> > that's the only way to avoid spam on the list.  I think that amount of
> > work is small compared to all subscribers' time wasted on occasional
> > spam on the list.  If it's unacceptable for you, I can remove you from
> > list moderators and maybe add someone else as a co-moderator.  I think
> > it wouldn't be hard for us to find a volunteer.  Please let me know.
> 
> Someone has already volunteered.  I'd also like to hear from someone
> possibly not as over-qualified and as busy as that person is. ;-)
> 
> Kees, if you'd like to step down as a co-moderator for kernel-hardening,
> please let me know.  We'll add someone else (so that this doesn't depend
> solely on me being around).
> 
> To avoid misinterpretation: I am not suggesting that you need to step
> down, totally not.  I merely feel that you need to have the option since
> you expressed unhappiness with having to spend effort on that.

My complaint about moderation is about the list needing to be moderated
at all. (I would note that your own postings to kernel-hardening@ got
moderated...) While vger is certainly not perfect in its spam control,
it is usually fine, and behaves well enough for many other upstream
kernel lists.

> > So your suggested use of kernel-hardening@ is for discussions of Linux
> > kernel hardening projects or work-in-progress that isn't to be submitted
> > upstream or isn't yet submitted upstream.  If, and as soon as, a patch
> > series is sent upstream, that should go on the new linux-hardening@
> > list?  And only in there or also CC'ed to kernel-hardening@?  I'm just
> > trying to understand.
> 
> We need you to comment on the above.  I hope you did have some idea of
> how the topics would be split between the two lists, but you haven't
> really specified that yet.  I tried to make guesses in the paragraph
> above, so at least you need to confirm whether my guesses are correct,
> or correct me if they are not.

My expectation would be that "new topic" RFCs/patches would be CCed to
both lists. Everything else would go to linux-hardening.

> I see there are already a few threads on linux-hardening, and those are
> not CC'ed to kernel-hardening.  I am pleasantly surprised that those
> threads are about rather minor changes, which while acceptable to have
> on kernel-hardening as well IMO do not add much value to discussions
> desirable on kernel-hardening: "Replace one-element array with
> flexible-array member", "Use flex_array_size() helper", "Use
> array_size() helper", "Replace one-element array and save heap space",
> "Use fallthrough pseudo-keyword".

These threads are all on topic, as far as I'm concerned, but they easily
run the "risk" of turning into bike-shedding and nuance, etc. But those
are exactly the kinds of threads I want to have on linux-hardening@ (as
well as the "larger" topics).

> I think topics more desirable on kernel-hardening would be deciding on
> such replacements in general (not patches for individual instances),

Right -- and this is impossible to separate "by default" without a second
list. linux-hardening@ is the default now, as declared by MAINTAINERS
and mailmap. For folks wanting a wider audience for new/big topics,
kernel-hardening@ can be additionally CCed. I have clarified this in the
KSPP wiki now:

https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Get_Involved

> introduction of such helpers, etc.  Also summaries of work done (e.g.,
> "this-many instances of that-thing were updated to new conventions in
> the kernel over the last month as discussed in those threads seen in
> that list archive").  I use examples from the past because that's what
> we have, but I use them to illustrate roughly what kinds of things we
> could possibly have on one list vs. the other in the future.

Agreed.

-- 
Kees Cook
