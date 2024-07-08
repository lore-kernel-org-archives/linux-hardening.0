Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E52146A98;
	Mon,  8 Jul 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470127; cv=none; b=rsc9oMg590cqm6G7IVKbO2aRui3p+YS+qBFtvAh9hvczjJGGosjLJXOGBwAsuUej3F8xxFxS6FnyCuDuVw1k1SxI5bizSJ0B+xKtWkTkkC20RZDHSyg84Gl8R+42joSzLYcYr2ofM+gka0ADORC4or4PMg53fWJJ2Yucj/Mqflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470127; c=relaxed/simple;
	bh=R+KCjxeALUlTLABjk0xgsQ68pJ97ScmMIL7WBVxnLgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bzv8aiKAIZkrAAnN08DldeHp5lr0a7BJp7PXNeEFHMvkSxHyNr5rKVsQPDCB0x2eUNganSLqLL4FBVQop3rDDfo6pHDSNw3dml+QyF91c2Nj3RvytTJ6IJ6DmJep04T6atOd2hz2GxPj+SSrRRRDqlMbcyH2b24m3J6w2MhUKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGl51C77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGl51C77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900DEC116B1;
	Mon,  8 Jul 2024 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470127;
	bh=R+KCjxeALUlTLABjk0xgsQ68pJ97ScmMIL7WBVxnLgk=;
	h=From:To:Cc:Subject:Date:From;
	b=YGl51C775NG7mxOfJcr9Lwkxxq26mgmL+wU0WoDcbOoqCY/TekeVr4FBZ9MJyeHFt
	 1CYElD5rYI9oWeqpVkQwe1IIiuNdkV6YymYIwc2Qak8Sg8naBmUoCFK3825SnZk+TI
	 KEfCL7tARav1xZFUL9j0L0O81gHrjyD1cyZxrrPmXFyZk3MtY6lFC3fIHba1IBakOu
	 micnrwZlTRiJ9JM3A6n7g8ZKdOSESXJpkOEqgWrue9f5wtT+x8aH4J8RbRgHXICycr
	 cXe8x+pOqqUjhL1rMMo3nIfs/KUsvAyQQ1kbVI5nx1JVhuO76jrVrpIY8lmFovCuQ7
	 31hS5JLWiWkdQ==
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <kees@kernel.org>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Brian Gerst <brgerst@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peter Collingbourne <pcc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
Date: Mon,  8 Jul 2024 13:22:06 -0700
Message-Id: <20240708202202.work.477-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2703; i=kees@kernel.org; h=from:subject:message-id; bh=R+KCjxeALUlTLABjk0xgsQ68pJ97ScmMIL7WBVxnLgk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjEptrVQyLhuRtz3Bw+kovOBW9KKzepjilyX72 klnrpFCAKaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoxKbQAKCRCJcvTf3G3A Jjo1EACOvYDVteegjw03HK9rSnkjN7JhnSDcy/JA3wtBwHuOJdPndOBm2aTWNKZbdBeL/xI9oke 45CKf3vtHRrFwOyIbLoSPP0cC95Bwc0b4m1fBnvUNzVkp8uLlmIfXM3YQyUnV79UaaANmN1zIij 2UvElugYloK147m6gPpePlZGIYJxvWi28Pn5g+TdfGT6icAbLIIe8/IIju7giG8j0uDugKXw83n 2FOwOXNmQKvTOfTfvVPBvFcqjrrsHtXJEYD0jy6gQY6j7m0/qD2/A1mwfP+V60okKPa/s3YnOiJ nlzGuAj7+rffzgjHkA7yZcFra5h0a4dR7qWVg2ryq1YN1FeP7+cjVCCgOM1wnoPRLOMSa2mAt7/ 69H91BVQhw5qUzKEchda+vLCpzX9uL89wTJLQ2ULytjlCawh3vGoK4xhLDP+AXiQcq8ockBEj51 pmSmZy7oGcukasQbsJgvY1lQzfDn80sv/ZgUBzvc8MYGJAsCIdEPnV1Adld3NFD9L5JjLk1Kpoy w0RPIXl+LGv+85DfBWtq6l7EcZa2PAvxNL7EJdzw9VwxzWbA+FOVNKX/FrTBlwJWlh0Cpb4icCL zbRYgi38SdiZmJ0LOzsc24jKud6zFzTn82EllSYWUtulf3aszvki4tzAtxOoiAxiudcKWUiEFJr 9isaBVSBjN5jk
 NQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
the end of the addressed destination (or source) struct member:

In function ‘fortify_memcpy_chk’,
    inlined from ‘syscall_get_arguments’ at ./arch/x86/include/asm/syscall.h:85:2,
    inlined from ‘populate_seccomp_data’ at kernel/seccomp.c:258:2,
    inlined from ‘__seccomp_filter’ at kernel/seccomp.c:1231:3:
./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As already done for x86_64 and compat mode, do not use memcpy() to
extract syscall arguments from struct pt_regs but rather just perform
direct assignments. Binary output differences are negligible, and actually
ends up using less stack space:

-       sub    $0x84,%esp
+       sub    $0x6c,%esp

and less text size:

   text    data     bss     dec     hex filename
  10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
  10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after

Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Peter Collingbourne <pcc@google.com>
---
 arch/x86/include/asm/syscall.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2fc7bc3863ff..7c488ff0c764 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
 					 unsigned long *args)
 {
-	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
+	args[0] = regs->bx;
+	args[1] = regs->cx;
+	args[2] = regs->dx;
+	args[3] = regs->si;
+	args[4] = regs->di;
+	args[5] = regs->bp;
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
-- 
2.34.1

