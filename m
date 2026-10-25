Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792898021;
	b=ry0Ly4vpCqzZ8v4a4Wm1aqoF2GzjYYr3GSH14fRuKb6McQtm8LbqPhbH+9yPlnTpORNc
	 i0ywIfmqPaL1Z2AkX6dCaefMtPKBmWqfF5KNwFr8ql94grjrLg5RRZ9zhXMbhDKSudFDk
	 NtUoo1kRi7++1geX1Q2tFAFYkO+hqO3y4gyDDDnOMKIZ72SINbaeu+nNIENNshG7Y8G+1
	 WqcNYhOn55csxUMNwqtSKerdvfCikX+ijbQsSIjVn5CkmJ+0Txja87PpAyp80LZqxtjH0
	 ht0lF8/E0tTK0jb8ZPpD/q/Hv8xxA2+Zj58UWjd75aMSCv0Tmnn0+KaTzcdbo1Yza8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792898021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Svkdinz0fhAVIl4VKqxj4TH+8XHNXL7X1C4TJInY6rA=;
	b=OVTE7jgPqvUj/ClEyg0IhpqDFEgjxqrgU1IIhBbvfE0ex/uFECNlKDpwXLenIsi1IiLH
	 Kha02TXywtFo4DB8Xq9HBjFsMDe7lkLkE3pMdx1rtA6JIW9NxuuxxUY25Yng86XaNOo1d
	 PpuoXmAHYcJsFf1PEz3iZdrEfU2wG6Sj1mrBLw/zM4RO1BwYBLiwln+BoFxnCr/gs4zNW
	 UpjuwqzjXeHvIrPJfeYLe98NEgsoKy/xM4qW6FHPhSCuszYQj1d5/mBqUc5THuH1hYwPw
	 TInKmNqPXgNOztJijxtKLISm8HSHEzfhf6RJqbvhfAi4YWrFO20i5CSlQH1FN7mPRnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yjn-systems.com;
	spf=none smtp.mailfrom=yjn-systems.com;
	dkim=pass header.d=yjn-systems.com header.i=@yjn-systems.com header.a=rsa-sha256 header.s=google header.b=kWVSkpDX;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA8606A31B
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 03:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BA8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yjn-systems.com header.i=@yjn-systems.com header.a=rsa-sha256 header.s=google header.b=kWVSkpDX
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a215e64962so12783155e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1792898018; x=1793502818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Svkdinz0fhAVIl4VKqxj4TH+8XHNXL7X1C4TJInY6rA=;
        b=kWVSkpDXW5N4qomhnWT1UGrEK/iKrGbrMnUAjYjlN2RwVSx1DDvhKPr/Tf7MJsgW5f
         2Q4jfBIcOAGaaFrcFLAALlhfI0bpO4JvYDeQFeqTFBDqon8WwVkinYxp2nusqb3Dm2tD
         gnqlpmVDzGmWNKDNHRxgcDLychJzrff6T6Fn2/0UpJaccpu4HzGkn/+ZTXmr4nIi1x9F
         qho+YbEnaUQUcEZ2FDlgcZyF52rnHbJ5nLBYOuwnJTN0j+nvt7nYbfT+GNIVT5Huq93k
         6ggHGNnytJTh8NGYAr+P21IdmunoL3CvyDWGjnaud1Fbh7QAMcvVfwd5ZtS8zO+OgLaS
         6p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792898018; x=1793502818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Svkdinz0fhAVIl4VKqxj4TH+8XHNXL7X1C4TJInY6rA=;
        b=TbIA1EA2rMkT9xYgsjktqhQ6SRikyDkSJzDKyqTaTbN+TOKSP0wT80BnsKevtbYKtf
         xfdQn/9fXOc+5LwRFtRyBI5lPLJtLqlFMbgzHlDEQxba3PpyJWh/MA9BI4y7ABMmC+E3
         ghhOid0+kmtLk5Wuwzj+dhzuqjtYS8j9AuZPuDZ1izTdFsoQeUJA2QDqOZElkXd5WZIy
         cjRwp+ksiUdQ8iilhgphrBTYZsNm1dnciUTTuzUCPs6O2wjrqZPUw01ulhQtg0istZg0
         Yz+zKGE8zSu5bEDo9kpAfRXM5tnR0qZ7T7SfMsVsNCKi/hnWnJVf8BU1aoh1lk4daEE1
         cwrQ==
X-Gm-Message-State: AFq9FYKIz/LWbl32MV/XChOAOtHRQykQwVhA45FfN6JVpSKGIVCKkgkw
	35h2S93zRi0Fxe8jbJRFma+kAJpoUogG+kW02uh9Ih+TMp0iHnx4TFp2kgp6sF2BGewMzTpcwjQ
	actSn0ygn
X-Gm-Gg: AYBFou3dn+HEgfE3YRAUcgMiFM6WeMA4wznaDKGgoHJIjR92LbzavCFZutvwa0Lk3B2
	CJr9JVPcrV+SzJ2oo6wArJUzHyfUyYFrRTSjh5goNVVhxgErn40tUHXC/w1ipIitO7ocz1c8U9s
	4h0RqhPgzSPoJfNz3f+ypiWhjOgtmmBng7W4tDtlan6plWd1Ox9ZWQhYCnkIyDbXyq9/NxBWZv+
	21GSBAfoH8LOYzK8nfqkUeKO6L1EJ/rDH1Tle+FB1KHWKWxr00XDapXAMcWUf31ZtV6hI+LtBv3
	KLtVI13O6uapnmZDEgsDXuJrdaINGJXnWIrdYJmiCW9hbS0MgusjoFkdKC9mivUJ5f60xezCkbO
	5rV8ilgwpF5azrr/o8k5wR9taQmiAxquUO8XUdx28JT9F8K1LkIT67C52c3SKEga2SD+1ee6kYQ
	IURHJGWe47xd5UpzhifKPHgy+L5tGQ/HqJ8MXVm0UMSm5VNNEaJN3P+2Vb8ufk7TwAkUBzI2ZTN
	ClhrHMX4Hxx+tqNMurLbG8x7DRpQPdCmt4+F1mixyQpvO0Xp41Hm7PdZmBKM11VpIuDcCZGrlac
	JABVoz7Ipb4ocG9KrCby8nW5xrzgH6yvUV397glZrldIXWMwPvbgv/0wdXN4Jj3CysiiSg==
