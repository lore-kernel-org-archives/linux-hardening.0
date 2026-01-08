Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0A4418D3;
	Thu,  8 Jan 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864495; cv=none; b=IVTCCCKv7YWMOWyNH4GK0cs9GgOGWtwGVmHKHgKMr/QvIgiZGfOuR9G1JcdTfKhdZqFXU3qEeAhaVb6UTQ0J5JlPqeBlN8rE4E85zIrRPXpPJBu28NaNmemRjvUmfNW89NBTXPmatEeL6x430jd/a0mSAxDHb70YT5elji5Wv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864495; c=relaxed/simple;
	bh=kuiwqDzl2f73n2rx6IkFHqKYsd+dEBHyHn/U0wchG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpBHAfjunS1BogVKzlzPlWITcy9wqkll+RPMZOUlr7dDsgvu3liSAkWEUAOa3zhB0sYrrsS1RaKQN1t+9BehY3DziX2MRaoLtPDiQp/Z/Y71r9bb/KXlTKMQEarvmKv4wYS2bP8qe+xqmV+U9XLIte4ZDHMZkgUzEcA36GeSemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE4g3NZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE4g3NZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A643C16AAE;
	Thu,  8 Jan 2026 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864492;
	bh=kuiwqDzl2f73n2rx6IkFHqKYsd+dEBHyHn/U0wchG6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE4g3NZIjUSbMFNAkVY+33hZ8GREkvXwF5nm2RP85oba55ABb5lq/mx14Pm3eltvZ
	 8yjjVnFbKJoEi5IeB2E9KHSlm8+eZA6DCNFLUr+IMnc7u7H25uoYz1U4c6aGXDjms/
	 SCWotGS11nbtnb7kzWIQc/WZUV7G449kV7HWeLt+eRjNAZAf5XvXiuUiiDOzPOfGL1
	 U+vjBX3G4iXETKeOCFApwS0nZd9GqcGO6DmJSCKw2WT8Xab28lEn8bWSFPSMhd0MTV
	 rECob5syJECEtpotW6FXM6EMreXGssMvZGLARcLs7ZGKdisMNZP7HBOdpMyAQxYkko
	 5svd1/4WZlM2Q==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 06/19] alloc_tag: Use __ prefixed ELF section names
Date: Thu,  8 Jan 2026 09:25:33 +0000
Message-ID: <20260108092526.28586-27-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5229; i=ardb@kernel.org; h=from:subject; bh=kuiwqDzl2f73n2rx6IkFHqKYsd+dEBHyHn/U0wchG6U=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+gr+/J608YJGRXc/NN5tidyxgut2atMbF+d2CIHN1n ewrG/07SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERs6hgZ1i4IWMCjp7YoLjqD KdjzEo9s7QT9vjn3uEIE9St5M3yqGP6XO1YIvZPPuqQxac+2y+skmOWmTWR9biBz8kzvqdDkK3e ZAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

The compiler will emit static relocations related to a section .foo into
a separate section called .rela.foo, i.e., it just appends the section
name to the string ".rela"

When section names start with . or __, this results in section names
that are correctly matched by the various pattern rules in the various
linker scripts across the tree.

Without any such leading delimiter, it may lead to spurious warnings
such as

  >> ld: warning: orphan section `.relaalloc_tags' from `init/main.o' being placed in section `.rela.dyn'
     ld: warning: dot moved backwards before `.rela.dyn'
     ld: .tmp_vmlinux1: section `.rela.dyn' can't be allocated in segment 1

Fix this by renaming the section to __alloc_tags. While at it, tweak the
headers so that the definition appears only a single time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/codetag.lds.h | 14 +++++++++-----
 include/linux/alloc_tag.h         | 11 ++++++-----
 lib/alloc_tag.c                   |  6 +++---
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index a14f4bdafdda..d7ff181862da 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_GENERIC_CODETAG_LDS_H
 #define __ASM_GENERIC_CODETAG_LDS_H
 
