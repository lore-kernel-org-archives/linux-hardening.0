Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED423B27F6;
	Tue,  6 Oct 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278440; cv=none; b=HFDPWHtnBrCcO5GPje1a7xTMf5W2tb3wOhce6iMswNZ4i+GutWRkPVJ4S6gcw5mq+myOGkUwOIsEjCp+EzVCNQNq6WWVVKsIsVJEhkOURvySTfdFbe6x42Es71K28nOFNp5lgwjDoBYx9Mlpk9xyl7UZ4i/L5UvxrUxBHPk2tIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278440; c=relaxed/simple;
	bh=1m3aTK6Z5wncbNPSgJ3TC1n9HxPYagStQRHXEMHg3AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXwmSjAgmg8HVKM80nnLISe9efcs0vP95NDunyCKvoTZvI/tJ36qGkojzWOMOHZGjSj9xecHi/psLYgZQb7IC9NnxlG359s1xyOclQ9iosph+NfbEQCYgcuNKpw7eBGj2G8GvThHf+OHRNJ0Z15MLoODcf01M3ddSz7hrhVWV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVpLBxgf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVpLBxgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888BE1F008A6;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278436;
	bh=CnyrpAYa14sI6txd4i9BRZdPd5nnZg7VR0kQkLdWkQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVpLBxgfM0rONG8Wiwrrt+BhOMXh4zL2IuOALKVYginZxUX/sgl5lHJGPcHCzPhYb
	 xyIfyzfGeLK/YZIAtGx2FM9tYy89UNeowwgeonbhVtB58jYPR2yraJiEpMbBWJSUcM
	 uFhrZFhuZ+BXwXQaodLHmPNB+kvd1+oP7enMIKBsad3i0IVDBEDqE0GQGhCq1hJUnb
	 D2+A7jGE4SpDgT1woYYm1nBOD+7fNCvcyKFOFfjDaaGHCXmx/RMcb3o2Rne/4ggJoC
	 o06DCfwkWu0JNR7R3YwQ/R5QdgSp6E6dt2UoXzMLA5BsbnK2gc1kQpJJbKrFH4MlAc
	 tQ1OaEdUcNw4w==
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 8/8] net: skb: isolate skb data area allocations into a separate bucket
Date: Tue,  6 Oct 2026 02:20:34 -0700
Message-ID: <20261006092035.166776-8-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006092030.got.500-kees@kernel.org>
References: <20261006092030.got.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264; i=kees@kernel.org; h=from:subject; bh=croNj7wGZJutVq0MdlBIPVhcFuxS4L8MSQxkndGPUZM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlH9iZOsbhvGdjwZt/kH1+3q/4/WHJ8GWfDpJT5Ok/OC SW8kLR63FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRXx6MDH0LL/dzTltYrfc+ 6GZ+x5LTld4lV7P9l/OHuu89cDfLoJbhn1ZvG9/Us2n/vislCfxZ7Lvh12nXul8nlY/8903zi5/ 8nwsA
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

AF_UNIX sets sk_allocation to GFP_KERNEL_ACCOUNT, and those skb data
areas, the ones most worth isolating, stay in the set, where memcg
charges them as it would in the general caches. GFP_DMA falls back to
the general caches, being passed to an skb allocator only by rare
devices.

Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..6f6b5f4cb39f 100644
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
@@ -593,11 +595,12 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
 	if (!obj_size)
 		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
 					     flags, node);
-	return kmalloc_node_track_caller(obj_size, flags, node);
+	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
+						    flags, node);
 }
 
 /*
- * kmalloc_reserve is a wrapper around kmalloc_node_track_caller that tells
+ * kmalloc_reserve is a wrapper around a caller-tracked kmalloc that tells
  * the caller if emergency pfmemalloc reserves are being used. If it is and
  * the socket is later found to be SOCK_MEMALLOC then PFMEMALLOC reserves
  * may be used. Otherwise, the packet data may be discarded until enough
@@ -634,7 +637,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
 	 */
-	obj = kmalloc_node_track_caller(obj_size,
+	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
 					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 					node);
 	if (likely(obj))
@@ -5235,6 +5238,7 @@ void __init skb_init(void)
 						0,
 						SKB_SMALL_HEAD_HEADROOM,
 						NULL);
+	skb_data_buckets = kmem_buckets_create("skb_data", 0, INT_MAX);
 	skb_extensions_init();
 }
 
-- 
2.55.0

