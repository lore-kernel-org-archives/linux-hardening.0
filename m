Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1A1D0E3E
	for <linux-hardening@vger.kernel.org>; Mon, 14 Oct 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942633; cv=none; b=go9hMMuWAqoEf9z9eibXyxs8mwkS8OrQfB7zMcYQPxgvYqxs+mUifwoBeCNUVtEGXxnsq3DFVr2FO9T7OeQB+r677SzA+vvCkJDguDzIENmdLNgLQvgStYPWu4MLyVsFFw7jRgl6JbK/xVtI1k3E5aElptg0KuUr4Ax36nZTEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942633; c=relaxed/simple;
	bh=MdiBWBgWff0+rMNg2h+OGqlXtz32Rg48h+3ogQJ/Swo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP1qRbKqAfqp4WT9vsnBYTXz9sd9wY6RQXiQljhyaF9b9SlVPrYF9NlZQOFmJ70yejfSbfieu4/mpYFxDuE9LepnjchtzbXk5StKQcv3AlOkph6IaAmp0zKXZqfWvAhEgYhNPZ14nVGl5jNnWsWxYLOCWQLRIlLovfks8Lx3hBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=crKd26Fh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crKd26Fh"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea6f99e6eeso100830a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Oct 2024 14:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728942630; x=1729547430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCqzm4XprfPZ6h5KSF8yerh8aBwfFdviFsIk/AJKr8Q=;
        b=crKd26Fhzsg5O4WZORKEeV7TbrPzGd88Dj1BJUYsliGXQjmb1idkJmNUg/x07Dbuem
         l2tLRyLnRvl/+yJpDf4fNLT/n5rg7KUcAI/Gtt7nSMmyrjSj31IoMvrfF78GbAImzNet
         hqAPJqV6gBGpO3IpWbCXCuSh6s/aBFOxsJ9Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942630; x=1729547430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCqzm4XprfPZ6h5KSF8yerh8aBwfFdviFsIk/AJKr8Q=;
        b=N2bW+ITwCpbWedYbaLMOYRhY4BGvFKrUhc6TeGWq8mUAHeXHKn0RvZ2Bs1e7kdnRCd
         8RzCz/KMRuMnXkgdPqKR6tO4LUDWWj6wH6SeY6BjkoIS8z7iDtEuy4cTZmMJtx7hEtck
         9f8A91BfsthpdSLnFanrj87a1vSA8+AtUmWg7v0a3J/bELaRi4GMq/wTgAFUWQbfQr42
         R2Pyc1C+CGZHcBgZ2TMMQ67qCcY+1utst8sGwG9hOc/cpaYg6C1dHBDhKAIPSvzpVOUC
         5tAEWeNBZpOwVr4WixOpAMWRxYQGRguZPbun2CViszt5PQxV3wHl5fhc+bIGSRol75GT
         mjaA==
X-Forwarded-Encrypted: i=1; AJvYcCVfOTf/d0tvr9Zzs30J5yBLIjVXad+B+7HmwuFSh2lCDo7w8NvTiFhCLqmUgffi3oH8OSKbt4TSHYJNKxY39B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTABagZGenqKazP/lYfNWgaMGgANQMgK5V+hFEibrLGzqCi06h
	rhLQvgwiJAYjrEM4eN79q6Gi9aCsPXlKlLqN4DHSyfXsl7c4qO511b5FkQpohw==
X-Google-Smtp-Source: AGHT+IHJibLG55dv20aw5zAlf9R+lVo01HQFW7VTQTck/5caHO6/ZiNO6n2U3rR/biiiYKEMvgayNg==
X-Received: by 2002:a05:6a00:1ad3:b0:71e:5400:1b35 with SMTP id d2e1a72fcca58-71e54001b7bmr4887430b3a.5.1728942630535;
        Mon, 14 Oct 2024 14:50:30 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71e4a77cb0bsm5458012b3a.193.2024.10.14.14.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:50:30 -0700 (PDT)
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
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v2 1/1] exec: seal system mappings
Date: Mon, 14 Oct 2024 21:50:20 +0000
Message-ID: <20241014215022.68530-2-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014215022.68530-1-jeffxu@google.com>
References: <20241014215022.68530-1-jeffxu@google.com>
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
them from ever changing during the life time of the process. For
complete descriptions of memory sealing, please see mseal.rst [1].

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization. These mappings
are designated as non-writable, and sealing them will prevent them
from ever becoming writeable.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [2], thus sealable.

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
been introduced to enable or disable this functionality. Note, uprobe
is always sealed and not controlled by this kernel configuration.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
 fs/exec.c                                     | 53 +++++++++++++++++++
 include/linux/fs.h                            |  1 +
 kernel/events/uprobes.c                       |  2 +-
 mm/mmap.c                                     |  1 +
 security/Kconfig                              | 26 +++++++++
 7 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e7bfe1bde49e..02e5eb23d76f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1538,6 +1538,16 @@
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
+			This option has no effect if CONFIG_64BIT=n
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
index 77364806b48d..5030879cda47 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/fs_parser.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -2159,3 +2160,55 @@ fs_initcall(init_fs_exec_sysctls);
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
+	if (!(*vm_flags & VM_SEALED) && seal_system_mappings_enabled())
+		*vm_flags |= VM_SEALED;
+
+}
+#else
+void update_seal_exec_system_mappings(unsigned long *vm_flags)
+{
+}
+#endif /* CONFIG_64BIT */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 42444ec95c9b..6e44aca4b24b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3079,6 +3079,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
+extern void update_seal_exec_system_mappings(unsigned long *vm_flags);
  
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c47a0bf25e58..e9876fae8887 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1506,7 +1506,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_SEALED,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
diff --git a/mm/mmap.c b/mm/mmap.c
index 57fd5ab2abe7..d4717e34a60d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2133,6 +2133,7 @@ struct vm_area_struct *_install_special_mapping(
 	unsigned long addr, unsigned long len,
 	unsigned long vm_flags, const struct vm_special_mapping *spec)
 {
+	update_seal_exec_system_mappings(&vm_flags);
 	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
 					&special_mapping_vmops);
 }
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..4ec8045339c3 100644
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
+	  Note: kernel command line exec.seal_system_mappings overwrites this.
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
2.47.0.rc1.288.g06298d1525-goog

