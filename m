Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747A4418E6;
	Thu,  8 Jan 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864496; cv=none; b=eLejgUqJCLbwl2I3Im5UzQs+93pFBTBYQZFaRp3VWeIZlPppYC/cpF13tdorULqDYLra+dm0omTY5rFwV8VvPvVcBoi6a6AOrTc53rOP5wjnjoPMEHGXXzLe3xb7bWiUgx2neA5vDy3UIUZRell7D6fsuwYdDZ2nesg/hhWwY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864496; c=relaxed/simple;
	bh=VoPcV/Fiyn3WL8X1wfBJAyjHiOZ8nzZ47iKxROdXI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soRf8stiUwluLtOiukg5ODhzv9j799mGr1z3oYI8Q2RvfI0QBH3ij4+Yuc4S8t28/nynJ02EY942Iw/qAKkceGajICU9cqhv3f1bTFckawjmqEQbC+P6OCFsJLG1olhL59GdR/VDyjtRL25Vt72oX0uV6xNo4eQafWw+YWzfoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz++tBtO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz++tBtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F195C19422;
	Thu,  8 Jan 2026 09:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864495;
	bh=VoPcV/Fiyn3WL8X1wfBJAyjHiOZ8nzZ47iKxROdXI3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vz++tBtOmeBj3aaYiCpkIn8ir73ueCKDoFs3QC5xmVCVs1Pu4VXEcRhDerV+lp41L
	 +0+8j0NwwZXFxofmW36R5S4XV6W7B7KhsiajxAPL3f42YhNCRtzz+w3g0brFEY4a6V
	 pajQ10FBpXKj0LQMiRzghGRSjMV7opjFe7NkaVIGUoDs6UTtxLIWXgnQx+DlI9p1Vt
	 g2H8s9E2V7BiGypeLzwjETmMI+ZRzxEqXb5THbZoUwCIapUDkBK2wxd2sXFGPV2sm8
	 HlO7aK+v395O3u4LOTDc0mKzQQy9cGKM5d/tURru9zAYHmfLbYtjzwcSK+OhLb5aBp
	 GNf8QvU372UMA==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 07/19] tools/objtool: Treat indirect ftrace calls as direct calls
Date: Thu,  8 Jan 2026 09:25:34 +0000
Message-ID: <20260108092526.28586-28-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=ardb@kernel.org; h=from:subject; bh=VoPcV/Fiyn3WL8X1wfBJAyjHiOZ8nzZ47iKxROdXI3E=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QiBbQDiyv0b9LvfZ6fHTagPiSnVOV938HXus+CnPI h7jo8kdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKrBRkZ3k3VPRt63UD8oE1S 5eYL53MNWssYzWrUBDS37l87tXrjWoZ/RusC3N/xpe9vndk6gzUrI3pecKnPca5Y1qsn/SXU7T8 yAAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

In some cases, the compiler may rely on indirect calls using GOT slots
as memory operands to emit function calls. This leaves it up to the
linker to relax the call to a direct call if possible, i.e., if the
destination address is known at link time and in range, which may not be
the case when building shared libraries for user space.

On x86, this may happen when building in PIC mode with ftrace enabled,
and given that vmlinux is a fully linked binary, this relaxation is
always possible, and therefore mandatory per the x86_64 psABI.

This means that the indirect calls to __fentry__ that are observeable in
vmlinux.o will have been converted to direct calls in vmlinux, and can
be treated as such by objtool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/check.c | 32 ++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f7999317f4d..765f818af839 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1660,11 +1660,39 @@ static int add_call_destinations(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		struct symbol *func = insn_func(insn);
-		if (insn->type != INSN_CALL)
+		if (insn->type != INSN_CALL &&
+		    insn->type != INSN_CALL_DYNAMIC)
 			continue;
 
 		reloc = insn_reloc(file, insn);
-		if (!reloc) {
+		if (insn->type == INSN_CALL_DYNAMIC) {
+			if (!reloc)
+				continue;
+
+			/*
+			 * GCC 13 and older on x86 will always emit the call to
+			 * __fentry__ using a relaxable GOT-based symbol
+			 * reference when operating in PIC mode, i.e.,
+			 *
+			 *   call   *0x0(%rip)
+			 *             R_X86_64_GOTPCRELX  __fentry__-0x4
+			 *
+			 * where it is left up to the linker to relax this into
+			 *
+			 *   call   __fentry__
+			 *   nop
+			 *
+			 * if __fentry__ turns out to be DSO local, which is
+			 * always the case for vmlinux. Given that this
+			 * relaxation is mandatory per the x86_64 psABI, these
+			 * calls can simply be treated as direct calls.
+			 */
+			if (arch_ftrace_match(reloc->sym->name)) {
+				insn->type = INSN_CALL;
+				add_call_dest(file, insn, reloc->sym, false);
+			}
+
+		} else if (!reloc) {
 			dest_off = arch_jump_destination(insn);
 			dest = find_call_destination(insn->sec, dest_off);
 
-- 
2.47.3

