Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA0C433ED
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D624E61157
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Apr 2021 15:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhDSP1X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhDSP1T (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Apr 2021 11:27:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AADBC06174A
        for <linux-hardening@vger.kernel.org>; Mon, 19 Apr 2021 08:26:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 82so39230505yby.7
        for <linux-hardening@vger.kernel.org>; Mon, 19 Apr 2021 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tzb/+EbwYHLN4nxTuV4UKFwyv5D43rDbhLkuAljBUMc=;
        b=r/yqG7pUEvuWmvwcAN+ZsOp88DSLN5Szqm7c64htgXhv6NnxyzEj31HM+u8SeAPgxF
         Y3r8QWzKV85aBZzq3d4zwsejv01NJ980SfWWo93Znlm+wDcPHK4fYNHX8KG0tokTGDEq
         tsPfZCbSk4okWCvn7fvayQ9bXEk1NgKsAFzIrzSPQh/T3BEbPvrDgNgp9lZLYe5rW7cs
         AOtvee6E4GE6+V6CSsKklT8e8dt9F8gBjgl6iPN8D7of6i5t7/jI6tSrbQtkCBnbKR3m
         6XYn7QLBY+xZo6fTmCigBgcZGIkuuYsB2gMPoIrVR3dlLslNjf8q2TiVtHmCRJ2i7D+E
         HjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tzb/+EbwYHLN4nxTuV4UKFwyv5D43rDbhLkuAljBUMc=;
        b=NMCz1CVvsWNDHncjHWS3yvZM7FbIRaprwIMCtOaKDOwsF3RwINf8MSeZimiemAjos2
         Bu9FXlv/2fkfQ2G/ZBePrCA/Xwz7u6RkdBYKyJOqBTZMQQd/YjTJphhGbfk72a4kc3At
         rHVL4Sl8yeBX67omnyirXmrXAaJDTgdzHJzcA811JbyWYrHdehkrOa7baIZkQhBicEc4
         Db1rJGfgAiqCcEMKHRRFjEcTeECNQgRAs/6KHMLmKEGJwAq5EInqguMlDOQvoxZuiOEi
         2MrI/doGcrJzNt6qwSNRI9HgQHLsD0+AcP29Pg7KNI3+GDG3ZbT3UfI9KiynGAJPlbs7
         KtTg==
X-Gm-Message-State: AOAM530UmMMGv+dwuuvnKEHZmeblk3DmZNIyb8WqEgi+zT9jRfX1tIAQ
        V5OyZj27B8+AUNqXtAlB/EWCihtYB0VETz9KAkGMZg==
X-Google-Smtp-Source: ABdhPJzTzl74OJPzMlU029c1MRTT0Th9IJfji30PLdlkZRVuJD6XS699NNKbJAHdTdd8WjDP7igb5Lkx5vEYFH1yORQ=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr10459679ybg.459.1618846007267;
 Mon, 19 Apr 2021 08:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-10-samitolvanen@google.com> <YHrIc0L5AQukw525@hirez.programming.kicks-ass.net>
In-Reply-To: <YHrIc0L5AQukw525@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 19 Apr 2021 08:26:36 -0700
Message-ID: <CABCJKuevfuVbKZPtLrFacXZLk+VtbFgebbyLeK8Xxe7Z3YmwQA@mail.gmail.com>
Subject: Re: [PATCH 09/15] x86/alternatives: Use C int3 selftest but disable KASAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Apr 17, 2021 at 4:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:38PM -0700, Sami Tolvanen wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > Instead of using inline asm for the int3 selftest (which confuses the
> > Clang's ThinLTO pass), this restores the C function but disables KASAN
> > (and tracing for good measure) to keep the things simple and avoid
> > unexpected side-effects. This attempts to keep the fix from commit
> > ecc606103837 ("x86/alternatives: Fix int3_emulate_call() selftest stack
> > corruption") without using inline asm.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/x86/kernel/alternative.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 6974b5174495..669a23454c09 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -496,23 +496,10 @@ extern struct paravirt_patch_site __start_parainstructions[],
> >   *
> >   * See entry_{32,64}.S for more details.
> >   */
> > -
> > -/*
> > - * We define the int3_magic() function in assembly to control the calling
> > - * convention such that we can 'call' it from assembly.
> > - */
> > -
> > -extern void int3_magic(unsigned int *ptr); /* defined in asm */
> > -
> > -asm (
> > -"    .pushsection    .init.text, \"ax\", @progbits\n"
> > -"    .type           int3_magic, @function\n"
> > -"int3_magic:\n"
> > -"    movl    $1, (%" _ASM_ARG1 ")\n"
> > -"    ret\n"
> > -"    .size           int3_magic, .-int3_magic\n"
> > -"    .popsection\n"
> > -);
> > +static void __init __no_sanitize_address notrace int3_magic(unsigned int *ptr)
> > +{
> > +     *ptr = 1;
> > +}
>
> I really don't like this. the compiler is free to mess this up in all
> sorts of ways.
>
> The problem is that the call-site does not respect the regular calling
> convention, so calling a regular C function is just asking for trouble,
> which is why it ended up being asm, then we fully control the calling
> convention.

Ack. The problem here is that we can't declare an extern static
function in C. How would you feel about making int3_magic a global
instead to match the C declaration?

Sami
