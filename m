Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF13C30
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348256; cv=none; b=ColX53MLgzuS2Rf2+xjkw0b6AjDZda63OD0mxkB1J2o71zyR0PLIM1XYhwdp7/tDjk/gjdrdPs3W8H6fSzjnRT62+npIDi++RaMYSMkV9tCPqhsxo9ySCK4OJ6PTV+JmBnultsK6XG/oD6vET0q8KmS44xTretFaZx6atf2TgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348256; c=relaxed/simple;
	bh=7jC4ZskKdBaVmuegrQ5krT15taFbgYbUatTyQmt36UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsQHRdukcUYUahtcvJv39lLk05fhv0TN3VG6bxKhan7ZbpouDT9MVpnnRFZv5kwghM0/i4weqqkuxM6p1luDNf+TNwbjL/wNCyGowC5JQvL8NAicgJh8a8pUAcoH6nOOJKR7DnEMEPi6lFh9VAiGIt/mSFlSNHE/m9+tLoPQPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVKZ0i3v; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVKZ0i3v"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so2851262b3a.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348254; x=1752953054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNk1yMcOnq+ZgJG6nrWMFpwLne9xEOGqiYN7XThKjZ8=;
        b=UVKZ0i3vu9OIiXzJJF4OO7BuBWPiMCbXwhnYUFV3q3aD3g7vfWMP64J1ldqpesAG5M
         hBxpAmuQ49k37ZF71DMOFPr2YwXLV1MnoD1X3Q61Puv1l125FmJGXGzBF7H/3OZc0uPC
         9pRdoeqYPHgsxkG7TTMgyQB84fhUJsJSVjaFQkuQE5CHvWmiEV+ij4oP+Z6DRvu8W9Pf
         ODS3G1lLtE3CTx3gXF+4/o68uClrV5Utm85WwWyOywFUful0gYxPpl+4e4SPPKFOaLg4
         S/Eo9QzLtG6XFHR8FBqj2DSE+9RAlQs+0DDynSYPmYQdxBcFk20bXSOlddE+gyndnY+x
         hZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348254; x=1752953054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNk1yMcOnq+ZgJG6nrWMFpwLne9xEOGqiYN7XThKjZ8=;
        b=iCbYp4bre1NVrcdWYqrO7WdK2jB4FJTtLHdUMKwIaPIw6hOdMdci7ARKs9tlzyUyLe
         fCbZsLW2Mculb13iIZQNroGAVQVkj7G+w+PkIGD07/WFUnI0bKMbYamoenZrMfvd7pmv
         gTIxBTC0+re2GUml23SusWEhwjuAoL4+zMFIsE40PPW4oggQPx09mQ2/zvrQJahPmdkl
         76hr0x2HC5ybj49zuxb0u/P/JLlNllRoVfVndx3lTsRW9uBVSJgMnVrDFNdLVpTmZ9ea
         u8NNB/+yVyi/OLSl1MSMqmrKEmeJLPPc0jT8jH/y6Q2k62VflqInF46BTupRjQPrLQVI
         lTsw==
X-Gm-Message-State: AOJu0YxmI+7uBIhUi7ycbg1h1NDIg5QM/Ks0l2QkqeLvBdzTfQBNdRRA
	IeUYDO1fgpQPZXMclad35owGAYXGFob3t/VcypOseA8DgbDAgFTNxNOTp3mLLJSD
X-Gm-Gg: ASbGnctmWOc12x7x2nG/ejQTGLTkhrvU8c9yOfwgy4JBwaNcGYH3Q8ZdilhW3RNXZIt
	5L6I7hkBlzauhQGEK4tRAx6U/ipTTAU8nXoqhjuNPW/ZXaHEgZG1935mwmSIEcC3KIXpTM8nm1y
	zLIfSfTBW6BpQoUsAc9epPbSeA8iw7QtzvIxyx35mvhRbauYwyO1J7HETe3W1BSKnLPPd0xHEi0
	EMo8lHrkVtrENKHOM5Ls44wn52NRcu6liq7wXH+k+90dvYCmQu1R/r/l4MVv7wRq+RjFXTLkBcm
	+vx0x0VR/xiar+txkM2loUhU1OwBRIwx96gcMeNx3Xs6wGI8vjwLxv2a1HfnPe3wVgFz/sMloLW
	VZb/eixqgNGcelmDo/8RNjAE84Q92XDjrtn5mXhhjKU9H
