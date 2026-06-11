Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF053F927D
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182014; cv=none; b=Yjs+OLmHIN9cCWWdbw3x9pqNH5NEvyY6rTCuhGWG3aWofs44AkG3+/tgYGZPNMdWzVqnGN0WMAKnX3XUzHWVfjoqaF6yJAW+Y7N/goWqRUi4hMQTShnh8CDtsys6jZjrqsAxWVwU19BMZVAqsokOXkg7/E6oVXC6ljBlfkmrGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182014; c=relaxed/simple;
	bh=R2Zg06SVXaeNmQnmyVqdUWQb51670ItfKlmJVtqgTiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZy0JGAelw5Lqttc0Q2g1AEI4FV7HP7mHtOGoFTVhUeSf6la/9loTWB/IAUKD/9NrbtxBXUKka4uAS8M5AfHeWZx/a8JNA2P4fAq0ZbYX5pPs+DqKLsY8n+FdysPlKKRDH0Igub+j3nufealbwG+7D5gW1JETtPaxidwXIwTpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B33C96AF04;
	Thu, 11 Jun 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AC3A779A7;
	Thu, 11 Jun 2026 12:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLbQFjauKmpaagAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 11 Jun 2026 12:46:46 +0000
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
	Kees Cook <kees@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH net-next v2 1/2] mm/slab: add a node-track-caller variant for kmem buckets allocation
Date: Thu, 11 Jun 2026 13:46:41 +0100
Message-ID: <20260611124642.345400-2-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611124642.345400-1-pfalcato@suse.de>
References: <20260611124642.345400-1-pfalcato@suse.de>
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
X-Rspamd-Queue-Id: B33C96AF04
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

This is required by users that want to use kmem buckets, but still
desire specifying the NUMA node.

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 include/linux/slab.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7b46fa499b08..685a87d8f0c5 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1153,8 +1153,11 @@ void *kmalloc_nolock(size_t size, gfp_t gfp_flags, int node);
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, NUMA_NO_NODE))
 
-#define kmem_buckets_alloc_track_caller(_b, _size, _flags)	\
-	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, NUMA_NO_NODE, _RET_IP_))
+#define kmem_buckets_alloc_node_track_caller(_b, _size, _flags, _node)	\
+	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, _node, _RET_IP_))
+
+#define kmem_buckets_alloc_track_caller(_b, _size, _flags) \
+	kmem_buckets_alloc_node_track_caller(_b, _size, _flags, NUMA_NO_NODE)
 
 static __always_inline __alloc_size(1) void *_kmalloc_node_noprof(size_t size, gfp_t flags, int node, kmalloc_token_t token)
 {
-- 
2.54.0

