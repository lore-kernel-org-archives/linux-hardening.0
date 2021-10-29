Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED2DC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E211F610A0
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJ2SWa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhJ2SWa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Oct 2021 14:22:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2DAC061714
        for <linux-hardening@vger.kernel.org>; Fri, 29 Oct 2021 11:20:01 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 131so14794321ybc.7
        for <linux-hardening@vger.kernel.org>; Fri, 29 Oct 2021 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGk9uVUl3MDhefL25yjOADYfMduMueO1BypIOCN+3P0=;
        b=lm2K28wncPdbsqH4WnpVx99VR/WYyIb/1vnDGYhWt/Bhzom54Qq0e/+slzPwuyrwwv
         G55Yf5tlXV6deKt6LwkxajTxTkTU3aMjX3XCAMxAO2LFuAMinQL+p1Otj9CRhnrLJXZs
         EG2Wgkvjv7IS1DCT1KlmC0KjvADfisuSDnwBe5n+f1RzSDR+CZc9QPXG8MxqZtSg53vP
         /W37zW0VESQMA2SlJGLaaA5FiQmYDWQvUF7f0LofVlqB8zafesIrBG6RZWqHvuv/MjqO
         KXWV7vUg3DXK8+Q3/m1f90o8/AglNDnhSJSNbzNxXrqxIeR6oT6u2NIjdk2y4lavJw3Y
         WNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGk9uVUl3MDhefL25yjOADYfMduMueO1BypIOCN+3P0=;
        b=BFNbKM51MLP8GFXqhTOx+2CPuNuPHU04IchOavT7kbF65nv2LzUZ3m6Bek3X6YO6c8
         fGGeH00jI6VZdfDNgN/05QfNZ3DNMI5R40uXwtclcgT/fRPxKy9zGCjaFxOXQP+phKut
         mOWG0+t5sYUbxnCvtiE98Cyt1wgKZYpRnCakP4QDJ96PWCR8DscPOaCZfMAg8fTX643W
         Wb9X39/hU9xn/FCIm5embI6tMPwdy8YJkFnT/D6aIxvxvjD5aDxdGuGI/xMmLnyoRBNc
         67RtPYgBl5ay0pVKrNredk0Jmjjgx/zD5CsxQjnFs4U0qZqL3tKRwdjWe8GinzIc6EHQ
         4tXw==
X-Gm-Message-State: AOAM531ujFqEuyw9RnXiZ3dCyp0ngYAcSqhPhtkAuFsKSNQmxyHIJRtc
        rxX1+nb9zVCqb9hihDE62j5PM/LFLiMPSywAJvJndQ==
X-Google-Smtp-Source: ABdhPJxEGq84YsEuD5ciwE31SpGkQDo3f5N6CuuUStDZ7ikYfkFXi9xpJWpoJ5k8zbzLiQZpy8jeaQiKGclc8toilGU=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr14142176ybt.454.1635531600521;
 Fri, 29 Oct 2021 11:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210903021326.206548-1-keescook@chromium.org>
 <202110111403.3C59BF77@keescook> <20211014014101.6du6jj2o7g4ficu5@treble>
 <202110132151.F78F49AD8@keescook> <20211014191643.6c7ca819a732dd6479329a6b@kernel.org>
 <20211022001347.6da975173bc8c797595630e6@kernel.org>
In-Reply-To: <20211022001347.6da975173bc8c797595630e6@kernel.org>
From:   Marios Pomonis <pomonis@google.com>
Date:   Fri, 29 Oct 2021 11:19:49 -0700
Message-ID: <CAKXAmdiUfXrhdeP6sd_4iTSoC74VHU3W4iwv13r+jXO=+KR8oA@mail.gmail.com>
Subject: Re: [PATCH] x86/unwind/orc: Handle kretprobes_trampoline
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 8:13 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 14 Oct 2021 19:16:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > On Wed, 13 Oct 2021 21:52:36 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> >
> > > On Wed, Oct 13, 2021 at 06:41:01PM -0700, Josh Poimboeuf wrote:
> > > > On Mon, Oct 11, 2021 at 02:03:26PM -0700, Kees Cook wrote:
> > > > > On Thu, Sep 02, 2021 at 07:13:26PM -0700, Kees Cook wrote:
> > > > > > From: Marios Pomonis <pomonis@google.com>
> > > > > >
> > > > > > Fix a bug in the ORC unwinder when kretprobes has replaced a return
> > > > > > address with the address of `kretprobes_trampoline'. ORC mistakenly
> > > > > > assumes that the address in the stack is a return address and decrements
> > > > > > it by 1 in order to find the proper depth of the next frame.
> >
> > Hmm, with my fixes[1], the kretprobe_trampoline address in the stack will be
> > replaced with the correct return address. In that case, that behavior
> > sounds correct.
> >
> > [1] https://lore.kernel.org/all/163163030719.489837.2236069935502195491.stgit@devnote2/
>
> Here is the code which I applied this on my series.
>
>         /* Find IP, SP and possibly regs: */
>         switch (orc->type) {
>         case UNWIND_HINT_TYPE_CALL:
>                 ip_p = sp - sizeof(long);
>
>                 if (!deref_stack_reg(state, ip_p, &state->ip))
>                         goto err;
>
>                 state->ip = unwind_recover_ret_addr(state, state->ip,
>                                                     (unsigned long *)ip_p);
>                 state->sp = sp;
>                 state->regs = NULL;
>                 state->prev_regs = NULL;
>                 state->signal = is_kretprobe_trampoline(state->ip);
>                 break;
>
> Actually, this cause a build issue because I introduced more generic is_kretprobe_trampoline().
> Anyway, after calling unwind_recover_ret_addr(), the state->ip should be fixed.
> This means that the is_kretprobe_trampoline(state->ip) always be false, and
> that is correct because state->ip is recovered with the correct return address
> which is call instruction + 5.
>
> So this patch seems not needed, hmm...
>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

You're right, I made a mistake when testing this code; this is what
happens when you create patches with debugging changes and then forget
to remove them. I re-checked and your patch does solve the issue, so
the cover mail fix is not needed (I had created it against the
then-linux-next branch which didn't include your patch).

Thanks for catching this and I apologize for the (very) late response!
