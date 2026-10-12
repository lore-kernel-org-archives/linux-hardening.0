Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED046F4A2;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795878; cv=none; b=QwNix0jLgHiLjxP+nTL5ibXL3CXwIThEjkCbIGt0mG+UOVsiEgW9KB9/TWUznFqGIGqAYv1YsNW2Rv26RnXFBXqA6TnekaZi+ka0Xn8sp6uH4kggIXpTLy6PNSuNbiZeSHZYr0pwgpH/HGggRwipESCt16Lwzu/CphMyJRs0PQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795878; c=relaxed/simple;
	bh=BFb8xOdPEA3BZwPuD1g5CFbAvOvTRBo7ejDBzfTpr6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmJ/Cf53ND+Qc3nNCApPO3GPksUmKX+vvEIkXOSdv+OAykQnNTpy/79z8S0uhOnVTCAB+E8BWsBbYuMIEmd6yLAH4ifj0fsIew/gXXHacPZFZWXhczEkUtIb+MQlW0xBhFAe3xNOn4hc0Y3rbnGt5JmhW78NVI8YH9iC4sIjj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO9murn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO9murn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9F91F0089B;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795876;
	bh=SGbflecj2ZO+fNGO1kWGMX2Ew/cG1RCxwZx5JEZyjzk=;
	h=From:To:Cc:Subject:Date;
	b=XO9murn/Df1TMQnpOCRlvuvsB9Q2jnRN7uM+LyKozD/d1cuYOTdy9VoMue1sjWk7n
	 6jw7rFbCsgcjx7/KeeqzaLvVcjPRk7oSMKrZVSilejJL8lf8ewv6iIG2MH3xF43t66
	 IuxKApVywGSPHNv1DTw63fNqTdo4w8hAEsrvH56bh1XTi3tN6y3O8a4j0gRNeTJu59
	 ampdiQRNB6QjkV5TYpOzZze8AL1aZzyTaBqLHnZC3cmhxbR5Uir4JglWyB3tzRc2Io
	 wN9XiQ6DN+mWH8OAkqqv+euavm7HPfzu4ANDJUIWGGWr/nwqgoWJRKs63JHVnKZOr3
	 kRK6bi7sz1JNA==
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	x86@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] x86/cfi: Fix a few kCFI issues found with GCC
Date: Mon, 12 Oct 2026 02:04:23 -0700
Message-ID: <20261012090424.i.497-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=kees@kernel.org; h=from:subject:message-id; bh=BFb8xOdPEA3BZwPuD1g5CFbAvOvTRBo7ejDBzfTpr6k=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlnFs1k5vU0rl28zmJt1j1Fu0fx73++OftH7PDshGTP6 /fm7tiU0FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjARowcM/+NmS6t5XL7NK699 YJJBe/p93m0vOTnq4uRFVlwWs/47uZeR4ceTrH+xXZJXXxuI7dVcv/CZzI9Xm5mDOI933Gpfu8y ymgsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

While testing x86 kernels built by GCC with the coming kCFI patches I
tripped over three problems. Since the kCFI call sequence was optimized
in v7.3-rc1, the trap handler decodes the check one byte off, so a
kCFI failure in a CONFIG_FINEIBT=y kernel running in kCFI mode reports
whatever %rbx holds as the target, with Clang as well as GCC (1/3). GNU
as warns about the "cs" prefix in the FineIBT paranoid caller template,
which Clang's integrated assembler accepts silently (2/3). And objtool's
kCFI check treats GCC's jump-table jump for the BPF interpreter's computed
goto as an unchecked indirect call (3/3).

Thanks!

-Kees

Kees Cook (3):
  x86/kcfi: Decode the kCFI check from the trap address
  x86/kcfi: Emit the FineIBT paranoid "cs" prefix as a byte
  objtool: Skip jump table jumps in the kCFI indirect call check

 arch/x86/kernel/alternative.c |  3 ++-
 arch/x86/kernel/cfi.c         | 14 +++++++-------
 tools/objtool/check.c         |  8 ++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.55.0

