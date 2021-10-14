Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9751DC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750C36109E
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 10:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNK0L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 06:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNK0K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 06:26:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50016C061570;
        Thu, 14 Oct 2021 03:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fx9cLhN7mOpr+grnv3F8YGfL7yLYIEU/n5hQtUEVSyY=; b=HBIQ7Jv1D7PPTEog37ZzHEDdD4
        fXw09We7EjdRG/JsM2auCONGNaJeVYxByvJTR0BBLKpQ50E0jtBIQ7oQQffEBpR9ZVVLPtqljJ8mV
        UeQqOkDFaU5AKBy/93IfRosKVg5rftVMdtvUtKocfd4a/yCtssToumA9HK42YLAG2zchyc6OzD29W
        TZD+lj0UpmmwgtcRMFDUk79nkNmdTdewozr/yxZmM+S2kwLrMfhug+3aK2WS962VeMVFclKDzGE4i
        mYIfeZ70gxEXEZ3S6iJZ5hy6+VvSJWqPRql0cEAiAN5VwrIhTaLUtfVC7Z8WdlVFsV1XiYhU8mWFt
        YnObZJxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maxsY-008FhE-QL; Thu, 14 Oct 2021 10:22:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59FB93001C0;
        Thu, 14 Oct 2021 12:22:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45B2C2008CB91; Thu, 14 Oct 2021 12:22:26 +0200 (CEST)
Date:   Thu, 14 Oct 2021 12:22:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 01/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <YWgE4iTPGr/ruu8e@hirez.programming.kicks-ass.net>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-2-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:44AM -0700, Sami Tolvanen wrote:
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 1f2ae708b223..5fe31523e51f 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -63,6 +63,23 @@ bool arch_callee_saved_reg(unsigned char reg)
>  	}
>  }
>  
> +unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
> +{
> +	if (!reloc->addend)
> +		return 0;
> +
> +	if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> +		return reloc->addend + 4;
> +
> +	return reloc->addend;
> +}
> +
> +unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
> +{
> +	/* offset to the relocation in a jmp instruction */
> +	return offset + 1;
> +}
> +
>  unsigned long arch_dest_reloc_offset(int addend)
>  {
>  	return addend + 4;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index b18f0055b50b..cd09c93c34fb 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c

> @@ -575,6 +580,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
>  	return 0;
>  }
>  
> +/*
> + * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
> + * jump table. Undo the conversion so objtool can make sense of things.
> + */
> +static int fix_cfi_relocs(const struct elf *elf)
> +{
> +	struct section *sec;
> +	struct reloc *reloc;
> +
> +	list_for_each_entry(sec, &elf->sections, list) {
> +		list_for_each_entry(reloc, &sec->reloc_list, list) {
> +			struct reloc *cfi_reloc;
> +			unsigned long offset;
> +
> +			if (!reloc->sym->sec->cfi_jt)
> +				continue;
> +
> +			if (reloc->sym->type == STT_SECTION)
> +				offset = arch_cfi_section_reloc_offset(reloc);
> +			else
> +				offset = reloc->sym->offset;
> +
> +			/*
> +			 * The jump table immediately jumps to the actual function,
> +			 * so look up the relocation there.
> +			 */
> +			offset = arch_cfi_jump_reloc_offset(offset);
> +			cfi_reloc = find_reloc_by_dest(elf, reloc->sym->sec, offset);
> +
> +			if (!cfi_reloc || !cfi_reloc->sym) {
> +				WARN("can't find a CFI jump table relocation at %s+0x%lx",
> +					reloc->sym->sec->name, offset);
> +				return -1;
> +			}
> +
> +			reloc->sym = cfi_reloc->sym;
> +			reloc->addend = 0;
> +		}
> +	}
> +
> +	return 0;
> +}

If that section ever gets modified and we end up running
elf_rebuild_reloc_section() on it, we're in trouble, right?

Do we want a fatal error in elf_rebuild_reloc_section() when ->cfi_jt is
set?