+#include <linux/compiler_types.h>
+
+#define ALLOC_TAG_SECTION_NAME	__alloc_tags
+
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 #define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
 #else
@@ -10,15 +14,15 @@
 
 #define SECTION_WITH_BOUNDARIES(_name)	\
 	. = ALIGN(8);			\
-	__start_##_name = .;		\
+	__PASTE(__start_, _name) = .;	\
 	KEEP(*(_name))			\
-	__stop_##_name = .;
+	__PASTE(__stop_, _name) = .;
 
 #define CODETAG_SECTIONS()		\
-	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
+	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(ALLOC_TAG_SECTION_NAME))
 
 #define MOD_SEPARATE_CODETAG_SECTION(_name)	\
-	.codetag.##_name : {			\
+	.codetag._name : {			\
 		SECTION_WITH_BOUNDARIES(_name)	\
 	}
 
@@ -28,6 +32,6 @@
  * unload them individually once unused.
  */
 #define MOD_SEPARATE_CODETAG_SECTIONS()		\
-	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
+	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(ALLOC_TAG_SECTION_NAME))
 
 #endif /* __ASM_GENERIC_CODETAG_LDS_H */
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index d40ac39bfbe8..f39d85b05b8a 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -15,6 +15,9 @@
 #include <linux/static_key.h>
 #include <linux/irqflags.h>
 
+/* for ALLOC_TAG_SECTION_NAME */
+#include <asm-generic/codetag.lds.h>
+
 struct alloc_tag_counters {
 	u64 bytes;
 	u64 calls;
@@ -74,8 +77,6 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
-#define ALLOC_TAG_SECTION_NAME	"alloc_tags"
-
 struct codetag_bytes {
 	struct codetag *ct;
 	s64 bytes;
@@ -98,7 +99,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)						\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
-	__section(ALLOC_TAG_SECTION_NAME) = {					\
+	__section(__stringify(ALLOC_TAG_SECTION_NAME)) = {			\
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_shared_alloc_tag };
 
@@ -108,7 +109,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)						\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
-	__section(ALLOC_TAG_SECTION_NAME) = {					\
+	__section(__stringify(ALLOC_TAG_SECTION_NAME)) = {			\
 		.ct = CODE_TAG_INIT,						\
 		.counters = NULL };
 
@@ -117,7 +118,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 #define DEFINE_ALLOC_TAG(_alloc_tag)						\
 	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
-	__section(ALLOC_TAG_SECTION_NAME) = {					\
+	__section(__stringify(ALLOC_TAG_SECTION_NAME)) = {			\
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_alloc_tag_cntr };
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 27fee57a5c91..3eff7e912521 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -15,8 +15,8 @@
 
 #define ALLOCINFO_FILE_NAME		"allocinfo"
 #define MODULE_ALLOC_TAG_VMAP_SIZE	(100000UL * sizeof(struct alloc_tag))
-#define SECTION_START(NAME)		(CODETAG_SECTION_START_PREFIX NAME)
-#define SECTION_STOP(NAME)		(CODETAG_SECTION_STOP_PREFIX NAME)
+#define SECTION_START(NAME)		(CODETAG_SECTION_START_PREFIX #NAME)
+#define SECTION_STOP(NAME)		(CODETAG_SECTION_STOP_PREFIX #NAME)
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
 static bool mem_profiling_support = true;
@@ -810,7 +810,7 @@ static inline void sysctl_init(void) {}
 static int __init alloc_tag_init(void)
 {
 	const struct codetag_type_desc desc = {
-		.section		= ALLOC_TAG_SECTION_NAME,
+		.section		= __stringify(ALLOC_TAG_SECTION_NAME),
 		.tag_size		= sizeof(struct alloc_tag),
 #ifdef CONFIG_MODULES
 		.needs_section_mem	= needs_section_mem,
-- 
2.47.3

