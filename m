Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41BFC433DB
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Feb 2021 23:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D49764EBA
	for <linux-hardening@archiver.kernel.org>; Mon,  1 Feb 2021 23:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBAXSl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhBAXSd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 1 Feb 2021 18:18:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0045C0613D6
        for <linux-hardening@vger.kernel.org>; Mon,  1 Feb 2021 15:17:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g15so788956pjd.2
        for <linux-hardening@vger.kernel.org>; Mon, 01 Feb 2021 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BH7JqYRJgVe3vsNAU4epkLL+VUNkt6PlTrNV6f51Lak=;
        b=psgOxADbsIese7e/ocVIsn+gzC7Om8eLEWVSXvf9zfas7ULfITgQxQGD0vRA6aXhDs
         cPRM4ri7/UhvPihMtDnemuFh10PnhgWcPa3ZxOmmirEy7+JttzSyXs4gC1J/OHByjWUv
         BU/n8cT3S/2IKtYFHG7Q1qKODe+/bQO9KTRdU64nX9aXHRhCfrMKqerO2rDi7YCtUueF
         4W0vlcqzrNFtOGyY39Uw5EAW21GljsC6dXjmA27+dK/PpaEvu8XZ/0KE0TPMf1W7JnyF
         mFidquAJRCxHTIONO2sGHiZNbAhQUPU/V+pZpo1UFrXqcZU+89gCjcq9souY3JYlK+Yv
         o0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH7JqYRJgVe3vsNAU4epkLL+VUNkt6PlTrNV6f51Lak=;
        b=mcMoxOpT/bcptEK7Ho0OhooDJSRWeMFVeOd2TATzku6nmHW4EJTfzMOkFcYrNZ0PgU
         n+y42pcD1ms/EhGMJ9ZEiH63zFIsW2mrHc9Xfpm1mVLb/D2j2z9iCc8FloNfgypL0MMo
         pMe+ThjQ47usnTvtGC+qnrcgmqvzejIJtyyd/cNhTR4kOw5zx1nB0lrAPUgloNkFa2OF
         JwEnaRqro777kAF9zPSH9qEDNbAn/8+g7lUWgOxLqj5gT44nyjxsMHZvtRzTfg7rkkUp
         CshKFzy4vIKwhC16UuoGcBeE+MvUrOTQUPCBoWWSekjANrSm4hhjpT/AowG61AzDIO0O
         igug==
X-Gm-Message-State: AOAM530H6pZzqO0uAzKe6uyTG7ieFv3Wmsj1iAEgHUmqPhXF789pprcA
        07CH6FeFa6LjuNxsFyRFLRy5BgPmQm2FGwPh1v8LdQ==
X-Google-Smtp-Source: ABdhPJz/FE60Rh1Oi9akyueA2x65LZ7OVJgCoDBRZGCuD026sxzBhCH8/o3DzicGk98bpxqwRWIZ9NIbJh876CYHLVM=
X-Received: by 2002:a17:90a:db05:: with SMTP id g5mr1242739pjv.32.1612221472089;
 Mon, 01 Feb 2021 15:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com> <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com> <20210201214423.dhsma73k7ccscovm@treble>
