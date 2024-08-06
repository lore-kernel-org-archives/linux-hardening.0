Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570FB663;
	Tue,  6 Aug 2024 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919146; cv=none; b=Ooijd75MmT9fbqqIAJvdmVbivtJ4kLXwaIx0+fC6OR9OYr1H3k0ZfDIPwIMu6+9qsUMXrNZZ4Xe2OL7kpaal/+0Fewg+Uj7VNEvlPtdTRBgTDlY+KmGVVi65LorZQh3NWv4er4pRtv9oNuPpTRQ+P/Vnp7L68qSLoVZQaxQ1cSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919146; c=relaxed/simple;
	bh=8joSK8cgWfzrcf51gsSdZJOHP9od2ZFiV7GhD9Azg7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnV8zXXLzK+ddWOT7cHiobZ0M7AZQGPxXffFuGqWndHI6m/p01H4tRzUkZSMdNIc6f1pKVboNmFzCRmD1M5eGRi+vb7EneNdOpuTAQb6po6SmPyyGByIyw0WRanld3YzAnkFiqeKEQYvNyzRc6/AL3cvPEw+0lP4N9gCRrIXe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5kGYjEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5kGYjEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3AFC32786;
	Tue,  6 Aug 2024 04:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722919146;
	bh=8joSK8cgWfzrcf51gsSdZJOHP9od2ZFiV7GhD9Azg7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5kGYjEmjWQ9+33WhwZ5aZeLeVzTGrlnpEIcqsPnRx+AJxgkBoh4GsMMp7kNUkgvu
	 1QMGdHCtVmoBH3W6KGXlvqhAMBdPmJq/3XD+zAiE3njHKkvVuw3Y86EazNvHIQ1qtG
	 rRr1zcRpSX7/dRRv+u1s3O2XgaIWeBgnM6Cv8F5TbsCC6K9F8HVTP1espSBF8pLuzj
	 CzxNy1NeT7e+4fCLDJvkdu6o8zFBHRddV5t8hT7DGFcd3o8g5dQiE3afopmyIrl0ch
	 CLs4OS+s0bma+I8oOxY8/VTJQ+30ib9CloeojG16rClEMx99mKVoAqTwN52l5NTghr
	 RwUj/L3AmCgtg==
Date: Mon, 5 Aug 2024 21:39:05 -0700
From: Kees Cook <kees@kernel.org>
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Pengfei Xu <pengfei.xu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Xin Li <xin3.li@intel.com>, Uros Bizjak <ubizjak@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5] x86/traps: Enable UBSAN traps on x86
Message-ID: <202408052138.EB7B9788E3@keescook>
References: <20240724000206.451425-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724000206.451425-1-gatlin.newhouse@gmail.com>

On Wed, Jul 24, 2024 at 12:01:55AM +0000, Gatlin Newhouse wrote:
> Currently ARM architectures extract which specific sanitizer
> has caused a trap via encoded data in the trap instruction.[1]
> Clang on x86 currently encodes the same data in ud1 instructions
> but the x86 handle_bug() and is_valid_bugaddr() functions
> currently only look at ud2s.
> 
> Bring x86 to parity with arm64, similar to commit 25b84002afb9
> ("arm64: Support Clang UBSAN trap codes for better reporting").
> Enable the reporting of UBSAN sanitizer detail on x86 architectures
> compiled with clang when CONFIG_UBSAN_TRAP=y.
> 
> [1] Details are in llvm/lib/Target/X86/X86MCInstLower.cpp. See:
> https://github.com/llvm/llvm-project/commit/c5978f42ec8e9#diff-bb68d7cd885f41cfc35843998b0f9f534adb60b415f647109e597ce448e92d9f
> 
> EmitAndCountInstruction() uses the UD1Lm template, which uses a
> OpSize32. See:
> https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86InstrSystem.td#L27
> 
> Signed-off-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>
> ---
> Changes in v5:
>   - Added references to the LLVM commits in the commit message from
>     Kees and Marco's feedback
>   - Renamed incorrect defines, and removed handle_ubsan_failure()'s
>     duplicated work per Peter's feedback

Ping to the x86 maintainers... can someone pick this up? It looks like
all the feedback has been addressed.

Thanks!

-Kees

