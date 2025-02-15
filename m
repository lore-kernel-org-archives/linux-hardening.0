Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7019CC39;
	Sat, 15 Feb 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739653663; cv=none; b=eaf4CVuSEoJRQjcfkTgbUZVUO6kSE0U43FF0pkX91OOaZWjZr8TSfxKBt5ZPKqD/U7qyiwiF9I/hMQe+cDKiu3ZtOg5CT57hmCrNuz2cQBNGb8hn+lNvC5nuOKYgmmVaC9QpexhDCMpf6yUupW7DF4AeRsu6AX/8moHohJvbtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739653663; c=relaxed/simple;
	bh=LOZliY1kozj0QT/HInAJ96eTksor/3qm+BxU79R5D+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG6oRF0XJ0Fo0tmi4+1fRYxKck9Pwb9CtonGzt9tOdljR/qEw9F7f9CP1cT15Exr1sBdNGQfTlBIfe8xjjjZIlc2YlFTryaMM1SqY57lOWIQz5zqFneMYaUydeiA0WfRr4eCQP0g9QeihmSD13ObuDG9pZpkiboSsKMbTNagacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HNQmHpZw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HNQmHpZw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/znqJHgZG6HQzUOymeE/jUfPK8gyXheuh82ohZO2AM4=; b=HNQmHpZwxxs+M4UziQALJLAyRo
	G5XVE/Jl6BAeIExdKUh9DnR7Qe+xNxr/2/bHYRCftn6cbvWecwZdjTZN/Ynts9Y9DRRHOIjPIRjrp
	5HshtKCIykvfDhW6lJ1av1WWGBd9TqKTLuaDt84/YJU5cXjZBnV6QP3Jxob4PqdasBAyvGtpFUEam
	5K+VPeRdI3exP6ecvkBJn9PkFzg3SPscXQUMwxDnDSOUqVzNoM/11/P+qJryRJzOD8PazJey1rO6c
	6g8YW/iw/E92URdYZ+dpsRKW3up/0GUTpQ90YfMzUXmPGx195ZTpmLZWx/JYCBljFQa04LR0wvgLk
	bALElLpg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tjPNr-00000001WHO-0mq7;
	Sat, 15 Feb 2025 21:07:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F52A300318; Sat, 15 Feb 2025 22:07:29 +0100 (CET)
Date: Sat, 15 Feb 2025 22:07:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, jannh@google.com,
	jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	scott.d.constable@intel.com, x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250215210729.GA25168@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
 <20250214095751.GF21726@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214095751.GF21726@noisy.programming.kicks-ass.net>

On Fri, Feb 14, 2025 at 10:57:51AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:
> 
> > Right, the "if they can control a function pointer" is the part I'm
> > focusing on. This attack depends on making an indirect call with a
> > controlled pointer. Non-FineIBT CFI will protect against that step,
> > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > nor CFI+IBT.
> 
> Yes, the whole caller side validation should stop this.

And I think we can retro-fit that in FineIBT. Notably the current call
sites look like:

0000000000000060 <fineibt_caller>:
  60:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
  66:   49 83 eb 10             sub    $0x10,%r11
  6a:   0f 1f 40 00             nopl   0x0(%rax)
  6e:   41 ff d3                call   *%r11
  71:   0f 1f 00                nopl   (%rax)

Of which the last 6 bytes are the retpoline site (starting at 0x6e). It
is trivially possible to re-arrange things to have both nops next to one
another, giving us 7 bytes to muck about with.

And I think we can just about manage to do a caller side hash validation
in them bytes like:

0000000000000080 <fineibt_paranoid>:
  80:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
  86:   49 83 eb 10             sub    $0x10,%r11
  8a:   45 3b 53 07             cmp    0x7(%r11),%r10d
  8e:   74 01                   je     91 <fineibt_paranoid+0x11>
  90:   ea                      (bad)
  91:   41 ff d3                call   *%r11

And while this is somewhat daft, it would close the hole vs this entry
point swizzle afaict, no?

Patch against tip/x86/core (which includes the latest ibt bits as per
this morning).

Boots and builds the next kernel on my ADL.

