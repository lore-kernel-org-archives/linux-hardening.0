Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69DC433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 07:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610E560F92
	for <linux-hardening@archiver.kernel.org>; Sun,  5 Sep 2021 07:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhIEH6q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhIEH6p (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 5 Sep 2021 03:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3444F60EE1;
        Sun,  5 Sep 2021 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630828662;
        bh=W3xcCkndsu9LZ9q+jY/ntg77e+br2nanRDdnooBmmLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h0tvopfAiDHKnDcH+4QW90p8DaBe6vH9j9UGa3MFN7xyImYh3P1LTZtJBOPTtRdyQ
         6euUZwa9PWCWlslSal64RRtKwZuWDmkDpf3wk0UFk7d91jSDFZv/bWwASQbPyOTZwR
         T4zxj8IQd6+gJu/vrnBgPBXlGDzD4Bh70f3zBlGV/b1ww3so5tZN5Hf1xLA7j2g8JA
         /gndGNBz9OhuMbCUSlhOt+8pCYt1DK/IFkZaRvx7hEsStnOV/xT0bD5ltUJ71DeUst
         N8mkriGbU3TYZ9qMz3vFuMCiL2i/Vkm+LfZnd2jYFSvFq8+aknFm52iZw/41YTvzeE
         kZjh7B+Qd8dxw==
Date:   Sun, 5 Sep 2021 16:57:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Marios Pomonis <pomonis@google.com>,
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
        linux-hardening@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-Id: <20210905165738.7e40d6e2cba3dd0724f85f3a@kernel.org>
In-Reply-To: <20210904175511.oijbn4f2tzghwk7l@treble>
References: <20210903021326.206548-1-keescook@chromium.org>
        <20210904175511.oijbn4f2tzghwk7l@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 4 Sep 2021 10:55:11 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > From: Marios Pomonis <pomonis@google.com>
> > 
> > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > assumes that the address in the stack is a return address and decrements
> > it by 1 in order to find the proper depth of the next frame.
> > 
> > This issue was discovered while testing the FG-KASLR series[0][1] and
> > running the live patching test[2] that was originally failing[3].
> > 
> > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > [1] https://github.com/KSPP/linux/issues/132
> > [2] https://github.com/lpechacek/qa_test_klp
> > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > 
> > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I suspect this is fixed by:
> 
>   https://lkml.kernel.org/r/162756755600.301564.4957591913842010341.stgit@devnote2

I think this can be a bit different issue. As far as I ran my test code
(same one in the above cover mail) with this fix, the stacktrace wasn't
fixed.

ffffffff812b7c80  r  vfs_read+0x0    [FTRACE]
ffffffff813b4cc0  r  full_proxy_read+0x0    [FTRACE]
# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
             cat-138     [002] ...1     9.488727: r_full_proxy_read_0: (vfs_read+0x99/0x190 <- full_proxy_read)
             cat-138     [002] ...1     9.488732: <stack trace>
 => kretprobe_trace_func+0x209/0x300
 => kretprobe_dispatcher+0x9d/0xb0
 => __kretprobe_trampoline_handler+0xc5/0x160
 => trampoline_handler+0x44/0x60
 => kretprobe_trampoline+0x25/0x50
             cat-138     [002] ...1     9.488733: r_vfs_read_0: (ksys_read+0x68/0xe0 <- vfs_read)

Kees, can you also try to test with my series?
It should be able to be checked out with;

git clone git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git -b kprobes/kretprobe-stackfix-v10

Thank you,
> 
> 
> > ---
> >  arch/x86/kernel/unwind_orc.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> > index a1202536fc57..8c5038b3b707 100644
> > --- a/arch/x86/kernel/unwind_orc.c
> > +++ b/arch/x86/kernel/unwind_orc.c
> > @@ -7,6 +7,7 @@
> >  #include <asm/unwind.h>
> >  #include <asm/orc_types.h>
> >  #include <asm/orc_lookup.h>
> > +#include <asm/kprobes.h>
> >  
> >  #define orc_warn(fmt, ...) \
> >  	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
> > @@ -414,6 +415,15 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
> >  	return false;
> >  }
> >  
> > +static bool is_kretprobe_trampoline(unsigned long ip)
> > +{
> > +#ifdef	CONFIG_KRETPROBES
> > +	if (ip == (unsigned long)&kretprobe_trampoline)
> > +		return true;
> > +#endif
> > +	return false;
> > +}
> > +
> >  bool unwind_next_frame(struct unwind_state *state)
> >  {
> >  	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
> > @@ -540,7 +550,7 @@ bool unwind_next_frame(struct unwind_state *state)
> >  		state->sp = sp;
> >  		state->regs = NULL;
> >  		state->prev_regs = NULL;
> > -		state->signal = false;
> > +		state->signal = is_kretprobe_trampoline(state->ip);
> >  		break;
> >  
> >  	case UNWIND_HINT_TYPE_REGS:
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
