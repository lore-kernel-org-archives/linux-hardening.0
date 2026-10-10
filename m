Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A603803D6;
	Sat, 10 Oct 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620356; cv=none; b=OAjw0IgafiHaC1MN1NKymBQ1Hao6GrTy2fXXKLfXzTu/PJV+3J4CHe/PUDI4LzCHXcQHehWgfx04BbCE0mwytVci1Ql5sF3B2H9tdGpFaOwDPkohdmDnQSqA0moGBZhtYb9RpPLP5Q0bXo9pd0MCdOprqqnO3wzAnhAnT8/haH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620356; c=relaxed/simple;
	bh=CJdFI5tM99j1PTiSqCvE2zGotTzWe12j2fmi96550Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxFD6+y/qYWep6hmDG9QN5sK0BIsptWJbh0IUdEJuPTKiZhGbEzqUtMKENiooJ+M4Z53g5c0gNmx0PB4uxf1pfPOjm28GAQLSJMsG6ozqm6xJADxqz31kzeKLGRuNBYNxQMaxD/P2OM9DHpY5siRBLxsc+GG8Kid73mqupOVq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSuEpLVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSuEpLVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E11F00893;
	Sat, 10 Oct 2026 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620354;
	bh=atUk/iE+0iiA/VdpGoR6DI11A5fY/jwMQiV7IPOyXjQ=;
	h=From:To:Cc:Subject:Date;
	b=KSuEpLVChEuoaD39qZXaasD0tks35j8dDqFDbiz0n9eynm18IaGf77dZP5Xyz9RxI
	 QQbZLOsPpfZjDrNLMFditHwDkNI0gNZ2U95YtqQeFn65mPdgUzNQ7DT8Hx6AMUuyn0
	 LJj6Lj9wXpqkjwCeCvjo8ZDaf3ia3/NkzbWt2XJUdaeK0Q0HTnyKOOmU40YP/7bEtK
	 UVayCEcg6HfwFZwv51Hw4AwNVhw3xw1nIbPPM3MTpaRoD8r8v8ReTXVFCw57j4WYSj
	 TuysWew9Ze1Y5UaN7gdSQZIftnZFj7PHdNEkMM6ShlkfZtlGFoHFEyAvI61NCBxFyT
	 JGZ7ezKu7jYXQ==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Nicolas Schier <n.schier@fritz.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] kbuild: Give jobserver-exec recipes the jobserver
Date: Sat, 10 Oct 2026 01:19:09 -0700
Message-ID: <20261010081910.stay.092-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2930; i=kees@kernel.org; h=from:subject:message-id; bh=CJdFI5tM99j1PTiSqCvE2zGotTzWe12j2fmi96550Qc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFknv/yTuLl40/6Wo6ZnSuRnVSwvymb1Vz17IOdd6sU9v l9Xh8pbd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEcR0jQxfD95TNh659tTuv Hu1kVKqs3Llklh9/isfhvWfU33O6mDD8z/78TCrr4pcvGzP3PPMVEp98aNWLfToTFk5htlvv5l2 txgUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

Paul reported a build failure on CentOS Stream 9 with linux-next[1]: the
kernel builds, but scripts/jobserver-exec prints

  WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')

and rcutorture's build check counts the "Error" in that line. CentOS's
make 4.3 carries a backport of the fix for GNU Make bug 58232, so
sub-makes, like the top-level make, give the jobserver pipe only to
recipes marked recursive, while MAKEFLAGS still names it. The new pigz
steps (1/2), for the kernel image, the built-in initramfs, and the other
gzip rules, and the older Clang LTO initcall ordering step (2/2) run
jobserver-exec from recipes without "+", so pigz gets one thread and the
initcall script caps its children at the CPU count instead of the free
job slots. Mark these recipes recursive, as was done for rustc.

Thanks!

-Kees

 v2:
 - 1/2: also mark the gzip rules that choose gzip through a variable,
   including the built-in initramfs in usr/Makefile, which rcutorture's
   kvm.sh builds and v1 missed (Paul)
 - 1/2: update the gzip entry in Documentation/kbuild/makefiles.rst
   (Nicolas)
 - 2/2: cite Masahiro's earlier version of this change and say when the
   script gets more than one archive (Nicolas)
 - v1..v2 diff: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/diff/?id=dev/next-20261001/pigz-recursive/v2&id2=dev/next-20261001/pigz-recursive/v1
 v1: https://lore.kernel.org/all/20261009062722.i.253-kees@kernel.org/

[1] https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/

Kees Cook (2):
  kbuild: Mark the gzip recipes as recursive
  kbuild: Mark the initcall ordering recipe as recursive

 arch/alpha/boot/Makefile                    | 4 ++--
 arch/arc/boot/Makefile                      | 2 +-
 arch/arm/boot/compressed/Makefile           | 2 +-
 arch/arm64/boot/Makefile                    | 2 +-
 arch/csky/boot/Makefile                     | 2 +-
 arch/microblaze/boot/Makefile               | 2 +-
 arch/mips/boot/Makefile                     | 2 +-
 arch/mips/boot/compressed/Makefile          | 2 +-
 arch/nios2/boot/Makefile                    | 2 +-
 arch/parisc/boot/compressed/Makefile        | 2 +-
 arch/riscv/boot/Makefile                    | 2 +-
 arch/s390/boot/Makefile                     | 2 +-
 arch/sh/boot/Makefile                       | 2 +-
 arch/sh/boot/compressed/Makefile            | 2 +-
 arch/sparc/boot/Makefile                    | 4 ++--
 arch/x86/boot/compressed/Makefile           | 2 +-
 arch/xtensa/boot/Makefile                   | 2 +-
 usr/Makefile                                | 2 +-
 drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
 scripts/Makefile.vmlinux_o                  | 2 +-
 Documentation/kbuild/makefiles.rst          | 7 +++++--
 21 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.55.0