X-Google-Smtp-Source: AGHT+IEBcK9enONVGmD2LQL9TjZl2SXRDBIUhPJttr9nsY9pZpn7xij4M9opJMs0BuXWDRlEAjf1Vw==
X-Received: by 2002:a17:902:fc4b:b0:22d:b243:2fee with SMTP id d9443c01a7336-23dee1e6ffemr98811685ad.13.1752348253626;
        Sat, 12 Jul 2025 12:24:13 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:13 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 02/17] x86: syscall: support caching in do_syscall_64()
Date: Sat, 12 Jul 2025 19:21:47 +0000
Message-Id: <20250712192202.707192-3-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Include safefetch and support caching strategy in syscalls to protect
against time of check to time of use bugs.
---
 arch/x86/entry/syscall_64.c | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index b6e68ea98b83..0d5665e096a6 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -20,6 +20,30 @@
 #undef  __SYSCALL_NORETURN
 #define __SYSCALL_NORETURN __SYSCALL
 
+#ifdef CONFIG_SAFEFETCH
+#include <linux/safefetch.h>
+#include <linux/region_allocator.h>
+#include <linux/mem_range.h>
+#include <linux/safefetch_static_keys.h>
+#ifdef SAFEFETCH_WHITELISTING
+#warning "Using DFCACHER whitelisting"
+static noinline void should_whitelist(unsigned long syscall_nr)
+{
+	switch (syscall_nr) {
+	case __NR_futex:
+	case __NR_execve:
+	case __NR_writev:
+	case __NR_pwritev2:
+	case __NR_pwrite64:
+	case __NR_write:
+			current->df_prot_struct_head.is_whitelisted = 1;
+			return;
+	}
+	current->df_prot_struct_head.is_whitelisted = 0;
+}
+#endif
+#endif
+
 /*
  * The sys_call_table[] is no longer used for system calls, but
  * kernel/trace/trace_syscalls.c still wants to know the system
@@ -87,8 +111,46 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
+	// If interrupts using current execute prior to the next syscall
+	// then we will enter the syscall with the mem_range initialized
+	// we could chose to clean this info (shrink_region) or simply
+	// trust that the interrupt doesn't fetch something nasty and just
+	// operate the next syscall on the interrupt state (happens for
+	// sigaction calls mostly during IPI's that save the signal frame
+	// prior to executing a sigaction call). Or simply clear state
+	// on irq end (might slow down irqs so avoid this).
+#if defined(CONFIG_SAFEFETCH)
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_hooks_key) {
+		if (unlikely(SAFEFETCH_MEM_RANGE_INIT_FLAG)) {
+			// An IPI probably sent us a signal and the signal
+			// enabled the defense in interrupt context. Reset
+			// dfcache interrupt state.
+#ifndef SAFEFETCH_DEBUG
+			// If in debug mode, we actually reset the range in
+			// df_debug_syscall_entry.
+			SAFEFETCH_RESET_MEM_RANGE();
+#endif
+			shrink_region(DF_CUR_STORAGE_REGION_ALLOCATOR);
+			shrink_region(DF_CUR_METADATA_REGION_ALLOCATOR);
+		}
+	}
+#endif
+
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+	// We only use this for measuring so execute this without the static key
+	// else we get into nasty scenarios if we miss this initialization step.
+	df_init_measure_structs(current);
+#endif
 	nr = syscall_enter_from_user_mode(regs, nr);
+#if defined(CONFIG_SAFEFETCH) && defined(SAFEFETCH_WHITELISTING)
+	should_whitelist(nr);
+#endif
 
+#if defined(CONFIG_SAFEFETCH) && defined(SAFEFETCH_DEBUG)
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_hooks_key) {
+		df_debug_syscall_entry(nr, regs);
+	}
+#endif
 	instrumentation_begin();
 
 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
@@ -99,6 +161,20 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 
+#ifdef CONFIG_SAFEFETCH
+	// Note, we might have rseq regions executing in syscall_exit_to_user_mode
+	// and irqs so delay resetting region after this.
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_hooks_key) {
+#ifdef SAFEFETCH_DEBUG
+		df_debug_syscall_exit();
+#endif
+#ifdef SAFEFETCH_MEASURE_DEFENSE
+		df_destroy_measure_structs();
+#endif
+		reset_regions();
+	}
+#endif
+
 	/*
 	 * Check that the register state is valid for using SYSRET to exit
 	 * to userspace.  Otherwise use the slower but fully capable IRET
-- 
2.25.1

