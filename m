Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBA1C07FA
	for <linux-hardening@vger.kernel.org>; Mon, 25 Nov 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566033; cv=none; b=cDCb1eWyn5STJK7JRP2GDHLEiT0pB+2hmSufpYRNIn18LgBPKSj95+xEtJ2fzY0YHizAcrSdiqFIkwc2JzFbY+RH3BrzEZux0u8bPOCuquXZYfcXhm9gZDygJ0nemYgUXYwUXxdF1cfbJcakqkJfhhx8/OcxPbxJK8mur4fr3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566033; c=relaxed/simple;
	bh=RrvSRabc5zeIRDLOON+k34b+9/SZLazd12MZklnKdpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUqfxRQgYhEsMHQmT6QN0HHsgJPXtHAfXQ8oryvQpvDi/hUimr9M5IdB88QULdjvWAWg0Ii1SZbe2GhqEpnGFfbTcsRH/Sjh1yehcT2ZKHvNDGz8J3PQCdJ0/b/FLclFkvSkNDtaquynNrSAzUkphaS8MEnNYcUoAFxfN04dMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fENNhv6n; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fENNhv6n"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea93311724so724706a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Nov 2024 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732566031; x=1733170831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck8iNHlaINiOxwziQMas9mEee03tDCqdu64rqgP3RtY=;
        b=fENNhv6n1FJJSpPr3qGW/ZudiaJZol+e2wDBH3XY7T5oRlsaSCzH85yZqCrlADKGwn
         Ny5hbSBoiGpudWZhT0+9XnMwik7cE9Zjk0aT4NiVJyLpwyImtZWPHab6LyTNVz1a10nL
         Drx2gy5j3KFKnuZ25z+fJAoGCVkkN5iqecTzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566031; x=1733170831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck8iNHlaINiOxwziQMas9mEee03tDCqdu64rqgP3RtY=;
        b=vLv51+QmGPIU/CopJbp0lFzicS3EHiGfnMR2upVnGHaOk8q8w4KrGs6s0ODIc8sW88
         +HiQAsyq/g8OM2nHX5k5w/OxmD3ydV392rll3lmTT9Smc/gU0COShcnFGip+SsTapkhQ
         RO8UFmuHofxKQyhNlf8OVRET/OUinyN+tAAOjeXZfR9RYYr1qKDwo5G0j+FdTI/4/upN
         XMppvx2CN7wuxw83Nc1dtuAT7Guf8kZuSNuWMcip8fRuYwU6YvjpRGeb0XjkcHTR63IF
         Oz/FdAPxKrIbYJW6vNO/rGta/C3JTK9+vFpWc89+APmEUJAstPjd4BAkA5qQS13LCYj+
         b+kw==
X-Forwarded-Encrypted: i=1; AJvYcCWvyE+Wr+SWoXO1yMlDKzW9N4Mh8eB/j+XeObkVOXAx/4tHzHKzWCkOuXVAsPeJw9kHN3Qq0rm6Mn3uHq3FZ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YKT1RFZLMCpnI1vaLeKTPW3mTVj9iLyWhpiXqn5rcHEoP96b
	/gA4sjYc/NOQkWcuIBcBZqEtL+o9zjIZCkgv23lqKWIKy7yWkWF8Sin012FM9g==
X-Gm-Gg: ASbGncujecaxmfNQIT+ilKP1sv9ZHxiCYI5ajesT9j1HbVvU7T6mnz0oLLnz71bsLuM
	R70IsIWz1ZDVZxzI582DQqdwe4dhWPaRmsiH7tAo1PU+x9SIfOdjnW2dtrB2bTtOBHrxECXsFYc
	fsoych/WgpuCNamDr3Xk60nZx7ZpxgA3++t1LVMf599p6mMOchNdE9WCi4w5i2fQ/jTzxMnb7s6
	WLyC0nZHGvj7VJrfkbIXIa6yjvSbNMUYUcHRKTrB4/DqguAGR+2iN++9AHeK1FEd7qU3RgP/WHw
	vtPKSoQau8E=
X-Google-Smtp-Source: AGHT+IEsNrIfDOlDJszJCCyP5knKGW7zK5+mBVoYuD5vArA1ATNn0z2H+b7d5ury5fhH1aIeHXqdCg==
X-Received: by 2002:a17:90b:1a86:b0:2ea:3ab5:cb83 with SMTP id 98e67ed59e1d1-2ede7e58cc0mr723100a91.9.1732566030884;
        Mon, 25 Nov 2024 12:20:30 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2eb0d048e94sm7191796a91.40.2024.11.25.12.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:20:30 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	hch@lst.de,
	peterx@redhat.com,
	hca@linux.ibm.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 1/1] exec: seal system mappings
Date: Mon, 25 Nov 2024 20:20:21 +0000
Message-ID: <20241125202021.3684919-2-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241125202021.3684919-1-jeffxu@google.com>
References: <20241125202021.3684919-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing or unmapped during the life time of the process.
For complete descriptions of memory sealing, please see mseal.rst [1].

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization, and are
sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [2]. It is sealed from creation.

The vdso, vvar, sigpage, and uprobe mappings all invoke the
_install_special_mapping() function. As no other mappings utilize this
function, it is logical to incorporate sealing logic within
_install_special_mapping(). This approach avoids the necessity of
modifying code across various architecture-specific implementations.

The vsyscall mapping, which has its own initialization function, is
sealed in the XONLY case, it seems to be the most common and secure
case of using vsyscall.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the mapping of vdso, vvar, and sigpage during restore
operations. Consequently, this feature cannot be universally enabled
across all systems.

Currently, memory sealing is only functional in a 64-bit kernel
configuration.

