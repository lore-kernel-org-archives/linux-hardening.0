Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E7C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 18:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbiBJSCI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:02:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245491AbiBJSCI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Feb 2022 13:02:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0FE25D7
        for <linux-hardening@vger.kernel.org>; Thu, 10 Feb 2022 10:02:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 13so11931336lfp.7
        for <linux-hardening@vger.kernel.org>; Thu, 10 Feb 2022 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nlOsd5JgRXIirKifvmJwXeIxdew5ZbaSyuXwRWkioH4=;
        b=p1GAK1V8eXcEzq47Fvq2vN9jx3rSPu4w/KYVw6B2MwJZIhieAFZD4nHhhsr/5D5fFW
         g0ZGd45Bu7sSltUo7FscaMHJcboP9NblAwTc6OzmdmI2SH31xEnj7Yyeb8F6SfKckWBS
         ZAQ7iBQ0A+GAl4d5knFsT9gF8ab6dF9duoJ5FleSD2zEiOoi8OxZWSY/W8GCUaaJ933K
         /kH2LbCOZUIIK0AcX2mgiWFc71+8ECcUBXSBWDi4Ac8llgvUsWQQm2/tEzsBViZW2+PC
         iKELZEYjQ0R8ePbJnNleYy1k0ExoUt4hR8depXVTZ2P8KU35T+IjMKykOn8gqZv02w6K
         Q3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nlOsd5JgRXIirKifvmJwXeIxdew5ZbaSyuXwRWkioH4=;
        b=ygrhWBEPCDdewZiRFFLIdxxNwQFV2aeqYMlrmPV2Ol4YzLtKBbxdxEIxjLM469LufF
         XMAqmrSUeanGYa02ieG9LXAFoo0m+pkrhIk25Vl7cl6WyXi87y8Vf0TK/S7vDSI8+h91
         cMiWrDyuafk5KI5yMG48G4Xo8zj/oJxxRX28ZDftJDZe4fWZ3hJEWkRduQp3F2pvuODU
         IzypJuT4GN7qKxIoXqqJrhb3gODIn35uCrPqYwIpg/QLMKEvFk2Z/UbBQTCQQcdw6RkS
         63LLT4LCI9vnOmgEb6ekwkU/RBzUcj0SGLz/x23sJGPYyVzr/aAXBgkDAbf03ky+eS7j
         0tmA==
X-Gm-Message-State: AOAM532L9aU7At96C7m2vbZ7i9HKrfU1Nk2AE1py4l1suNNDnSkZuANy
        xPJz1FxNEu+yUBsscrS/F+zr7XRCIbGHl3ybVu3abg==
X-Google-Smtp-Source: ABdhPJyJEKNknsqObHfl8Uoa9tzMLpWuOL4UjvrRNQVehKzVHcdc3TUq0BVCGVfxFdgfFKhYlXHSFbkL5zLAvcjxMiI=
X-Received: by 2002:a19:ee04:: with SMTP id g4mr5780832lfb.157.1644516126252;
 Thu, 10 Feb 2022 10:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20220210025321.787113-1-keescook@chromium.org>
 <20220210025321.787113-2-keescook@chromium.org> <CAG48ez1m7XJ1wJvTHtNorH480jTWNgdrn5Q1LTZZQ4uve3r4Sw@mail.gmail.com>
 <202202100935.FB3E60FA5@keescook>
In-Reply-To: <202202100935.FB3E60FA5@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Feb 2022 19:01:39 +0100
Message-ID: <CAG48ez3fG7S1dfE2-JAtyOZUK=0_iZ03scf+oD6gwVyD1Qp33g@mail.gmail.com>
Subject: Re: [PATCH 1/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 10, 2022 at 6:37 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 10, 2022 at 05:18:39PM +0100, Jann Horn wrote:
> > On Thu, Feb 10, 2022 at 3:53 AM Kees Cook <keescook@chromium.org> wrote=
:
> > > Fatal SIGSYS signals were not being delivered to pid namespace init
> > > processes. Make sure the SIGNAL_UNKILLABLE doesn't get set for these
> > > cases.
> > >
> > > Reported-by: Robert =C5=9Awi=C4=99cki <robert@swiecki.net>
> > > Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced sigan=
ls do not get changed")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  kernel/signal.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > index 38602738866e..33e3ee4f3383 100644
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -1342,9 +1342,10 @@ force_sig_info_to_task(struct kernel_siginfo *=
info, struct task_struct *t,
> > >         }
> > >         /*
> > >          * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won'=
t expect
> > > -        * debugging to leave init killable.
> > > +        * debugging to leave init killable, unless it is intended to=
 exit.
> > >          */
> > > -       if (action->sa.sa_handler =3D=3D SIG_DFL && !t->ptrace)
> > > +       if (action->sa.sa_handler =3D=3D SIG_DFL &&
> > > +           (!t->ptrace || (handler =3D=3D HANDLER_EXIT)))
> > >                 t->signal->flags &=3D ~SIGNAL_UNKILLABLE;
> >
> > You're changing the subclause:
> >
> > !t->ptrace
> >
> > to:
> >
> > (!t->ptrace || (handler =3D=3D HANDLER_EXIT))
> >
> > which means that the change only affects cases where the process has a
> > ptracer, right? That's not the scenario the commit message is talking
> > about...
>
> Sorry, yes, I was not as accurate as I should have been in the commit
> log. I have changed it to:
>
> Fatal SIGSYS signals (i.e. seccomp RET_KILL_* syscall filter actions)
> were not being delivered to ptraced pid namespace init processes. Make
> sure the SIGNAL_UNKILLABLE doesn't get set for these cases.

So basically force_sig_info() is trying to figure out whether
get_signal() will later on check for SIGNAL_UNKILLABLE (the SIG_DFL
case), and if so, it clears the flag from the target's signal_struct
that marks the process as unkillable?

This used to be:

if (action->sa.sa_handler =3D=3D SIG_DFL)
    t->signal->flags &=3D ~SIGNAL_UNKILLABLE;

Then someone noticed that in the ptrace case, the signal might not
actually end up being consumed by the target process, and added the
"&& !t->ptrace" clause in commit
eb61b5911bdc923875cde99eb25203a0e2b06d43.

And now Robert Swiecki noticed that that still didn't accurately model
what'll happen in get_signal().


This seems hacky to me, and also racy: What if, while you're going
through a SECCOMP_RET_KILL_PROCESS in an unkillable process, some
other thread e.g. concurrently changes the disposition of SIGSYS from
a custom handler to SIG_DFL?

Instead of trying to figure out whether the signal would have been
fatal without SIGNAL_UNKILLABLE, I think it would be better to find a
way to tell the signal-handling code that SIGNAL_UNKILLABLE should be
bypassed for this specific signal, or something along those lines...
but of course that's also kind of messy because the signal-sending
code might fall back to just using the pending signal mask on
allocation failure IIRC?
