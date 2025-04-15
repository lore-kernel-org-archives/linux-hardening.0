Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760D10E9;
	Tue, 15 Apr 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736562; cv=none; b=DLl2IDmOGpvc2keAqkYFRQTx5lmXyFuLMVkgHQcn5rHz6X+8JA83YlCcxykEeM0nPzEO5wNV1ivbNrMFW4DUUL6ExvPiUfdjtsrR3r9ehEKqXZmLwdK6K008aXEDJjhj7fIY95mNyAGK1/7YCNMmUVWBBQ5N5GqxP6fSVCOZI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736562; c=relaxed/simple;
	bh=WgJ7ltnjSlSMgyEg86kq1HUblr9Q7ZvJJzZDcJ6BoSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SG8QPv6mYw8zFYSffsUaF50737SAdXkU5awzuLRyo47bZTGMlx8wK5FdwLZ40wAPP0UlAMj5zAXbh9IbLBemNRkX/ljpIKH1jmObptdrbRy2tXcRBqEO8dClaETjuhIuzfcv2yqO9p0/cxiVzkkp2qhOliLCs+n7HRjWQAr45wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXkf72fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXkf72fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453E8C4CEE9;
	Tue, 15 Apr 2025 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736560;
	bh=WgJ7ltnjSlSMgyEg86kq1HUblr9Q7ZvJJzZDcJ6BoSs=;
	h=From:To:Cc:Subject:Date:From;
	b=aXkf72fzanAJsg1tKVDIKR5oeSoWjGYAT3dwSOH/JYFxk46G3M7QLa/Po/VHaPuVf
	 jVyA2ev+hQPbYzYeJwMmOVNG1+lEn25otvldn1S3nf5a/yTQEfesvZr4u/P1PJM6/X
	 XGGM68DhVw/K8+r4mi/qXNxUUcTBr5CZH/dVMjXqXf8eBbhdrg0E5cA3G7Eg5GeRNJ
	 UEld3Tv6AfJjVMf/7/1GyJ/SS1hSd1q4xX8I7bBcr5QbIwlsjzFszfjjEw+5syRWRn
	 PtpwQ/Hwf/UcdwaT4fnGlptyfiusO34vzPOr+Rub0Up77tMCiCMJ/5GVLlTWDiNiTC
	 2L6ODMxSxnqfg==
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] slab: Decouple slab_debug and no_hash_pointers
Date: Tue, 15 Apr 2025 10:02:33 -0700
Message-Id: <20250415170232.it.467-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8813; i=kees@kernel.org; h=from:subject:message-id; bh=WgJ7ltnjSlSMgyEg86kq1HUblr9Q7ZvJJzZDcJ6BoSs=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/Jmq+ZbwuMbkjfWHjYlP5D83ix8+1eF1imXlq9/eez 7aLzjiJdJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExEs42R4dhRDe6V+pfadUsz /1s4uGXl2wkUnZD+Lmee+VLU7948N4Y/nC4zCjS27Pp9Je7qrq4ds85u2bWVZcf1j9MZ/PemaCV qcAIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Some system owners use slab_debug=FPZ (or similar) as a hardening option,
but do not want to be forced into having kernel addresses exposed due
to the implicit "no_hash_pointers" boot param setting.[1]

Introduce the "hash_pointers" boot param, which defaults to "auto"
(the current behavior), but also includes "always" (forcing on hashing
even when "slab_debug=..." is defined), and "never". The existing
"no_hash_pointers" boot param becomes an alias for "hash_pointers=never".

This makes it possible to boot with "slab_debug=FPZ hash_pointers=always".

Link: https://github.com/KSPP/linux/issues/368 [1]
Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is enabled")
Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: use switch state to avoid missing states (pmladek)
 v1: https://lore.kernel.org/lkml/20250410174428.work.488-kees@kernel.org/
Cc: Petr Mladek <pmladek@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-mm@kvack.org
---
 .../admin-guide/kernel-parameters.txt         | 34 +++++++----
 include/linux/sprintf.h                       |  2 +-
 lib/vsprintf.c                                | 61 +++++++++++++++++--
 mm/slub.c                                     |  5 +-
 4 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 76e538c77e31..d0fd9c745db9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1798,6 +1798,27 @@
 			backtraces on all cpus.
 			Format: 0 | 1
 
+	hash_pointers=
+			[KNL,EARLY]
+			By default, when pointers are printed to the console
+			or buffers via the %p format string, that pointer is
+			"hashed", i.e. obscured by hashing the pointer value.
+			This is a security feature that hides actual kernel
+			addresses from unprivileged users, but it also makes
+			debugging the kernel more difficult since unequal
+			pointers can no longer be compared. The choices are:
+			Format: { auto | always | never }
+			Default: auto
+
+			auto   - Hash pointers unless slab_debug is enabled.
+			always - Always hash pointers (even if slab_debug is
+				 enabled).
+			never  - Never hash pointers. This option should only
+				 be specified when debugging the kernel. Do
+				 not use on production kernels. The boot
+				 param "no_hash_pointers" is an alias for
+				 this mode.
+
 	hashdist=	[KNL,NUMA] Large hashes allocated during boot
 			are distributed across NUMA nodes.  Defaults on
 			for 64-bit NUMA, off otherwise.
