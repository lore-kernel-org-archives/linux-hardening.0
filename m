Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D36C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2926961054
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbhI3Smc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbhI3Sm2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:42:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22EC06176C
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:40:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e15so29252915lfr.10
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/WNsW9cvRSrycN8v1M50/aQKwA+TESWFq+m9DKzD9M=;
        b=YCay/cSODiK5x8RlHaeoFtpseelnfGpcENOwmWzNaCPnJyDgpB4+jcUysEUz7IvASP
         FuaHOWfOiAEKNf9rGVT2vab9aZWcLmkNthheEST7W3xo4kKLyoqf/BN+3DcpTNR+cJMn
         4Yog7aaOjKGEVkPtapVaPpVt67j/nVzfTmYcBJ/DQzsAUmly88nGzNgejdnxlkt3bbKE
         t++y55Yjx64Yimv2sPnKSnGxPO20ndFxF/dlFKudw8Dx3I3DEeu8eb3SoUHgqzoGI+ds
         D/rztX4LGy+uG6yoGm3U/DBDahXIuADG/G3hqZe9J/EGldeCK/h6pFUnRAnf9/4ySrSz
         C5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/WNsW9cvRSrycN8v1M50/aQKwA+TESWFq+m9DKzD9M=;
        b=msxrnTgBjG2mRwCEGPS3WWm3MEOff1v6Y5k3CPnhueU3KtbIU9azW9pxpI1RPiRrck
         YIqlRNnNeSyk6Jy+RceAG2NoaPs/DJmYr+hkX1PR3fBOP4llnCP28MZA+SiXhG8Ksezy
         NHRL47DNwu4mp/YdTCqfGD3V8pMiyHMWAdfUaTWJzvL47m4E4BmTe0MUBNjDvp2fQfMg
         gHbrwAvtwwBQ0119ThspTahBDWRZnbLzaTho3mWZq9z5p5sktrcMRcSRQFYJtsNrvp34
         MtfYT8q6IvBOcLPYx0dCE8W0G8Sdxw+SWMOHc0piS6ZEmbzeY8UlUJfqpKj/6mJjwwr5
         1ncA==
X-Gm-Message-State: AOAM530LxzQ8SE7GqQ2pPFDvgnA2dC+3zV+gPNotYCm3OyZx5K+eHWts
        MhSHWEVXyw6iJpm841o3qKKFEKHLrpiLrYbykQC9RA==
X-Google-Smtp-Source: ABdhPJwAFsZ9+bvYX7bxP3/EuiWzFoIzYzHFJ8OV2XFbVFB2yoOXggzzwCRYpf6DSPiytfR/wX5JBTUZXkQ9urYlDP8=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr759454lfu.444.1633027243526;
 Thu, 30 Sep 2021 11:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com> <20210930180531.1190642-2-samitolvanen@google.com>
In-Reply-To: <20210930180531.1190642-2-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Sep 2021 11:40:32 -0700
Message-ID: <CAKwvOdm1QZxZYzyc0RR0ry530Hqezca-_Xv0t1e0oa7rN21rjg@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] objtool: Add CONFIG_CFI_CLANG support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05 AM Sami Tolvanen <samitolvanen@google.com> wrote:
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
>  tools/objtool/arch/x86/decode.c      | 17 ++++++++++
>  tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
>  tools/objtool/include/objtool/arch.h |  3 ++
>  tools/objtool/include/objtool/elf.h  |  2 +-
>  4 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 3172983bf808..9b043220b0af 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -63,6 +63,23 @@ bool arch_callee_saved_reg(unsigned char reg)
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
> +       /* offset to the relocation in a jmp instruction */

Thanks for the added comment. ;)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
> index 589ff58426ab..93bde8aaf2e3 100644
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
>  const char *arch_ret_insn(int len);
>
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index c3857fadee7a..e8d838217c77 100644
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
> 2.33.0.800.g4c38ced690-goog
>


-- 
Thanks,
~Nick Desaulniers
