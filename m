Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585E218AAD;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775785; cv=none; b=hhvPjakf5Yg/l74ONpsMaXWmlNQ1VEtibSws5SNeH40iazqNWGpnp0GdeOHADHA/46gJZVQ1WE2shyRG/XRuFTGWCOo0k0hAdPoT8EUPPQla1bFkQbAJpKI1BuHzNSE1UdH7MXYkvJQfTmdzVjB1LkJY7qWsUdmRQUMZ8dSFbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775785; c=relaxed/simple;
	bh=JxuvIO3718cS+Dvv5mnYaQfpRZs89bnBJgRU4fqHVhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1dEjtWwPA2gyCjz0W/gJIFjJb5MZAZdoBkt9j+41pSAgUeZgeDqQtfRUH7uDexAWPWj9xNfqO3UMZatRN8U7TOllQkeGkGruFpK8jqzWvIvM4s52WUCLy+Do6wF1T3TNX/LVv9lmG2xqLyb2l+aZX30RRc3v4vJ/dCvFxH6CZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMvlgijz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMvlgijz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45596C116C6;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775785;
	bh=JxuvIO3718cS+Dvv5mnYaQfpRZs89bnBJgRU4fqHVhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMvlgijzbmFNkfbnQVSo6QNnc2jbeN9HLvXWjQOD93VkbfHKnVlUY7eOKEBcuHc67
	 6PayG7QOl6uN5Vz7SX/SjbnnvJVTQSEFclQ3E+RQMEN37u2gsLaJDrutd2UEd1hPKn
	 eHktdbFsp5skk56TH79GEktt7iA/iT2S0Qrad486wiP+ow/jAeOAJNCJmRYglKwsM+
	 9a0RORXbOB7nHKxtWvj/g0k5k++pY7QHTI9D4WK65u6qIM8mqN4C23qYwhkfzWSWS1
	 eNUUfNb2zOrPMBidmcWKFrNloeo0lQC+OG0v99oD132px4tyS1RAxPzJgAcV2eS+tF
	 wFnZ3vu36liyw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
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
Subject: [PATCH v5 4/4] coccinelle: Add kmalloc_objs conversion script
Date: Fri, 21 Nov 2025 17:43:00 -0800
Message-Id: <20251122014304.3417954-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122014258.do.018-kees@kernel.org>
References: <20251122014258.do.018-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5220; i=kees@kernel.org; h=from:subject; bh=JxuvIO3718cS+Dvv5mnYaQfpRZs89bnBJgRU4fqHVhg=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmKoiovd0kEL2nM9vrWcEr0BrNDueiFSz1VT7Ynz/mxU HCv85o3HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABORKWdkeMS4oWH2j/3ayy4U ntTmmnLqyr3eozWS3Heu/Np3OmE6822GP3wLym6t6qhK1xRnlXp2RrSzPrjMxZRN3oOxU9LE8eY tFgA=
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
 scripts/coccinelle/api/kmalloc_objs.cocci | 168 ++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
new file mode 100644
index 000000000000..39f82f014b17
--- /dev/null
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use kmalloc_obj family of macros for allocations
+///
+// Confidence: High
+// Comments:
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
+@assign_sizeof depends on patch && !(file in "tools") && !(file in "samples")@
+type TYPE;
+TYPE *P;
+TYPE INST;
+expression VAR;
+expression GFP;
+expression SIZE;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_OBJ_SZ = ALLOC ## "_obj_sz";
+@@
+
+(
+-	SIZE = sizeof(*VAR);
+	... when != SIZE
+	VAR =
+-	ALLOC(SIZE, GFP);
++	ALLOC_OBJ_SZ(*VAR, GFP, &SIZE);
+|
+-	SIZE = (sizeof(TYPE));
+	... when != SIZE
+	P =
+-	ALLOC(SIZE, GFP);
++	ALLOC_OBJ_SZ(*P, GFP, &SIZE);
+|
+-	SIZE = (sizeof(INST));
+	... when != SIZE
+	P =
+-	ALLOC(SIZE, GFP);
++	ALLOC_OBJ_SZ(*P, GFP, &SIZE);
+)
+
+@assign_struct_size depends on patch && !(file in "tools") && !(file in "samples")@
+type TYPE;
+TYPE *P;
+expression VAR;
+expression GFP;
+expression SIZE;
+expression FLEX;
+expression COUNT;
+identifier ALLOC =~ "^kv?[mz]alloc$";
+fresh identifier ALLOC_FLEX_SZ = ALLOC ## "_flex_sz";
+@@
+
+(
+-	SIZE = struct_size(VAR, FLEX, COUNT);
+	... when != SIZE
+	VAR =
+-	ALLOC(SIZE, GFP);
++	ALLOC_FLEX_SZ(*VAR, FLEX, COUNT, GFP, &SIZE);
+|
+-	SIZE = struct_size_t(TYPE, FLEX, COUNT);
+	... when != SIZE
+	P =
+-	ALLOC(SIZE, GFP);
++	ALLOC_FLEX_SZ(*P, FLEX, COUNT, GFP, &SIZE);
+)
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
+
-- 
2.34.1

