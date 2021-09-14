Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643EC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD2660F25
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhINVDC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhINVDC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 17:03:02 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F0C061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 14:01:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a93so1046823ybi.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkGAPucbjFQWpGvMKr0Saxy8X0oEUxiqCfIGsaeFN1I=;
        b=oHHJnBD6/WoTONJOkoOV4dBBrnVFj2qPgF3Rv4NS1i80wIVxyB61SGa3JS+cgd6KyW
         +10igIK8UEhI+2wS5ApC5P/lQgkXDZxqVL/kUn34PI+qjLIz3Ke8IGEPybWut9WjDeKH
         gGehDcwXJMkcqfmbNXSoKNTSdTKeDP7I8g2mFkfClXCaV201kcs129pVLEV+gNYItCku
         /P0zVZDFj6WqivXV0MnGudCWGSqmDZoBBU2Lhm0U+aOnxAhZ6qxJNXEUv9gYu0TRNkN3
         VSd2faHMQzWvtp11/LfAkKpStW9zZANfOs1cq7+OIhqqlUUtWyJlLJUYfbyK0XuoFc3L
         pALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkGAPucbjFQWpGvMKr0Saxy8X0oEUxiqCfIGsaeFN1I=;
        b=1WObuYtx/7serC4ILFXLAmpi9EDgr6n4HDW75s/BMep6xIs0J61KIvOEuyTSpPeTUu
         Nl8qvdsg974TRGsqHynmoRmbkr/JPSJ1wP92tmnzf8oHXTOODv3vZLmc2HQTHPRoRh1Z
         5O+Nseo9Jvk6g4paw7iukTck9fdgMzF1WWGe7ml4FtWNs7ZuDl0eQqXYvnanzGwGWVlY
         tm8a2TAUuc/zzd1UN1pDE5w/0iWwrpSqSBji8aMwnC0R6E5Dz7XaP1Ki/OawUCQJTTKh
         E/q4f9xoKEChItbkmJnDEbRmSfQLbd5A9QoGAJBLbfC6nE+H9cw28LxT62S6d2Om0WUg
         My8g==
X-Gm-Message-State: AOAM5305L3FYi804RKxnckyMNHhlkvvK3GFJks+5/4hi1gwvDk87uDZV
        P2TI5Ncn+xe0l4PlQPP4eMsAw3ow2jV9Juq0IPaIyw==
X-Google-Smtp-Source: ABdhPJzs+ASOm9A0nYgvMtbH+kY5uG90SONRHnnzaWqNrSeDPpngHqJOtFgf4i7vhI2DnQX33SJrRzuB04tEPVQ0SdE=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr1500051ybb.267.1631653301347;
 Tue, 14 Sep 2021 14:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-2-samitolvanen@google.com> <CAKwvOd=pmcfJRkgBFnqePauMd67+eQ9=JAbSjxrWmBQY9zRveQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=pmcfJRkgBFnqePauMd67+eQ9=JAbSjxrWmBQY9zRveQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 14:01:30 -0700
