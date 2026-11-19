Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123923;
	b=il98wo/K+NzsYEfrczOHbn3Zx3KqQuZn8hqNkUVc0Ai4lFxLPEB5d4ZvS8YSTak4BfCW
	 Ns6AmpgR4FaL+igxEUqDYMZPWTXfb8uivzLa2YbY9sTAvxPoBLvRHEaY2yYWnJorVZLiT
	 ufECFWhLr6hRn/X28Ys1RGEaH/e6oh0LSGUtm6a4iiCEIYtHodX+LYlVVTHWMr14/9/C/
	 lG9EyKH8cBbG5w9oVRzWFC/uxA34tORGK9gdZ8meEeF1u1yiw+NMhpsYCZ+q0c22SkYaY
	 HOm2Z8nraaNvjFg08xLZEB3UwJJtvXyeT77bGUW62WZnmySwEFShFPbuZsDwhCf/UOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123923;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z0f12Fhq47yJ0K7JFq0vMJwpWMgJuv95hRHiFmZI46Y=;
	b=NOoUEVvRLtvx5ZR22V3SQ3U/T0MsZQRHRt4BlKpU9LFZAboubah2y+8xEwPxQXoffRSm
	 Vx8KRkZf8Zh6IY40VE4l8vHte4ELdiBNslcFSJz3JEmP5i40j78E2bR19k574l3WDHLT2
	 57aRPd9GC+auvhWCxCk75YMJuhHUPy4vuHqBYkO8JHPnvolzZLCmVHjzuYzKpD1OQAXEc
	 I4Rt90FG6YWteo11fKYRWiX2nNnXtMQ56fSiLE3JtoGYR13eq2MpgdcIOUpqpjgdGOwTp
	 OtLLhiKasU+qW2ZizqvxbWrKE5Bqv48ANXZTLa8uk2shgIXQY0J2R5Xx9EhcTqNEOvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dsXxke9j;
	arc=none smtp.remote-ip=91.218.175.131
Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E797606A331
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 21:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E797606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dsXxke9j
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9gahvkdbVvSIQ2Nc7cy9eg/+EHh2j7Wk8/IBr2Sw/HE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795123920; v=1; x=1795728720;
 b=dsXxke9jDjDaayZnT2i6cjDgJx4pretLtMzLCtep7qGIFtPyB156VAZblwMyRNz2t3Tb39/d
 JYNLOh09C/DhyeCuT3HGthDFWZ7JwnU/UMn0vGqcvtGGTGKGNA+fFxpSyKijQKhe2Ia7P+AJbaW
 rakmw/pLcM+GON982DEbI1zI=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 2ff727b0e57761ec;
	Thu, 19 Nov 2026 21:32:00 +0000
X-Mizu-Trace-ID: 2ff727b0e57761ec
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
Subject: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
Date: Thu, 19 Nov 2026 13:31:08 -0800
Message-ID: <20261119213147.1094488-3-usama.arif@linux.dev>
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

With KSTACK_ERASE, every return to user space poisons the part of the
task stack that was used since the previous return. The generic
__stackleak_poison() does that one word per loop iteration, so a syscall
that went 1-2 KiB deep pays for 128-256 separate stores. On Meta hosts
running many small VMs, stackleak_erase() accounts for about 1.5% of
non-idle host kernel cycles.

Override __stackleak_poison() on x86-64, as s390 already does, through
the hook added by commit 491a78663e03 ("stackleak: allow to specify arch
specific stackleak poison function"). Fill spans larger than 512 bytes
with REP STOSQ and keep the word loop for shorter ones, where the fixed
startup cost of REP STOSQ does not pay off. REP STOSQ starts to win at
about 300-400 bytes on Zen 5c and Cooper Lake, so on both no span gets
slower.

The fill is inline asm, so the noinstr function still makes no calls.
memset64() would be the same instruction, but it is only static inline,
and with KMSAN it is an out-of-line function.

In a Zen 5c KVM guest, stackleak_erase() got about 35% cheaper per return
to user space (71 ns to 46 ns, scan included) over a futex, epoll, procfs
and Unix socket syscall mix. Same-vCPU futex wake/wait and Unix socket
sendmsg()/recvmsg() ping-pong round trips got 5-8% faster.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 arch/x86/include/asm/processor.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 77488ff5eb8c7c..049231d484ad0e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -580,6 +580,31 @@ static __always_inline bool on_thread_stack(void)
 			       current_stack_pointer) < THREAD_SIZE;
 }
 
+#ifdef CONFIG_X86_64
+#define __stackleak_poison __stackleak_poison
+static __always_inline void __stackleak_poison(unsigned long erase_low,
+					       unsigned long erase_high,
+					       unsigned long poison)
+{
+	unsigned long count;
+
+	/* Short spans do not amortize the startup cost of REP STOSQ. */
+	if (erase_high <= erase_low + 512) {
+		while (erase_low < erase_high) {
+			*(unsigned long *)erase_low = poison;
+			erase_low += sizeof(unsigned long);
+		}
+		return;
+	}
+
+	count = (erase_high - erase_low) / sizeof(unsigned long);
+	asm volatile("rep stosq"
+		     : "+D" (erase_low), "+c" (count)
+		     : "a" (poison)
+		     : "memory");
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-- 
2.53.1-Meta

