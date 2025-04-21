Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505407D3F4;
	Mon, 21 Apr 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254518; cv=none; b=l6DcaM8nRNMynfGmetDI/sPLBYzwO5h4VK2IBP4l1Q9QEfQLEkdVXw67tjxeykQd0OO4bh+ocGj+m8gTO567Rl3ocfG7i1xJmvMXH1Vzod7XLp+m/TlPGHcbAK8oEeDOPjIy31XL2h3rJRCDvvWsJlBPlbknKjIWqwsNCclxjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254518; c=relaxed/simple;
	bh=iS0I9IX2sFCSsXL/t1+wx5auONRvDGG0fRjH5jXkuQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eXQE9FxzH1tLMKjg3UjjgCPiKhMy/D9rvUNwgSXqpmHBZsHoiwsqqBfYdsDE1iW7rmvUbl+TBi2qwAFR5qkfTh0Dh7BtiYt15Lm9lLXBeyR9II05jcCtT23As1bMX1CpO/+GQB6C0QW8PI3NmdBMXc9gdX/KkwglgFQ4IVjw5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEQ/+Bnl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEQ/+Bnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1809C4CEE4;
	Mon, 21 Apr 2025 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745254517;
	bh=iS0I9IX2sFCSsXL/t1+wx5auONRvDGG0fRjH5jXkuQk=;
	h=From:To:Cc:Subject:Date:From;
	b=HEQ/+Bnljgi00rzGfwQQ4rzbZdPoy6U4YfVEDaSaWmnWI9juv9NOFrQokwSQ31r8S
	 00dXshXMLhkJ+1rahKpfDjjrWwtz/ysxDf+6q3RPy3g0dWGgQTMqzRvttaDadrCtwL
	 qVA3GpiiZc9MVsm1V9Pms/TNCEfNoGbSoZ+wA8rbQN7U2XMISYmVkuzndAoAdpIlFb
	 r/9JALcDB1QcDJt0KyJcJmZxT0LAyhsx2kgIu+AUvMnv8DuPp8kbXce/PM1+b7iUd6
	 jCWDjxqDoG4xht9HCjXxewUUzBapczQxOMWJ8NzL/5sULwrx6q5dpEP4xNqhfGBf7D
	 edYENDkQNoniw==
From: Kees Cook <kees@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Rafael Aquini <raquini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] slab: Decouple slab_debug and no_hash_pointers
Date: Mon, 21 Apr 2025 09:55:12 -0700
Message-Id: <20250421165508.make.689-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8609; i=kees@kernel.org; h=from:subject:message-id; bh=iS0I9IX2sFCSsXL/t1+wx5auONRvDGG0fRjH5jXkuQk=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlsFfkRtxzucF1bXNfZ/STmaC3/poZAvv5nTEZlv2dce +y1uLito5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCI95owMs+6sMnQuY/21ZUXp Rd3/ihzcx47ey1x4+d5ML991+a8yghkZ9imJL9dZ8n7zFNnXnHVFb7ecfH4l9xEz///YV7FNXz8 ZswAA
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
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Rafael Aquini <raquini@redhat.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3: add docs about implicit "no_hash_pointers" when using "slab_debug" (harry.yoo)
 v2: https://lore.kernel.org/all/20250415170232.it.467-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20250410174428.work.488-kees@kernel.org/
---
 .../admin-guide/kernel-parameters.txt         | 38 ++++++++----
 include/linux/sprintf.h                       |  2 +-
 lib/vsprintf.c                                | 61 +++++++++++++++++--
 mm/slub.c                                     |  5 +-
 4 files changed, 86 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9fd26b95b34..cb12531b2100 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1795,6 +1795,27 @@
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
@@ -4117,18 +4138,7 @@
 
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
 
@@ -6478,6 +6488,10 @@
 			Documentation/mm/slub.rst.
 			(slub_debug legacy name also accepted for now)
 
+			Using this option implies the "no_hash_pointers"
+			option which can be undone by adding the
+			"hash_pointers=always" option.
+
 	slab_max_order= [MM]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
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

