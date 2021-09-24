Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948CC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F95661250
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbhIXRTr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347521AbhIXRTo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 13:19:44 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E816C061613
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 10:18:11 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r4so7235400ybp.4
        for <linux-hardening@vger.kernel.org>; Fri, 24 Sep 2021 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMNH1n+J9Sdp/Dhc4InVJUy+tIIlUR+ChPt/tLgskEw=;
        b=aLE0RcKB98oARudLo8/YXOn4Q6uewwPUUzHKjKmNvi27bu83jqBw7XkYFRQjhjhSjF
         CmWoUrwGv4OPfvNRARxDJ2tYg4esu97zljUEruRbbT6d1d+7ocUYQY0NkIi6pHpoto09
         bZgkYxQrIHVUWdRxrDHWOLKfwh8WGEdZSXqpapmHU3/CB7k+P2tkUh6GBmMKVfUXV7AC
         dRnd5HgoCUET/dQhsYo1aVEUvpEvSRgfmga0bn4HOmyKkrZiv+BUuqn+q72H0NKAC3GV
         z3b+SxR7Qm/7K3rg6L/j+RMJ88eLPSQpYq5Mi4mGkTCV3Pnowd6c3NqmkrhwHZBSZedn
         va1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMNH1n+J9Sdp/Dhc4InVJUy+tIIlUR+ChPt/tLgskEw=;
        b=y/51G5RygzpDc3QMOrL6Kij4vAV3orfr1lHOK49iwXJFepp+myt6dY8E7zlfQEHQbn
         /IoAqxeC5cuIHiMh3xuiYg3RuV7P+SAoV5TsJD+ogPT8E/TMifuT24HJ8d0a/eKyKSBK
         GPgC56TVjpV8pRdA+8uadMambiybwQD8/935pgitJ7wdAKYBIHp0kt1Bc3GRxkZZ7RBI
         fDcbZT27cT1fPphgxMmsN+x7Ww2Ii/LkmSyanpol+jSHE9c1KmPFRXQphHUB7zZS1Vct
         4xv+5pmk80X2ug3QAK4nNq8ABDi8RIX9eGRCbmlDLXnEq+RazDid4DYq8dQS/0DHk43y
         yYXA==
X-Gm-Message-State: AOAM532AvQD0J6JCB9UqROtgQ+N1RdvSBFYSh9ZKITyCCNvyoT8eJ4mZ
        MnKJs+Ds33AwTj3nc6znKjlOADSr4IFE4ptrkGPFUA==
X-Google-Smtp-Source: ABdhPJzyKdCVKSFCibtqbyhxpBaijFfu673x+3GDeHkRohDZ3CDX23jeamrsn3495406nZjIQd9iKS2aGoduBpo5j1c=
X-Received: by 2002:a25:3545:: with SMTP id c66mr14231452yba.317.1632503889886;
 Fri, 24 Sep 2021 10:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210903021326.206548-1-keescook@chromium.org>
 <20210904175511.oijbn4f2tzghwk7l@treble> <20210905165738.7e40d6e2cba3dd0724f85f3a@kernel.org>
In-Reply-To: <20210905165738.7e40d6e2cba3dd0724f85f3a@kernel.org>
From:   Marios Pomonis <pomonis@google.com>
Date:   Fri, 24 Sep 2021 10:17:58 -0700
Message-ID: <CAKXAmdgS3SL_qyjzjY32_DXe3WVTN+O=wYwJ9vkUXKhjmt87fA@mail.gmail.com>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Sep 5, 2021 at 12:57 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sat, 4 Sep 2021 10:55:11 -0700
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > > From: Marios Pomonis <pomonis@google.com>
> > >
> > > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > > assumes that the address in the stack is a return address and decrements
> > > it by 1 in order to find the proper depth of the next frame.
> > >
> > > This issue was discovered while testing the FG-KASLR series[0][1] and
> > > running the live patching test[2] that was originally failing[3].
> > >
> > > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > > [1] https://github.com/KSPP/linux/issues/132
> > > [2] https://github.com/lpechacek/qa_test_klp
> > > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > >
> > > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > I suspect this is fixed by:
> >
> >   https://lkml.kernel.org/r/162756755600.301564.4957591913842010341.stgit@devnote2
>
> I think this can be a bit different issue. As far as I ran my test code
> (same one in the above cover mail) with this fix, the stacktrace wasn't
> fixed.
>
> ffffffff812b7c80  r  vfs_read+0x0    [FTRACE]
> ffffffff813b4cc0  r  full_proxy_read+0x0    [FTRACE]
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>              cat-138     [002] ...1     9.488727: r_full_proxy_read_0: (vfs_read+0x99/0x190 <- full_proxy_read)
>              cat-138     [002] ...1     9.488732: <stack trace>
>  => kretprobe_trace_func+0x209/0x300
>  => kretprobe_dispatcher+0x9d/0xb0
>  => __kretprobe_trampoline_handler+0xc5/0x160
>  => trampoline_handler+0x44/0x60
>  => kretprobe_trampoline+0x25/0x50
>              cat-138     [002] ...1     9.488733: r_vfs_read_0: (ksys_read+0x68/0xe0 <- vfs_read)
>
> Kees, can you also try to test with my series?
> It should be able to be checked out with;
>
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git -b kprobes/kretprobe-stackfix-v10
>
> Thank you,

I tested this series in conjunction with FG-KASLR and klp_tc_12 fails.
Therefore the patch of the cover mail fixes a different issue than the
one of this series.

Thanks,
Marios
> >
> >
> > > ---
> > >  arch/x86/kernel/unwind_orc.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> > > index a1202536fc57..8c5038b3b707 100644
> > > --- a/arch/x86/kernel/unwind_orc.c
> > > +++ b/arch/x86/kernel/unwind_orc.c
> > > @@ -7,6 +7,7 @@
> > >  #include <asm/unwind.h>
> > >  #include <asm/orc_types.h>
> > >  #include <asm/orc_lookup.h>
> > > +#include <asm/kprobes.h>
> > >
> > >  #define orc_warn(fmt, ...) \
> > >     printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
> > > @@ -414,6 +415,15 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
> > >     return false;
> > >  }
> > >
> > > +static bool is_kretprobe_trampoline(unsigned long ip)
> > > +{
> > > +#ifdef     CONFIG_KRETPROBES
> > > +   if (ip == (unsigned long)&kretprobe_trampoline)
> > > +           return true;
> > > +#endif
> > > +   return false;
> > > +}
> > > +
> > >  bool unwind_next_frame(struct unwind_state *state)
> > >  {
> > >     unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> > > @@ -540,7 +550,7 @@ bool unwind_next_frame(struct unwind_state *state)
> > >             state->sp = sp;
> > >             state->regs = NULL;
> > >             state->prev_regs = NULL;
> > > -           state->signal = false;
> > > +           state->signal = is_kretprobe_trampoline(state->ip);
> > >             break;
> > >
> > >     case UNWIND_HINT_TYPE_REGS:
> > > --
> > > 2.30.2
> > >
> >
> > --
> > Josh
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
