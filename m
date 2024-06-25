Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FA12EBEA;
	Tue, 25 Jun 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308296; cv=none; b=dMDTa/vESuTPeEweXllQ/2AKYYaNkv+J+V6I34GOSBhouMJj1dykZ2S8HAqooFrRVKWhsYquep8mWrjdKETrbdqfyP/wetfsZPlx0bGdDdx/6blMG0JcAVxU/ivCtJZFaqJrVaSYzSEhjBqz30+j/C9gZdFiOyRUwu6xFKl5vi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308296; c=relaxed/simple;
	bh=JHBg/Hqu7jDucGLJh8PXWrcGEzA3WPJnZuttQx/ap4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tioamJd+XYUbVpmYXej/4kkny+MY7xBNe8NrDbnqBtonPVpJJqcfe3idSmL/jnTO7HzzJQKoEvQ1yHEdxiTxq+n9DOSV4LbRAhl4vvmHVd2c7gX0xnWsWc7XOKg/61H03UOyKx/5WQmMFg0+7xv9Bd8VnmF6fwm/4jnOPdDgHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xj13taHy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xj13taHy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p81muDELRMtjx8hyqZALP7SKcIRl8MDp2vLMju2Ho8E=; b=Xj13taHya5HkEoqUPsGFqMXHJ6
	NzCzD6zqCeviLJEzSNTX732uamV96/kCoG4N49ZpaEM5ELZuyNjO5fcLmYiNSYvE+IoMQextvoGMA
	42eZUiN+rON8xClJiFvWQp8+2oWtriG1BUMVIfrU7TPlVKFlsazxR7yaMUWpVG/6Vip3k8/FbqIqR
	QIHj7ugnY9D2Uvpu/VN9B3o6SozZXayb0XRgc9yvCKqXpGgYcCJTlI+AR+xdS/3DooYMNppoWrisG
	x13f+gC2IkxLXLTskwLibafo3V0Z1CcB7NKUZ2kFSz1kvt2SoXNecNOOfXdkC8JORSHN7781hXnDA
	zmikDRBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM2c3-00000008Njg-3inE;
	Tue, 25 Jun 2024 09:37:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7378B300754; Tue, 25 Jun 2024 11:37:19 +0200 (CEST)
Date: Tue, 25 Jun 2024 11:37:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] x86/traps: Enable UBSAN traps on x86
Message-ID: <20240625093719.GW31592@noisy.programming.kicks-ass.net>
References: <20240625032509.4155839-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625032509.4155839-1-gatlin.newhouse@gmail.com>

On Tue, Jun 25, 2024 at 03:24:55AM +0000, Gatlin Newhouse wrote:
> Currently ARM architectures output which specific sanitizer caused
> the trap, via the encoded data in the trap instruction. Clang on
> x86 currently encodes the same data in ud1 instructions but the x86
> handle_bug() and is_valid_bugaddr() functions currently only look
> at ud2s.
> 
> Bring x86 to parity with arm64, similar to commit 25b84002afb9
> ("arm64: Support Clang UBSAN trap codes for better reporting").
> Enable the output of UBSAN type information on x86 architectures
> compiled with clang when CONFIG_UBSAN_TRAP=y.
> 
> Signed-off-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>
> ---
> Changes in v3:
>   - Address Thomas's remarks about: change log structure,
>     get_ud_type() instead of is_valid_bugaddr(), handle_bug()
>     changes, and handle_ubsan_failure().
> 
> Changes in v2:
>   - Name the new constants 'LEN_ASOP' and 'INSN_ASOP' instead of
>     'LEN_REX' and 'INSN_REX'
>   - Change handle_ubsan_failure() from enum bug_trap_type to void
>     function
> 
> v1: https://lore.kernel.org/linux-hardening/20240529022043.3661757-1-gatlin.newhouse@gmail.com/
> v2: https://lore.kernel.org/linux-hardening/20240601031019.3708758-1-gatlin.newhouse@gmail.com/
> ---
>  MAINTAINERS                  |  2 ++
>  arch/x86/include/asm/bug.h   | 11 ++++++++++
>  arch/x86/include/asm/ubsan.h | 23 +++++++++++++++++++++
>  arch/x86/kernel/Makefile     |  1 +
>  arch/x86/kernel/traps.c      | 40 +++++++++++++++++++++++++++++++-----
>  arch/x86/kernel/ubsan.c      | 21 +++++++++++++++++++
>  6 files changed, 93 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/include/asm/ubsan.h
>  create mode 100644 arch/x86/kernel/ubsan.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28e20975c26f..b8512887ffb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22635,6 +22635,8 @@ L:	kasan-dev@googlegroups.com
>  L:	linux-hardening@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> +F:	arch/x86/include/asm/ubsan.h
> +F:	arch/x86/kernel/ubsan.c
>  F:	Documentation/dev-tools/ubsan.rst
>  F:	include/linux/ubsan.h
>  F:	lib/Kconfig.ubsan
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index a3ec87d198ac..a363d13c263b 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -13,6 +13,17 @@
>  #define INSN_UD2	0x0b0f
>  #define LEN_UD2		2
>  
> +/*
> + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> + */
> +#define INSN_UD1	0xb90f
> +#define INSN_UD_MASK	0xFFFF
> +#define LEN_UD1		2
> +#define INSN_ASOP	0x67
> +#define INSN_ASOP_MASK	0x00FF
> +#define BUG_UD_NONE	0xFFFF
> +#define BUG_UD2		0xFFFE
> +

