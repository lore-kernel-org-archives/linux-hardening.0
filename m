Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D7DC433FE
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Nov 2022 20:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiKGU5C (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKGU5B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Nov 2022 15:57:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97F2B19E
        for <linux-hardening@vger.kernel.org>; Mon,  7 Nov 2022 12:57:00 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a27so7619539qtw.10
        for <linux-hardening@vger.kernel.org>; Mon, 07 Nov 2022 12:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1S/JQnMmN3DjPvkqvFQzgmskknDsfipulGwZNvds56w=;
        b=DjPZ80abs50yysr3vgzBuOIHSiisPDueDD2gradfm5Mc0WVW8bcqmtusRnHYvmQ5xU
         3Oj31BsKULnicqGaR0VWCX63nOp9Z7YjlCzML9GDNvpbnJGvYJHp3sV/g16Q5rHBuzyE
         Fu7Vrtege4aTPrIbIdQHFNkQlb3MFmnTSkDng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1S/JQnMmN3DjPvkqvFQzgmskknDsfipulGwZNvds56w=;
        b=TVJCUXaMBvn4NCFfHWK4xotQuvqE4ZrrdHaSvqD46lvI5aLd7b3yr4NmeXyR5zcAaF
         vUaa+2HV3z497a0/3H08oKkpAc7JW8/qg2eGKN4RNeaIFhtHPu+lEQf0M6dW0CTmoZbE
         qzb6MmDAbsZ1SBYfL/Mtp6nqHY9PB38SkQqbbGmV0Q56EcMXXId2EoiXBFFFB7rQUuuw
         c1vESKD8KUhnqUBMAATdpIGImSZJyo7rl8S+LGLK/XHqaYhBdjTELn7jv8tph/c9G/PK
         Y4bKaL7kmf0tVq9d8NOUkTWaxBjG/pFSl6Aci28T44gtlOWOqXnWOnoJ9Wi+wLX9GIK7
         sJ/Q==
X-Gm-Message-State: ACrzQf1qYS8XeIXGS/YEEvV5kNTtloNG0jNoudu/sBjQLzTjaZIk1HwM
        oJa4Fgb/bZLkKlxwxuvOunRVXtxOAjDKKA==
X-Google-Smtp-Source: AMsMyM6cGwc9m+tPdnQ2ynJMl/azpoyimnrvzW+4I/m20CZOk8pLtVTxqZIs/bRNITcaeAj8E0EF5A==
X-Received: by 2002:ac8:4243:0:b0:3a5:1ac5:490d with SMTP id r3-20020ac84243000000b003a51ac5490dmr39230282qtm.269.1667854619524;
        Mon, 07 Nov 2022 12:56:59 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id o9-20020a05622a138900b003a582090530sm5299043qtk.83.2022.11.07.12.56.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:56:55 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-333a4a5d495so116139027b3.10
        for <linux-hardening@vger.kernel.org>; Mon, 07 Nov 2022 12:56:54 -0800 (PST)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr30747649ywe.401.1667854613940; Mon, 07
 Nov 2022 12:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com>
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 7 Nov 2022 12:56:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjejeg+mymJQYzjc=TeMkGkcOLTgKg4FY4tz4ueYdMsGQ@mail.gmail.com>
Message-ID: <CAHk-=wjejeg+mymJQYzjc=TeMkGkcOLTgKg4FY4tz4ueYdMsGQ@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 7, 2022 at 12:13 PM Jann Horn <jannh@google.com> wrote:
>
> I picked 10000 here to also provide safety for the ldsem code on 32-bit
> systems, but you could also argue that the real fix there is to make
> ldsem more robust, and that the limit should be something like 2^31...
>
> An alternative approach would be to always let make_task_dead() take the
> do_task_dead() path and never exit; but that would probably be a more
> disruptive change?

It might be more disruptive, but it might also be a better idea in
some respects: one of the bigger issues we've had with oopses in
inconvenient places is when they then cause even more problems in the
exit path (because the initial oops was horrid).

I'd honestly prefer something higher than 10000, but hey... I would
also prefer something where that legacy 'ldsem' was based on our
current legacy 'struct semaphore' rather than the half-way optimized
'rwsem'. The difference being that 'struct rwsem' tries to be clever
and uses atomic operations, while we long ago decided that anybody who
uses the bad old 'struct semaphore' can just use spinlocks and
non-atomic logic.

It's kind of silly how we try to stuff things into one 'sem->count'
value, when we could just have separate readers and writers counts.

And the only reason we do that is because those kinds of things *do*
matter for contended locks and the rwsem code has it, but I really
think the ldsem code could just always take the spinlock that it
already takes in the slowpath, and just skip any other atomics.

And it shouldn't have a wait_lock thing and two different wait queues
- it should have one wait queue, use that wait queues spinlock *as*
the lock for the semaphore operations, and put readers at the end, and
writers at the beginning as exclusive waiters.

So that ldesc_sem thing is just historical garbage in so many ways.
It's basically a modified copy of an old version of our rwsem, and
hasn't evern been simplified for its intended use, nor has it been
updated to improvements by the actual rwsem code.

Worst of both worlds, in other words.

Oh well. I don't think anybody really cares about the ldsem code,
which is why it is like it is, and probably will remain that way
forever.

I guess 10000 is fine - small enough to test for, big enough that if
somebody really hits it, they only have themselves to blame.

             Linus
