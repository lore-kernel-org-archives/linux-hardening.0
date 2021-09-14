Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE1C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BDF61108
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Sep 2021 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhINTbL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhINTbK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Sep 2021 15:31:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A2C061574
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:29:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c8so763789lfi.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 Sep 2021 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d29wXxwYw2ENSPs6TRPPGxX2mpwXTs89xVA0k6Truos=;
        b=gzzlYXXnDXnAPtA+FrKZ63b26A/QISqEkQn1GTIsTdZuF3rY+FjMPv6G/CBaQdQfcV
         GECZTVFSX030xXczfKSob7lV6bH7tZ8pP5+SqWZvJlvypQpGjXNfL+u8gB/ghN4U4bSD
         pLWZbH+eV/Q0e6FipKBbnvh3C8WRxNm2xDe7hR//2Pj+CqjXAkBbT54EGf8ZqVacJxTP
         X/7Xg1aFAklQw/4golyXVgSVjx6eHp81U/4X+alZ0r6HV3tWIzt5vEPKdLJgjjURWf12
         IO8ggV+0yBFkKGjSU3CUPE87dpkddg9klVdygkGCva/ewWij63YvddUKOoaOUNzybrm2
         +sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d29wXxwYw2ENSPs6TRPPGxX2mpwXTs89xVA0k6Truos=;
        b=WbU7NypFTVOHIbMKtIBIYpqD2bEJVXgQqRXx9jailYwQowM40gXqNMVO1LOMlvVfJf
         OglEvTEa5AowvegZQJAUWbfqIM4jrlbmfUaJcgjqyZa7ZnbsWJp5jQIFNnV3uFIVXI4V
         r34b652eIbiuhOGVyE6GD9LfRxAzdTjxCUQeVqOw6mhqniJ5VMoQVbnSo5iG44fiwy22
         hS7COuDB+DP44TELtToxAXIaOs6e0X2LGxvfaZQYfnjx1J98CzWD4oHg0qBPr7HW5RH+
         kBQFZdpITYSkdby0ESROcpaZidDind4CK9ECPvxhDpb3OWs5N853PtlKOc0JagBAs1W8
         +pTA==
X-Gm-Message-State: AOAM532aoV2csbNMjAE7gkcMF/ZYM6IydSCw5zoPrrH25YmOBGFh4pjo
        muFzGQ1xMDSvQFmVEcTFVnAM6/T38GITvdI1foX9Rg==
X-Google-Smtp-Source: ABdhPJxsP1zDxcsnFy/3ynjlb5FnrOMwXGzJuXEWOybMu4FPprFz8WzCh6GMJPNS3NJbUFlNplxl0nksRyN7cLL5YJM=
X-Received: by 2002:a05:6512:3b9e:: with SMTP id g30mr14030392lfv.651.1631647790861;
 Tue, 14 Sep 2021 12:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com> <20210914191045.2234020-2-samitolvanen@google.com>
