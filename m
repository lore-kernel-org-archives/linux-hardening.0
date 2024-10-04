Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338B1CACEC
	for <linux-hardening@vger.kernel.org>; Fri,  4 Oct 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059526; cv=none; b=suvxCxhtX7h4bc7xlhAtHZI0p88SKIvmNXwQZsOv8AyU94/aTVARwGCrfqv8KlTSHXE+PbvhpI1cYE6tKFR2NlRkKrg/n3ulTKgZcS98wBUO2IuEubgqxUHl6Zs/UQRFnLzxKkO8eTPyfsXQ4meUj3JRviM5PIIFLNH5MsyBYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059526; c=relaxed/simple;
	bh=kUl1sKw/xZqbxSTdZSwJtsohwS7kwAMEXoZtDsaxJLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRP/26B60S7X1QvkAB6f8MFFK/MGoOmBQQxCCiZ8U8pKuDBZGxbrzjxbMcaWfWeor4IT7F8UWHvchJSEyxw83tCehzSjGr0yPm4RavojiR/CAD5ofGZKPzB1Fwu0TzBNSAORGemde4Ll3indjdaR1LYygmZ8u9nrMohCPUnc29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=THakEV7y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THakEV7y"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e19df65beeso331448a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 04 Oct 2024 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728059524; x=1728664324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQOMelg8du2jqJR/l5fp+h+gbDSex9spvxivV4Wc4GE=;
        b=THakEV7yI2XEQTKmJ6tAIEgLk+/euK7wUMBcWcG4sX/0/7EyMvxuEk3fiRoxE9MJaj
         e+RcRDOSRrmfLJARE1xQ7sXITpsa2Pf0jYYTbyAXACHXQMJZhB67su+9qQGfh3bINu2J
         RdyJac+VBSizBwkkfPcqA0CSyjachUvpTZutU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059524; x=1728664324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQOMelg8du2jqJR/l5fp+h+gbDSex9spvxivV4Wc4GE=;
        b=clYDdyFnxZgOFYBe/YA6yxmLcYP5bDlrcXs9zUo5qMZqV4b9RdyAi8PWxHSsZYa2XE
         /wX/lfIEJs8mgqpHOkXOQTcxMmIBQTdSjwfG+rxsLunA6wjWMZwbSBPNXcUR7TPp7ZFH
         ilj6kkRrlSJ8XE1lO4GZgTh8FfTwM8wE1bATX87oWGCx9z4RYUFhHF9H9cdxAmzQN3X7
         kyh3dDFTgOinwCJd47lvFwAcczr1FmPY3Wr9lO9ok6GemlV4iYjb0SMF+Ra98aDOB4N1
         mSYQmHCqylQR8z0yt7D+Jo0NnJWJ6HqY4xEgA/kOk8ZsSe0284203EIJxWztfxy5zFWP
         Agzw==
X-Forwarded-Encrypted: i=1; AJvYcCXFMykQ9MrXoMqhAYXw5Is10xcxPSk3NUTFaibrl3RGZ0ONwbMTOsGn7vFm6jaZUMlodOSSwsnuNIhgeMA6I3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4JZxcus2DA4y/hHkGu/ZFojqKw3KQ46onbxf7QO0S0DHhwhS
	ex1qvgiNyqSwJde5DNh+tHazp4jNLwsfbIvVZ+gag3b6+CLdF4wRnsMdHqV6Hw==
X-Google-Smtp-Source: AGHT+IHlRjKCM5IdGCgmApKjlpZTmU7xptRaY1QXl4V8jzbeG1/tYay9E/D80BRI0OhBkb9/UUDt1A==
X-Received: by 2002:a17:90a:c7cb:b0:2db:60b:eec with SMTP id 98e67ed59e1d1-2e1e63ae8a0mr1687786a91.7.1728059523995;
        Fri, 04 Oct 2024 09:32:03 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e1e866583esm1837061a91.37.2024.10.04.09.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:32:03 -0700 (PDT)
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
	mike.kravetz@oracle.com,
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
	nathan_lynch@mentor.com,
	dsafonov@virtuozzo.com,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 1/1] exec: seal system mappings
Date: Fri,  4 Oct 2024 16:31:55 +0000
Message-ID: <20241004163155.3493183-2-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241004163155.3493183-1-jeffxu@google.com>
References: <20241004163155.3493183-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing during the life time of the process.

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization. These mappings
are designated as non-writable, and sealing them will prevent them
from ever becoming writeable.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [1], thus sealable.

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
across all systems. To address this, a kernel configuration option has
been introduced to enable or disable this functionality. I tested
CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn’t use
CHECKPOINT_RESTORE, to verify the sealing works.

