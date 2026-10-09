Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F84432F5;
	Fri,  9 Oct 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527256; cv=none; b=M5686jprNV71uBgm5rmzvhVfr/PKxTz+W6W8kw26U+Jjwf9Y6FkW6m9x7ExK/FqxM1q0jxA3BQmaLH23LKWiP9lb5W4qRKUarsKiV2vkkFeRUg3hD+/9L+BVQdutlMZHJJ5FRApluHYqJ/RKGJ9rWsDuXkAScHg8F+TE8uD7PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527256; c=relaxed/simple;
	bh=Ou6T9IYNd58AY4rXiZP4j6dFf/TA3MEpH+4ENptCD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaiS2/CROvrnvIpHY9oKHE9bR69LelPqSi6+HPEWtlnU0WOzXzB4SVQTpeXwLalTRe4o6F9tZbHDqUm7tMZHkGj/sOm8GabQTZ2YbTaegcjop3+Za0V8oxTaW2UZExDV5k/saRYUXRwhq5uQHzoyvTGJddZUHv6Rfzc15mLg360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7yerwHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7yerwHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242D21F00898;
	Fri,  9 Oct 2026 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527254;
	bh=JlF3Kjq74l11rQ0rauivIkipzjLi4Zy802cOB/jxEDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X7yerwHBTctt8iediODeR+lKZv8OVH7ZGF8bwa3az/KLpmLQXTGeSNqfcokX/s8In
	 uDoVqMCLNlsFkJdBQgA7qcymsXgTecA0qfgmcN+PnPakAK2nLm/yw4awYr+5HOrSlb
	 vUpccvR7C4v3Vq6NsSs3zNKa6G3Vqaesw77Yiswd4JxffLJhM5cC3y4hu5jnqncvzI
	 avQu1q9HX21M9vl4yMDHhbvocE5hmGRSZ/Tl2uVDidVhuGKp6I99NngZptV3fQoArU
	 0BhX5qyjO+o7HCh7syguSZInpS7yUVRHPr4brP936clCvP0BfvhG3oHm4KvDn1V1Ts
	 m3ICpknFTJ9Qw==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 2/2] kbuild: Mark the initcall ordering recipe as recursive
Date: Thu,  8 Oct 2026 23:27:31 -0700
Message-ID: <20261009062733.3119731-2-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009062722.i.253-kees@kernel.org>
References: <20261009062722.i.253-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=kees@kernel.org; h=from:subject; bh=Ou6T9IYNd58AY4rXiZP4j6dFf/TA3MEpH+4ENptCD70=; b=owGbwMvMwCVmps19z/KJym7G02pJDFknOoNnuMtL3z1/y9TBoSb0yqz7p1+rOYc9X3rSu8y4X tGu3s6+o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIq8owMb18uFfjyRnRmZkqc z7qFDxIlc99sE0j9xRnD3cVyvvlFIiPDeomYtdOjRUz3iXA8VpFIfbtAaKXdlc8CqnX7mKYY/Sv jAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

generate_initcall_order.pl, which orders initcalls for Clang LTO, forks
a child per input file, up to the job count scripts/jobserver-exec
passes it in PARALLELISM. It used to run from link-vmlinux.sh, which
the top-level Makefile invokes as a recursive recipe, but
commit 5d45950dfbb15 ("kbuild: move vmlinux.o link to
scripts/Makefile.vmlinux_o") moved it into a recipe without "+".

GNU Make passes the jobserver pipe only to recipes it treats as
recursive, and the make 4.3 in CentOS Stream 9 also hides it in
sub-makes (a backport of the fix for GNU Make bug 58232), so
jobserver-exec cannot open it and prints:

  WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')

PARALLELISM is then left unset, and the script caps its children at the
number of online CPUs instead of the free job slots.

Mark the recipe as recursive again.

Tested ARCH=x86_64 defconfig with CONFIG_LTO_CLANG_THIN=y, LLVM=1
(Clang 24.0.0git), and GNU Make 4.3 plus CentOS Stream 9's
make-4.3-cloexec.patch.

Fixes: 5d45950dfbb15 ("kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 scripts/Makefile.vmlinux_o | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 24a3a4fd271c..0b37bd5dc3a4 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -19,7 +19,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
 
 .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
 		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
-	$(call if_changed,gen_initcalls_lds)
+	+$(call if_changed,gen_initcalls_lds)
 
 targets := .tmp_initcalls.lds
 
-- 
2.55.0

