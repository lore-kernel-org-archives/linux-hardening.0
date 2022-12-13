Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E01C4167B
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Dec 2022 19:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiLMTWe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Dec 2022 14:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiLMTWd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Dec 2022 14:22:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354701A83B
        for <linux-hardening@vger.kernel.org>; Tue, 13 Dec 2022 11:22:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w23so838075ply.12
        for <linux-hardening@vger.kernel.org>; Tue, 13 Dec 2022 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GooOz5xzwABA0aXeznw8tJUM/w4xxzmJuyWu/svzARU=;
        b=JQhIG2Dnt+kBdWNk3DVyFOdSdA0ib8mpr1HWSpWifG0Wgsu5cuwDKCXsQh8tWSrgyH
         42GLmuR2Ph/Wci79VjQVy/C/W1o9PE46hYWAfq6TzhzJhdV7/d7OqkZ2F8n88iknOoVz
         hkMKqFCyV52bkH93aadGRLMw2f38wQCcx+hq0MfiIE/9xCfCA6vzvyy2StriIrmjZt/s
         Kp5RjTqR9zVNNWyBrneZ8Evqug9QLnxruisFOoy4/pOTlPwghDIaLH80mrTgUuFaN8dY
         CdLmgmoqvfnRiL7VkF08qMmXGb9EEGcjpzdpOejtRPF6oCABT9Y6c47t+Zw54yxDiRnh
         91fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GooOz5xzwABA0aXeznw8tJUM/w4xxzmJuyWu/svzARU=;
        b=5d2gY7637tuhWeCmiRCuAz+W7aRNJaYyUJptN5CI/n6ROfzbrjC/rpSCVyBCX8e26A
         YmYkS3rmGIhEhE7un1V+nnyyCTobLPtYoSRElQsgMzGMee2FTHkVQP6pk9GKXh1C8OHr
         x9rd0bOJZXPsQdpw/pHqh1FvfTc6Rfud3pBRZhROw7p7zI7ErOXodKxB95ZioCX5MGAq
         7ER4CqnqQnS3uNsvAnQDk7MIZRElfefAjXKJh4gbHl17qNI+iIrtbptP6YsgtX+8jP7O
         tYiZnJfVL8Uoyi1GNQ8Ep99LU35u4b4ZzwJTF1xWOGBubDL/eJelSxVIOS/3RzuDXLMH
         Scjg==
X-Gm-Message-State: ANoB5pmGBUcRfhCQhfsPFP5dp1JDQJGIGx/WNpaEqOk407Lr30h+DHKL
        Nt1TkpvKgeceJsnpZM61KJHiPGLhkzTHBmdYLhY/
X-Google-Smtp-Source: AA0mqf7aGuvEMwZQ2myz4q21F/vwAjdbZ8+nOsSBmZZRAt8LcZga6xnXTekj7k2zRVU4K/i46QHyS2HTCWcbSGlnof8=
X-Received: by 2002:a17:902:a70b:b0:189:b0a3:cf4f with SMTP id
 w11-20020a170902a70b00b00189b0a3cf4fmr37496320plq.56.1670959350637; Tue, 13
 Dec 2022 11:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com> <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
In-Reply-To: <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Dec 2022 14:22:19 -0500
Message-ID: <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 13, 2022 at 10:00 AM Jeff Xu <jeffxu@google.com> wrote:
> On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> > >
> > > From: Jeff Xu <jeffxu@google.com>
> > >
> > > The new security_memfd_create allows lsm to check flags of
> > > memfd_create.
> > >
> > > The security by default system (such as chromeos) can use this
> > > to implement system wide lsm to allow only non-executable memfd
> > > being created.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h | 1 +
> > >  include/linux/lsm_hooks.h     | 4 ++++
> > >  include/linux/security.h      | 6 ++++++
> > >  mm/memfd.c                    | 5 +++++
> > >  security/security.c           | 5 +++++
> > >  5 files changed, 21 insertions(+)
> >
> > We typically require at least one in-tree LSM implementation to
> > accompany a new LSM hook.  Beyond simply providing proof that the hook
> > has value, it helps provide a functional example both for reviewers as
> > well as future LSM implementations.  Also, while the BPF LSM is
> > definitely "in-tree", its nature is such that the actual
> > implementation lives out-of-tree; something like SELinux, AppArmor,
> > Smack, etc. are much more desirable from an in-tree example
> > perspective.
>
> Thanks for the comments.
> Would that be OK if I add a new LSM in the kernel  to block executable
> memfd creation ?

If you would be proposing the LSM only to meet the requirement of
providing an in-tree LSM example, no that would definitely *not* be
okay.

Proposing a new LSM involves documenting a meaningful security model,
implementing it, developing tests, going through a (likely multi-step)
review process, and finally accepting the long term maintenance
responsibilities of this new LSM.  If you are proposing a new LSM
because you feel the current LSMs do not provide a security model
which meets your needs, then yes, proposing a new LSM might be a good
idea.  However, if you are proposing a new LSM because you don't want
to learn how to add a new hook to an existing LSM, then I suspect you
are misguided/misinformed with the amount of work involved in
submitting a new LSM.

> Alternatively,  it might be possible to add this into SELinux or
> landlock, it will be a larger change.

It will be a much smaller change than submitting a new LSM, and it
would have infinitely more value to the community than a throw-away
LSM where the only use-case is getting your code merged upstream.

-- 
paul-moore.com
