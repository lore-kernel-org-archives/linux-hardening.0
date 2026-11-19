Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123920;
	b=snx78vdswSYf81i+2lYUwSrNMhZgira6gjxA+QScWmuMS000SALnYske6wmN68ODcnQs
	 9OqhV5wTkXY5Keiij8yb+LdmACCiJvpv1zCIIXeaay0fJttoGnwlIPNOCP90DfFxiDxBm
	 UW3+9yncl3EpapXSFIwqCX/+aJYj7QxuzaVofzu4Uci5i6wBJOOBEBYtxAPATGE0WaIdl
	 I4EUU7vI5dPjn4a9UJtM+D+TqkzXlSpkG5JSKfBQQz+4PXjKDiO0Mdm8gm0iujNbwLO9v
	 +DC8R8Fb618XY6CTcAb+2sM14o61xvjTaKUKscjMLCm1vSijqztuYoLN7Bj8pzu+/fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123920;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z82Fi18D8IzxzM7snm4f0enJxLNYAonxvUBFSN19rNE=;
	b=yy2s8oOqYBDsml4HnuX0sR/PjIzMC2tKhKyQapgeiA6yqIJq6DbPwSxOR/qZS5bGP493
	 NmtZq2Je1aSRj3am39hP8ftHtUxhJ2cxhBXDqZCQN2YlH53jMVOQpXHEqOQQKaqmxjsMJ
	 +bYXehxW4KlGKSen4m6liL5TL4w9Eq+xKlGBKbrTYOxzHuiA8gzqBmyanFdK/v33ChLXN
	 TI9lMDAVdyNg9pDqXLvuyz1Cxeio6Sfyqc3afbP8iefcAjjhGxqqjQ6OQseggNxVoR9tg
	 91bIAQby0gDJfci9kKeOqwFwKfmLyn04s0BmY9bVx1qdbID2lxHU5OAckzs4GOHHIUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qyZBAUrc;
	arc=none smtp.remote-ip=91.218.175.125
Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247D606A324
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 21:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7247D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qyZBAUrc
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FQgocnJVGX/UOY3g+Sx9R6WdMZmKAPZnWIEEeOVH290=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795123917; v=1; x=1795728717;
 b=qyZBAUrciq0cRBwUw7Ly2XcqfONyylaAvv+F//yn+cysuEMD/kN1kAc4tmDFQvIS19JGpEuu
 dT6nWUk4lGhaEcEkl+bGD8eEspjxj6pmFPPkr75CTvkw+vymVZmizgexfhvNbUmATfIpIvHngK4
 vvQhC1Gd7W2lXc7dEKTFvbCI=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id a7fa74e5abb5802f;
	Thu, 19 Nov 2026 21:31:57 +0000
X-Mizu-Trace-ID: a7fa74e5abb5802f
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	kees@kernel.org
Cc: hpa@zytor.com,
	gustavoars@kernel.org,
	ardb@kernel.org,
	hca@linux.ibm.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	rkeilty@meta.com,
	atish.patra@linux.dev,
	dgreid@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 1/2] x86/boot/startup: Disable kernel stack depth tracking
Date: Thu, 19 Nov 2026 13:31:07 -0800
Message-ID: <20261119213147.1094488-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119213147.1094488-1-usama.arif@linux.dev>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 57fbad15c2ee ("stackleak: Rename STACKLEAK to KSTACK_ERASE")
renamed DISABLE_STACKLEAK_PLUGIN to DISABLE_KSTACK_ERASE everywhere
except in arch/x86/boot/startup/Makefile. The old name now expands to
nothing, so the startup code is built with stack depth tracking enabled.

The startup code is linked with every symbol prefixed by __pi_, so that
it cannot call into the rest of the kernel by accident. It has no alias
for the tracking callback, and tracking stack depth there is of no use.

At the default KSTACK_ERASE_TRACK_MIN_SIZE of 100 no startup function is
large enough to be tracked, so this went unnoticed. With Clang,
CONFIG_AMD_MEM_ENCRYPT=y and a minimum below about 90 bytes,
pvalidate_4k_page(), snp_cpuid() and do_vc_no_ghcb() get a call to
__sanitizer_cov_stack_depth() and vmlinux fails to link:

  ld.lld: error: undefined symbol: __pi___sanitizer_cov_stack_depth

Use DISABLE_KSTACK_ERASE, which disables tracking with either compiler.

Fixes: 57fbad15c2ee ("stackleak: Rename STACKLEAK to KSTACK_ERASE")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/x86/boot/startup/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5c0..0815105e7205c7 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -3,7 +3,7 @@
 KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
 KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 			   -Os -DDISABLE_BRANCH_PROFILING \
-			   $(DISABLE_STACKLEAK_PLUGIN) \
+			   $(DISABLE_KSTACK_ERASE) \
 			   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 			   -fno-stack-protector -D__NO_FORTIFY \
 			   -fno-jump-tables \
-- 
2.53.1-Meta

