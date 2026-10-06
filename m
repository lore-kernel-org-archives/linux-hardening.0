Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17073AA9D8;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278439; cv=none; b=Oucj1PZPAn4tVMPdmIX7y2sIbdE8KfRRm2U0eefRNXSnABor179O5m9pSvs9C1U6r8YbeTTCYORyOsvsJ3++IeiphInYcVUSK+QR9BCeo/1JdHXYMcMTVoGvDStj+KghNKEbG6VGoUZslmgeik/zJb1xg/XoIhMXDJHIw+8seQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278439; c=relaxed/simple;
	bh=VTBkNsJfqD4uSQDLJ95b9wi9U4gRgcj84wnPIW38sWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcql2s1/2NLbuzjV4tBCYcoDz59JMxu4wZCwVOk0MxTq6dkJfJiZnzFqLrWgaOGRoOHRWWC2Qb+qw/X4C/dw8aegDFWnq8eZU4h06i6GDCUrnMIsIL8YftSlSv0fK2Hk0tX3FYC36fJLexiZ9wG/ttlczCHCh1vKvezPGocvwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFGwV6Ot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFGwV6Ot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4841F008A4;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278436;
	bh=ziXSIFKy4iYBIXzefxPjJEejxh6eI0ypyw0gaU6vVJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BFGwV6Ot437+lLzZytDMcJMCEjlmOPmJZxOkahUbroKgnSRzvq2jm/55eOIG13LlI
	 QPrgWc8VKrKuJp+/FS8fxyKsXdhE9OvSuaYwxl3OBroTpN15iL/zqMT7oCx2r/pUDR
	 hec+OLdi1KCYAQVarNnGmp8pO505achrSEtnNqSDRuyv6AUYzkoYrUD2rxuj8wTGQd
	 w0tle1Uf7ZupVOVKzgRZTGcnytWNCSC0Zjv6qrxLC2h7wlMjx4/64mWERNVAd8VzQ7
	 1aMRuu/dUmO+C68iyyQO4KRk7GJ4qNBefA8shkoNHj3TpYUD6PcLBgvxqmpU3CNXqs
	 ah3u8MbFlFbZw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 4/8] mm/slab: Give bucket caches the alignment of the caches they mirror
Date: Tue,  6 Oct 2026 02:20:30 -0700
Message-ID: <20261006092035.166776-4-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006092030.got.500-kees@kernel.org>
References: <20261006092030.got.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=kees@kernel.org; h=from:subject; bh=VTBkNsJfqD4uSQDLJ95b9wi9U4gRgcj84wnPIW38sWc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlH9iaweZyuaA6b/rog9YrLkeA5r36Gnl56NuLzg13xn E1P11yt6yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjI9iJGhlWezjx+4tOXzkp4 OPVPc8O0M8+2Cc+JZK4W2+BzdY0H+x9Ghtuc9yepvbvcsohJSCTt3JMj5uddw8/OLfgbMGf2pxk przgB
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

A bucket set is created with kmem_cache_create_usercopy(..., align = 0),
so calculate_alignment() falls back to arch_slab_minalign(), typically 8
bytes. The general kmalloc caches it stands in for are created through
create_boot_cache(), which starts from ARCH_KMALLOC_MINALIGN and raises
it to the largest power-of-two divisor of the size:

	if (flags & SLAB_KMALLOC)
		align = max(align, 1U << (ffs(size) - 1));

This is only a problem when slab metadata is enabled with
CONFIG_KASAN=y, CONFIG_SLUB_DEBUG_ON=y, or "slab_debug=...", because
metadata changes the stride size off a power of two, for example:

	size 128:  bucket align=8 size=224  | kmalloc align=128  size=384
	size 512:  bucket align=8 size=608  | kmalloc align=512  size=1536
	size 2048: bucket align=8 size=2144 | kmalloc align=2048 size=6144

So bucket allocations will fail the IS_ALIGNED(p, ARCH_DMA_MINALIGN)
check, potentially creating problems for non-coherent DMA situation.

Take the alignment from the kmalloc cache being mirrored, which is where
the size and the name suffix already come from, so a caller moving from
kmalloc() keeps the alignment it had.

Don't take an alignment from the caller instead. With
CONFIG_SLAB_BUCKETS=n, or when kmem_buckets_create() fails,
kmem_buckets_alloc() is served by the general kmalloc caches, which give
kmalloc()'s alignment and no other.

Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 mm/slab_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index f8bb70d76eb4..885aafa23da7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -481,7 +481,8 @@ kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
 			if (WARN_ON(!cache_name))
 				goto fail;
 			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
-					0, SLAB_NO_MERGE, cache_useroffset,
+					kmalloc_caches[KMALLOC_NORMAL][idx]->align,
+					SLAB_NO_MERGE, cache_useroffset,
 					cache_usersize, NULL);
 			kfree(cache_name);
 			if (WARN_ON(!(*b)[aligned_idx]))
-- 
2.55.0

