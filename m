Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696E37B02A;
	Sat, 10 Oct 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620357; cv=none; b=GW0dJ+URRVwn6ndr91XTqDPq9izbcufeGYWtOX0Yg30dITQQ7DYsCKTUgPClnAs/SaE3CTBF8xEq+FqNjcW9tYwF2P/CpmR4wIfSrbTfjJc3FMcrLSkA2AvEuCCNHjAJBEM6X0MmX4xxExJ3LPIqZ5xS6LfG57uIY4rG/6k4XIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620357; c=relaxed/simple;
	bh=HMquPe7N6mUq7z9vc+3RYD2sTdPieUUTgqGEqBHAN0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbQWuleEF8mEeh7Dcn7KwEMrjBD9QXxfY8SRtKREtzFuUuFwBQuw/quyYBVBqVPXV6XSv/YsGdfZ5KriqPinhBvd2CeZdFPmDoXDEL3p8MvwG4lQESnJ3Ne021T9f61ZbQZ+Gv6L7qJX620YUtbyyg+EawrGxd0+9qYclYF1pA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9UU47Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9UU47Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FC71F00898;
	Sat, 10 Oct 2026 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620355;
	bh=tCviqUMwrNU3ojULvE9rOHj3rAEbOqdUMWWp+9aJI/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9UU47OlFwHVPEfnpOuPqEaKN00RavzEb1c5bq1ZFMPbokPrgYWNfUvlB+bx+JT8O
	 /B54ldKcekihuwGGNTc8S8DG6cG8vsgZ1qGYJqmS0xPc3HabUdtQ1U1rL3ejJvs0A1
	 ByXJzTxk1RuEP+4UrLq2UQm/m64DVCTa+gIX+Nr6r8wWG/XovntJmzMudgbU4GRMIj
	 jTZdvEFQ4vNrujkNbfZdTM2xOoC6/gnhxPTRK/g21FAbWXu6bQrngHsrxjTbkkK2/E
	 W2jh23dVH0oFfgGuYADMjxvzzNQJJj/+qYooLECJwMPcrC16eE9Psdw+8eTlDsgsvE
	 lI/qk4hHfTpBA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	Nicolas Schier <n.schier@fritz.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: Mark the initcall ordering recipe as recursive
Date: Sat, 10 Oct 2026 01:19:11 -0700
Message-ID: <20261010081914.540611-2-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010081910.stay.092-kees@kernel.org>
References: <20261010081910.stay.092-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2312; i=kees@kernel.org; h=from:subject; bh=HMquPe7N6mUq7z9vc+3RYD2sTdPieUUTgqGEqBHAN0M=; b=owGbwMvMwCVmps19z/KJym7G02pJDFknv/znDLGf/GDFFX5btpRWXoV50otLdqToHpKMFvz2d wOPm59nRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETWcTD8z8map7J8D4uqZUz7 y6WWr32/Kh5j5H5/qmnd3Uea244ZbWP4zRYqXNy+/8ry2LyLaazW0gnbnJ7kKD8O+LSDq3aHmuc 7PgA=
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

Mark the recipe as recursive again (this makes "make -n" runs the script
again too, as it did from link-vmlinux.sh). Masahiro posted the same
change and withdrew it because the script was given only vmlinux.a, and
so never ran more than one child [1]. But on arm64, LoongArch, and RISC-V
with CONFIG_EFI_STUB, KBUILD_VMLINUX_LIBS also gives it the EFI stub's
lib.a. Either way, the warning is silenced.

Tested ARCH=x86_64 defconfig with CONFIG_LTO_CLANG_THIN=y, LLVM=1
(Clang 24.0.0git), and GNU Make 4.3 plus CentOS Stream 9's
make-4.3-cloexec.patch.

Fixes: 5d45950dfbb15 ("kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o")
Link: https://lore.kernel.org/all/CAK7LNARCM=rUm8mA8GRQ7ufeyfneGf4OEvHmESKt=zuxs2KrHw@mail.gmail.com/ [1]
Assisted-by: LLM
Reviewed-by: Nicolas Schier <n.schier@fritz.com>
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