In-Reply-To: <20210201214423.dhsma73k7ccscovm@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Feb 2021 15:17:40 -0800
Message-ID: <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Feb 1, 2021 at 1:44 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:10:01AM -0800, Nick Desaulniers wrote:
> > On Wed, Jan 27, 2021 at 3:27 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
> > > > > From: Raphael Gault <raphael.gault@arm.com>
> > > > >
> > > > > This plugins comes into play before the final 2 RTL passes of GCC and
> > > > > detects switch-tables that are to be outputed in the ELF and writes
> > > > > information in an ".discard.switch_table_info" section which will be
> > > > > used by objtool.
> > > > >
> > > > > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > > > > [J.T.: Change section name to store switch table information,
> > > > >        Make plugin Kconfig be selected rather than opt-in by user,
> > > > >        Add a relocation in the switch_table_info that points to
> > > > >        the jump operation itself]
> > > > > Signed-off-by: Julien Thierry <jthierry@redhat.com>
> > > >
> > > > Rather than tightly couple this feature to a particular toolchain via
> > > > plugin, it might be nice to consider what features could be spec'ed out
> > > > for toolchains to implement (perhaps via a -f flag).
> > >
> > > The problem is being able to detect switch statement jump table vectors.
> > >
> > > For a given indirect branch (due to a switch statement), what are all
> > > the corresponding jump targets?
> > >
> > > We would need the compiler to annotate that information somehow.
> >
> > Makes sense, the compiler should have this information.  How is this
> > problem solved on x86?
>
> Thus far we've been able to successfully reverse engineer it on x86,
> though it hasn't been easy.
>
> There were some particulars for arm64 which made doing so impossible.
> (I don't remember the details.)

I think the details are pertinent to finding a portable solution.  The
commit message of this commit in particular doesn't document such
details, such as why such an approach is necessary or how the data is
laid out for objtool to consume it.

> > > > Distributions (like Android, CrOS) wont be able to use such a feature as
> > > > is.
> > >
> > > Would a Clang plugin be out of the question?
> >
> > Generally, we frown on out of tree kernel modules for a couple reasons.
> >
> > Maintaining ABI compatibility when the core kernel changes is
> > generally not instantaneous; someone has to notice the ABI has changed
> > which will be more delayed than if the module was in tree.  Worse is
> > when semantics subtly change.  While we must not break userspace, we
> > provide no such guarantees within the kernel proper.
> >
> > Also, it's less likely that out of tree kernel modules have been
> > reviewed by kernel developers.  They may not have the same quality,
> > use the recommended interfaces, follow coding conventions, etc..
> >
> > Oh, did I say "out of tree kernel modules?"  I meant "compiler
> > plugins."  But it's two different sides of the same coin to me.
>
> I thought Android already relied on OOT modules.

Android Common Kernel does not *rely* on OOT modules or compiler
plugins.  Android doesn't forbid vendors from using OOT modules,
though, just as the mainline kernel does not prevent modules from
being built out of tree, or users from insmod'ing them.  It's
certainly a pragmatic approach; idealism doesn't work for all OEMs.

Personally, I lean more towards idealistic; I prefer in-tree modules,
dislike compiler plugins (for much the same reasons), and idealize
loose coupling of software components. This series looks to me like it
tightly couples arm64 live patching to objtool and GCC.

On the earlier thread, Julien writes:

>> I think most people interested in livepatching are using GCC built
>> kernels, but I could be mistaken (althought in the long run, both
>> compilers should be supported, and yes, I realize the objtool solution
>> currently only would support GCC).

Google's production kernels are using livepatching and are built with
Clang.  Getting similar functionality working for arm64 would be of
interest.

> GCC plugins generally enforce the exact same GCC version for OOT
> modules.  So there's no ABI to worry about.  I assume Clang does the
> same?
>
> Or did I miss your point?

I think so.  It would seem that the current solution for stack
validation would require multiple different compiler plugins to work
reliably.  If jump tables are an issue, I don't see why you wouldn't
pursue a more portable option like -fno-jump-tables first, then work
to claw back any performance loss from that, if relevant?  Then
there's no complaint about toolchain specific implementations or tight
coupling.

Objtool support on arm64 is interesting to me though, because it has
found bugs in LLVM codegen. That alone is extremely valuable.  But not
it's not helpful if it's predicated or tightly coupled to GCC, as this
series appears to do.  The idea of rebuilding control flow from binary
analysis and using that to find codegen bugs is a really cool idea
(novel, even? idk), and I wish we had some analog for userspace
binaries that could perform similar checks.

>
> > FWIW, I think the approach taken by -mstack-protector-guard-reg= is a
> > useful case study.  It was prototyped as a GCC extension, then added
> > to GCC proper, then added to LLVM (currently only x86, but most of the
> > machinery is in place in the compiler to get it running on arm64).  My
> > recommendation is to skip the plugin part and work on a standard
> > interface for compilers to implement, with input from compiler
> > developers.
>
> I like the idea.  Is there a recommended forum for such discussions?
> Just an email to GCC/Clang development lists?

linux-toolchains@vger.kernel.org is probably a good start.

--
Thanks,
~Nick Desaulniers