[1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
 fs/exec.c                                     | 53 +++++++++++++++++++
 include/linux/fs.h                            |  1 +
 mm/mmap.c                                     |  1 +
 security/Kconfig                              | 26 +++++++++
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8dcec6d1cdb8..871ba308bb04 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1535,6 +1535,15 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	exec.seal_system_mappings = [KNL]
+			Format: { never | always }
+			Seal system mappings: vdso, vvar, sigpage, uprobes,
+			vsyscall.
+			This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS_*
+			- 'never':  never seal system mappings.
+			- 'always': always seal system mappings.
+			If not specified or invalid, default is the KCONFIG value.
+
 	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
 			stages so cover more early boot allocations.
 			Please note that as side effect some optimizations
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 2fb7d53cf333..20a3000550d2 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -32,6 +32,7 @@
 #include <linux/mm_types.h>
 #include <linux/syscalls.h>
 #include <linux/ratelimit.h>
+#include <linux/fs.h>
 
 #include <asm/vsyscall.h>
 #include <asm/unistd.h>
@@ -366,8 +367,12 @@ void __init map_vsyscall(void)
 		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
 	}
 
-	if (vsyscall_mode == XONLY)
-		vm_flags_init(&gate_vma, VM_EXEC);
+	if (vsyscall_mode == XONLY) {
+		unsigned long vm_flags = VM_EXEC;
+
+		update_seal_exec_system_mappings(&vm_flags);
+		vm_flags_init(&gate_vma, vm_flags);
+	}
 
 	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
 		     (unsigned long)VSYSCALL_ADDR);
diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..bd4d687c37b1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/fs_parser.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -2169,3 +2170,55 @@ fs_initcall(init_fs_exec_sysctls);
 #ifdef CONFIG_EXEC_KUNIT_TEST
 #include "tests/exec_kunit.c"
 #endif
+
+#ifdef CONFIG_64BIT
+/*
+ * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS_X
+ */
+enum seal_system_mappings_type {
+	SEAL_SYSTEM_MAPPINGS_NEVER,
+	SEAL_SYSTEM_MAPPINGS_ALWAYS
+};
+
+static enum seal_system_mappings_type seal_system_mappings __ro_after_init =
+	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS) ? SEAL_SYSTEM_MAPPINGS_ALWAYS :
+	SEAL_SYSTEM_MAPPINGS_NEVER;
+
+static const struct constant_table value_table_sys_mapping[] __initconst = {
+	{ "never", SEAL_SYSTEM_MAPPINGS_NEVER},
+	{ "always", SEAL_SYSTEM_MAPPINGS_ALWAYS},
+	{ }
+};
+
+static int __init early_seal_system_mappings_override(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	seal_system_mappings = lookup_constant(value_table_sys_mapping,
+			buf, seal_system_mappings);
+
+	return 0;
+}
+
+early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
+
+static bool seal_system_mappings_enabled(void)
+{
+	if (seal_system_mappings == SEAL_SYSTEM_MAPPINGS_ALWAYS)
+		return true;
+
+	return false;
+}
+
+void update_seal_exec_system_mappings(unsigned long *vm_flags)
+{
+	if (seal_system_mappings_enabled())
+		*vm_flags |= VM_SEALED;
+
+}
+#else
+void update_seal_exec_system_mappings(unsigned long *vm_flags)
+{
+}
+#endif /* CONFIG_64BIT */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1e25267e2e48..7539e89ccd03 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3075,6 +3075,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
+extern void update_seal_exec_system_mappings(unsigned long *vm_flags);
  
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
diff --git a/mm/mmap.c b/mm/mmap.c
index ee8f91eaadb9..eb158e39ce0d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2115,6 +2115,7 @@ struct vm_area_struct *_install_special_mapping(
 	unsigned long addr, unsigned long len,
 	unsigned long vm_flags, const struct vm_special_mapping *spec)
 {
+	update_seal_exec_system_mappings(&vm_flags);
 	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
 					&special_mapping_vmops);
 }
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..e289fbb5d676 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,32 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+choice
+	prompt "Seal system mappings"
+	default SEAL_SYSTEM_MAPPINGS_NEVER
+	help
+	  Seal system mappings such as vdso, vvar, sigpage, uprobes and
+	  vsyscall.
+	  Note: kernel command line exec.seal_system_mappings overwrite this.
+
+config SEAL_SYSTEM_MAPPINGS_NEVER
+	bool "Traditional behavior - not sealed"
+	help
+	  Do not seal system mappings.
+	  This is default.
+
+config SEAL_SYSTEM_MAPPINGS_ALWAYS
+	bool "Always seal system mappings"
+	depends on 64BIT
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Seal system mappings such as vdso, vvar, sigpage, uprobes and
+	  vsyscall.
+	  Note: CHECKPOINT_RESTORE might relocate vdso mapping during restore,
+	  and remap will fail if the mapping is sealed, therefore
+	  !CHECKPOINT_RESTORE is added as dependency.
+endchoice
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.47.0.rc0.187.ge670bccf7e-goog

