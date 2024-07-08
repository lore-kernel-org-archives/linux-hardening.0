Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076D14C5BD;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466321; cv=none; b=i7GNRSGHfnFYHCCVmtOu7qBKnHEQew+18MAu7GRHAcZRTplCnMu4e0qxx1CSJbTILXLO5ypnHN+wdypzrQHHknQZFUj3JTTqdkPBqAb4i7XKwpn1SFxFz37b+woaQbNRDfBhU33de53wWW4m+Z8W0pqbWdveZypgiYs98DoEb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466321; c=relaxed/simple;
	bh=uZVkbgeH0EuqCqY0VzPg0KmfW7oX+qB7fM4s+/wiMwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TMHzdM9F+jAttAL8ENeNp7WiLy2FB0YRYaCbI8BgBuLRxfdoKa5BSeFmQFRZI4udfdZ2i/WHrh95bCECjDvKDnt6YCFIk6inzw4gaGc+L9HQ3jSTJPsLRq50iwJPeqqgx0R6+CrbIZBHinpkwvzURauSOzdCrTyYZkaGf+DbFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwLkmYW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwLkmYW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B96C4AF0D;
	Mon,  8 Jul 2024 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466321;
	bh=uZVkbgeH0EuqCqY0VzPg0KmfW7oX+qB7fM4s+/wiMwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwLkmYW8fDSlPfZ6zg7OC+ydN9VHjamB6SV206zEE06CByDYBXL/E3kNymf8f5Z/E
	 WXWWVI1V3oP15b7GAXdSADCafWiAMveNkB2HZ8+7NEQYI7YdmW42qR7tgMpWlporuN
	 J6+evyd+mmMafD6umN9x6L0ddtcnOi2Z/esDflp2s17QEeO3zfTDHjjxNwRPSRfd2D
	 N/Wx4RbcY7RYlE6239c5cLmYVj9D7kFyUZZLHE19qqTGaklfFdSuR11ywV6Sd70kIJ
	 u0Osw7RcbBkJDMa5T0vBYml4oKCg3CzE+2hy/lCWNO73/LSIfqxrEtYHJUDtN1rpMW
	 F4uvi02aZMKmQ==
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
	linux-mm@kvack.org,
	Jann Horn <jannh@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC][PATCH 3/4] slab: Allow for type introspection during allocation
Date: Mon,  8 Jul 2024 12:18:37 -0700
Message-Id: <20240708191840.335463-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708190924.work.846-kees@kernel.org>
References: <20240708190924.work.846-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=kees@kernel.org; h=from:subject; bh=uZVkbgeH0EuqCqY0VzPg0KmfW7oX+qB7fM4s+/wiMwc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjDuOqk8BerNUzSb5otXo2P3d37h+IoXOh1nFQ Es8spHhmLSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZow7jgAKCRCJcvTf3G3A Js1KD/wJ2MAI4caQ2BMn/GB4nzrXJRJ23IazCtug/USRi+kQWodnvPYxG+OU+xrhwSce62gNZ9S znIek1BQjBppXGf28xJhr6X4LXKca7NgslCOEdUwoqIub1c++sTts9qQT0tH57ia5wamfKn6pyb CQE10/gSkeqCJt0UJuJ5/nCE10q12uZrqT3yJWH3xw2XrHBYAvGUdKKCODaz1ntjJNY30179RPL 9TfhRvm8kUACvshW0bDFQnvld+uTNyM6tGAPJqebTDc46oj5rt1MBJG/VeIJe68j6rEDiIzwsPD Fxj3qdXHzCh07JW5zueYPrNQAaPon3vbQ4oeqURGA+Ky+WTmXYUXObiGcGDk+nzW5Osma2tNXQB ezldsO8GZgleLm4WbuOE0XPe39ya0qFBrlRUDHU6w9yVcakglo92jKjgVftQkOlgHimrUSwRKrz 0CosucBmH1tXhl1rCKvcapwPwn6zI9wIKZnxexvS+E0QYWtmRm5Ck2dp8I4ID/xVzy/xaacUEFg odokjaXlY93cRzej7rDMtDo9xGQRxb+K1OpBiyNjuiieHati+E+xNlxzSQZXu+6tfd82Dk7BcDk YVMVnnig8SN4IU2Yzai3pznlTfzu7/X0wPowK80xVs4df6Al6nIE33Dk0eP1JiMtnDb/jzShLKL ylIoTkHjI1WSlnA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

There is currently no way for the slab to know what type is being
allocated, and this hampers the development of any logic that would need
this information including basic type checking, alignment need analysis,
etc.

Allow the size argument to optionally be a variable, from which the
type (and there by the size, alignment, or any other features) can be
determined at compile-time. This allows for the incremental replacement
of the classic code pattern:

	obj = kmalloc(sizeof(*obj), gfp);

into:

	obj = kmalloc(obj, gfp);

As an additional build-time safety feature, the return value of kmalloc()
also becomes typed so that the assignment and first argument cannot drift,
doing away with the other, more fragile, classic code pattern:

	obj = kmalloc(sizeof(struct the_object), gfp);

into:

	obj = kmalloc(obj, gfp);

And any accidental variable drift will not be masked by the traditional
default "void *" return value:

	obj = kmalloc(something_else, gfp);

error: assignment to 'struct the_object *' from incompatible pointer type 'struct foo *' [-Wincompatible-pointer-types]
   71 |     obj = kmalloc(something_else, gfp);
      |         ^

This also opens the door for a proposed heap hardening feature that
would randomize the starting offset of the allocated object within
its power-of-2 bucket. Without being able to introspect the type for
alignment needs, this can't be done safely (or cannot be done without
significant memory usage overhead). For example, a 132 byte structure
with an 8 byte alignment could be randomized into 15 locations within
the 256 byte bucket: (256 - 132) / 8.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7353756cbec6..4a7350bbcfe7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -685,6 +685,7 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 	return __kmalloc_noprof(size, flags);
 }
 #define kmalloc_sized(...)			alloc_hooks(kmalloc_noprof(__VA_ARGS__))
+#define kmalloc_aligned(size, align, gfp)	alloc_hooks(kmalloc_noprof(size, gfp))
 
 #define __size_force_positive(x)				\
 	({							\
@@ -701,7 +702,10 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 	signed char:    kmalloc_sized(__size_force_positive(p), gfp), \
 	signed short:   kmalloc_sized(__size_force_positive(p), gfp), \
 	signed int:     kmalloc_sized(__size_force_positive(p), gfp), \
-	signed long:    kmalloc_sized(__size_force_positive(p), gfp))
+	signed long:    kmalloc_sized(__size_force_positive(p), gfp), \
+	default:	(typeof(__force_ptr_expr(p)))kmalloc_aligned(  \
+				sizeof(*__force_ptr_expr(p)),	      \
+				__alignof__(*__force_ptr_expr(p)), gfp))
 
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
@@ -816,14 +820,11 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 
 /**
  * kzalloc - allocate memory. The memory is set to zero.
- * @size: how many bytes of memory are required.
+ * @p: either a pointer to an object to be allocated or bytes of memory are required.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
-{
-	return kmalloc_noprof(size, flags | __GFP_ZERO);
-}
-#define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
+#define kzalloc(_p, _flags)			kmalloc(_p, (_flags)|__GFP_ZERO)
+#define kzalloc_noprof(_size, _flags)		kmalloc_noprof(_size, (_flags)|__GFP_ZERO)
 #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
 void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node) __alloc_size(1);
-- 
2.34.1