> 
> Changes in v4:
>   - Implement Peter's suggestions for decode_bug(), and fix
>     inconsistent capitalization in hex values.
> 
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
> v3: https://lore.kernel.org/linux-hardening/20240625032509.4155839-1-gatlin.newhouse@gmail.com/
> v4: https://lore.kernel.org/linux-hardening/20240710203250.238782-1-gatlin.newhouse@gmail.com/
> ---
>  MAINTAINERS                  |  2 ++
>  arch/x86/include/asm/bug.h   | 12 ++++++++
>  arch/x86/include/asm/ubsan.h | 18 ++++++++++++
>  arch/x86/kernel/Makefile     |  1 +
>  arch/x86/kernel/traps.c      | 57 ++++++++++++++++++++++++++++++++----
>  arch/x86/kernel/ubsan.c      | 19 ++++++++++++
>  6 files changed, 104 insertions(+), 5 deletions(-)
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
> index a3ec87d198ac..751e45ea27ca 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -13,6 +13,18 @@
>  #define INSN_UD2	0x0b0f
>  #define LEN_UD2		2
>  
> +/*
> + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> + */
> +#define INSN_ASOP	0x67
> +#define OPCODE_ESCAPE	0x0f
> +#define SECOND_BYTE_OPCODE_UD1	0xb9
> +#define SECOND_BYTE_OPCODE_UD2	0x0b
> +
> +#define BUG_NONE	0xffff
> +#define BUG_UD1		0xfffe
> +#define BUG_UD2		0xfffd
> +
>  #ifdef CONFIG_GENERIC_BUG
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/include/asm/ubsan.h b/arch/x86/include/asm/ubsan.h
> new file mode 100644
> index 000000000000..1d7c2b4129de
> --- /dev/null
> +++ b/arch/x86/include/asm/ubsan.h
> @@ -0,0 +1,18 @@
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
> +#ifdef CONFIG_UBSAN_TRAP
> +void handle_ubsan_failure(struct pt_regs *regs, u32 type);
> +#else
> +static inline void handle_ubsan_failure(struct pt_regs *regs, u32 type) { return; }
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
> index 4fa0b17e5043..6350d00a6555 100644
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
> @@ -91,6 +92,45 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
>  	return *(unsigned short *)addr == INSN_UD2;
>  }
>  
> +/*
> + * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
> + * If it's a UD1, get the ModRM byte to pass along to UBSan.
> + */
> +__always_inline int decode_bug(unsigned long addr, u32 *imm)
> +{
> +	u8 v;
> +
> +	if (addr < TASK_SIZE_MAX)
> +		return BUG_NONE;
> +
> +	v = *(u8 *)(addr++);
> +	if (v == INSN_ASOP)
> +		v = *(u8 *)(addr++);
> +	if (v != OPCODE_ESCAPE)
> +		return BUG_NONE;
> +
> +	v = *(u8 *)(addr++);
> +	if (v == SECOND_BYTE_OPCODE_UD2)
> +		return BUG_UD2;
> +	if (v != SECOND_BYTE_OPCODE_UD1)
> +		return BUG_NONE;
> +
> +	v = *(u8 *)(addr++);
> +	if (X86_MODRM_RM(v) == 4)
> +		addr++;
> +
> +	*imm = 0;
> +	if (X86_MODRM_MOD(v) == 1)
> +		*imm = *(u8 *)addr;
> +	else if (X86_MODRM_MOD(v) == 2)
> +		*imm = *(u32 *)addr;
> +	else
> +		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
> +
> +	return BUG_UD1;
> +}
> +
> +
>  static nokprobe_inline int
>  do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
>  		  struct pt_regs *regs,	long error_code)
> @@ -216,6 +256,8 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>  static noinstr bool handle_bug(struct pt_regs *regs)
>  {
>  	bool handled = false;
> +	int ud_type;
> +	u32 imm;
>  
>  	/*
>  	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
> @@ -223,7 +265,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  	 * irqentry_enter().
>  	 */
>  	kmsan_unpoison_entry_regs(regs);
> -	if (!is_valid_bugaddr(regs->ip))
> +	ud_type = decode_bug(regs->ip, &imm);
> +	if (ud_type == BUG_NONE)
>  		return handled;
>  
>  	/*
> @@ -236,10 +279,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  	 */
>  	if (regs->flags & X86_EFLAGS_IF)
>  		raw_local_irq_enable();
> -	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> -	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> -		regs->ip += LEN_UD2;
> -		handled = true;
> +	if (ud_type == BUG_UD2) {
> +		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> +		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
> +			regs->ip += LEN_UD2;
> +			handled = true;
> +		}
> +	} else {
> +		handle_ubsan_failure(regs, imm);
>  	}
>  	if (regs->flags & X86_EFLAGS_IF)
>  		raw_local_irq_disable();
> diff --git a/arch/x86/kernel/ubsan.c b/arch/x86/kernel/ubsan.c
> new file mode 100644
> index 000000000000..63f819928820
> --- /dev/null
> +++ b/arch/x86/kernel/ubsan.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clang Undefined Behavior Sanitizer trap mode support.
> + */
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +#include <linux/printk.h>
> +#include <linux/ubsan.h>
> +#include <asm/ptrace.h>
> +#include <asm/ubsan.h>
> +
> +/*
> + * Checks for the information embedded in the UD1 trap instruction
> + * for the UB Sanitizer in order to pass along debugging output.
> + */
> +void handle_ubsan_failure(struct pt_regs *regs, u32 type)
> +{
> +	pr_crit("%s at %pS\n", report_ubsan_failure(regs, type), (void *)regs->ip);
> +}
> -- 
> 2.25.1
> 

-- 
Kees Cook
