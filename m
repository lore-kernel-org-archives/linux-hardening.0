Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0ACC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 23:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiD2XeV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 19:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiD2XeV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 19:34:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F43B0A40;
        Fri, 29 Apr 2022 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cc9wZ7jbygrqxfO1k5hdmSYC6xqhyAv60HjCEdg7k9Y=; b=cEcg8VvxAdZnBo7JOh5l638Yfp
        /n6FPztndQQn1Lo4ySoW9J7S5uwj0246oQaAaKc3ztTzVxOXuFQj6pXy8sQRNHh5t04vH6b7PRHVh
        bQqe9Roa7Yiei99IecXCLKMBF9ZUWwKSE5pbBmMIaQnr+nhjZyrqpMxB+GWmYsGl4ygyMynTDtRGT
        /Qt+UdxjYf8kd3+rnBxTLrz6uqjCeYQSjP2PBrTTM9ILULPbpgFOICuC0tTucF6mEc1/pP/6DpjRB
        LI2w26AEHg4ex9SR1ZkgiyRNsuSbP0xCbO+9xxAoUXjkUe0fav6AG7AxYBUjAO82gcYZlUBuu9DVX
        /b0QT7yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nka4T-009jCu-Rs; Fri, 29 Apr 2022 23:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C8B23001EA;
        Sat, 30 Apr 2022 01:30:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B9462028F01B; Sat, 30 Apr 2022 01:30:45 +0200 (CEST)
Date:   Sat, 30 Apr 2022 01:30:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 16/21] objtool: Add support for CONFIG_CFI_CLANG
Message-ID: <Ymx1JcO36h7YqLa0@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429203644.2868448-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:39PM -0700, Sami Tolvanen wrote:

> +static void *kcfi_alloc_hash(unsigned long size)
> +{
> +	kcfi_bits = max(10, ilog2(size));
> +	kcfi_hash = mmap(NULL, sizeof(struct hlist_head) << kcfi_bits,
> +			PROT_READ|PROT_WRITE,
> +			MAP_PRIVATE|MAP_ANON, -1, 0);
> +	if (kcfi_hash == (void *)-1L) {
> +		WARN("mmap fail kcfi_hash");
> +		kcfi_hash = NULL;
> +	}  else if (stats) {
> +		printf("kcfi_bits: %d\n", kcfi_bits);
> +	}
> +
> +	return kcfi_hash;
> +}
> +
> +static void add_kcfi_type(struct kcfi_type *type)
> +{
> +	hlist_add_head(&type->hash,
> +		&kcfi_hash[hash_min(
> +			sec_offset_hash(type->sec, type->offset),
> +			kcfi_bits)]);

:se cino=(0:0

Also, I'm thinking you can unwrap some lines at least.

> +}
> +
> +static bool is_kcfi_typeid(struct elf *elf, struct instruction *insn)
> +{
> +	struct hlist_head *head;
> +	struct kcfi_type *type;
> +	struct reloc *reloc;
> +
> +	if (!kcfi)
> +		return false;
> +
> +	/* Compiler-generated annotation in .kcfi_types. */
> +	head = &kcfi_hash[hash_min(sec_offset_hash(insn->sec, insn->offset), kcfi_bits)];
> +
> +	hlist_for_each_entry(type, head, hash)
> +		if (type->sec == insn->sec && type->offset == insn->offset)
> +			return true;

missing { }

> +
> +	/* Manual annotation (in assembly code). */
> +	reloc = find_reloc_by_dest(elf, insn->sec, insn->offset);
> +
> +	if (reloc && !strncmp(reloc->sym->name, "__kcfi_typeid_", 14))
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * This checks to see if the given function is a "noreturn" function.
>   *
> @@ -388,13 +487,18 @@ static int decode_instructions(struct objtool_file *file)
>  			insn->sec = sec;
>  			insn->offset = offset;
>  
> -			ret = arch_decode_instruction(file, sec, offset,
> -						      sec->sh.sh_size - offset,
> -						      &insn->len, &insn->type,
> -						      &insn->immediate,
> -						      &insn->stack_ops);
> -			if (ret)
> -				goto err;
> +			if (is_kcfi_typeid(file->elf, insn)) {
> +				insn->type = INSN_KCFI_TYPEID;
> +				insn->len = KCFI_TYPEID_LEN;

Urgh, what does this do for decode speed? This is a hash-lookup for
every single instruction.

Is that kcfi location array sorted by the compiler? Because then you can
keep a running iterator and replace the whole lookup with a simple
equality comparison.

> +			} else {
> +				ret = arch_decode_instruction(file, sec, offset,
> +							      sec->sh.sh_size - offset,
> +							      &insn->len, &insn->type,
> +							      &insn->immediate,
> +							      &insn->stack_ops);
> +				if (ret)
> +					goto err;
> +			}
>  
>  			/*
>  			 * By default, "ud2" is a dead end unless otherwise
