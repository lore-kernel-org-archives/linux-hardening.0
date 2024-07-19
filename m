Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4B148827;
	Fri, 19 Jul 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417272; cv=none; b=nXnZnRHeNB0ENecvDXDzw8I9+nTUx1r2vGyXhalNYcN7CAlgkTjDFjYEqtSHFANb1Kv7cm87l2Wzdw0w+5VjRmxKTCZCxwb7SnF2pITmxx+AXsaFTInvev19RFPuWmy2QUR/lz2a5e4t1pc8xUBxlqJEv+RkLIU+JdKsWCoiugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417272; c=relaxed/simple;
	bh=PEDczIo+N1zc3HDWBH6pVQlbE4VTMIsKTmLki2Kgujg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0IaZWkefACu64VVeLmb2NzwJuFRxk2XW6UVH/oh/CP6K6qG+TcYWfxgTvFL8cOtviZdsnHpa4gEhvIfM+KjkW/NU3f/9plRJh/0n7wVw9800VZ6Yx7sAawBgcBCjMQRV94Q66ITmgh+et1g6mnaTPnAPZr7Pwaz9/2rbPmXRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aATqaNws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aATqaNws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC5DC32782;
	Fri, 19 Jul 2024 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721417271;
	bh=PEDczIo+N1zc3HDWBH6pVQlbE4VTMIsKTmLki2Kgujg=;
	h=From:To:Cc:Subject:Date:From;
	b=aATqaNwsw7zUhMSCxIzcS+PaFt7EMdmq6f1ISFbvRp9EinIRdkadj3apjqOBPt8H2
	 mM0qZAaRZoW5GGrFgw5BDjxaIEdA+kbr/XkWb35AhKJvwa4bTteCdgeDzoZhyRMGIT
	 y/z/SlqoLUFgV6a1ZbQpcGlrV/AiQMHHmrNiEQH5OzHBAOTEfp0ECgFNmbl3E6W8ZW
	 FcYOWtx3rfm0p4Ftko/7YNZZ3CTMrX10LY5lt0STJ7XD4QG+hL8f9qOXm34N4YWWTO
	 nmtdVtY27l1/HNFMGfZR4MxORr/Ax0LSVDPkhAB4TV+EQBB+t7xl/V7TGhLSYlTkEp
	 ATOrwcoqPg1/g==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] slab: Introduce kmalloc_obj() and family
Date: Fri, 19 Jul 2024 12:27:48 -0700
Message-Id: <20240719192744.work.264-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4424; i=kees@kernel.org; h=from:subject:message-id; bh=PEDczIo+N1zc3HDWBH6pVQlbE4VTMIsKTmLki2Kgujg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmmr4zWEhFKb72H7UArt9Y4HKLkvwrT5DByCcol rkyOA/7hJOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpq+MwAKCRCJcvTf3G3A JkwGEACSNPqi1z0Rbac2tYergCeVTF0BJw90KpQW+JJlLlAtU2q0NcSYmIby+hoV48sYHqwXx2A Te/n3DVId2VY9yV5H9HxORKzXngzVwqHW8L99nwMOPI3ejdy6RGIIg91yLUlDbxY+Ay53ZdFOTF kbFwFSdV7axOIGilb4VWMUJuzG7ioL71ugBTnHfFYEUE2Uw8ssVP0YmAS21oG9XF+wPtOKBisXu PDhtf3/qjvmz6JJcuvNYgb/dig0DqpCxltP+WHVkRzqMgwgxMiTRO6MPJW19yi9CF4aQQtn9JMy 9dvAJ4HhfPfqreSBv9YYMbfapsqqz0X8SKSK+hqtMBFycURsav39aRivbGwi35G+yLFqRXOo8yw ImlwApj+1gUMDuHRwjmMxURyz3pQ1Vtsgwh0MXaNpCiohe5cy9vlhFfvEq86Z/9i4Rh1uRfGyMZ hrpNwb5SIdfzUzGRQs5MNOynY7gCryY+X4ph1qHv0KIXIfEmDhSJSquyoqrstq+SI1sJbJKhSyH kF7p6SDPe8nbj8MmNLMY8Wmpg4Vcujj9MUnuxhIYAwRhn5rY9Mqlf6S43rJ2uMHez4lx99rkaWv YGY4rn/XKmx3u9FzS4N4kQfcDNmLevNyvlVy+QxnEYxSKwxXcrrYjZ/AcrrrHzjSD9UK/n/r4ig gahzpHb6u7Elb
 0w==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce type-aware kmalloc-family helpers to replace the common
idioms for single, array, and flexible object allocations:

	ptr = kmalloc(sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);
	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);
	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);

These become, respectively:

	kmalloc_obj(p, gfp);
	kzalloc_obj(p, count, gfp);
	kmalloc_obj(p, count, gfp);
	kzalloc_obj(p, count, gfp);
	kmalloc_obj(p, flex_member, count, gfp);

These each return the size of the allocation, so that other common
idioms can be converted easily as well. For example:

	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);

becomes:

	info->size = kmalloc_obj(ptr, flex_member, count, gfp);

Internal introspection of allocated type also becomes possible, allowing
for alignment-aware choices and future hardening work. For example,
adding __alignof(*ptr) as an argument to the internal allocators so that
appropriate/efficient alignment choices can be made, or being able to
correctly choose per-allocation offset randomization within a bucket
that does not break alignment requirements.

Additionally, once __builtin_set_counted_by() (or equivalent) is added
by GCC and Clang, it will be possible to automatically set the counted
member of a struct with a counted_by FAM, further eliminating open-coded
redundant initializations:

	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);
	ptr->flex_count = count;

becomes (i.e. unchanged from earlier example):

	info->size = kmalloc_obj(ptr, flex_member, count, gfp);

Replacing all existing simple code patterns via Coccinelle[1] shows what
could be replaced immediately (saving roughly 1,500 lines):

 7040 files changed, 14128 insertions(+), 15557 deletions(-)

Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_obj-assign-size.cocci [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..3817554f2d51 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -665,6 +665,44 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+#define __alloc_obj3(ALLOC, P, COUNT, FLAGS)			\
+({								\
+	size_t __obj_size = size_mul(sizeof(*P), COUNT);	\
+	void *__obj_ptr;					\
+	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
+	if (!__obj_ptr)						\
+		__obj_size = 0;					\
+	__obj_size;						\
+})
+
+#define __alloc_obj2(ALLOC, P, FLAGS)	__alloc_obj3(ALLOC, P, 1, FLAGS)
+
+#define __alloc_obj4(ALLOC, P, FAM, COUNT, FLAGS)		\
+({								\
+	size_t __obj_size = struct_size(P, FAM, COUNT);		\
+	void *__obj_ptr;					\
+	(P) = __obj_ptr = ALLOC(__obj_size, FLAGS);		\
+	if (!__obj_ptr)						\
+		__obj_size = 0;					\
+	__obj_size;						\
+})
+
+#define kmalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kmalloc, __VA_ARGS__)
+
+#define kzalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kzalloc, __VA_ARGS__)
+
+#define kvmalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kvmalloc, __VA_ARGS__)
+
+#define kvzalloc_obj(...)					\
+	CONCATENATE(__alloc_obj,				\
+		    COUNT_ARGS(__VA_ARGS__))(kvzalloc, __VA_ARGS__)
+
 static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
-- 
2.34.1