In-Reply-To: <20210914191045.2234020-2-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:29:38 -0700
Message-ID: <CAKwvOd=pmcfJRkgBFnqePauMd67+eQ9=JAbSjxrWmBQY9zRveQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] objtool: Add CONFIG_CFI_CLANG support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_CFI_CLANG, the compiler replaces function references with
> references to the CFI jump table, which confuses objtool. This change,
> based on Josh's initial patch [1], goes through the list of relocations
> and replaces jump table symbols with the actual function symbols.
>
> [1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  tools/objtool/arch/x86/decode.c      | 16 +++++++++
>  tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
>  tools/objtool/include/objtool/arch.h |  3 ++
>  tools/objtool/include/objtool/elf.h  |  2 +-
>  4 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index bc821056aba9..318189c8065e 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -62,6 +62,22 @@ bool arch_callee_saved_reg(unsigned char reg)
>         }
>  }
>
> +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
> +{
> +       if (!reloc->addend)
> +               return 0;
> +
> +       if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> +               return reloc->addend + 4;
> +
> +       return reloc->addend;
> +}
> +
> +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
> +{
> +       return offset + 1;
> +}
> +
>  unsigned long arch_dest_reloc_offset(int addend)
>  {
>         return addend + 4;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 8676c7598728..05a5f51aad2c 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -18,6 +18,7 @@
>  #include <errno.h>
>  #include <objtool/builtin.h>
>
> +#include <objtool/arch.h>
>  #include <objtool/elf.h>
>  #include <objtool/warn.h>
>
> @@ -291,6 +292,10 @@ static int read_sections(struct elf *elf)
>                 if (sec->sh.sh_flags & SHF_EXECINSTR)
>                         elf->text_size += sec->len;
>
> +               /* Detect -fsanitize=cfi jump table sections */
> +               if (!strncmp(sec->name, ".text..L.cfi.jumptable", 22))
> +                       sec->cfi_jt = true;
> +
>                 list_add_tail(&sec->list, &elf->sections);
>                 elf_hash_add(section, &sec->hash, sec->idx);
>                 elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
> @@ -576,6 +581,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
>         return 0;
>  }
>
> +/*
> + * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
> + * jump table. Undo the conversion so objtool can make sense of things.
> + */
> +static int fix_cfi_relocs(const struct elf *elf)
> +{
> +       struct section *sec;
> +       struct reloc *reloc;
> +
> +       list_for_each_entry(sec, &elf->sections, list) {
> +               list_for_each_entry(reloc, &sec->reloc_list, list) {
> +                       struct reloc *cfi_reloc;
> +                       unsigned long offset;
> +
> +                       if (!reloc->sym->sec->cfi_jt)
> +                               continue;
> +
> +                       if (reloc->sym->type == STT_SECTION)
> +                               offset = arch_cfi_section_reloc_offset(reloc);
> +                       else
> +                               offset = reloc->sym->offset;
> +
> +                       /*
> +                        * The jump table immediately jumps to the actual function,
> +                        * so look up the relocation there.
> +                        */
> +                       offset = arch_cfi_jump_reloc_offset(offset);

Sorry, this comment is curious to me, it looks like we jump to the
offset+1, not directly to the actual function?  Perhaps a comment
above arch_cfi_jump_reloc_offset() and/or amending this comment might
make it clearer? Sorry if this is obvious to others?  Perhaps comments
can be cleaned up in a follow up, if this is not a bug?

> +                       cfi_reloc = find_reloc_by_dest(elf, reloc->sym->sec, offset);
> +
> +                       if (!cfi_reloc || !cfi_reloc->sym) {
> +                               WARN("can't find a CFI jump table relocation at %s+0x%lx",
> +                                       reloc->sym->sec->name, offset);
> +                               return -1;
> +                       }
> +
> +                       reloc->sym = cfi_reloc->sym;
> +                       reloc->addend = 0;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int read_relocs(struct elf *elf)
>  {
>         struct section *sec;
> @@ -639,6 +687,9 @@ static int read_relocs(struct elf *elf)
>                 tot_reloc += nr_reloc;
>         }
>
> +       if (fix_cfi_relocs(elf))
> +               return -1;
> +
>         if (stats) {
>                 printf("max_reloc: %lu\n", max_reloc);
>                 printf("tot_reloc: %lu\n", tot_reloc);
> diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
> index 062bb6e9b865..2205b2b08268 100644
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -81,6 +81,9 @@ unsigned long arch_jump_destination(struct instruction *insn);
>
>  unsigned long arch_dest_reloc_offset(int addend);
>
> +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc);
> +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset);
> +
>  const char *arch_nop_insn(int len);
>
>  int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index e34395047530..d9c1dacc6572 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -39,7 +39,7 @@ struct section {
>         char *name;
>         int idx;
>         unsigned int len;
> -       bool changed, text, rodata, noinstr;
> +       bool changed, text, rodata, noinstr, cfi_jt;
>  };
>
>  struct symbol {
> --
> 2.33.0.309.g3052b89438-goog
>


-- 
Thanks,
~Nick Desaulniers
