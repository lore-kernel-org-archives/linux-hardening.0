Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4D3C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD7861052
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJUPQ1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhJUPQI (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 11:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B162C60F46;
        Thu, 21 Oct 2021 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634829232;
        bh=ruagNsEyw3JIWO97eB7HyyER6TijqqZmxwT762qH5yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KzlxnxPjYfw7b7HUIL2fVpwTigQ556Uhy4x3O5vKe3EN+oWMlCI6pPX13bbS22shB
         u5+vZUlcMn6WpwESYxBRhfd6OhdovCJBPf9LngAQIKfeodhwnrz5DibVJEp9r1ADrT
         8YKBVKQK51IAlLrxZu6/2v+3IMUaLaneGC3+PYqU5NDIj6AAr9qL8/fPZLGdSxVj+L
         z+2c9P8AFdvLbgqC6X8qH5ojpuuUWAQqk7mtaGAP64FMZwg2X91TaK36UVZvH4ixQc
         u92bZnx0G8tO+b46atopV3RYMPghlZcacRbY+1eW1mE1pxsTiguTdrkpG4920GVii+
         DwGK/Rx/qMjSw==
Date:   Fri, 22 Oct 2021 00:13:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-Id: <20211022001347.6da975173bc8c797595630e6@kernel.org>
In-Reply-To: <20211014191643.6c7ca819a732dd6479329a6b@kernel.org>
References: <20210903021326.206548-1-keescook@chromium.org>
        <202110111403.3C59BF77@keescook>
        <20211014014101.6du6jj2o7g4ficu5@treble>
        <202110132151.F78F49AD8@keescook>
        <20211014191643.6c7ca819a732dd6479329a6b@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 14 Oct 2021 19:16:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 13 Oct 2021 21:52:36 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Wed, Oct 13, 2021 at 06:41:01PM -0700, Josh Poimboeuf wrote:
> > > On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> > > > On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > > > > From: Marios Pomonis <pomonis@google.com>
> > > > > 
> > > > > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > > > > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > > > > assumes that the address in the stack is a return address and decrements
> > > > > it by 1 in order to find the proper depth of the next frame.
> 
> Hmm, with my fixes[1], the kretprobe_trampoline address in the stack will be
> replaced with the correct return address. In that case, that behavior
> sounds correct.
> 
> [1] https://lore.kernel.org/all/163163030719.489837.2236069935502195491.stgit@devnote2/

Here is the code which I applied this on my series.

        /* Find IP, SP and possibly regs: */
        switch (orc->type) {
        case UNWIND_HINT_TYPE_CALL:
                ip_p = sp - sizeof(long);

                if (!deref_stack_reg(state, ip_p, &state->ip))
                        goto err;

                state->ip = unwind_recover_ret_addr(state, state->ip,
                                                    (unsigned long *)ip_p);
                state->sp = sp;
                state->regs = NULL;
                state->prev_regs = NULL;
                state->signal = is_kretprobe_trampoline(state->ip);
                break;

Actually, this cause a build issue because I introduced more generic is_kretprobe_trampoline().
Anyway, after calling unwind_recover_ret_addr(), the state->ip should be fixed.
This means that the is_kretprobe_trampoline(state->ip) always be false, and
that is correct because state->ip is recovered with the correct return address
which is call instruction + 5.

So this patch seems not needed, hmm...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