X-Received: by 2002:a05:600c:c4a6:b0:4a1:fb2f:eff with SMTP id 5b1f17b1804b1-4a35aca2de3mr51631695e9.18.1792898017957;
        Sat, 24 Oct 2026 20:13:37 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf1819005b3565a866058f95.dip0.t-ipconnect.de. [2003:dc:bf18:1900:5b35:65a8:6605:8f95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm7046736f8f.58.2026.10.24.20.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:13:37 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	gregkh@linuxfoundation.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org,
	York Jasper Niebuhr <yjn@yjn-systems.com>
Subject: [RFC v4 2/3] Selfpatch-SLR selfpatch runtime
Date: Sun, 25 Oct 2026 04:13:34 +0100
Message-ID: <20261025031334.183879-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025031011.183364-1-yjn@yjn-systems.com>
References: <20261025031011.183364-1-yjn@yjn-systems.com>
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

This patch adds the Selfpatch runtime component of the Selfpatch-SLR
series. It is responsible for generating randomized structure layouts
and patching the kernel image in memory using the metadata emitted by
Pinpoint.

The runtime interface is defined in include/linux/spslr.h. Patching is
intentionally split into multiple stages. spslr_init() parses and
validates the Pinpoint metadata, constructs the randomized layout
database, and stores it for the lifetime of the kernel.
spslr_selfpatch() then patches the main kernel image using those
layouts. Module patching is handled separately through
spslr_patch_module(), which adjusts a module to the already-generated
host layouts. spslr_workspace_size() reports the size of the temporary
workspace required to patch a particular metadata set.

Since Selfpatch executes during early boot, before the normal allocator
is available, it allocates its persistent runtime state using memblock.
The randomized layout database is allocated once and retained for the
lifetime of the kernel. Patching itself uses a temporary workspace: one
buffer during kernel self-patching, also allocated through memblock, and
one temporary buffer for each module patch operation, provided by the
module loader.

For each target type, Selfpatch generates a permutation of its
randomizable fields and derives the corresponding runtime field
offsets. The layout generator uses a Fisher-Yates shuffle and attempts
to place fields into alignment holes left by preceding fields. Layouts
which cannot satisfy the target's original size and alignment
constraints are retried.

Once the layouts have been generated, Selfpatch applies three classes
of metadata emitted by Pinpoint.

Data pins (dpins) describe static instances of randomized target types.
Selfpatch rearranges the contents of each such object from the
compiler's original layout into the generated runtime layout. The
temporary workspace allows this to be done without overwriting source
fields which have not yet been moved.

Refresh pins (rpins) describe static values which depend on randomized
field offsets. Each rpin references a generated refresh function.
Selfpatch invokes these functions after the layouts have been selected
so that offset-dependent static initializer values are recomputed using
the runtime offsets.

Instruction pins (ipins) describe values embedded in generated
instructions which depend on randomized field offsets. Each ipin
references a generated calculator function. Selfpatch evaluates the
calculator against the runtime layout database and replaces the
corresponding instruction immediate with the result.

The generated calculator and refresh functions obtain field offsets
through a runtime callback rather than directly accessing the layout
database. Target references emitted by Pinpoint identify the target
type requested by each callback. This keeps the generated functions
independent of Selfpatch's internal representation of randomized
layouts.

Kernel self-patching takes place during early boot after the layouts
have been constructed. The same layouts are retained for subsequently
loaded modules: module SPSLR metadata is located by the module loader
and passed to spslr_patch_module(), which resolves the module's target
references against the kernel's target database and applies its pins
using the layouts already selected for the running kernel.

The patch adds the linker sections required to retain the Pinpoint
metadata and generated calculator/refresh code in the kernel and
modules. It also adds the module-loader integration needed to locate
these sections and reserve the temporary workspace used while patching
a module.

The runtime can be disabled with the "nospslr" command-line option. A
deterministic randomization seed can be supplied with "spslr_seed=",
which is primarily useful for reproducing a particular layout while
testing or debugging Selfpatch-SLR.

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 .../admin-guide/kernel-parameters.txt         |   9 +
 arch/x86/boot/startup/Makefile                |   4 +
 arch/x86/entry/vdso/common/Makefile.include   |   2 +-
 arch/x86/kernel/vmlinux.lds.S                 |  42 ++
 include/linux/compiler_types.h                |  31 +-
 include/linux/module.h                        |  18 +-
 include/linux/spslr.h                         |  72 +++
 init/main.c                                   |  39 ++
 kernel/Makefile                               |   2 +
 kernel/module/internal.h                      |   6 +
 kernel/module/main.c                          | 194 +++++-
 kernel/module/strict_rwx.c                    |  23 +
 kernel/spslr/Makefile                         |   5 +
 kernel/spslr/pinpoint.h                       |  62 ++
 kernel/spslr/spslr.c                          | 590 ++++++++++++++++++
 kernel/spslr/spslr_env.c                      | 147 +++++
 kernel/spslr/spslr_env.h                      |  41 ++
 kernel/spslr/spslr_randomizer.c               | 264 ++++++++
 kernel/spslr/spslr_randomizer.h               |  19 +
 scripts/module.lds.S                          |  43 ++
 20 files changed, 1600 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/spslr.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/pinpoint.h
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..996abd9d7eb7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4587,6 +4587,15 @@ Kernel parameters
 			kernel and module base offset ASLR (Address Space
 			Layout Randomization).
 
+	nospslr		[X86-64,EARLY]
+			When CONFIG_SPSLR is set, this disables boot-time
+			structure layout randomization.
+
+	spslr_seed=	[X86-64,EARLY]
+			When CONFIG_SPSLR is set, use the given hex-string of at
+			most 64 digits to seed the CSPRNG used for boot-time
+			structure layout randomization (no leading "0x").
+
 	no-kvmapf	[X86,KVM,EARLY] Disable paravirtualized asynchronous page
 			fault handling.
 
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..1fa601781546 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -12,6 +12,10 @@ KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 # disable ftrace hooks and LTO
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
+# Startup code executes before Bootpatch-SLR applies its runtime patches.
+KBUILD_CFLAGS	:= $(filter-out $(PINPOINT_PLUGIN_CFLAGS),$(KBUILD_CFLAGS))
+
 KASAN_SANITIZE	:= n
 KCSAN_SANITIZE	:= n
 KMSAN_SANITIZE	:= n
diff --git a/arch/x86/entry/vdso/common/Makefile.include b/arch/x86/entry/vdso/common/Makefile.include
index 687b3d89b40d..d8cc53cd9560 100644
--- a/arch/x86/entry/vdso/common/Makefile.include
+++ b/arch/x86/entry/vdso/common/Makefile.include
@@ -27,7 +27,7 @@ flags-remove-y += \
 	-mfentry -pg \
 	$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 	$(RETPOLINE_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
-	$(PADDING_CFLAGS)
+	$(PADDING_CFLAGS) $(PINPOINT_PLUGIN_CFLAGS)
 
 #
 # Don't omit frame pointers for ease of userspace debugging, but do
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2438b89a4620..9c2a18fb2098 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -206,6 +206,41 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+#ifdef CONFIG_SPSLR
+		__spslr_start = .;
+
+		. = ALIGN(8);
+		__start_spslr_targets = .;
+		KEEP(*(spslr_targets))
+		__stop_spslr_targets = .;
+
+		. = ALIGN(8);
+		__start_spslr_target_refs = .;
+		KEEP(*(spslr_target_refs))
+		__stop_spslr_target_refs = .;
+
+		. = ALIGN(8);
+		__start_spslr_ipins = .;
+		KEEP(*(spslr_ipins))
+		__stop_spslr_ipins = .;
+
+		. = ALIGN(8);
+		__start_spslr_dpins = .;
+		KEEP(*(spslr_dpins))
+		__stop_spslr_dpins = .;
+
+		. = ALIGN(8);
+		__start_spslr_rpins = .;
+		KEEP(*(spslr_rpins))
+		__stop_spslr_rpins = .;
+
+		. = ALIGN(8);
+		KEEP(*(spslr_strtab))
+		KEEP(*(spslr_target_layouts))
+
+		__spslr_end = .;
+#endif
+
 		/* End of data section */
 		_edata = .;
 	} :data
@@ -222,6 +257,13 @@ SECTIONS
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
 
+#ifdef CONFIG_SPSLR
+	. = ALIGN(PAGE_SIZE);
+	.spslr.calc.text : AT(ADDR(.spslr.calc.text) - LOAD_OFFSET) {
+		KEEP(*(.spslr.calc.text))
+	}
+#endif
+
 	/*
 	 * Section for code used exclusively before alternatives are run. All
 	 * references to such code must be patched out by alternatives, normally
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..2ee25f708b94 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -465,19 +465,34 @@ struct ftrace_likely_data {
 # define __latent_entropy
 #endif
 
+#if defined(__SPSLR__)
+# define __randomize_layout_spslr __attribute__((spslr))
+# define __no_randomize_layout_spslr __attribute__((no_spslr))
+# define randomized_struct_fields_start_spslr	struct {
+# define randomized_struct_fields_end_spslr	} __randomize_layout_spslr;
+#else
+# define __randomize_layout_spslr
+# define __no_randomize_layout_spslr
+# define randomized_struct_fields_start_spslr
+# define randomized_struct_fields_end_spslr
+#endif
+
 #if defined(RANDSTRUCT) && !defined(__CHECKER__)
-# define __randomize_layout __designated_init __attribute__((randomize_layout))
-# define __no_randomize_layout __attribute__((no_randomize_layout))
+# define __randomize_layout_randstruct __designated_init __attribute__((randomize_layout))
+# define __no_randomize_layout_randstruct __attribute__((no_randomize_layout))
 /* This anon struct can add padding, so only enable it under randstruct. */
-# define randomized_struct_fields_start	struct {
-# define randomized_struct_fields_end	} __randomize_layout;
+# define randomized_struct_fields_start_randstruct	struct {
+# define randomized_struct_fields_end_randstruct	} __randomize_layout_randstruct;
 #else
-# define __randomize_layout __designated_init
-# define __no_randomize_layout
-# define randomized_struct_fields_start
-# define randomized_struct_fields_end
+# define __randomize_layout_randstruct __designated_init
+# define __no_randomize_layout_randstruct
+# define randomized_struct_fields_start_randstruct
+# define randomized_struct_fields_end_randstruct
 #endif
 
+#define __randomize_layout __randomize_layout_randstruct __randomize_layout_spslr
+#define __no_randomize_layout __no_randomize_layout_randstruct __no_randomize_layout_spslr
+
 #ifndef __no_kstack_erase
 # define __no_kstack_erase
 #endif
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..5fd92050118b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -324,20 +324,32 @@ enum mod_mem_type {
 	MOD_INIT_DATA,
 	MOD_INIT_RODATA,
 
+#ifdef CONFIG_SPSLR
+	MOD_SPSLR_TEXT,
+#endif
+
 	MOD_MEM_NUM_TYPES,
 	MOD_INVALID = -1,
 };
 
+#ifdef CONFIG_SPSLR
+# define mod_mem_type_is_spslr_text(type) ((type) == MOD_SPSLR_TEXT)
+#else
+# define mod_mem_type_is_spslr_text(type) (false)
+#endif
+
 #define mod_mem_type_is_init(type)	\
 	((type) == MOD_INIT_TEXT ||	\
 	 (type) == MOD_INIT_DATA ||	\
-	 (type) == MOD_INIT_RODATA)
+	 (type) == MOD_INIT_RODATA ||	\
+	 mod_mem_type_is_spslr_text(type))
 
 #define mod_mem_type_is_core(type) (!mod_mem_type_is_init(type))
 
 #define mod_mem_type_is_text(type)	\
 	 ((type) == MOD_TEXT ||		\
-	  (type) == MOD_INIT_TEXT)
+	  (type) == MOD_INIT_TEXT ||	\
+	  mod_mem_type_is_spslr_text(type))
 
 #define mod_mem_type_is_data(type) (!mod_mem_type_is_text(type))
 