To enable this feature, the architecture needs to be tested to
confirm that it doesn't unmap/remap system mappings during the
the life time of the process. After the architecture enables
ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
Alternatively, kernel command line (exec.seal_system_mappings)
enables this feature also.

This feature is tested using ChromeOS and Android on X86_64 and ARM64,
therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
Other architectures can enable this after testing. No specific hardware
features from the CPU are needed.

This feature's security enhancements will benefit ChromeOS, Android,
and other secure-by-default systems.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         | 11 ++++++
 Documentation/userspace-api/mseal.rst         |  4 ++
 arch/arm64/Kconfig                            |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
 include/linux/mm.h                            | 12 ++++++
 init/Kconfig                                  | 25 ++++++++++++
 mm/mmap.c                                     | 10 +++++
 mm/mseal.c                                    | 39 +++++++++++++++++++
 security/Kconfig                              | 24 ++++++++++++
 10 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e7bfe1bde49e..f63268341739 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1538,6 +1538,17 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	exec.seal_system_mappings = [KNL]
+			Format: { no | yes }
+			Seal system mappings: vdso, vvar, sigpage, vsyscall,
+			uprobe.
+			- 'no':  do not seal system mappings.
+			- 'yes': seal system mappings.
+			This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=(y/n)
+			If not specified or invalid, default is the value set by
+			CONFIG_SEAL_SYSTEM_MAPPINGS.
+			This option has no effect if CONFIG_64BIT=n
+
 	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
 			stages so cover more early boot allocations.
 			Please note that as side effect some optimizations
diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..bec122318a59 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,10 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- seal system mappings:
+  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings such
+  as vdso, vvar, sigpage, uprobes and vsyscall.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 63de71544d95..fc5da8f74342 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -44,6 +44,7 @@ config ARM64
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
 	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1ea18662942c..5f6bac99974c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,6 +26,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 2fb7d53cf333..30e0958915ca 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -366,8 +366,12 @@ void __init map_vsyscall(void)
 		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
 	}
 
-	if (vsyscall_mode == XONLY)
-		vm_flags_init(&gate_vma, VM_EXEC);
+	if (vsyscall_mode == XONLY) {
+		unsigned long vm_flags = VM_EXEC;
+
+		vm_flags |= seal_system_mappings();
+		vm_flags_init(&gate_vma, vm_flags);
+	}
 
 	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
 		     (unsigned long)VSYSCALL_ADDR);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index df0a5eac66b7..f787d6c85cbb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+#ifdef CONFIG_64BIT
+/*
+ * return VM_SEALED if seal system mapping is enabled.
+ */
+unsigned long seal_system_mappings(void);
+#else
+static inline unsigned long seal_system_mappings(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/init/Kconfig b/init/Kconfig
index 1aa95a5dfff8..614719259aa0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
+	bool
+	help
+	  Control SEAL_SYSTEM_MAPPINGS access based on architecture.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  To enable this feature, the architecture needs to be tested to
+	  confirm that it doesn't unmap/remap system mappings during the
+	  the life time of the process. After the architecture enables this,
+	  a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage access
+	  to the feature.
+
+	  The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOINT_RESTORE
+	  feature, which is known to remap/unmap vdso.  Thus, the presence of
+	  CHECKPOINT_RESTORE is not considered a factor in enabling
+	  ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
+
+	  For complete list of system mappings, please see
+	  CONFIG_SEAL_SYSTEM_MAPPINGS.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_PERF_EVENTS
 	bool
 	help
diff --git a/mm/mmap.c b/mm/mmap.c
index 57fd5ab2abe7..bc694c555805 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
 	unsigned long addr, unsigned long len,
 	unsigned long vm_flags, const struct vm_special_mapping *spec)
 {
+	/*
+	 * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
+	 * invoke the _install_special_mapping function can be sealed.
+	 * Therefore, it is logical to call the seal_system_mappings_enabled()
+	 * function here. In the future, if this is not the case, i.e. if certain
+	 * mappings cannot be sealed, then it would be necessary to move this
+	 * check to the calling function.
+	 */
+	vm_flags |= seal_system_mappings();
+
 	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
 					&special_mapping_vmops);
 }
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..80126d6231bb 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -7,6 +7,7 @@
  *  Author: Jeff Xu <jeffxu@chromium.org>
  */
 
+#include <linux/fs_parser.h>
 #include <linux/mempolicy.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
@@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
 {
 	return do_mseal(start, len, flags);
 }
+
+/*
+ * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
+ */
+enum seal_system_mappings_type {
+	SEAL_SYSTEM_MAPPINGS_DISABLED,
+	SEAL_SYSTEM_MAPPINGS_ENABLED
+};
+
+static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
+	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
+	SEAL_SYSTEM_MAPPINGS_DISABLED;
+
+static const struct constant_table value_table_sys_mapping[] __initconst = {
+	{ "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
+	{ "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
+	{ }
+};
+
+static int __init early_seal_system_mappings_override(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
+			buf, seal_system_mappings_v);
+	return 0;
+}
+
+early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
+
+unsigned long seal_system_mappings(void)
+{
+	if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
+		return VM_SEALED;
+
+	return 0;
+}
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..5bbb8d989d79 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+config SEAL_SYSTEM_MAPPINGS
+	bool "seal system mappings"
+	default n
+	depends on 64BIT
+	depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
+
+	  CHECKPOINT_RESTORE might relocate vdso mapping during restore,
+	  and remap/unmap will fail when the mapping is sealed, therefore
+	  !CHECKPOINT_RESTORE is added as dependency.
+
+	  Kernel command line exec.seal_system_mappings=(no/yes) overrides
+	  this.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.47.0.338.g60cca15819-goog

