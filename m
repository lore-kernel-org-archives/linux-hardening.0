Return-Path: <SRS0=yYSg=DG=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C0C4727C
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Sep 2020 23:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8E20773
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Sep 2020 23:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EkRtlnWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgI2Xlu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgI2Xlu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 29 Sep 2020 19:41:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804DEC061755
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2020 16:41:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so37512pjb.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2020 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dP8I9oyL7TEPrbaEo1IUtt5BofPuI3wthx4WkN4QjrU=;
        b=EkRtlnWrQNgl+R79TCEqwzwX1+mB5/VOtBZOhMyWjDGtmx/59qKQMgPd/tFb5fBK0g
         ld+kzOYXAYEjG1Wo2G2uVkk1ZNNXNn1N/tPunUMHsDoppbrXI0sp5Jf5rS4x/Z7CC69Z
         Wc0tPiO5FViqbkvpZds8DO5KFSSAcmzJT1dhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dP8I9oyL7TEPrbaEo1IUtt5BofPuI3wthx4WkN4QjrU=;
        b=i3D5gOnb84FGNoofXMmlkKGzWgdFoBvMLWMKGOoiM71lSiYkDs81clM3tNcmRJuDDS
         TYPoEPzsER21V2aRd+b7pCjXJuW1jZbGahKkY2HSXjI5tfJOB0j66rydLG1dWAyN9QAV
         J2cEwa/N+pnFCN2qLyUzFTK8lR8TVgfh2wm7cHhMjA6kyQWzO6VHFPIatL9uTy2cenP0
         IOGcBvUUb2XyyxY8mLwh7PKY7wC5Urj1mZjshmFDGiV/3zvzIhaPqavYqoiTYm8sxfCi
         CMBMkBi/8AodNIUTUJW5bsMJtd4LgYVULxnsfJogz2CNO4coXL3bA3Neav+R2CHJiJZs
         gWHg==
X-Gm-Message-State: AOAM532XbnDndkFj9rB3m58J7T1BdkLi2tFA7RMBiPTqGC1JYb6BP3mT
        JAgy9LeZl+lP/HQL2+jkT6m4NL0f++hVmi7w
X-Google-Smtp-Source: ABdhPJweioQXF7DB3cNF+Nuo1vdvnCLB0r7/Z7nSyH4ZlW1lj8CADieMNwMg7kmhCNi3Eqq4nVIRQw==
X-Received: by 2002:a17:90b:198c:: with SMTP id mv12mr33129pjb.236.1601422907813;
        Tue, 29 Sep 2020 16:41:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v13sm5457pjr.12.2020.09.29.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 16:41:46 -0700 (PDT)
Date:   Tue, 29 Sep 2020 16:41:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Solar Designer <solar@openwall.com>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Linux-specific kernel hardening
Message-ID: <202009291558.04F4D35@keescook>
References: <202009281907.946FBE7B@keescook>
 <20200929192517.GA2718@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192517.GA2718@openwall.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 29, 2020 at 09:25:17PM +0200, Solar Designer wrote:
> On Tue, Sep 29, 2020 at 10:14:03AM -0700, Kees Cook wrote:
> > New topics and on-going work will be discussed there, and I urge
> > anyone interested in Linux kernel hardening to join the new list. It's
> > my intention that all future upstream work can be CCed there, following
> > the standard conventions of the Linux development model, for better or
> > worse. ;)
> > 
> > For anyone discussing new topics or ideas, please continue to CC
> > kernel-hardening too, as there will likely be many people only subscribed
> > there. Hopefully this will get the desired split of topics between the
> > two lists.
> 
> I find this confusing.  Given that "new topics and on-going work will be
> discussed" on the new linux-hardening list, what's left for the old
> kernel-hardening list?  Just a legacy list to be CC'ed because people

My intention is to allow for linux-hardening@ to be the defacto place
for upstream Linux kernel hardening work. (And I include "upstream"
there again intentionally, and "work", which is larger than just
discussing new features.) Such a place must exist for the mechanical
and social processes inherent in the Linux kernel development model to
operate. Something needs to be listed in the MAINTAINERS file, and tools
direct email delivery much more commonly than individuals.