@@ -577,7 +589,7 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
-} ____cacheline_aligned __randomize_layout;
+} ____cacheline_aligned __randomize_layout_randstruct;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
 #endif
diff --git a/include/linux/spslr.h b/include/linux/spslr.h
new file mode 100644
index 000000000000..768be677aacb
--- /dev/null
+++ b/include/linux/spslr.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef SPSLR_SELFPATCH_H
+#define SPSLR_SELFPATCH_H
+
+#ifdef CONFIG_SPSLR
+
+#include <linux/types.h>
+
+extern bool spslr_enabled;
+
+#define SPSLR_START_TARGET_REFS_SYM __start_spslr_target_refs
+#define SPSLR_STOP_TARGET_REFS_SYM __stop_spslr_target_refs
+#define SPSLR_START_IPINS_SYM __start_spslr_ipins
+#define SPSLR_STOP_IPINS_SYM __stop_spslr_ipins
+#define SPSLR_START_DPINS_SYM __start_spslr_dpins
+#define SPSLR_STOP_DPINS_SYM __stop_spslr_dpins
+#define SPSLR_START_RPINS_SYM __start_spslr_rpins
+#define SPSLR_STOP_RPINS_SYM __stop_spslr_rpins
+
+enum spslr_viability { SPSLR_VIABLE, SPSLR_NONVIABLE };
+
+enum spslr_error {
+	SPSLR_OK,
+	SPSLR_ERROR_INCOMPLETE_CTX,
+	SPSLR_ERROR_INCOMPATIBLE_CTX,
+	SPSLR_ERROR_RANDOMIZE,
+	SPSLR_ERROR_MEMORY,
+	SPSLR_ERROR_UNINITIALIZED,
+	SPSLR_ERROR_ALREADY_PATCHED,
+	SPSLR_ERROR_PATCH_RPINS,
+	SPSLR_ERROR_PATCH_DPINS,
+	SPSLR_ERROR_PATCH_IPINS,
+};
+
+struct spslr_status {
+	enum spslr_viability viability;
+	enum spslr_error error;
+};
+
+struct spslr_entry {
+	void *start_target_refs; // Address of SPSLR_START_TARGET_REFS_SYM
+	void *stop_target_refs; // Address of SPSLR_STOP_TARGET_REFS_SYM
+	const void *start_ipins; // Address of SPSLR_START_IPINS_SYM
+	const void *stop_ipins; // Address of SPSLR_STOP_IPINS_SYM
+	const void *start_dpins; // Address of SPSLR_START_DPINS_SYM
+	const void *stop_dpins; // Address of SPSLR_STOP_DPINS_SYM
+	const void *start_rpins; // Address of SPSLR_START_RPINS_SYM
+	const void *stop_rpins; // Address of SPSLR_STOP_RPINS_SYM
+};
+
+struct spslr_ctx {
+	struct spslr_entry entry;
+	void *workspace; // Temporary buffer of spslr_workspace_size(&entry) bytes
+};
+
+/*
+ * Runtime entry points are intentionally split:
+ *
+ * spslr_init() creates randomized layouts.
+ * spslr_selfpatch() patches the main executable.
+ * spslr_patch_module() patches with module-local metadata using host layouts.
+ */
+
+struct spslr_status spslr_init(void);
+struct spslr_status spslr_selfpatch(void);
+unsigned long spslr_workspace_size(const struct spslr_entry *entry);
+struct spslr_status spslr_patch_module(const struct spslr_ctx *m);
+
+#endif
+
+#endif
diff --git a/init/main.c b/init/main.c
index 31f2bf54976a..569fd96f6112 100644
--- a/init/main.c
+++ b/init/main.c
@@ -120,6 +120,21 @@
 
 #include <kunit/test.h>
 
+#include <linux/spslr.h>
+
+#ifdef CONFIG_SPSLR
+
+bool spslr_enabled __ro_after_init = true;
+
+static int __init nospslr_setup(char *str)
+{
+	spslr_enabled = false;
+	return 0;
+}
+early_param("nospslr", nospslr_setup);
+
+#endif
+
 static int kernel_init(void *);
 
 /*
@@ -1038,6 +1053,30 @@ void start_kernel(void)
 	/* Architectural and non-timekeeping rng init, before allocator init */
 	random_init_early(command_line);
 
+#ifdef CONFIG_SPSLR
+	if (spslr_enabled) {
+		/* Randomize structure layouts */
+		u64 bench_start, bench_stop;
+
+		bench_start = local_clock();
+
+		struct spslr_status spslr_init_status = spslr_init();
+		if (spslr_init_status.error != SPSLR_OK)
+			panic("SPSLR initialization failed");
+
+		struct spslr_status spslr_selfpatch_status = spslr_selfpatch();
+		if (spslr_selfpatch_status.error != SPSLR_OK)
+			panic("SPSLR selfpatch failed");
+
+		bench_stop = local_clock();
+
+		pr_notice("Successfully applied SPSLR (%llu ns)\n",
+			(unsigned long long)(bench_stop - bench_start));
+	} else {
+		pr_notice("SPSLR disabled\n");
+	}
+#endif
+
 	/*
 	 * These use large bootmem allocations and must precede
 	 * initalization of page allocator
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..cddfbff9f9f0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -142,6 +142,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_SPSLR) += spslr/
+
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..b8438a1aab0f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -336,6 +336,12 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
+#ifdef CONFIG_SPSLR
+
+int module_enable_spslr_text_rox(const struct module *mod);
+
+#endif
+
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
 #else /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c1b34dc1e89a..48c4bb7eb28a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -66,6 +66,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
+#include <linux/spslr.h>
+
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable within RCU read section),
@@ -1742,6 +1744,41 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 	}
 }
 
+#ifdef CONFIG_SPSLR
+
+#define SPSLR_CALC_TEXT_SECTION ".spslr.calc.text"
+
+static void layout_spslr_sections(struct module *mod,
+				  struct load_info *info)
+{
+	unsigned int i;
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		Elf_Shdr *s = &info->sechdrs[i];
+		const char *sname = info->secstrings + s->sh_name;
+
+		if (strcmp(sname, SPSLR_CALC_TEXT_SECTION) != 0)
+			continue;
+
+		if (!(s->sh_flags & SHF_ALLOC) ||
+		    !(s->sh_flags & SHF_EXECINSTR) ||
+		    (s->sh_flags & SHF_WRITE)) {
+			pr_err("%s: invalid flags %#llx on %s\n",
+			       mod->name,
+			       (unsigned long long)s->sh_flags,
+			       sname);
+			continue;
+		}
+
+		s->sh_entsize = module_get_offset_and_type(
+			mod, MOD_SPSLR_TEXT, s, i);
+
+		pr_debug("\t%s\n", sname);
+	}
+}
+
+#endif
+
 /*
  * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
  * might -- code, read-only data, read-write data, small data.  Tally
@@ -1755,6 +1792,12 @@ static void layout_sections(struct module *mod, struct load_info *info)
 	for (i = 0; i < info->hdr->e_shnum; i++)
 		info->sechdrs[i].sh_entsize = ~0UL;
 
+#ifdef CONFIG_SPSLR
+	pr_debug("SPSLR calculator section allocation order for %s:\n",
+		 mod->name);
+	layout_spslr_sections(mod, info);
+#endif
+
 	pr_debug("Core section allocation order for %s:\n", mod->name);
 	__layout_sections(mod, info, false);
 
@@ -3048,6 +3091,9 @@ struct mod_initfree {
 	void *init_text;
 	void *init_data;
 	void *init_rodata;
+#ifdef CONFIG_SPSLR
+	void *spslr_text;
+#endif
 };
 
 static void do_free_init(struct work_struct *w)
@@ -3064,6 +3110,9 @@ static void do_free_init(struct work_struct *w)
 		execmem_free(initfree->init_text);
 		execmem_free(initfree->init_data);
 		execmem_free(initfree->init_rodata);
+#ifdef CONFIG_SPSLR
+		execmem_free(initfree->spslr_text);
+#endif
 		kfree(initfree);
 	}
 }
@@ -3096,7 +3145,7 @@ static noinline int do_init_module(struct module *mod)
 		const struct module_memory *mod_mem = &mod->mem[type];
 		if (mod_mem->size) {
 			total_size += mod_mem->size;
-			if (type == MOD_TEXT || type == MOD_INIT_TEXT)
+			if (mod_mem_type_is_text(type))
 				text_size += mod_mem->size;
 		}
 	}
@@ -3110,11 +3159,15 @@ static noinline int do_init_module(struct module *mod)
 	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
 	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
 	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
+#ifdef CONFIG_SPSLR
+	freeinit->spslr_text = mod->mem[MOD_SPSLR_TEXT].base;
+#endif
 
 	do_mod_ctors(mod);
 	/* Start the module */
 	if (mod->init != NULL)
 		ret = do_one_initcall(mod->init);
