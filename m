Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107603F660F
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182009; cv=none; b=WcXGmyNoCZeyI3ZvVsVDRHl4bAa5M9clivgVHy4lPsjd/qyyAAJWEX8XwsG7kj8suRUAHNOS+Jurho9BZaWo7MW1QNn00KnQnrlT5gLa6O2azPrczafOuPp4fn80oa1vikPqrSpZg734L0TNoz2xqsHnBewI9NSrr3zwlBZezi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182009; c=relaxed/simple;
	bh=RqWrQDNNzlxmYpymw1eMIq1WnpqD4vPONq76D4VOzD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm4FzivxuShxzsRfi3nRTdAO7+KRwEiBMncEKd8pBLfCJ7lrlBmnDQo4TVHk4FZ4bZxsaVZqjq2abn0EGNlIZpECupVQGKtfK4SZs8mQgnAkdsxoKgbmgSXo6DxwORhqu8xCyHB66Bv3dkCow7r72vTS0UCVIq61B2WZuSRDz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Szc1lnZ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X2XdxoRs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Szc1lnZ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X2XdxoRs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Szc1lnZ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X2XdxoRs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Szc1lnZ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X2XdxoRs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 532386AEFC;
	Thu, 11 Jun 2026 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781182006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=Szc1lnZ4SQUwGPUKFxZyZJTGKDopj3R9crYXAQ6sKzeeT8VLXz8e2JUzAhEiCU26xCjbw+
	qzJ25jY+tTl+/mvE32QF48RNv1Gfkq1vLSB52BMp2RBsX9gjXT0lAhahGs1uD9Wcr3rQkE
	Wz+RUAwDHrxOuF4BxY2nqC+YvbEkK6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781182006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=X2XdxoRs/JYyDeXVoPNav8S8Oh92s0IHIC2KyyK1wQS6a1EBUJi06fZkywP2dXQ2PNkDIc
	ErxyAys9qbFLw+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781182006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=Szc1lnZ4SQUwGPUKFxZyZJTGKDopj3R9crYXAQ6sKzeeT8VLXz8e2JUzAhEiCU26xCjbw+
	qzJ25jY+tTl+/mvE32QF48RNv1Gfkq1vLSB52BMp2RBsX9gjXT0lAhahGs1uD9Wcr3rQkE
	Wz+RUAwDHrxOuF4BxY2nqC+YvbEkK6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781182006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=X2XdxoRs/JYyDeXVoPNav8S8Oh92s0IHIC2KyyK1wQS6a1EBUJi06fZkywP2dXQ2PNkDIc
	ErxyAys9qbFLw+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 032A0779A7;
	Thu, 11 Jun 2026 12:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Db6ODSuKmpaagAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 11 Jun 2026 12:46:44 +0000
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
Subject: [PATCH net-next v2 0/2] net: isolate SKB data area allocations
Date: Thu, 11 Jun 2026 13:46:40 +0100
Message-ID: <20260611124642.345400-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gentwo.org,google.com,kernel.org,gmail.com,suse.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

This is a rather simple series that attempts to address a possible
exploitation avenue - the allocation of skbs around the network stack, which
frequently get user-controlled contents. Found while doing some amateur
exploitation analysis for some other issue, elsewhere.

Patch 0 is a precursor patch that adds a slab allocation helper, patch 1
does the actual bucketing.

v2:
 - Pick up A-b, R-b tags (thanks everyone!)
 - Cover kmalloc_pfmemalloc as well (Harry)

Pedro Falcato (2):
  mm/slab: add a node-track-caller variant for kmem buckets allocation
  net: skb: isolate skb data area allocations into a separate bucket

 include/linux/slab.h | 7 +++++--
 net/core/skbuff.c    | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.54.0

