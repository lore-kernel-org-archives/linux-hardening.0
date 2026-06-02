Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBE396B73
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jun 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425111; cv=none; b=lAUADEfEEkCAI5RDXLlcdztUhhgkt0777zMDPxWTkiYE9n9Rsf89rRTgEhuASAbZ1Mrd7DGJe4xvHMdVbJfn4oLtmISuL5bFSdaFyTxdkjxFdtPdMx7IseGV5kDR3BO2vF5uyjUUnZfgJ/8qMqAWLVRY8DEYBp0WjnpyuwtF3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425111; c=relaxed/simple;
	bh=chQg/NkEyt4Mdb9IkUxVPMwXtdBmoW3fBYnP9aDTCsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFxIQQuxIl8/vqI7QLF3fcVL7m73JUGZ+5cRpMxbzNezOST4U4NiG99ZO4nECOMfVjYxNWwZb+eTz+HSoGbG2+YbdlG0WyFEwkIHkFhTM0zLcEWmujTM2voydhBJbRQgJ662xiL7PPCPXjDNfETVq5xSTZtSdLeLo6rAZGnRJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2687A6AF1B;
	Tue,  2 Jun 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D666B779A7;
	Tue,  2 Jun 2026 18:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4KvUMI4hH2owXQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 18:31:42 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 2/2] net: skb: isolate skb data area allocations into a separate bucket
Date: Tue,  2 Jun 2026 19:31:22 +0100
Message-ID: <20260602183122.747759-3-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602183122.747759-1-pfalcato@suse.de>
References: <20260602183122.747759-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 2687A6AF1B
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

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

Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 44a7f8401468..1f6c6b531ece 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
 	return kmalloc_node_track_caller(obj_size, flags, node);
 }
 
+static kmem_buckets *skb_data_buckets __ro_after_init;
+
 /*
  * kmalloc_reserve is a wrapper around kmalloc_node_track_caller that tells
  * the caller if emergency pfmemalloc reserves are being used. If it is and
@@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
 	 */
-	obj = kmalloc_node_track_caller(obj_size,
+	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
 					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
 					node);
 	if (likely(obj))
@@ -5213,6 +5215,7 @@ void __init skb_init(void)
 						0,
 						SKB_SMALL_HEAD_HEADROOM,
 						NULL);
+	skb_data_buckets = kmem_buckets_create("skb_data", SLAB_PANIC, 0, INT_MAX, NULL);
 	skb_extensions_init();
 }
 
-- 
2.54.0