Please look at 790d1ce71de. Also your style above is inconsistent,
please use lower case consistently for the hex values.


>  #ifdef CONFIG_GENERIC_BUG
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/include/asm/ubsan.h b/arch/x86/include/asm/ubsan.h
> new file mode 100644
> index 000000000000..ac2080984e83
> --- /dev/null
> +++ b/arch/x86/include/asm/ubsan.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_UBSAN_H
> +#define _ASM_X86_UBSAN_H
> +
> +/*
> + * Clang Undefined Behavior Sanitizer trap mode support.
> + */
> +#include <linux/bug.h>
> +#include <linux/ubsan.h>
> +#include <asm/ptrace.h>
> +
> +/*
> + * UBSAN uses the EAX register to encode its type in the ModRM byte.
> + */
> +#define UBSAN_REG	0x40
> +
> +#ifdef CONFIG_UBSAN_TRAP
> +void handle_ubsan_failure(struct pt_regs *regs, u16 insn);
> +#else
> +static inline void handle_ubsan_failure(struct pt_regs *regs, u16 insn) { return; }
> +#endif /* CONFIG_UBSAN_TRAP */
> +
> +#endif /* _ASM_X86_UBSAN_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 74077694da7d..fe1d9db27500 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
>  
>  obj-$(CONFIG_CFI_CLANG)			+= cfi.o
> +obj-$(CONFIG_UBSAN_TRAP)		+= ubsan.o
>  
>  obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
>  
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4fa0b17e5043..aef21287e7ed 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -67,6 +67,7 @@
>  #include <asm/vdso.h>
>  #include <asm/tdx.h>
>  #include <asm/cfi.h>
> +#include <asm/ubsan.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -91,6 +92,29 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
>  	return *(unsigned short *)addr == INSN_UD2;
>  }
>  
> +/*
> + * Check for UD1, UD2, with or without Address Size Override Prefixes instructions.
> + */
> +__always_inline u16 get_ud_type(unsigned long addr)
> +{
> +	u16 insn;
> +
> +	if (addr < TASK_SIZE_MAX)
> +		return BUG_UD_NONE;
> +	insn = *(u16 *)addr;
> +	if ((insn & INSN_UD_MASK) == INSN_UD2)
> +		return BUG_UD2;
> +	if ((insn & INSN_ASOP_MASK) == INSN_ASOP)
> +		insn = *(u16 *)(++addr);
> +
> +	// UBSAN encode the failure type in the two bytes after UD1
> +	if ((insn & INSN_UD_MASK) == INSN_UD1)
> +		return *(u16 *)(addr + LEN_UD1);
> +
> +	return BUG_UD_NONE;
> +}

Given that insn is u16, this INSN_UD_MASK seems eminently pointless.

Are the bytes after UD1 a proper ModRM such that the whole forms a
decodable instruction? You seem to not mention this anywhere. It is
paramount that the instruction stream is still correctly decodable.

Also, wouldn't it be saner to write this something like:

__always_inline int decode_bug(unsigned long addr, u32 *imm)
{
	u8 v;

	if (addr < TASK_SIZE)
		return BUG_NONE;

	v = *(u8 *)(addr++);
	if (v == 0x67)
		v = *(u8 *)(addr++);
	if (v != 0x0f)
		return BUG_NONE;
	v = *(u8 *)(addr++);
	if (v == 0x0b)
		return BUG_UD2;
	if (v != 0xb9)
		return BUG_NONE;

	if (X86_MODRM_RM(v) == 4)
		addr++; /* consume SiB */

	*imm = 0;
	if (X86_MODRM_MOD(v) == 1)
		*imm = *(u8 *)addr;
	if (X86_MORRM_MOD(v) == 2)
		*imm = *(u32 *)addr;

	// WARN on MOD(v)==3 ??

	return BUG_UD1;
}

Why does the thing emit the asop prefix at all through? afaict it
doesn't affect the immediate you want to get at. And if it does this
prefix, should we worry about other prefixes? Ideally we'd not accept
any prefixes.


