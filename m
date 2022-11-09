Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40556C433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Nov 2022 09:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKIJdr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiKIJdp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 04:33:45 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9962E09E
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 01:33:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z9so8768407ilu.10
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 01:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0IbVjZeeZUd5a3T1kVXY2URyfXn/ZP2LWDBW3L+YLzk=;
        b=o3ZxD3e0+Zj2SmdDhc6hKxjMHX289z5HSc572OZzcONUeqpCbN9iFjnd/pNOKwVzYf
         9YTF/LJ/OhKsOZw/miZqAe7y4eeKtduT000SHmFgN3WX7V+CIyqcMuqin+uX6Lch5nDU
         SAQl6ks4pJN5l+1xi13gAk0kxAmKpJ+44xk4NMvARjlIYa+iafOD/0KgVN/4PlyhrL4i
         U5Qp+jZt3hRDBjoFwFJyZ/t0xhd0ydQS17ccQRH0PlGk7TQ6OJNRxovFS39lSDqZnUpk
         /bOoeDBPhUs04jzxtdqq8h+WIHMSlrFHZf7DOIxqWBUBXScgQ8l5us0m+7BPwns7GnGf
         BKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IbVjZeeZUd5a3T1kVXY2URyfXn/ZP2LWDBW3L+YLzk=;
        b=OxGcG9WzLxWTS0TQUoUleqxhBDbvUIi9BnHNfZ1ANDUivFZ7KfOVopb92RS1zTG4TF
         w4+NzX9A6McKE6tA1Cv9XI4IvIZuAig/XPWCO/46lnI4TNxR2KimK4WMKPFRZoaTFj+Z
         2LGWtC9OD++S24CZptsQEvMhpvMK9D/w41UrgdwTawJgbFd7vavKgXMiNpsj8DBvi6po
         fNWZr3+LPg46P7j9gZCOvQyOFsQQnDofE7VVefLtk+yIVNpiJCcIgYmlvaYJn0FswNrg
         n62TvPn6zAb/ZpyX+FC1Rr4XT3BXHFOOFd+iQm62U4FfG9dqExsvEe0uiYsWzFOTW/TQ
         8xXg==
X-Gm-Message-State: ACrzQf2Kn2FF2yN5LB7/rYhUif2q7irwDyrwkORrnhqZvjsW+TF98ep/
        Rz/V49BW6zuTCcc8qwFroHbVMDIulHGmPOR7ynmYAg==
X-Google-Smtp-Source: AMsMyM57CuGAwsh8GlZqWabFTRdKwOzYDnDxAh9Duy8n4B7pDdV1sMgE+4XJj8v4tvq88HofurNZL9VD1MPZFY8CbZA=
X-Received: by 2002:a05:6e02:966:b0:300:e9f9:8716 with SMTP id
 q6-20020a056e02096600b00300e9f98716mr14846177ilt.254.1667986422946; Wed, 09
 Nov 2022 01:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com> <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
 <CAG48ez3AGh-R+deQMbNPt6PCQazOz8a96skW+qP3_HmUaANmmQ@mail.gmail.com> <d88999d8e9ec486bb1a0f75911457985@AcuMS.aculab.com>
In-Reply-To: <d88999d8e9ec486bb1a0f75911457985@AcuMS.aculab.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 9 Nov 2022 10:33:06 +0100
Message-ID: <CAG48ez3UO03RRMxxj-ZAcw5vhjhPYeoN1DB82s2SAiYm-qWmYw@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 9, 2022 at 10:04 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jann Horn
> > Sent: 08 November 2022 14:53
> >
> > On Tue, Nov 8, 2022 at 10:26 AM David Laight <David.Laight@aculab.com> wrote:
> > > > Many Linux systems are configured to not panic on oops; but allowing an
> > > > attacker to oops the system **really** often can make even bugs that look
> > > > completely unexploitable exploitable (like NULL dereferences and such) if
> > > > each crash elevates a refcount by one or a lock is taken in read mode, and
> > > > this causes a counter to eventually overflow.
> > > >
> > > > The most interesting counters for this are 32 bits wide (like open-coded
> > > > refcounts that don't use refcount_t). (The ldsem reader count on 32-bit
> > > > platforms is just 16 bits, but probably nobody cares about 32-bit platforms
> > > > that much nowadays.)
> > > >
> > > > So let's panic the system if the kernel is constantly oopsing.
> > >
> > > I think you are pretty much guaranteed to run out of memory
> > > (or at least KVA) before any 32bit counter wraps.
> >
> > Not if you repeatedly take a reference and then oops without dropping
> > the reference, and the oops path cleans up all the resources that were
> > allocated for the crashing tasks. In that case, each oops increments
> > the reference count by 1 without causing memory allocation.
>
> I'd have thought that the kernel stack and process areas couldn't
> be freed because they might contain 'live data'.
> There is also the much smaller pid_t structure.
>
> Of course I might be wrong...
> But I'm sure /proc/pid/stack is valid for an oopsed process.

No. It might be in the edgecase where the process oopses, then the
kernel tries to exit, then it oopses again, and the kernel decides
that that process is a hazardous mess and can't be cleaned up. But in
the general case, oopsed processes don't have /proc/$pid/stack
anymore, they go through the normal exit path, and they get reaped
normally by their parent.
