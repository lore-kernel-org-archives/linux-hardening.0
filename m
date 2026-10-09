Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D0443C15;
	Fri,  9 Oct 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527256; cv=none; b=d+ez5jvZK9mKs7T5/Hg8a2p0NFsTSlNVoGKdrl3aURaB5ZbMr1Dy07erpZkukCy+Nak5wYJN48EH1YuQLc8hFqbXqAyHiCBbeD0pH2LxusSNuZ3Xetiyq7GVwacUsqwXEt+4w1J/R+Tye5/gmvvChHjVHA1/ktrCJIN7NELtLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527256; c=relaxed/simple;
	bh=SVQ4ZAsvPrxbrO9AHLTBF7QeQdPMB3EXJlWgEL6MtqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrShZhnboaWcVL4BSkxhwVsf4+HiVTSYyO8nR6gYqyDEHUyxgKRrK4kVAkJ4EWhnuCT6/34w4UyDeIeIObtPxNaatCuakD8h3l/+Iv08o6rpakoNuyOe13PdS04OFeXNpMmX0yIkuBDEciOSByMmKuT5a346pUfgCBWhW1SNVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDjgDuNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDjgDuNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB8A1F00893;
	Fri,  9 Oct 2026 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527254;
	bh=j7LL+35X4cqcgpU23OihZTa5KlObZi60c2CzGisdAzk=;
	h=From:To:Cc:Subject:Date;
	b=XDjgDuNghb2YbsZ6ctJTYV9kTg5ZvSnIYyJHxZd/qg5rMu2qGTmq1znx+0CmJ68+3
	 Kd6FfP3kDiv8k8x3xCYdlJ3qjGqIZofYYSwIZAG3rZ50QEuKmmCk+r+1ySvTWksaSe
	 bJSZG67v+mT6yQynFe9cjvCHj9XB9H7L6C3Qf/BSK39bsEKAFANaLasZatBTJ96IbN
	 kulNQfZNO1v7HcpAp/+p5Kefrt1WkQht08L8gBd6QTVfdM7M+0aAhWLKFbD3tdumVp
	 F5ZZDFe2lNRdCUp34pnXY80rD0V4leUA8qnZElDRFeqTRc3N5nqBXY1JEU48orwMhI
	 7XpUfD/rRfrnQ==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 0/2] kbuild: Give jobserver-exec recipes the jobserver
Date: Thu,  8 Oct 2026 23:27:29 -0700
Message-ID: <20261009062722.i.253-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=kees@kernel.org; h=from:subject:message-id; bh=SVQ4ZAsvPrxbrO9AHLTBF7QeQdPMB3EXJlWgEL6MtqQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFknOoO8ZvydcEdKoDFFR7oj7vnxSlvDxd3zVu8vO7WjU HJaLANbRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwET21DMyfN3LuT1xwaNHTns3 TZ1zqbMsm+e0bkSSJsPO3G0OIRMvz2FkeDTrRHS44ewHgUeCjHc1T/rR8fJlgUXfEZk72X3usXI Z3AA=
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
step (1/2) and the older Clang LTO initcall ordering step (2/2) run
jobserver-exec from recipes without "+", so pigz gets one thread and the
initcall script caps its children at the CPU count instead of the free
job slots. Mark both recipes recursive, as was done for rustc.

Thanks!

-Kees

[1] https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/

Kees Cook (2):
  kbuild: Mark the kernel image gzip recipes as recursive
  kbuild: Mark the initcall ordering recipe as recursive

 arch/alpha/boot/Makefile             | 4 ++--
 arch/arc/boot/Makefile               | 2 +-
 arch/arm64/boot/Makefile             | 2 +-
 arch/microblaze/boot/Makefile        | 2 +-
 arch/mips/boot/Makefile              | 2 +-
 arch/nios2/boot/Makefile             | 2 +-
 arch/parisc/boot/compressed/Makefile | 2 +-
 arch/riscv/boot/Makefile             | 2 +-
 arch/s390/boot/Makefile              | 2 +-
 arch/sh/boot/Makefile                | 2 +-
 arch/sh/boot/compressed/Makefile     | 2 +-
 arch/sparc/boot/Makefile             | 4 ++--
 arch/x86/boot/compressed/Makefile    | 2 +-
 arch/xtensa/boot/Makefile            | 2 +-
 scripts/Makefile.vmlinux_o           | 2 +-
 15 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.55.0