---
 arch/x86/include/asm/bug.h    |   1 +
 arch/x86/include/asm/cfi.h    |   8 ++--
 arch/x86/kernel/alternative.c | 107 +++++++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/cfi.c         |   4 +-
 arch/x86/kernel/traps.c       |  13 ++++-
 5 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 1a5e4b372694..bc8a2ca3c82e 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -25,6 +25,7 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
+#define BUG_EA			0xffea
 
 #ifdef CONFIG_GENERIC_BUG
 
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 7dd5ab239c87..550f75450e43 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -104,7 +104,7 @@ extern enum cfi_mode cfi_mode;
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
-enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs);
 #define __bpfcall
 extern u32 cfi_bpf_hash;
 extern u32 cfi_bpf_subprog_hash;
@@ -127,10 +127,10 @@ static inline int cfi_get_offset(void)
 extern u32 cfi_get_func_hash(void *func);
 
 #ifdef CONFIG_FINEIBT
-extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
+extern bool decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u32 *type);
 #else
 static inline bool
-decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	return false;
 }
@@ -138,7 +138,7 @@ decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 #endif
 
 #else
-static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+static inline enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 247ee5ffbff4..9e327b5e9f75 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -741,6 +741,11 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 		op2 = insn.opcode.bytes[1];
 
 		switch (op1) {
+		case 0x70 ... 0x7f:	/* Jcc.d8 */
+			/* See cfi_paranoid. */
+			WARN_ON_ONCE(cfi_mode != CFI_FINEIBT);
+			continue;
+
 		case CALL_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 			break;
@@ -983,6 +988,8 @@ u32 cfi_get_func_hash(void *func)
 static bool cfi_rand __ro_after_init = true;
 static u32  cfi_seed __ro_after_init;
 
+static bool cfi_paranoid __ro_after_init = false;
+
 /*
  * Re-hash the CFI hash with a boot-time seed while making sure the result is
  * not a valid ENDBR instruction.
@@ -1022,6 +1029,8 @@ static __init int cfi_parse_cmdline(char *str)
 			cfi_mode = CFI_FINEIBT;
 		} else if (!strcmp(str, "norand")) {
 			cfi_rand = false;
+		} else if (!strcmp(str, "paranoid")) {
+			cfi_paranoid = true;
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -1097,6 +1106,29 @@ extern u8 fineibt_caller_end[];
 
 #define fineibt_caller_jmp (fineibt_caller_size - 2)
 
+asm(	".pushsection .rodata			\n"
+	"fineibt_paranoid_start:		\n"
+	"	movl	$0x12345678, %r10d	\n"
+	"	sub	$16, %r11		\n"
+	"	cmpl	7(%r11), %r10d		\n"
+	"	je	fineibt_paranoid_call	\n"
+	"fineibt_paranoid_trap:			\n"
+	"	.byte	0xea			\n"
+	"fineibt_paranoid_call:			\n"
+	"	call	*%r11			\n"
+	"fineibt_paranoid_end:			\n"
+	".popsection				\n"
+);
+
+extern u8 fineibt_paranoid_start[];
+extern u8 fineibt_paranoid_trap[];
+extern u8 fineibt_paranoid_call[];
+extern u8 fineibt_paranoid_end[];
+
+#define fineibt_paranoid_size (fineibt_paranoid_end - fineibt_paranoid_start)
+#define fineibt_paranoid_ud   (fineibt_paranoid_trap - fineibt_paranoid_start)
+#define fineibt_paranoid_ind  (fineibt_paranoid_call - fineibt_paranoid_start)
+
 static u32 decode_preamble_hash(void *addr)
 {
 	u8 *p = addr;
@@ -1260,18 +1292,48 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 {
 	s32 *s;
 
+	BUG_ON(fineibt_paranoid_size != 20);
+
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		struct insn insn;
+		u8 bytes[20];
 		u32 hash;
+		int ret;
+		u8 op;
 
 		addr -= fineibt_caller_size;
 		hash = decode_caller_hash(addr);
-		if (hash) {
+		if (!hash)
+			continue;
+
+		if (!cfi_paranoid) {
 			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
 			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
 			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+			/* rely on apply_retpolines() */
+			continue;
 		}
