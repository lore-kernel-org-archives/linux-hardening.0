Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1BEC5;
	Tue, 22 Apr 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340896; cv=none; b=rFMMFYiLIMoEDZ91vVkqF4KPbpqDJjGQxy9FGTPWXqQDxonYLnRdXOK2S6Wv29g/Q3laqslYe/dMTglAKFyayZ/mcsyzFkCNgQBjNi3Z2sAuUiYXA38MIAy5y8AWkRxnX1iCPZ0x/yOH41Mv48frUixls9sRWFXzEczpiVrh2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340896; c=relaxed/simple;
	bh=tbyL9UQJ2BSbltSs0HNxn0bdkIl2+mEJvKVfmqSMtuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kjk39Z8VGzSDxiCBcG2rm6CFFXj3hzo4A6a5FAzEZ/aQcoqQEysATP8y44raHQhgFb7JLNnAwVA9MUic5luFcSafWgzpK5o5Bt1O3w+VughujiAzI11C+bPVOiGJEyLt9xVhpJC25HMDaqL1wPWSoTe7EuGhY5G/6l1ZuqHE/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Mq3kr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Mq3kr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF6C4CEE9;
	Tue, 22 Apr 2025 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745340895;
	bh=tbyL9UQJ2BSbltSs0HNxn0bdkIl2+mEJvKVfmqSMtuc=;
	h=From:To:Cc:Subject:Date:From;
	b=M7Mq3kr+HjAlc0TJZCe7z2oQNg4vgoy4wkseBPQEi9FbMfEJ8ub8fH1WeOv+6y0HH
	 bQQPCwIdwZaPbwayM9aprQFoV7cDwRrTFvsKB7VqQjExUWXjP78NbYPNKz+lo2o8om
	 q/Jx7dOxnWnaEXtdsyUbelKBj+8GyGSyt3hkEd+hE/aA/0KDQ4xKl0jUB0Ifk8mSHi
	 1WB/7b/lltdgiz/+FmcpC+eZfaT6CcSH+aII0uWYIjxSGijqFbM9CLZw8T2tq+HOEI
	 gZQVOx8MLgKXqQBmeHLq8KtXnhTnYwFuVH6ETAnyMOCrkv9ivrbwr00c9CdgqAM2hu
	 Q4uHQZCJPVMaQ==
From: Kees Cook <kees@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] configs/debug: Refresh debug config dependencies
Date: Tue, 22 Apr 2025 09:54:50 -0700
Message-Id: <20250422165446.work.015-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=kees@kernel.org; h=from:subject:message-id; bh=tbyL9UQJ2BSbltSs0HNxn0bdkIl2+mEJvKVfmqSMtuc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnsJ29eLrxybkXp0vlzWnh6XL7dOmvZMy89WS7wXGrL9 tD5++8zdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExE4yfD/5BS89KeFW5F5Xu7 lxSffaW945t+z4xt39cw7n6RfKvNqofhr+RSsV/fdl5ZcPW90IVCObb7W1Zv2dhUNj+4aMFLt1n 1U5gB
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Many of the CONFIG_DEBUG* options need CONFIG_DEBUG_KERNEL=y to be set,
so enable it explicitly. Similarly for CONFIG_NET* options, enable
CONFIG_NET=y. Finally, remove CONFIG_DEBUG_VM_VMACACHE, since it was
removed in commit 7964cf8caa4d ("mm: remove vmacache").

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/configs/debug.config     | 3 ++-
 kernel/configs/x86_debug.config | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e81327d2cd63..1a8724f29137 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -26,6 +26,7 @@ CONFIG_SECTION_MISMATCH_WARN_ONLY=y
 #
 # Generic Kernel Debugging Instruments
 #
+CONFIG_DEBUG_KERNEL=y
 # CONFIG_UBSAN_ALIGNMENT is not set
 # CONFIG_UBSAN_DIV_ZERO is not set
 # CONFIG_UBSAN_TRAP is not set
@@ -42,6 +43,7 @@ CONFIG_UBSAN_UNREACHABLE=y
 #
 # Networking Debugging
 #
+CONFIG_NET=y
 CONFIG_NET_DEV_REFCNT_TRACKER=y
 CONFIG_NET_NS_REFCNT_TRACKER=y
 CONFIG_DEBUG_NET=y
@@ -72,7 +74,6 @@ CONFIG_DEBUG_VIRTUAL=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_VM_RB=y
-CONFIG_DEBUG_VM_VMACACHE=y
 CONFIG_KASAN=y
 CONFIG_KASAN_GENERIC=y
 CONFIG_KASAN_INLINE=y
diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
index 35f48671b8d5..28d1c6ba3bf0 100644
--- a/kernel/configs/x86_debug.config
+++ b/kernel/configs/x86_debug.config
@@ -2,7 +2,6 @@
 CONFIG_X86_DEBUG_FPU=y
 CONFIG_LOCK_STAT=y
 CONFIG_DEBUG_VM=y
-CONFIG_DEBUG_VM_VMACACHE=y
 CONFIG_DEBUG_VM_RB=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_KMEMLEAK=y
-- 
2.34.1