+
 	if (ret < 0) {
 		/*
 		 * -EEXIST is reserved by [f]init_module() to signal to userspace that
@@ -3426,6 +3479,127 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+#ifdef CONFIG_SPSLR
+
+static void spslr_flush_module_calculators(const struct module *mod)
+{
+	const struct module_memory *mem =
+		&mod->mem[MOD_SPSLR_TEXT];
+
+	if (!mem->base || !mem->size)
+		return;
+
+	flush_icache_range((unsigned long)mem->base,
+			   (unsigned long)mem->base + mem->size);
+}
+
+/* Find spslr symbol in module without kallsym */
+static unsigned long spslr_find_module_symbol(const struct load_info *info,
+					      const char *name)
+{
+	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
+	Elf_Sym *sym = (void *)symsec->sh_addr;
+	unsigned int i, n = symsec->sh_size / sizeof(*sym);
+
+	for (i = 1; i < n; i++) {
+		const char *symname = info->strtab + sym[i].st_name;
+
+		if (strcmp(symname, name) != 0)
+			continue;
+
+		/* Ignore undefined symbols just in case. */
+		if (sym[i].st_shndx == SHN_UNDEF)
+			return 0;
+
+		return (unsigned long)sym[i].st_value;
+	}
+
+	return 0;
+}
+
+/* Apply structure layout randomization to module */
+static int __maybe_unused spslr_prepare_module(struct module *mod,
+					       const struct load_info *info)
+{
+	struct spslr_ctx ctx = { };
+	struct spslr_status st;
+	unsigned long workspace_size;
+	int err = 0;
+
+	ctx.entry.start_target_refs = (void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_START_TARGET_REFS_SYM));
+	if (!ctx.entry.start_target_refs) {
+		pr_err("%s: SPSLR target refs start symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.stop_target_refs = (void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_STOP_TARGET_REFS_SYM));
+	if (!ctx.entry.stop_target_refs) {
+		pr_err("%s: SPSLR target refs stop symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.start_ipins = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_START_IPINS_SYM));
+	if (!ctx.entry.start_ipins) {
+		pr_err("%s: SPSLR ipins start symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.stop_ipins = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_STOP_IPINS_SYM));
+	if (!ctx.entry.stop_ipins) {
+		pr_err("%s: SPSLR ipins stop symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.start_dpins = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_START_DPINS_SYM));
+	if (!ctx.entry.start_dpins) {
+		pr_err("%s: SPSLR dpins start symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.stop_dpins = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_STOP_DPINS_SYM));
+	if (!ctx.entry.stop_dpins) {
+		pr_err("%s: SPSLR dpins stop symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.start_rpins = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_START_RPINS_SYM));
+	if (!ctx.entry.start_rpins) {
+		pr_err("%s: SPSLR rpins start symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.stop_rpins = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_STOP_RPINS_SYM));
+	if (!ctx.entry.stop_rpins) {
+		pr_err("%s: SPSLR rpins stop symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	workspace_size = spslr_workspace_size(&ctx.entry);
+	ctx.workspace = kvmalloc(workspace_size, GFP_KERNEL);
+	if (!ctx.workspace)
+		return -ENOMEM;
+
+	st = spslr_patch_module(&ctx);
+	if (st.viability != SPSLR_VIABLE || st.error != SPSLR_OK) {
+		pr_err("%s: SPSLR patch failed: viability=%d error=%d\n",
+		       mod->name, st.viability, st.error);
+		err = -ENOEXEC;
+	}
+
+	kvfree(ctx.workspace);
+	return err;
+}
+
+#endif /* CONFIG_SPSLR */
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -3531,6 +3705,24 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto free_modinfo;
 
+#ifdef CONFIG_SPSLR
+	if (spslr_enabled) {
+		spslr_flush_module_calculators(mod);
+
+		err = module_enable_spslr_text_rox(mod);
+		if (err) {
+			pr_err("%s: failed to enable SPSLR calculator text: %ld\n",
+			       mod->name, err);
+			goto free_modinfo;
+		}
+
+		/* SPSLR must happen after relocation and icache should be flushed afterwards */
+		err = spslr_prepare_module(mod, info);
+		if (err < 0)
+			goto free_modinfo;
+	}
+#endif
+
 	flush_module_icache(mod);
 
 	/* Now copy in args */
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 8fd438529fbc..5e8de8add1d1 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -149,3 +149,26 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 		}
 	}
 }
+
+#ifdef CONFIG_SPSLR
+
+int module_enable_spslr_text_rox(const struct module *mod)
+{
+	const struct module_memory *mem =
+		&mod->mem[MOD_SPSLR_TEXT];
+
+	if (!mem->base || !mem->size)
+		return 0;
+
+	if (mem->is_rox)
+		return execmem_restore_rox(mem->base, mem->size);
+
+	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return module_set_memory(
+			mod, MOD_SPSLR_TEXT, set_memory_rox);
+
+	return module_set_memory(
+		mod, MOD_SPSLR_TEXT, set_memory_x);
+}
+
+#endif
diff --git a/kernel/spslr/Makefile b/kernel/spslr/Makefile
new file mode 100644
index 000000000000..5a8664392b1b
--- /dev/null
+++ b/kernel/spslr/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_SPSLR) += spslr.o spslr_env.o spslr_randomizer.o
+
+CFLAGS_REMOVE_spslr.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_spslr_env.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_spslr_randomizer.o += $(PINPOINT_PLUGIN_CFLAGS)
diff --git a/kernel/spslr/pinpoint.h b/kernel/spslr/pinpoint.h
new file mode 100644
index 000000000000..78a63fcda3ca
--- /dev/null
+++ b/kernel/spslr/pinpoint.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef SPSLR_PINPOINT_H
+#define SPSLR_PINPOINT_H
+
+#include "spslr_env.h"
+
+struct spslr_target;
+struct spslr_target_ref;
+struct spslr_target_layout;
+struct spslr_target_field;
+
+typedef int (*spslr_offset_getter)(const void *target_ref,
+				   spslr_u64 field_index, spslr_u64 *offset);
+
+typedef int (*spslr_ipin_calculator)(spslr_offset_getter get_offset,
+				     spslr_u64 *result);
+
+typedef int (*spslr_rpin_refresher)(spslr_offset_getter get_offset);
+
+struct spslr_ipin {
+	void *addr;
+	spslr_u64 size;
+	spslr_ipin_calculator calculate;
+} __packed;
+
+struct spslr_dpin {
+	void *addr;
+	const struct spslr_target_ref *target_ref;
+} __packed;
+
+struct spslr_rpin {
+	void *addr;
+	spslr_u64 size;
+	spslr_rpin_refresher refresh;
+} __packed;
+
+struct spslr_target {
+	const char *hash; /* hex cstr */
+	const char *name;
+	const struct spslr_target_layout *layout;
+} __packed;
+
+struct spslr_target_ref {
+	const struct spslr_target *target;
+} __packed;
+
+/* Physical layout of a target type. */
+struct spslr_target_layout {
+	spslr_u64 size;
+	spslr_u64 field_cnt;
+	const struct spslr_target_field *fields;
+} __packed;
+
+struct spslr_target_field {
+	const char *name;
+	spslr_u64 size;
+	spslr_u64 offset;
+	spslr_u64 alignment;
+} __packed;
+
+#endif
diff --git a/kernel/spslr/spslr.c b/kernel/spslr/spslr.c
new file mode 100644
index 000000000000..25dfbf4b15ff
--- /dev/null
+++ b/kernel/spslr/spslr.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/spslr.h>
+#include <linux/irqflags.h>
+#include <asm/sync_core.h>
+
+#include "spslr_randomizer.h"
+#include "spslr_env.h"
+#include "pinpoint.h"
+
+/*
+ * Runtime portion of SPSLR.
+ *
+ * This code consumes the metadata emitted by pinpoint, randomizes target
+ * layouts, rewrites static data objects, and patches instruction immediates.
+ */
+
+static struct spslr_status spslr_patch(const struct spslr_ctx *ctx, int mod);
+static void *workspace_reorder_buffer(void *workspace);
+
+static int spslr_patch_rpins(const struct spslr_rpin *begin,
+			     const struct spslr_rpin *end);
+static int spslr_patch_dpins(const struct spslr_dpin *begin,
+			     const struct spslr_dpin *end,
+			     void *reorder_buffer);
+static int spslr_patch_dpin(void *addr, const struct spslr_target *target,
+			    void *reorder_buffer);
+static int spslr_patch_ipins(const struct spslr_ipin *begin,
+			     const struct spslr_ipin *end);
+
+static int reorder_object(void *dst, const void *src,
+			  const struct spslr_target *target);
+static const struct spslr_target *
+spslr_host_target(const struct spslr_target *t);
+
+static void spslr_memset(void *dst, int v, spslr_u64 n);
+static void spslr_memcpy(void *dst, const void *src, spslr_u64 n);
+
+static int spslr_allocate_runtime_layouts(void);
+static spslr_u64 *spslr_runtime_offsets(const struct spslr_target *target);
+static int spslr_runtime_offset(const struct spslr_target *target,
+				spslr_u64 fidx, spslr_u64 *off);
+
+static int spslr_runtime_offset_getter(const void *opaque_target_ref,
+				       spslr_u64 field_index, spslr_u64 *off);
+
+static int initialized = 0, patched = 0;
+static enum spslr_viability viable = SPSLR_VIABLE;
+
+struct spslr_runtime_layout {
+	spslr_u64 *offsets;
+};
+
+static struct spslr_runtime_layout *spslr_runtime_layouts;
+
+/* Host image spslr metadata entry point */
+
+#define SPSLR_START_TARGETS_SYM __start_spslr_targets
+#define SPSLR_STOP_TARGETS_SYM __stop_spslr_targets
+
+extern const struct spslr_target SPSLR_START_TARGETS_SYM[];
+extern const struct spslr_target SPSLR_STOP_TARGETS_SYM[];
+extern struct spslr_target_ref SPSLR_START_TARGET_REFS_SYM[];
+extern struct spslr_target_ref SPSLR_STOP_TARGET_REFS_SYM[];
+extern const struct spslr_ipin SPSLR_START_IPINS_SYM[];
+extern const struct spslr_ipin SPSLR_STOP_IPINS_SYM[];
+extern const struct spslr_dpin SPSLR_START_DPINS_SYM[];
+extern const struct spslr_dpin SPSLR_STOP_DPINS_SYM[];
+extern const struct spslr_rpin SPSLR_START_RPINS_SYM[];
+extern const struct spslr_rpin SPSLR_STOP_RPINS_SYM[];
+
+#define FOREACH_TARGET(it)                                            \
+	for (const struct spslr_target *it = SPSLR_START_TARGETS_SYM; \
+	     it != SPSLR_STOP_TARGETS_SYM; it++)
+
+static void spslr_memset(void *dst, int v, spslr_u64 n)
+{
+	unsigned char *d = (unsigned char *)dst;
+
+	for (spslr_u64 i = 0; i < n; i++)
+		d[i] = (unsigned char)v;
+}
+
+static void spslr_memcpy(void *dst, const void *src, spslr_u64 n)
+{
+	unsigned char *d = (unsigned char *)dst;
+	unsigned char *s = (unsigned char *)src;
+
+	for (spslr_u64 i = 0; i < n; i++)
+		d[i] = s[i];
+}
+
+static int __init spslr_allocate_runtime_layouts(void)
+{
+	spslr_u64 target_count =
+		SPSLR_STOP_TARGETS_SYM - SPSLR_START_TARGETS_SYM;
+
+	spslr_runtime_layouts = spslr_env_early_malloc(
+		target_count * sizeof(struct spslr_runtime_layout));
+	if (!spslr_runtime_layouts)
+		return -1;
+
+	for (spslr_u64 i = 0; i < target_count; ++i) {
+		const struct spslr_target *target = &SPSLR_START_TARGETS_SYM[i];
+		spslr_u64 bytes = target->layout->field_cnt * sizeof(spslr_u64);
+
+		spslr_runtime_layouts[i].offsets =
+			spslr_env_early_malloc(bytes);
+		if (!spslr_runtime_layouts[i].offsets)
+			return -1;
+	}
+
+	return 0;
+}
+
+static spslr_u64 *spslr_runtime_offsets(const struct spslr_target *target)
+{
+	if (!spslr_runtime_layouts || !target)
+		return NULL;
+
+	if (target < SPSLR_START_TARGETS_SYM ||
+	    target >= SPSLR_STOP_TARGETS_SYM)
+		return NULL;
+
+	spslr_u64 idx = target - SPSLR_START_TARGETS_SYM;
+	return spslr_runtime_layouts[idx].offsets;
+}
+
+static int spslr_runtime_offset(const struct spslr_target *target,
+				spslr_u64 fidx, spslr_u64 *off)
+{
+	if (!off || !target || fidx >= target->layout->field_cnt)
+		return -1;
+
+	/* NOTE: This function should check if the current task is actually in
+	   the process of patching. Potential task_struct fields for this should
+	   reside outside the randomized area. */
+
+	const spslr_u64 *toffsets = spslr_runtime_offsets(target);
+	if (!toffsets)
+		return -1;
+
+	*off = toffsets[fidx];
+	return 0;
+}
+
+/* The callback invoked by the calculator and refresh functions. */
+static int spslr_runtime_offset_getter(const void *opaque_target_ref,
+				       spslr_u64 field_index, spslr_u64 *off)
+{
+	const struct spslr_target_ref *target_ref =
+		(const struct spslr_target_ref *)opaque_target_ref;
+
+	if (!target_ref || !target_ref->target || !off)
+		return -1;
+
+	return spslr_runtime_offset(target_ref->target, field_index, off);
+}
+
+/*
+ * Initialize runtime randomization state.
+ *
+ * After this point target layouts are randomized, but code/data does still
+ * contain original-layout offsets until the patching entry points run.
+ */
+
+struct spslr_status __init spslr_init(void)
+{
+	if (initialized)
+		return (struct spslr_status){ .viability = viable,
+					      .error = SPSLR_OK };
+
+	if (spslr_allocate_runtime_layouts() != 0)
+		return (struct spslr_status){ .viability = viable,
+					      .error = SPSLR_ERROR_MEMORY };
+
+	FOREACH_TARGET(target)
+	{
+		if (spslr_randomize(target, spslr_runtime_offsets(target)) < 0)
+			return (struct spslr_status){
+				.viability = viable,
+				.error = SPSLR_ERROR_RANDOMIZE
+			};
+	}
+
+	initialized = 1;
+	return (struct spslr_status){ .viability = viable, .error = SPSLR_OK };
+}
+
+/*
+ * Calculate required workspace buffer size. This currently only effects
+ * the reorder buffer for dpins.
+ */
+
+unsigned long spslr_workspace_size(const struct spslr_entry *entry)
+{
+	if (!entry || !entry->start_dpins || !entry->stop_dpins)
+		return 0;
+
+	const struct spslr_dpin *start_dpins =
+		(const struct spslr_dpin *)entry->start_dpins;
+	const struct spslr_dpin *stop_dpins =
+		(const struct spslr_dpin *)entry->stop_dpins;
+
+	spslr_u64 max_dpin_size = 0;
+	for (const struct spslr_dpin *dpin = start_dpins; dpin != stop_dpins;
+	     dpin++) {
+		spslr_u64 target_size = dpin->target_ref->target->layout->size;
+		if (target_size > max_dpin_size)
+			max_dpin_size = target_size;
+	}
+
+	return max_dpin_size;
+}
+
+static int spslr_target_hash_eq(const char *a, const char *b)
+{
+	if (!a || !b)
+		return 0;
+
+	/* Pinpoint is expected to produce lower-case hex strings, so
+	   this boils down to string equivalence. */
+	char ca, cb;
+	while ((ca = *a++, cb = *b++) && ca && cb && ca == cb)
+		;
+
+	return ca == cb;
+}
+
+static const struct spslr_target *
+spslr_host_target(const struct spslr_target *t)
+{
+	FOREACH_TARGET(ht)
+	{
+		if (spslr_target_hash_eq(t->hash, ht->hash))
+			return ht;
+	}
+
+	return NULL;
+}
+
+static void *workspace_reorder_buffer(void *workspace)
+{
+	return workspace;
+}
+
+static struct spslr_status spslr_patch(const struct spslr_ctx *ctx, int mod)
+{
+	enum spslr_error err = SPSLR_OK;
+	enum spslr_viability via = SPSLR_VIABLE;
+
+	void *reorder_buffer = NULL;
+
+	struct spslr_target_ref *start_target_refs = NULL;
+	struct spslr_target_ref *stop_target_refs = NULL;
+	const struct spslr_ipin *start_ipins = NULL;
+	const struct spslr_ipin *stop_ipins = NULL;
+	const struct spslr_dpin *start_dpins = NULL;
+	const struct spslr_dpin *stop_dpins = NULL;
+	const struct spslr_rpin *start_rpins = NULL;
+	const struct spslr_rpin *stop_rpins = NULL;
+
+	if (!ctx || !ctx->entry.start_target_refs ||
+	    !ctx->entry.stop_target_refs || !ctx->entry.start_ipins ||
+	    !ctx->entry.stop_ipins || !ctx->entry.start_dpins ||
+	    !ctx->entry.stop_dpins || !ctx->entry.start_rpins ||
+	    !ctx->entry.stop_rpins || !ctx->workspace) {
+		err = SPSLR_ERROR_INCOMPLETE_CTX;
+		goto finish;
+	}
+
+	start_target_refs =
+		(struct spslr_target_ref *)ctx->entry.start_target_refs;
+	stop_target_refs =
+		(struct spslr_target_ref *)ctx->entry.stop_target_refs;
+	start_ipins = (const struct spslr_ipin *)ctx->entry.start_ipins;
+	stop_ipins = (const struct spslr_ipin *)ctx->entry.stop_ipins;
+	start_dpins = (const struct spslr_dpin *)ctx->entry.start_dpins;
+	stop_dpins = (const struct spslr_dpin *)ctx->entry.stop_dpins;
+	start_rpins = (const struct spslr_rpin *)ctx->entry.start_rpins;
+	stop_rpins = (const struct spslr_rpin *)ctx->entry.stop_rpins;
+
+	if (mod) {
+		for (struct spslr_target_ref *r = start_target_refs;
+		     r != stop_target_refs; r++) {
+			const struct spslr_target *mod_target = r->target;
+			const struct spslr_target *host_target;
+
+			host_target = spslr_host_target(mod_target);
+			if (!host_target) {
+				err = SPSLR_ERROR_INCOMPATIBLE_CTX;
+				goto finish;
+			}
+
+			/* Redirect module target refs to host targets. */
+			r->target = host_target;
+		}
+	}
+
+	reorder_buffer = workspace_reorder_buffer(ctx->workspace);
+	via = SPSLR_NONVIABLE;
+
+	/* Patch order is: rpins, dpins, ipins. */
+
+	if (spslr_patch_rpins(start_rpins, stop_rpins) < 0) {
+		err = SPSLR_ERROR_PATCH_RPINS;
+		goto finish;
+	}
+
+	if (spslr_patch_dpins(start_dpins, stop_dpins, reorder_buffer) < 0) {
+		err = SPSLR_ERROR_PATCH_DPINS;
+		goto finish;
+	}
+
+	if (spslr_patch_ipins(start_ipins, stop_ipins) < 0) {
+		err = SPSLR_ERROR_PATCH_IPINS;
+		goto finish;
+	}
+
+	via = SPSLR_VIABLE;
+finish:
+	return (struct spslr_status){ .viability = via, .error = err };
+}
+
+/* Public entrypoint for patching the host image. */
+struct spslr_status __init spslr_selfpatch(void)
+{
+	enum spslr_error err = SPSLR_OK;
+
+	spslr_u64 host_workspace_size;
+
+	struct spslr_ctx host_ctx;
+	host_ctx.entry.start_target_refs = SPSLR_START_TARGET_REFS_SYM;
+	host_ctx.entry.stop_target_refs = SPSLR_STOP_TARGET_REFS_SYM;
+	host_ctx.entry.start_ipins = SPSLR_START_IPINS_SYM;
+	host_ctx.entry.stop_ipins = SPSLR_STOP_IPINS_SYM;
+	host_ctx.entry.start_dpins = SPSLR_START_DPINS_SYM;
+	host_ctx.entry.stop_dpins = SPSLR_STOP_DPINS_SYM;
+	host_ctx.entry.start_rpins = SPSLR_START_RPINS_SYM;
+	host_ctx.entry.stop_rpins = SPSLR_STOP_RPINS_SYM;
+	host_ctx.workspace = NULL;
+
+	unsigned long flags;
+
+	struct spslr_status internal_patch_status;
+
+	if (patched) {
+		err = SPSLR_ERROR_ALREADY_PATCHED;
+		goto finish;
+	}
+
+	if (!initialized) {
+		err = SPSLR_ERROR_UNINITIALIZED;
+		goto finish;
+	}
+
+	host_workspace_size = spslr_workspace_size(&host_ctx.entry);
+	host_ctx.workspace = spslr_env_early_malloc(host_workspace_size);
+
+	if (!host_ctx.workspace) {
+		err = SPSLR_ERROR_MEMORY;
+		goto finish;
+	}
+
+	local_irq_save(flags);
+
+	internal_patch_status = spslr_patch(&host_ctx, 0);
+	if (internal_patch_status.error == SPSLR_OK)
+		patched = 1;
+
+	sync_core();
+	local_irq_restore(flags);
+
+	viable = internal_patch_status.viability;
+	err = internal_patch_status.error;
+
+finish:
+	if (host_ctx.workspace)
+		spslr_env_early_free(host_ctx.workspace, host_workspace_size);
+
+	return (struct spslr_status){ .viability = viable, .error = err };
+}
+
+/* Public entrypoint for patching a modular image. Reuses the target
+   randomization state owned by the main executable. */
+struct spslr_status spslr_patch_module(const struct spslr_ctx *m)
+{
+	if (!initialized)
+		return (struct spslr_status){
+			.viability = SPSLR_VIABLE,
+			.error = SPSLR_ERROR_UNINITIALIZED
+		};
+
+	struct spslr_status s = spslr_patch(m, 1);
+
+	/* Even if a module state may still be viable in itself, it can not
+	   safely be used on a randomized host if the patching is incomplete. */
+	if (s.error != SPSLR_OK)
+		s.viability = SPSLR_NONVIABLE;
+
+	return s;
+}
+
+/*
+ * Rewrite one object instance from original layout into randomized layout.
+ *
+ * A temporary buffer is used so overlapping source/destination field ranges do
+ * not corrupt data while fields are moved.
+ */
+
+static int reorder_object(void *dst, const void *src,
+			  const struct spslr_target *target)
+{
+	if (!dst || !src || !target || !target->layout ||
+	    !target->layout->fields)
+		return -1;
+
+	const struct spslr_target_layout *layout = target->layout;
+
+	const spslr_u8 *source = (const spslr_u8 *)src;
+	spslr_u8 *destination = (spslr_u8 *)dst;
+
+	for (spslr_u64 i = 0; i < layout->field_cnt; ++i) {
+		const struct spslr_target_field *field = &layout->fields[i];
+
+		spslr_u64 initial_offset = field->offset;
+		spslr_u64 runtime_offset = 0;
+
+		if (spslr_runtime_offset(target, i, &runtime_offset) != 0)
+			return -1;
+
+		if (initial_offset > layout->size ||
+		    field->size > layout->size - initial_offset)
+			return -1;
+
+		if (runtime_offset > layout->size ||
+		    field->size > layout->size - runtime_offset)
+			return -1;
+
+		spslr_memcpy(destination + runtime_offset,
+			     source + initial_offset, field->size);
+	}
+
+	return 0;
+}
+
+/* Apply data refresh pin patches. */
+
+static int spslr_patch_rpins(const struct spslr_rpin *begin,
+			     const struct spslr_rpin *end)
+{
+	for (const struct spslr_rpin *pin = begin; pin != end; pin++) {
+		if (!pin->addr || pin->size == 0 || !pin->refresh)
+			return -1;
+
+		int fail_flag = 0;
+
+		int pending_prot_pop =
+			spslr_env_push_writable(pin->addr, pin->size);
+		if (pending_prot_pop < 0)
+			return -1;
+
+		fail_flag = pin->refresh(spslr_runtime_offset_getter);
+
+		if (pending_prot_pop &&
+		    spslr_env_pop_writable(pin->addr, pin->size) < 0)
+			return -1;
+
+		if (fail_flag != 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Apply data pin patches.
+ *
+ * Each pin's address already points at an existing object in original layout. Patching
+ * converts that storage in-place to the target's randomized layout.
+ */
+
+static int spslr_patch_dpins(const struct spslr_dpin *begin,
+			     const struct spslr_dpin *end, void *reorder_buffer)
+{
+	for (const struct spslr_dpin *dpin = begin; dpin != end; dpin++) {
+		if (!dpin->target_ref)
+			return -1;
+
+		if (spslr_patch_dpin(dpin->addr, dpin->target_ref->target,
+				     reorder_buffer) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int spslr_patch_dpin(void *addr, const struct spslr_target *target,
+			    void *reorder_buffer)
+{
+	if (!addr || !target || !target->layout || !reorder_buffer)
+		return -1;
+
+	int res = -1;
+	int pending_prot_pop = 0;
+
+	spslr_memset(reorder_buffer, 0, target->layout->size);
+
+	if (reorder_object(reorder_buffer, addr, target) < 0)
+		goto finish;
+
+	pending_prot_pop = spslr_env_push_writable(addr, target->layout->size);
+	if (pending_prot_pop < 0)
+		goto finish;
+
+	spslr_memcpy(addr, reorder_buffer, target->layout->size);
+
+	if (pending_prot_pop &&
+	    spslr_env_pop_writable(addr, target->layout->size) < 0)
+		goto finish;
+
+	res = 0;
+finish:
+	return res;
+}
+
+static spslr_u64 spslr_ipin_value_cut(spslr_u64 value, spslr_u64 size)
+{
+	if (size >= 8)
+		return value;
+
+	spslr_u64 mask = ((spslr_u64)1 << (8 * size)) - 1;
+	return value & mask;
+}
+
+static int spslr_patch_ipins(const struct spslr_ipin *begin,
+			     const struct spslr_ipin *end)
+{
+	for (const struct spslr_ipin *ip = begin; ip != end; ip++) {
+		if (!ip->calculate)
+			return -1;
+
+		spslr_u64 value = 0;
+		if (ip->calculate(spslr_runtime_offset_getter, &value) != 0)
+			return -1;
+
+		value = spslr_ipin_value_cut(value, ip->size);
+
+		int pending_prot_pop =
+			spslr_env_push_writable(ip->addr, ip->size);
+		if (pending_prot_pop < 0)
+			return -1;
+
+		int invalid_size = 0;
+
+		switch (ip->size) {
+		case 1: {
+			spslr_u8 v = (spslr_u8)value;
+			spslr_memcpy(ip->addr, &v, sizeof(v));
+			break;
+		}
+		case 2: {
+			spslr_u16 v = (spslr_u16)value;
+			spslr_memcpy(ip->addr, &v, sizeof(v));
+			break;
+		}
+		case 4: {
+			spslr_u32 v = (spslr_u32)value;
+			spslr_memcpy(ip->addr, &v, sizeof(v));
+			break;
+		}
+		case 8: {
+			spslr_u64 v = (spslr_u64)value;
+			spslr_memcpy(ip->addr, &v, sizeof(v));
+			break;
+		}
+		default:
+			invalid_size = 1;
+		}
+
+		if (pending_prot_pop &&
+		    spslr_env_pop_writable(ip->addr, ip->size) < 0)
+			return -1;
+
+		if (invalid_size)
+			return -1;
+	}
+
+	return 0;
+}
diff --git a/kernel/spslr/spslr_env.c b/kernel/spslr/spslr_env.c
new file mode 100644
index 000000000000..7ab62a5affbb
--- /dev/null
+++ b/kernel/spslr/spslr_env.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "spslr_env.h"
+
+#include <linux/kernel.h>
+#include <linux/hex.h>
+#include <linux/random.h>
+#include <linux/memblock.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <crypto/chacha.h>
+
+/* When spslr runs, everything of interest is writable anyways. */
+int spslr_env_push_writable(void *, spslr_u64)
+{
+	return 0;
+}
+int spslr_env_pop_writable(void *, spslr_u64)
+{
+	return 0;
+}
+
+/*
+ * Hook runs before slab allocators are available.
+ * memblock_alloc() is the correct early-boot allocator.
+ */
+void *__init spslr_env_early_malloc(spslr_u64 n)
+{
+	size_t size = PAGE_ALIGN(n ? n : 1);
+	return memblock_alloc(size, SMP_CACHE_BYTES);
+}
+
+void __init spslr_env_early_free(void *ptr, spslr_u64 n)
+{
+	if (ptr)
+		memblock_free(ptr, PAGE_ALIGN(n ? n : 1));
+}
+
+static u8 spslr_key[CHACHA_KEY_SIZE] __initdata;
+static bool spslr_key_supplied __initdata;
+
+static struct chacha_state spslr_chacha;
+static u8 spslr_block[CHACHA_BLOCK_SIZE];
+static unsigned int spslr_block_pos = CHACHA_BLOCK_SIZE;
+static bool spslr_prng_initialized;
+
+/*
+ * spslr_seed=<64 hex digits>
+ */
+static int __init spslr_seed_setup(char *str)
+{
+	int len = 0;
+
+	if (!str || (len = strlen(str)) > CHACHA_KEY_SIZE * 2) {
+		pr_err("spslr: seed must be 1 to 64 hex digits\n");
+		return -EINVAL;
+	}
+
+	memset(spslr_key, 0, sizeof(spslr_key));
+
+	for (int i = 0; i < len; ++i) {
+		int v = hex_to_bin(str[len - i - 1]);
+
+		if (v < 0) {
+			pr_err("spslr: invalid hex digit in seed\n");
+			return -EINVAL;
+		}
+
+		if (i % 2)
+			v <<= 4;
+
+		spslr_key[CHACHA_KEY_SIZE - (i / 2) - 1] |= (u8)v;
+	}
+
+	spslr_key_supplied = true;
+	return 0;
+}
+early_param("spslr_seed", spslr_seed_setup);
+
+static void __init spslr_prng_init(void)
+{
+	if (spslr_prng_initialized)
+		return;
+
+	/*
+	 * No explicit seed: seed the local generator once from the
+	 * kernel RNG. Can only run after random_init_early().
+	 */
+	if (!spslr_key_supplied)
+		get_random_bytes(spslr_key, sizeof(spslr_key));
+
+	chacha_init_consts(&spslr_chacha);
+
+	memcpy(&spslr_chacha.x[4],
+	       spslr_key, CHACHA_KEY_SIZE);
+
+	/*
+	 * x[12:13] = 64-bit block counter.
+	 *
+	 * x[14:15] = fixed domain separator/nonce.
+	 *
+	 * This gives SPSLR its own deterministic ChaCha stream.
+	 */
+	spslr_chacha.x[12] = 0;
+	spslr_chacha.x[13] = 0;
+
+	spslr_chacha.x[14] = 0x4c535053; /* "SPSL", arbitrary domain */
+	spslr_chacha.x[15] = 0x474e5252; /* arbitrary fixed domain */
+
+	spslr_block_pos = CHACHA_BLOCK_SIZE;
+	spslr_prng_initialized = true;
+
+	/* Don't leave another copy of the key around. */
+	memzero_explicit(spslr_key, sizeof(spslr_key));
+
+	if (spslr_key_supplied)
+		pr_info("spslr: deterministic PRNG seed supplied\n");
+	else
+		pr_info("spslr: PRNG seeded from kernel RNG\n");
+}
+
+static void __init spslr_prng_refill(void)
+{
+	chacha20_block(&spslr_chacha, spslr_block);
+	spslr_block_pos = 0;
+}
+
+static u64 __init spslr_prng_u64(void)
+{
+	u64 value;
+
+	if (unlikely(!spslr_prng_initialized))
+		spslr_prng_init();
+
+	if (spslr_block_pos + sizeof(value) > CHACHA_BLOCK_SIZE)
+		spslr_prng_refill();
+
+	value = get_unaligned_le64(spslr_block + spslr_block_pos);
+	spslr_block_pos += sizeof(value);
+
+	return value;
+}
+
+spslr_u64 __init spslr_env_random_u64(void)
+{
+	return spslr_prng_u64();
+}
diff --git a/kernel/spslr/spslr_env.h b/kernel/spslr/spslr_env.h
new file mode 100644
index 000000000000..4d3193133610
--- /dev/null
+++ b/kernel/spslr/spslr_env.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef SPSLR_ENV_H
+#define SPSLR_ENV_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/init.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#ifndef __init
+#define __init /* only required in kernel */
+#endif
+
+#ifndef __printf
+#define __printf(fmt_pos, arg_pos) \
+	__attribute__((format(printf, fmt_pos, arg_pos)))
+#endif
+
+#ifndef NULL
+#define NULL ((void *)0)
+#endif
+
+typedef uint8_t spslr_u8;
+typedef uint16_t spslr_u16;
+typedef uint32_t spslr_u32;
+typedef uint64_t spslr_u64;
+typedef int32_t spslr_s32;
+typedef int64_t spslr_s64;
+typedef uintptr_t spslr_uintptr;
+
+int spslr_env_push_writable(void *ptr, spslr_u64 n);
+int spslr_env_pop_writable(void *ptr, spslr_u64 n);
+void *spslr_env_early_malloc(spslr_u64 n);
+void spslr_env_early_free(void *ptr, spslr_u64 n);
+spslr_u64 spslr_env_random_u64(void);
+
+#endif
diff --git a/kernel/spslr/spslr_randomizer.c b/kernel/spslr/spslr_randomizer.c
new file mode 100644
index 000000000000..5a73b74b9631
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "spslr_randomizer.h"
+
+#include "spslr_env.h"
+#include "pinpoint.h"
+
+#define SPSLR_RANDOMIZER_RETRIES 64
+
+static spslr_u64 __init align_up(spslr_u64 value, spslr_u64 alignment)
+{
+	if (alignment <= 1)
+		return value;
+
+	spslr_u64 remainder = value % alignment;
+	if (remainder == 0)
+		return value;
+
+	return value + alignment - remainder;
+}
+
+/*
+ * Return a random integer in [0, BOUND).
+ *
+ * Modulo bias is negligible for the field counts used here.
+ */
+static spslr_u64 __init random_bounded(spslr_u64 bound)
+{
+	return !bound ? 0 : spslr_env_random_u64() % bound;
+}
+
+static void __init initialize_permutation(spslr_u64 *order, spslr_u64 count)
+{
+	for (spslr_u64 i = 0; i < count; ++i)
+		order[i] = i;
+}
+
+static void __init fisher_yates(spslr_u64 *order, spslr_u64 count)
+{
+	if (count < 2)
+		return;
+
+	for (spslr_u64 i = count - 1; i > 0; --i) {
+		spslr_u64 j = random_bounded(i + 1);
+
+		spslr_u64 tmp = order[i];
+		order[i] = order[j];
+		order[j] = tmp;
+	}
+}
+
+/*
+ * Move order[from] to order[to], where to < from, while preserving the
+ * relative order of every intervening element.
+ */
+static void __init pull_forward(spslr_u64 *order, spslr_u64 to, spslr_u64 from)
+{
+	spslr_u64 selected = order[from];
+
+	for (spslr_u64 i = from; i > to; --i)
+		order[i] = order[i - 1];
+
+	order[to] = selected;
+}
+
+static const struct spslr_target_field *__init
+field_at_order_position(const struct spslr_target_layout *layout,
+			const spslr_u64 *order, spslr_u64 i)
+{
+	if (!layout || !order || i >= layout->field_cnt)
+		return NULL;
+
+	spslr_u64 original_index = order[i];
+
+	if (original_index >= layout->field_cnt)
+		return NULL;
+
+	return &layout->fields[original_index];
+}
+
+/*
+ * Greedily rearrange ORDER to fill alignment holes.
+ *
+ * ORDER maps:
+ *
+ *     final position -> original field index
+ *
+ * On success, RESULT_SIZE contains the occupied size before tail padding.
+ */
+static int __init collapse_layout(const struct spslr_target_layout *layout,
+				  spslr_u64 *order, spslr_u64 *result_size)
+{
+	if (!layout || !order || !result_size)
+		return -1;
+
+	spslr_u64 position = 0;
+	spslr_u64 i = 0;
+
+	while (i < layout->field_cnt) {
+		const struct spslr_target_field *anchor =
+			field_at_order_position(layout, order, i);
+
+		if (!anchor || anchor->alignment == 0)
+			return -1;
+
+		spslr_u64 anchor_start = align_up(position, anchor->alignment);
+
+		if (anchor_start != position) {
+			spslr_u64 candidate = i + 1;
+
+			for (; candidate < layout->field_cnt; ++candidate) {
+				const struct spslr_target_field *candidate_field =
+					field_at_order_position(layout, order,
+								candidate);
+
+				if (!candidate_field ||
+				    candidate_field->alignment == 0)
+					return -1;
+
+				spslr_u64 candidate_start = align_up(
+					position, candidate_field->alignment);
+
+				if (candidate_start < position)
+					return -1;
+
+				/*
+				 * Candidate must fit entirely into the hole before
+				 * the current anchor.
+				 */
+				if (candidate_start <= anchor_start &&
+				    candidate_field->size <=
+					    anchor_start - candidate_start) {
+					break;
+				}
+			}
+
+			if (candidate < layout->field_cnt) {
+				pull_forward(order, i, candidate);
+
+				const struct spslr_target_field *selected =
+					field_at_order_position(layout, order,
+								i);
+
+				spslr_u64 start =
+					align_up(position, selected->alignment);
+
+				position = start + selected->size;
+				++i;
+				continue;
+			}
+		}
+
+		position = anchor_start + anchor->size;
+		++i;
+	}
+
+	*result_size = position;
+	return 0;
+}
+
+/*
+ * Publish:
+ *
+ *     roffsets[original_field_index]
+ *         = randomized byte offset
+ */
+static int __init publish_offsets(const struct spslr_target_layout *layout,
+				  const spslr_u64 *order, spslr_u64 *roffsets)
+{
+	if (!layout || !order || !roffsets)
+		return -1;
+
+	spslr_u64 position = 0;
+
+	for (spslr_u64 i = 0; i < layout->field_cnt; ++i) {
+		spslr_u64 original_index = order[i];
+
+		if (original_index >= layout->field_cnt)
+			return -1;
+
+		const struct spslr_target_field *field =
+			&layout->fields[original_index];
+
+		spslr_u64 start = align_up(position, field->alignment);
+
+		if (start > layout->size)
+			return -1;
+
+		if (field->size > layout->size - start)
+			return -1;
+
+		roffsets[original_index] = start;
+		position = start + field->size;
+	}
+
+	return 0;
+}
+
+/*
+ * Restore the compile-time layout after an unexpected publication failure.
+ */
+static void __init restore_initial_offsets(
+	const struct spslr_target_layout *layout, spslr_u64 *roffsets)
+{
+	if (!layout || !roffsets)
+		return;
+
+	for (spslr_u64 i = 0; i < layout->field_cnt; ++i)
+		roffsets[i] = layout->fields[i].offset;
+}
+
+int __init spslr_randomize(const struct spslr_target *target,
+			   spslr_u64 *roffsets)
+{
+	if (!target || !target->layout)
+		return -1;
+
+	const struct spslr_target_layout *layout = target->layout;
+
+	if (layout->field_cnt == 0)
+		return 0;
+
+	if (!layout->fields || !roffsets)
+		return -1;
+
+	restore_initial_offsets(layout, roffsets);
+
+	spslr_u64 order_size = layout->field_cnt * sizeof(spslr_u64);
+	spslr_u64 *order = (spslr_u64 *)spslr_env_early_malloc(order_size);
+
+	if (!order)
+		return -1;
+
+	int result = -1;
+
+	for (spslr_u64 attempt = 0; attempt < SPSLR_RANDOMIZER_RETRIES;
+	     ++attempt) {
+		initialize_permutation(order, layout->field_cnt);
+
+		fisher_yates(order, layout->field_cnt);
+
+		spslr_u64 used_size;
+
+		if (collapse_layout(layout, order, &used_size) < 0)
+			goto finish;
+
+		/* Retry if layout is too large. Should very rarely happen
+		   after collapse. */
+		if (used_size > layout->size)
+			continue;
+
+		if (publish_offsets(layout, order, roffsets) < 0) {
+			restore_initial_offsets(layout, roffsets);
+			goto finish;
+		}
+
+		result = 0;
+		goto finish;
+	}
+
+finish:
+	spslr_env_early_free(order, order_size);
+	return result;
+}
diff --git a/kernel/spslr/spslr_randomizer.h b/kernel/spslr/spslr_randomizer.h
new file mode 100644
index 000000000000..3ccc096d4f29
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef SPSLR_RANDOMIZER_H
+#define SPSLR_RANDOMIZER_H
+
+#include "pinpoint.h"
+
+/*
+ * Randomize exactly one target.
+ *
+ * On success:
+ *
+ *     roffsets[original_field_index]
+ *
+ * contains that field's randomized byte offset.
+ */
+int spslr_randomize(const struct spslr_target *target, spslr_u64 *roffsets);
+
+#endif
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index d0f200428957..3c318445e504 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -6,6 +6,8 @@
 
 #include <asm-generic/codetag.lds.h>
 
+FORCE_GROUP_ALLOCATION
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
@@ -57,6 +59,47 @@ SECTIONS {
 	}
 
 	MOD_SEPARATE_CODETAG_SECTIONS()
+
+#ifdef CONFIG_SPSLR
+	.spslr : ALIGN(8) {
+		__spslr_start = .;
+
+		. = ALIGN(8);
+		__start_spslr_targets = .;
+		KEEP(*(spslr_targets))
+		__stop_spslr_targets = .;
+
+		. = ALIGN(8);
+		__start_spslr_target_refs = .;
+		KEEP(*(spslr_target_refs))
+		__stop_spslr_target_refs = .;
+
+		. = ALIGN(8);
+		__start_spslr_ipins = .;
+		KEEP(*(spslr_ipins))
+		__stop_spslr_ipins = .;
+
+		. = ALIGN(8);
+		__start_spslr_dpins = .;
+		KEEP(*(spslr_dpins))
+		__stop_spslr_dpins = .;
+
+		. = ALIGN(8);
+		__start_spslr_rpins = .;
+		KEEP(*(spslr_rpins))
+		__stop_spslr_rpins = .;
+
+		. = ALIGN(8);
+		KEEP(*(spslr_strtab))
+		KEEP(*(spslr_target_layouts))
+
+		__spslr_end = .;
+	}
+
+	.spslr.calc.text : {
+		KEEP(*(.spslr.calc.text))
+	}
+#endif
 }
 
 /* bring in arch-specific sections */
-- 
2.43.0