-		/* rely on apply_retpolines() */
+
+		/* cfi_paranoid */
+		ret = insn_decode_kernel(&insn, addr + fineibt_caller_size);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		op = insn.opcode.bytes[0];
+		if (op != CALL_INSN_OPCODE && op != JMP32_INSN_OPCODE) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		memcpy(bytes, fineibt_paranoid_start, fineibt_paranoid_size);
+		memcpy(bytes + fineibt_caller_hash, &hash, 4);
+
+		ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind);
+		if (WARN_ON_ONCE(ret != 3))
+			continue;
+
+		text_poke_early(addr, bytes, fineibt_paranoid_size);
 	}
 
 	return 0;
@@ -1288,8 +1350,11 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
 	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
-		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT)) {
+			if (!cpu_feature_enabled(X86_FEATURE_FRED))
+				cfi_paranoid = true;
 			cfi_mode = CFI_FINEIBT;
+		}
 	}
 
 	/*
@@ -1346,8 +1411,10 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		/* now that nobody targets func()+0, remove ENDBR there */
 		cfi_rewrite_endbr(start_cfi, end_cfi);
 
-		if (builtin)
-			pr_info("Using FineIBT CFI\n");
+		if (builtin) {
+			pr_info("Using FineIBT %s CFI\n",
+				cfi_paranoid ? "paranoid" : "");
+		}
 		return;
 
 	default:
@@ -1420,7 +1487,8 @@ static void poison_cfi(void *addr)
  * We check the preamble by checking for the ENDBR instruction relative to the
  * UD2 instruction.
  */
-bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+static bool decode_fineibt_preamble(int ud_type, struct pt_regs *regs,
+				    unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud2;
 	u32 endbr, hash;
@@ -1440,6 +1508,33 @@ bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 	return false;
 }
 
+/*
+ * regs->ip points to a 0xea instruction from the fineibt_paranoid_start[]
+ * sequence.
+ */
+static bool decode_fineibt_paranoid(int ud_type, struct pt_regs *regs,
+				    unsigned long *target, u32 *type)
+{
+	unsigned long addr = regs->ip - fineibt_paranoid_ud;
+	u32 hash;
+
+	__get_kernel_nofault(&hash, addr + fineibt_caller_hash, u32, Efault);
+	*target = regs->r11 + 16;
+	*type = regs->r10;
+	return true;
+
+Efault:
+	return false;
+}
+
+bool decode_fineibt_insn(int ud_type, struct pt_regs *regs,
+			 unsigned long *target, u32 *type)
+{
+	if (ud_type == BUG_EA)
+		return decode_fineibt_paranoid(ud_type, regs, target, type);
+	return decode_fineibt_preamble(ud_type, regs, target, type);
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index f6905bef0af8..f9eb7465eec6 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -65,7 +65,7 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
  * Checks if a ud2 trap is because of a CFI failure, and handles the trap
  * if needed. Returns a bug_trap_type value similarly to report_bug.
  */
-enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
 {
 	unsigned long target;
 	u32 type;
@@ -81,7 +81,7 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 		break;
 
 	case CFI_FINEIBT:
-		if (!decode_fineibt_insn(regs, &target, &type))
+		if (!decode_fineibt_insn(ud_type, regs, &target, &type))
 			return BUG_TRAP_TYPE_NONE;
 
 		break;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 05b86c05e446..500030ab8036 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -113,6 +113,10 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 	v = *(u8 *)(addr++);
 	if (v == INSN_ASOP)
 		v = *(u8 *)(addr++);
+	if (v == 0xea) {
+		*len = addr - start;
+		return BUG_EA;
+	}
 	if (v != OPCODE_ESCAPE)
 		return BUG_NONE;
 
@@ -308,9 +312,16 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		raw_local_irq_enable();
 
 	switch (ud_type) {
+	case BUG_EA:
+		if (handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += ud_len;
+			handled = true;
+		}
+		break;
+
 	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+		    handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
 			regs->ip += ud_len;
 			handled = true;
 		}