Message-ID: <CABCJKufA537qjWumDSeF6y0Ei5Ej=SXY-7r=Qyu3+VtVUALSCA@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] objtool: Add CONFIG_CFI_CLANG support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:29 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 12:10 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > With CONFIG_CFI_CLANG, the compiler replaces function references with
> > references to the CFI jump table, which confuses objtool. This change,
> > based on Josh's initial patch [1], goes through the list of relocations
> > and replaces jump table symbols with the actual function symbols.
> >
> > [1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/
> >
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  tools/objtool/arch/x86/decode.c      | 16 +++++++++
> >  tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
> >  tools/objtool/include/objtool/arch.h |  3 ++
> >  tools/objtool/include/objtool/elf.h  |  2 +-
> >  4 files changed, 71 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> > index bc821056aba9..318189c8065e 100644
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -62,6 +62,22 @@ bool arch_callee_saved_reg(unsigned char reg)
> >         }
> >  }
> >
> > +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
> > +{
> > +       if (!reloc->addend)
> > +               return 0;
> > +
> > +       if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> > +               return reloc->addend + 4;
> > +
> > +       return reloc->addend;
> > +}
> > +
> > +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
> > +{
> > +       return offset + 1;
> > +}
> > +
> >  unsigned long arch_dest_reloc_offset(int addend)
> >  {
> >         return addend + 4;
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index 8676c7598728..05a5f51aad2c 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -18,6 +18,7 @@
> >  #include <errno.h>
> >  #include <objtool/builtin.h>
> >
> > +#include <objtool/arch.h>
> >  #include <objtool/elf.h>
> >  #include <objtool/warn.h>
> >
> > @@ -291,6 +292,10 @@ static int read_sections(struct elf *elf)
> >                 if (sec->sh.sh_flags & SHF_EXECINSTR)
> >                         elf->text_size += sec->len;
> >
> > +               /* Detect -fsanitize=cfi jump table sections */
> > +               if (!strncmp(sec->name, ".text..L.cfi.jumptable", 22))
> > +                       sec->cfi_jt = true;
> > +
> >                 list_add_tail(&sec->list, &elf->sections);
> >                 elf_hash_add(section, &sec->hash, sec->idx);
> >                 elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
> > @@ -576,6 +581,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
> >         return 0;
> >  }
> >
> > +/*
> > + * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
> > + * jump table. Undo the conversion so objtool can make sense of things.
> > + */
> > +static int fix_cfi_relocs(const struct elf *elf)
> > +{
> > +       struct section *sec;
> > +       struct reloc *reloc;
> > +
> > +       list_for_each_entry(sec, &elf->sections, list) {
> > +               list_for_each_entry(reloc, &sec->reloc_list, list) {
> > +                       struct reloc *cfi_reloc;
> > +                       unsigned long offset;
> > +
> > +                       if (!reloc->sym->sec->cfi_jt)
> > +                               continue;
> > +
> > +                       if (reloc->sym->type == STT_SECTION)
> > +                               offset = arch_cfi_section_reloc_offset(reloc);
> > +                       else
> > +                               offset = reloc->sym->offset;
> > +
> > +                       /*
> > +                        * The jump table immediately jumps to the actual function,
> > +                        * so look up the relocation there.
> > +                        */
> > +                       offset = arch_cfi_jump_reloc_offset(offset);
>
> Sorry, this comment is curious to me, it looks like we jump to the
> offset+1, not directly to the actual function?  Perhaps a comment
> above arch_cfi_jump_reloc_offset() and/or amending this comment might
> make it clearer? Sorry if this is obvious to others?  Perhaps comments
> can be cleaned up in a follow up, if this is not a bug?

It looks like my response was sent only to Nick, so to summarize the
brief off-list discussion:

arch_cfi_jump_reloc_offset() returns the offset to a relocation when
given the address of a jmp instruction in the CFI jump table. Here's
an example:

Disassembly of section .text..L.cfi.jumptable:

0000000000000000 <_printk.cfi_jt>:
       0: e9 00 00 00 00                jmp     0x5 <_printk.cfi_jt+0x5>
                0000000000000001:  R_X86_64_PLT32       _printk-0x4
       5: cc                            int3
       6: cc                            int3
       7: cc                            int3

We look at the relocation in the jump table to figure out the actual
target function, in this case, _printk. Alternatively, we could look
at the jump table symbol instead (i.e., _printk.cfi_jt) and use the
name to figure out the target. Unfortunately, LLVM doesn't generate
symbols for all the jump table entries, so we can't rely on them in
objtool.

What comes to the magic offset value, it's one because the first byte
of the jmp instruction is the opcode and the relocation only applies
to the rest of the instruction.

I'll add a comment to arch_cfi_jump_reloc_offset() in v4 to clarify this.

Sami
