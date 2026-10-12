Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7E46EF6A;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795878; cv=none; b=Jh1qMBWfw47JLD+qTf06e+4nRc0EwEEKaPHl811N2boniFqQBCPHEocvuZPvi7FDLU3Prbp0hzYouakY6qnQpXnzUjNEiiRWRaP6JkJvX/vSrMCqE6jkeZdwO1w9W38sIXHdZd4WsMjvfrPtkIX6V2P+Qe4GSrffOdyFnEDBPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795878; c=relaxed/simple;
	bh=F+hU7zwvoM4jrDZHnAy/AVYIpxeYgHOwQ6w9X6A+J/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuFQ94aIk5ohtk4xN87TxyXFV5qNUaY8ZxXwPfTOukKOIVjjaTMlb13X0Q3hLY+X9o6XMYioBGAzSaaqLBZGiJozhIw6aMbNMRcS4dpgGkjKot+cs0V6Obxq9LG2UM1+E9C+tWE6ZEVsh0oTQhfPJDRzgzzVzOqWBIYdVhT8/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU553+qa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU553+qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17491F0089E;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795876;
	bh=qCxhAANfVhEXP/8xHY5Cud2Gow55mujn4jh7Fzm4A04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MU553+qaNz6AzM0rba9oPDtYAkVfgFIRPAleDgwX/MJuDW4F3MO5Ab1lel9UKN+rw
	 8wl2G7QX1trbND/URMezfF6ZQh0fNHdBP7EKcNIK0DpVft9LYaG38OkB1kU1o8sq7m
	 2WTbwTnCB63x69o0EnbCyUD5co5Yqgsu/Gt11p/2sMSf3IrWFjCQeBarvkjLonb1Fd
	 i4u9RiQ8BBPw/e0uUOY5yOqsxBSxTR+6f4y2BgxA6z1c7q1Duw3hgYE0ocqEnp603B
	 uHVJBd+tgxo6VcR/195SnRZAf9liKGrNAy/ge9eDKHpYpWU+KcXR6VZ3T79p0apd1h
	 EMZ7V9TV1li8Q==
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] objtool: Skip jump table jumps in the kCFI indirect call check
Date: Mon, 12 Oct 2026 02:04:26 -0700
Message-ID: <20261012090436.1676525-3-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012090424.i.497-kees@kernel.org>
References: <20261012090424.i.497-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=kees@kernel.org; h=from:subject; bh=F+hU7zwvoM4jrDZHnAy/AVYIpxeYgHOwQ6w9X6A+J/4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlnFs3irS5IOrOg6v9TTQuP5Rqrvq1Zvv+axBbOLyd4M /escGG27ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiIxxVGhrcL3flNC4N2T147 oYJ/ptxj1QrPgKMXHhrIzTVaELaojYeR4eRGPpY4x1RLh/iDHbUTWP0l/55VEvl0aXam2sGr1q2 VjAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With MITIGATION_RETPOLINE=y, GCC lowers the computed goto in
___bpf_prog_run() to a jump through __x86_indirect_thunk_rdx. objtool
puts that jump on the retpoline call list along with the indirect calls,
so with CONFIG_CFI=y the kCFI check wants a UD2 before it:

  vmlinux.o: warning: objtool: ___bpf_prog_run+0x1e: no-cfi indirect call!

The jump goes through the "jumptable" array, which objtool already reads
from .data.rel.ro.c_jump_table, so its targets stay inside the function
and need no kCFI check. Skip jump table jumps in the check. Clang does
not emit this jump: with retpolines, it lowers the computed goto without
an indirect jump.

Build tested ARCH=x86_64 defconfig with CONFIG_LKDTM=y and CONFIG_CFI=y,
with GCC 17.0.0 (experimental, with the kCFI series).

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 tools/objtool/check.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f6c9d9ff0..d35c5305075f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4199,6 +4199,14 @@ static int validate_retpoline(struct objtool_file *file)
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 		struct symbol *sym = insn_sym(insn);
 
+		/*
+		 * A jump through a jump table stays inside the function, so
+		 * it has no kCFI check.  GCC turns the computed goto in
+		 * ___bpf_prog_run() into one under MITIGATION_RETPOLINE.
+		 */
+		if (is_jump_table_jump(insn))
+			continue;
+
 		if (sym && (is_notype_sym(sym) ||
 			    is_func_sym(sym)) && !sym->nocfi) {
 			struct instruction *prev =
-- 
2.55.0

