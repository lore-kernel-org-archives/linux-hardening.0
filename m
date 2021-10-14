Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5315C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D74610E6
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 10:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJNKSw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 06:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhJNKSw (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 06:18:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E358B60EBB;
        Thu, 14 Oct 2021 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634206607;
        bh=3XsDHD/eBSYmde+bZHZT79zui6v3kV5ZUbATOpXk5nc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ca50zmQcZF6benVZW7U0Xq7fM5jl9D342FFc0SlGtkV3OPo07L9taV2OH3FIgImFt
         xk2qqfVfJ4mIoMoBJXjBJN+zCSpALYyOFynQfUiP26r5btucp/5PNOspCELUJXN9k3
         /nqIDU9ztvGU7r1XKj9I76MX/IbSx/isG9AeUo1q4mwokhMIIdXpYWld5Z8sUmHVeZ
         K/kiQch3GPJKvuruCvmg0mFYsPSRZq+okvLP3nwy4NlGOhCRVpK/P6j4q1sF/pjLIa
         Yg1pBwRNzzMAoh9dOOlezm8h1T54nQoHPZvvCB1K2zHgJIMwbMZrwAxMwuym7qefub
         cJfSbtIwp17KA==
Date:   Thu, 14 Oct 2021 19:16:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
Message-Id: <20211014191643.6c7ca819a732dd6479329a6b@kernel.org>
In-Reply-To: <202110132151.F78F49AD8@keescook>
References: <20210903021326.206548-1-keescook@chromium.org>
        <202110111403.3C59BF77@keescook>
        <20211014014101.6du6jj2o7g4ficu5@treble>
        <202110132151.F78F49AD8@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 13 Oct 2021 21:52:36 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Oct 13, 2021 at 06:41:01PM -0700, Josh Poimboeuf wrote:
> > On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> > > On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > > > From: Marios Pomonis <pomonis@google.com>
> > > > 
> > > > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > > > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > > > assumes that the address in the stack is a return address and decrements
> > > > it by 1 in order to find the proper depth of the next frame.

Hmm, with my fixes[1], the kretprobe_trampoline address in the stack will be
replaced with the correct return address. In that case, that behavior
sounds correct.

[1] https://lore.kernel.org/all/163163030719.489837.2236069935502195491.stgit@devnote2/

> > > > 
> > > > This issue was discovered while testing the FG-KASLR series[0][1] and
> > > > running the live patching test[2] that was originally failing[3].
> > > > 
> > > > [0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com/
> > > > [1] https://github.com/KSPP/linux/issues/132
> > > > [2] https://github.com/lpechacek/qa_test_klp
> > > > [3] https://lore.kernel.org/lkml/alpine.LSU.2.21.2009251450260.13615@pobox.suse.cz/
> > > > 
> > > > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> > > > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > > Cc: Kristen C Accardi <kristen.c.accardi@intel.com>
> > > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Ping again; Josh can you take this please?
> > 
> > I'm confused how this still fixes anything after Masami's patch set,
> > which is now in linux-next.
> > 
> > After those patches, for a CALL-type ORC entry, the unwinder sets
> > state->ip to the address returned by unwind_recover_ret_addr().  In the
> > case of a kretprobe, that means that state->ip will no longer point to
> > kretprobes_trampoline() -- making the above patch description incorrect.
> > 
> > Instead, state->ip will then contain the original call return address
> > which was replaced by kretpobes.  So it looks to the unwinder like a
> > normal call return address, and 'state->signal' should remain false.
> > 
> > Am I missing something?
> 
> I'll let Marios answer in more detail, but my understanding is that
> Masami's patch set didn't solve the FGKASLR-vs-kretprobes issue[1].
> I don't understand _why_ yet, though.

My another question is that this fix still works correctly on my series,
because it's already merged via Steve's tree. Isn't this break anything?

I also need to know how (from where) the failed test uses stacktrace.
Does it call stacktrace from outside of kretprobe?

Thank you,

> 
> -Kees
> 
> [1] https://lore.kernel.org/all/CAKXAmdgS3SL_qyjzjY32_DXe3WVTN+O=wYwJ9vkUXKhjmt87fA@mail.gmail.com/
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
