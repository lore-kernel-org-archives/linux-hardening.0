Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510A44F542;
	Mon, 21 Sep 2026 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977506; cv=none; b=j/S0Km0WBuvpZjDjbBFQ1eazMwN9IYbTyx1DnZope4jS46266vy0SQ5v0ihlj5tONtGRzFw9ZcauRJaOMl/ZzVG1rvK0NBW2K3PywZUuK96F8pYz3Y4hVgtZyuq1gZkblO1EQqMEqCU4vhJV+TwiBwD40l4Wd5AftL+5FDYO/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977506; c=relaxed/simple;
	bh=5/W6d8/fGN0H8flCw1+s2MH+b1ysv235gOyZUqiA6PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkiOn/ybPIVpZWUN1gJ0f2y+TXRctw4+PK4Frb2BPDp2GDg47Ch6UpFy0bpplUkXdempykUd0NMMTuU2UUEqyCHukYr/0XDfl9ItHTmp4HP4izfNBAM3EUzS5rPAXHF8B5XYj8A9cxuFP68cWt+8EH33RKAE3W5YgDg41Oe0C6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5l6xMLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5l6xMLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A71F0092B;
	Mon, 21 Sep 2026 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977500;
	bh=NYCJwCjTojZoMSg1K1fjM/5lK8uQavHZIHSOSFY3WTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5l6xMLr+mdsyD4v9Exth0ro3zP53iCdhEmLvIqv/LW76z/hhaaHJOsgHfnUWXIZ+
	 GrnzjyQXahhr94V3EyvWJwwhX4xXN55NzWW4lpD/CtK0uRf6PfPC8XxSzxp0FfCpnt
	 xyz9yUy+4l5YMv/tWafJttCsw3tx+I6jyPbWuVjkH1/6SRaQvoLbO715gjAw1Ze8Wx
	 bH6sLPxEJTj6YROx4jOtMDMQy9vbJTxIY2/KuP9pFMtgx4qmMFjUmfodEasuIIfQMM
	 6mWXurW0lopmPAjxJnZxWvYuLY8bAis2OPiOKTuxS/9u3qCpxQleshG2Gnp44ctCqm
	 Zuw0hGkOFp+0g==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 7/7] net: skb: isolate skb data area allocations into a separate bucket
Date: Mon, 21 Sep 2026 00:58:18 -0700
Message-Id: <20260921075820.1718334-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921075811.too.775-kees@kernel.org>
References: <20260921075811.too.775-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=kees@kernel.org; h=from:subject; bh=YbmMITYuL1x/iTXXiiC6TtrZwPTf+P8ee7ihm7zXbV8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkbHs96Od9twi4pFTetfSFhyZfmVrMo1B9ll3bbeJ/t7 pcFHYp2HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPZZc7wv3rT2r5XJVMCz6wK vqIT9T/GlW9Rd9/7p/57/rs+yFdZ/I/hf3DgwrXRchzeZREev01/vRJKDn01aQmLgKWqcFv/nrn H+QE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Pedro Falcato <pfalcato@suse.de>

SKB data area allocations (as done from alloc_skb()) use kmalloc().
These allocations can be variably sized and their contents can be more
or less controlled from userspace, which makes them useful for attackers
that want to overwrite a use-after-free'd object from the same kmalloc slab
(which often just requires the sizes to roughly match into the same kmalloc
bucket). [0] is an easy example of an exploit that uses netlink skb
allocation to target another similarly-sized accidentally freed object.

While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
probabilistic. Use the existing kmem buckets API to further isolate these
allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.

Ask for the accounted kmalloc type as well as the normal one. AF_UNIX
sets sk_allocation to GFP_KERNEL_ACCOUNT, so without it every AF_UNIX
skb data area would fall back to the general caches, and those are the
ones most worth isolating. GFP_DMA is left to fall back, being passed to
an skb allocator only by rare devices.

Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Cc: <netdev@vger.kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: <linux-hardening@vger.kernel.org>
---
 net/core/skbuff.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..865eed3c57d1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -586,6 +586,8 @@ struct sk_buff *napi_build_skb(void *data, unsigned int frag_size)
 }
 EXPORT_SYMBOL(napi_build_skb);
 
+static kmem_buckets *skb_data_buckets __ro_after_init;
+
 static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
 {
 	if (!gfp_pfmemalloc_allowed(flags))
@@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
 	if (!obj_size)
 		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
 					     flags, node);
-	return kmalloc_node_track_caller(obj_size, flags, node);
+	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
+						    flags, node);
 }
 
 /*
@@ -634,7 +637,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
 	 */
-	obj = kmalloc_node_track_caller(obj_size,
+	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
 					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 					node);
 	if (likely(obj))
@@ -5235,6 +5238,10 @@ void __init skb_init(void)
 						0,
 						SKB_SMALL_HEAD_HEADROOM,
 						NULL);
+	skb_data_buckets = kmem_buckets_create_types("skb_data", SLAB_PANIC, 0,
+						     INT_MAX, NULL,
+						     BIT(KMEM_BUCKET_NORMAL) |
+						     BIT(KMEM_BUCKET_CGROUP));
 	skb_extensions_init();
 }
 
-- 
2.34.1