Since it is not part of the established Linux development processes to
_remove_ lists from CC when they're part of the maintainership chain or
git history, it's simply not possible for kernel-hardening@ to serve in
that role, given the constraints on topic applicability.

For stuff that IS a new topic, where people are explicitly choosing
what lists to send to, CCing both linux-hardening@ and kernel-hardening@
seems like the right thing to do to get that topic split.

> are still subscribed to it?  If so, it looks like basically because of
> my concern about a minor issue you chose to move the list from one place
> to another without actually addressing my concern in any way but causing
> lots of inconvenience.  That would be weird, so I hope I misunderstand.

I don't think the Linux kernel's (email) development model is compatible
with having a "strictly on-topic" mailing list as part of the standard
process. Your concerns are perfectly valid, but just not something that
I see a way to solving without significant effort (e.g. making the list
entirely moderated, etc). And moderation is actually another aspect of
the desire to move; emails are regularly auto-moderated which just
creates more manual work (for both of us).

> To me, "new topics" are certainly desirable on kernel-hardening.  Ditto
> for "on-going work" as long as it's work on kernel hardening per se
> (patch review, etc.) rather than e.g. documentation formatting fixes for
> former kernel hardening changes that are already accepted upstream and
> are only CC'ed here because of a formality (link from MAINTAINERS)
> rather than anyone's well-reasoned decision.

I don't want myself or anyone else to have to worry about where the line
is drawn. If kernel-hardening@ is on CC for new topics, we're all good.
With the MAINTAINERS file updated, and a .mailmap entry added to redirect
kernel-hardening@ to linux-hardening@, all the "mechanical" threads will
avoid kernel-hardening@, and we'll be close to what will work best for
the topic split.

> I suggested that a small minority of messages on kernel-hardening be
> removed from here.  You're effectively replacing one list with another,
> or if that's not what you're doing then you haven't described it well,
> and I wouldn't expect to "get the desired split of topics".

I understand what you mean, but I think the effort required to remove
those messages is too high. As an upstream Linux kernel maintainer, I
have different constraints on how I need a development discussion list
to operate. In the quoted thread[2] from earlier, I explained (perhaps
badly) those constraints, and you disagreed and additionally said
further discussion would hinder kernel-hardening@. It's your list and
list server, so I obviously can't make you agree to operate it the way
Linux kernel development lists are expected to work, so I didn't really
have any other choice but to start a new list. I recognize you've made a
lot of changes over the past several years (e.g. Subject prefixes, etc)
to adapt to those norms, but the list's acceptable "range of discussion"
seemed like a pretty fundamental difference that was unlikely to be
easily solved with a single list.

> Then there's also the lists' naming and the Subject on this message.
> Are you suggesting that the kernel-hardening list be used for kernel
> hardening that is not Linux specific?  That would be a reuse of an

The better distinction is between upstream and not. Another aspect driving
this change is the belief by people that the Linux Kernel Self-Protection
Project is somehow not upstream, which I think is somewhat reinforced
by the mailing list not living on vger.kernel.org. It's hardly a strong
enough reason to move (much like the auto-moderation hassles), but when
all are combined, I found the move sufficiently justified.

> abandoned list, if it would be, but I don't know whether there's demand
> for that and it's probably incompatible with continuing to CC the list
> on Linux-specific topics and it might not be well-received by all
> current subscribers who assumed it was a Linux list, which it was.

Agreed, I should have said "upstream-specific" in the Subject. That was
not clear there.

Hopefully this clears things up. I'm fundamentally seeking less
work/irritation for both of us, as well as for the folks doing upstream
work who find themselves CCing a development mailing list, and the folks
who want to just see the discussion of new features.

-Kees

> [2] https://lore.kernel.org/kernel-hardening/20200902121604.GA10684@openwall.com/

-- 
Kees Cook
