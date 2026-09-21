Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27644C65D;
	Mon, 21 Sep 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977504; cv=none; b=tkInJyyjcTEtbLPbDNH7nYXDnMv+SobiMb/yrOLeFNU9Cn2+Fd8m3Gbn6t4dEtejOKlqykVUSqUneQoS1N4ssSJzcbDppfG8aryjAHwxslchqWsz9z0sPZJpkSCEU9Umg17lWmXIlRvkKaA19IcKVWyRjREbd0/f8sgdFFA0w2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977504; c=relaxed/simple;
	bh=U4cVv3SUTzhH/lrc/2fcsnidFcJazCsEDw7sFYGmqdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzIKIPjLBLWTiD98ZTMAvrrpENDWzZMzT5oXUNCYpT5EUtSUhheRfxGfrJFc7gK6UHpb+LQT7xsK/YRnF1l5Qg9zDY4PoRnZ6NRGnZC0YmnOsMWcerB/SmOdn0W5pD2QwozhJfRP0ZJGow/FvG3jUqHPXhfJI2H1ePX9PQEWX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdL0Rct0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdL0Rct0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C4D1F00893;
	Mon, 21 Sep 2026 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977500;
	bh=LrV5HlUofGQHQ/kNdAFIhT1ZS3PTpyWCIefSybl8wfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FdL0Rct0o8D1RMzCLiAIR3g8WKsP5grYoTTdBh0dDgSKhqumLJ/MVuJYKSBgsSsbW
	 gCgPDkx1tfK8qP+AWxKq9B+0hy69AL55t1FnlywiLjI10GviMm1hUZ1CPRoDpylmwY
	 Nd7BHaHp6WU0lv3/93R+xhNIDwJo07svjVpMcL0e4qRmDpkaRBbXLGEHiHwiX83wT4
	 qs87VMBFZjX9Th97lNW1bMRg6ahQV4kXTYfxHMEU61iupQpMvjzw8izbcklS6qa0t9
	 UJ2M0R+to0SeDtu36W5k4VJYtSbwZmlZjaZEa/w9GyGjueJPlfUcN+Nb7z4xYPZXNr
	 tGXfalSsm70wg==
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
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 2/7] mm/slab: Give bucket caches the alignment of the caches they mirror
Date: Mon, 21 Sep 2026 00:58:13 -0700
Message-Id: <20260921075820.1718334-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921075811.too.775-kees@kernel.org>
References: <20260921075811.too.775-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=kees@kernel.org; h=from:subject; bh=U4cVv3SUTzhH/lrc/2fcsnidFcJazCsEDw7sFYGmqdg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkbHs/4sDlPq9X8gb7/bpsnB7XWCMtlbF5fMs+qiOlbz eQtvnwsHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNR+Mbw33d+keP64y2Zywy3 Z9Va3Y0Ud5otrZGsueeRMpODbe3tYkaG5r37+zvfr/z2PVUhSt9uNvN1w5vbrnNfUql6WeVyIP0 oKwA=
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

Take the alignment from the cache being mirrored, which is where the
size and the name suffix already come from. Nothing changes where the
alignment was already implied by the size.

Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <linux-mm@kvack.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: <linux-hardening@vger.kernel.org>
---
 mm/slab_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 270408ce5a9d..cc58f192f349 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -487,7 +487,8 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 			if (WARN_ON(!cache_name))
 				goto fail;
 			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
-					0, flags, cache_useroffset,
+					kmalloc_caches[KMALLOC_NORMAL][idx]->align,
+					flags, cache_useroffset,
 					cache_usersize, ctor);
 			kfree(cache_name);
 			if (WARN_ON(!(*b)[aligned_idx]))
-- 
2.34.1