@@ -4120,18 +4141,7 @@
 
 	no_hash_pointers
 			[KNL,EARLY]
-			Force pointers printed to the console or buffers to be
-			unhashed.  By default, when a pointer is printed via %p
-			format string, that pointer is "hashed", i.e. obscured
-			by hashing the pointer value.  This is a security feature
-			that hides actual kernel addresses from unprivileged
-			users, but it also makes debugging the kernel more
-			difficult since unequal pointers can no longer be
-			compared.  However, if this command-line option is
-			specified, then all normal pointers will have their true
-			value printed. This option should only be specified when
-			debugging the kernel.  Please do not use on production
-			kernels.
+			Alias for "hash_pointers=never".
 
 	nohibernate	[HIBERNATION] Disable hibernation and resume.
 
diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 51cab2def9ec..521bb2cd2648 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -22,7 +22,7 @@ __scanf(2, 0) int vsscanf(const char *, const char *, va_list);
 
 /* These are for specific cases, do not use without real need */
 extern bool no_hash_pointers;
-int no_hash_pointers_enable(char *str);
+void hash_pointers_finalize(bool slub_debug);
 
 /* Used for Rust formatting ('%pA') */
 char *rust_fmt_argument(char *buf, char *end, const void *ptr);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 01699852f30c..22cbd75266ef 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -60,6 +60,20 @@
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
+/*
+ * Hashed pointers policy selected by "hash_pointers=..." boot param
+ *
+ * `auto`   - Hashed pointers enabled unless disabled by slub_debug_enabled=true
+ * `always` - Hashed pointers enabled unconditionally
+ * `never`  - Hashed pointers disabled unconditionally
+ */
+enum hash_pointers_policy {
+	HASH_PTR_AUTO = 0,
+	HASH_PTR_ALWAYS,
+	HASH_PTR_NEVER
+};
+static enum hash_pointers_policy hash_pointers_mode __initdata;
+
 noinline
 static unsigned long long simple_strntoull(const char *startp, char **endp, unsigned int base, size_t max_chars)
 {
@@ -2271,12 +2285,23 @@ char *resource_or_range(const char *fmt, char *buf, char *end, void *ptr,
 	return resource_string(buf, end, ptr, spec, fmt);
 }
 
-int __init no_hash_pointers_enable(char *str)
+void __init hash_pointers_finalize(bool slub_debug)
 {
-	if (no_hash_pointers)
-		return 0;
+	switch (hash_pointers_mode) {
+	case HASH_PTR_ALWAYS:
+		no_hash_pointers = false;
+		break;
+	case HASH_PTR_NEVER:
+		no_hash_pointers = true;
+		break;
+	case HASH_PTR_AUTO:
+	default:
+		no_hash_pointers = slub_debug;
+		break;
+	}
 
-	no_hash_pointers = true;
+	if (!no_hash_pointers)
+		return;
 
 	pr_warn("**********************************************************\n");
 	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
@@ -2289,11 +2314,39 @@ int __init no_hash_pointers_enable(char *str)
 	pr_warn("** the kernel, report this immediately to your system   **\n");
 	pr_warn("** administrator!                                       **\n");
 	pr_warn("**                                                      **\n");
+	pr_warn("** Use hash_pointers=always to force this mode off      **\n");
+	pr_warn("**                                                      **\n");
 	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
 	pr_warn("**********************************************************\n");
+}
+
+static int __init hash_pointers_mode_parse(char *str)
+{
+	if (!str) {
+		pr_warn("Hash pointers mode empty; falling back to auto.\n");
+		hash_pointers_mode = HASH_PTR_AUTO;
+	} else if (strncmp(str, "auto", 4) == 0)   {
+		pr_info("Hash pointers mode set to auto.\n");
+		hash_pointers_mode = HASH_PTR_AUTO;
+	} else if (strncmp(str, "never", 5) == 0) {
+		pr_info("Hash pointers mode set to never.\n");
+		hash_pointers_mode = HASH_PTR_NEVER;
+	} else if (strncmp(str, "always", 6) == 0) {
+		pr_info("Hash pointers mode set to always.\n");
+		hash_pointers_mode = HASH_PTR_ALWAYS;
+	} else {
+		pr_warn("Unknown hash_pointers mode '%s' specified; assuming auto.\n", str);
+		hash_pointers_mode = HASH_PTR_AUTO;
+	}
 
 	return 0;
 }
+early_param("hash_pointers", hash_pointers_mode_parse);
+
+static int __init no_hash_pointers_enable(char *str)
+{
+	return hash_pointers_mode_parse("never");
+}
 early_param("no_hash_pointers", no_hash_pointers_enable);
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index b46f87662e71..f3d61b330a76 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6314,9 +6314,8 @@ void __init kmem_cache_init(void)
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
 
-	/* Print slub debugging pointers without hashing */
-	if (__slub_debug_enabled())
-		no_hash_pointers_enable(NULL);
+	/* Inform pointer hashing choice about slub debugging state. */
+	hash_pointers_finalize(__slub_debug_enabled());
 
 	kmem_cache_node = &boot_kmem_cache_node;
 	kmem_cache = &boot_kmem_cache;
-- 
2.34.1

