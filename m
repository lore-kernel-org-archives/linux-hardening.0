Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC3FC433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A92A613D8
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Apr 2021 20:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhDTUqQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhDTUqO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Apr 2021 16:46:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B64C06138A
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 13:45:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p3so23961344ybk.0
        for <linux-hardening@vger.kernel.org>; Tue, 20 Apr 2021 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNWJnV/ujY0AN1/v5JQQqbaoBjz2BczeakSAfc9G65g=;
        b=JmEmQ1D+ODdrwKrwWj0YOP+LdHOd9roC5YmCZ8iKaY3ySqcDx0cyMmAqAhs/BIRer6
         BIQmhHuLIogDg6jE8hRR5+acsut5b7DmJpk+M5Qin+dohrtDco+FYLHIEkwizYIH/VFy
         7D4d5O+++U+8bGRQyY5k43091qfq5t52c8+9ZTvJDCLpnV8ustet3YMp9JlpLMzGbOnS
         6GnulHbJ/xDnCAqs384JsNg8cWUSggU16lLY4ZRORY1CP3y6YJR0W8IBvdIkXyI4yzdh
         zB2aeQokQEWsIdHTTscKaUGSuRDZKZXeNygQU37BPp3OYOjI9bxeSioqZBOa6FN9hyKi
         8/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNWJnV/ujY0AN1/v5JQQqbaoBjz2BczeakSAfc9G65g=;
        b=IRgpoASNM/K0gKpcozGrGwc8t/KWSMU0H83iqnj2Q3C11HjK/wZFkwiaw2nnvkBcVA
         mWtDSEyO1Bh/u3WTP0sW52jC1L3BlFxcsy1G8pOzMN7BeFNJ0xGndwM0ubWITzUGjpgU
         JBht8G7oKX3AsCAfxwHxgBP4mJI+ImmvNEaAhofAFDfAeq+HuTjDT2fYl2N05yfzIskQ
         fmYiWqCBQdIPhSWw/lOp4nzz25WJzHuRvuPN2qo9gfBCr0IICAxzfHCNNQxg+AjHGqHH
         4vR2l0o/QJrdr2QFEWOqJmnyCoiY3hL1bf0EIOizrNE57duuPuDmFEKotQr3m9xLJuSB
         1D3A==
X-Gm-Message-State: AOAM532tzK2zfoXkVMT4ZwZCeYezSXF6Fae5jdYseTp40Vj+RSsJpYFi
        SMqgPZbpro0jldrR5qIRNG2HIow5wmYpEpXCq1q6xg==
X-Google-Smtp-Source: ABdhPJxvErDAeKN7gNVUK8lP+l8e8YgAeqaZVPcPX0mn5e8XJ3uublln/uslQceWPqApgq7S+ag3pSG/4f3jJ0cavaA=
X-Received: by 2002:a25:7085:: with SMTP id l127mr27992640ybc.293.1618951539670;
 Tue, 20 Apr 2021 13:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-3-samitolvanen@google.com> <20210420194747.3snxvaaa4amfnbah@treble>
In-Reply-To: <20210420194747.3snxvaaa4amfnbah@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Apr 2021 13:45:28 -0700
Message-ID: <CABCJKufE2_z0SGhsbgu-Wu+L5TRhOktQO4wHgJg04RYcvoxAAA@mail.gmail.com>
Subject: Re: [PATCH 02/15] objtool: Add CONFIG_CFI_CLANG support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Apr 20, 2021 at 12:48 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:31PM -0700, Sami Tolvanen wrote:
> > +static int fix_cfi_relocs(const struct elf *elf)
> > +{
> > +     struct section *sec, *tmpsec;
> > +     struct reloc *reloc, *tmpreloc;
> > +
> > +     list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
> > +             list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
>
> These loops don't remove structs from the lists, so are the "safe"
> iterators really needed?
>
> > +                     struct symbol *sym;
> > +                     struct reloc *func_reloc;
> > +
> > +                     /*
> > +                      * CONFIG_CFI_CLANG replaces function relocations to refer
> > +                      * to an intermediate jump table. Undo the conversion so
> > +                      * objtool can make sense of things.
> > +                      */
>
> I think this comment could be clearer if it were placed above the
> function.
>
> > +                     if (!reloc->sym->sec->cfi_jt)
> > +                             continue;
> > +
> > +                     if (reloc->sym->type == STT_SECTION)
> > +                             sym = find_func_by_offset(reloc->sym->sec,
> > +                                                       reloc->addend);
> > +                     else
> > +                             sym = reloc->sym;
> > +
> > +                     if (!sym || !sym->sec)
> > +                             continue;
>
> This should be a fatal error, it probably means something's gone wrong
> with the reading of the jump table.
>
> > +
> > +                     /*
> > +                      * The jump table immediately jumps to the actual function,
> > +                      * so look up the relocation there.
> > +                      */
> > +                     func_reloc = find_reloc_by_dest_range(elf, sym->sec, sym->offset, 5);
>
> The jump instruction's reloc is always at offset 1, so this can maybe be
> optimized to:
>
>                         func_reloc = find_reloc_by_dest(elf, sym->sec, sym->offset+1);
>
> though of course that will probably break (future) arm64 objtool.  Maybe
> an arch-specific offset from the start of the insn would be good.
>
> > +                     if (!func_reloc || !func_reloc->sym)
> > +                             continue;
>
> This should also be an error.
>
> > +
> > +                     reloc->sym = func_reloc->sym;
>
> I think we should also do 'reloc->addend = 0', because of the
> STT_SECTION case:
>
>   0000000000000025  0000259e0000000b R_X86_64_32S           0000000000000000 .text..L.cfi.jumptable.8047 + 8
>
> which then translates to
>
>   0000000000000009  0000063200000004 R_X86_64_PLT32         0000000000000000 x2apic_prepare_cpu - 4
>
> so the original addend of '8' is no longer valid.  Copying the '-4'
> wouldn't be right either, because that only applies to a PLT32 text
> reloc.  A '0' should be appropriate for the 32S data reloc.
>
> This addend might not actually be read by any code, so it may not
> currently be an actual bug, but better safe than sorry.

Thank you for taking a look, Josh!  I'll fix these in the next version.

Sami
