Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1EB2FE045;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804637; cv=none; b=tjQjEKBaBUljHmRHq5lNnArW8XSGgmHhL5moahi7hX9jkWw5FdmspZf59XfGupUwbToLao0WtsYWkJR1Vx+8zrM3EqwzybVL8WCkje/iPdJlMkfFCfQdXBO0eslpX8Kca3ObOAw+5akZc+V3qNQkHzZAGGDWEum1R0H2MBNn7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804637; c=relaxed/simple;
	bh=5dAQ4T//TVYvlDNMsV5Y6TSBwmCOXpo3qNaO4v8qX0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzNzNBCtK3GhHCTszc9xgjPsOg45P9kRgKTCLC+EWzYDXuN7dH0053z6TJnEbI7zoN+OK6MgzRR8lvZ3Riz0bOIfl2S1tyfdkGvqNPsWwmaldsRd92QMrC1fAj0l2Xjp2Y7XbrAU3xFUUr5a5b+P5+4LJ6Bq2lw08X5xpJqMS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb1QFnmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb1QFnmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5515AC2BCB9;
	Wed,  3 Dec 2025 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764804637;
	bh=5dAQ4T//TVYvlDNMsV5Y6TSBwmCOXpo3qNaO4v8qX0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tb1QFnmrmnR+zXH4fFBLmyxgcqpG4u3ZvwA7jcak8tIqWFqIsmYPPKVxGdTX8Ryvr
	 R1Li+pHJWV1tAMBLLP3p+jTOEuYTJC+rO7oIZ4ejDqA1hne6lUoKesO8t7wxq6qoqz
	 dGwtzcdHfbeL7AZLleyooLz5rSKKZZHmqOqNQT/gL2IqbrPdi1OGOn1CFy4tmYloBK
	 ZP+6uTtqVaFhxeXwW8PA0tVDOwqLxJ/ruN46Fnaai8RPGeamw7sRh3iri3PFyf7QuU
	 aqmZoLMDLVciN4vCgG365BnxUxt6oAmlIlK001XgapbBRngGvP07yXaJrao1Bu0yB+
	 aS4CkB0gAXGhg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>,
	Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion script
Date: Wed,  3 Dec 2025 15:30:35 -0800
Message-Id: <20251203233036.3212363-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203233029.it.641-kees@kernel.org>
References: <20251203233029.it.641-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3968; i=kees@kernel.org; h=from:subject; bh=5dAQ4T//TVYvlDNMsV5Y6TSBwmCOXpo3qNaO4v8qX0A=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkGJ6Sy9r13X/2Re2em+HFHS6vbrLaGdziDJu7dxrh1l R1vmPW3jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl4hzD8L6ve9u7a1VXb7Pz5 MjPFYksnmr7e9rF9fq7z04VTjtk3ejH84bQ9zWIc4xC+xfH9mXsPlN8nHDdq3WiycYLhz4VWbE2 qDAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Finds and converts sized kmalloc-family of allocations into the
typed kmalloc_obj-family of allocations.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
new file mode 100644
index 000000000000..916cc3a661b9
--- /dev/null
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use kmalloc_obj family of macros for allocations
+///
+// Confidence: High
+// Options: --include-headers-for-types --all-includes --include-headers --keep-comments
+
+virtual patch
+
+@initialize:python@
+@@
+import sys
+
+def alloc_array(name):
+	func = "FAILED_RENAME"
+	if name == "kmalloc_array":
+		func = "kmalloc_objs"
+	elif name == "kvmalloc_array":
+		func = "kvmalloc_objs"
+	elif name == "kcalloc":
+		func = "kzalloc_objs"
+	elif name == "kvcalloc":
+		func = "kvzalloc_objs"
+	else:
+		print(f"Unknown transform for {name}", file=sys.stderr)
+	return func
+
+// This excludes anything that is assigning to or from integral types or
+// string literals. Everything else gets the sizeof() extracted for the
+// kmalloc_obj() type/var argument. sizeof(void *) is also excluded because
+// it will need case-by-case double-checking to make sure the right type is
+// being assigned.
+@direct depends on patch && !(file in "tools") && !(file in "samples")@
+typedef u8, u16, u32, u64;
+typedef __u8, __u16, __u32, __u64;
+typedef uint8_t, uint16_t, uint32_t, uint64_t;
+typedef __le16, __le32, __le64;
+typedef __be16, __be32, __be64;
+type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,
+		 u16,__u16,uint16_t,unsigned short,
+		 u32,__u32,uint32_t,unsigned int,
+		 u64,__u64,uint64_t,unsigned long,
+		 __le16,__le32,__le64,__be16,__be32,__be64};
+char [] STRING;
+INTEGRAL *BYTES;
+type TYPE;
+expression VAR;
+expression GFP;
+expression COUNT;
+expression FLEX;
+expression E;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
+fresh identifier ALLOC_FLEX = ALLOC ## "_flex";
+identifier ALLOC_ARRAY = {kmalloc_array,kvmalloc_array,kcalloc,kvcalloc};
+fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARRAY) };
+@@
+
+(
+-	VAR = ALLOC((sizeof(*VAR)), GFP)
++	VAR = ALLOC_OBJ(*VAR, GFP)
+|
+	ALLOC((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC((sizeof(E)), GFP)
+|
+	BYTES = ALLOC((sizeof(TYPE)), GFP)
+|
+	ALLOC((sizeof(void *)), GFP)
+|
+-	ALLOC((sizeof(E)), GFP)
++	ALLOC_OBJ(E, GFP)
+|
+-	ALLOC((sizeof(TYPE)), GFP)
++	ALLOC_OBJ(TYPE, GFP)
+|
+	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
+|
+	BYTES = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
+|
+	BYTES = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
+|
+	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
+|
+	BYTES = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
+|
+	ALLOC_ARRAY(COUNT, (sizeof(void *)), GFP)
+|
+	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
+|
+-	ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
++	ALLOC_OBJS(E, COUNT, GFP)
+|
+-	ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
++	ALLOC_OBJS(TYPE, COUNT, GFP)
+|
+-	ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
++	ALLOC_OBJS(E, COUNT, GFP)
+|
+-	ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
++	ALLOC_OBJS(TYPE, COUNT, GFP)
+|
+-	ALLOC(struct_size(VAR, FLEX, COUNT), GFP)
++	ALLOC_FLEX(*VAR, FLEX, COUNT, GFP)
+|
+-	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
++	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
+)
-- 
2.34.1

