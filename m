Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDA101E6;
	Sat, 22 Feb 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740253601; cv=none; b=SEwgivRl0vNCTFMMg7dcq4T3PWk23noonfs7CwkhtD6InLnqUeq6UIj8/Ik+V8jXnU8Ktq442Z25xriqjSg8JSd+TBUyd34Or3yIU8w8+AJh1+2T37Gd2UUnG+kJIA8v1DuEJZI5ntkScVdDgQuCxSAF//zb+ZLlyVw4acez9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740253601; c=relaxed/simple;
	bh=WJXh6otmXryLoI09QxuBOmx096ot4bpbrMJcxXLcU78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UEPiM2BHY6nMjOtc5MRnzpQl4OMZjKQw4b5lk11lAVlSLP4jOYRPVAOM2J1Zg6M4PlTBd5tmAWzG6VuU5EOOVJr8HrWrJjjwvEzBjUOAZ7PaTJcxOEnNRC+g+SZ3Xd8XL3V1WLd0AXREt/9SYLpznrBgKAj1774nfTGLantKm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=S0qkwSA/; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="S0qkwSA/"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0cv83bk6z9sck;
	Sat, 22 Feb 2025 20:46:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740253588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9+CXkYaMZwIZzzOXM/b51T1ZwM7ATw1x8gihAxLB1DM=;
	b=S0qkwSA/zL/H8R6HLpWJsyK4onCp6SvUPlMMeegRRCv4CnTeqZRhykzWwZbQ+Hd24x5LZl
	BqGCBdXY7LR/MWLzgsft7EXu5R6NVQ+yIos4cOdF0DWQtXcvUbSXfqpoM3CFUJ1C3Dlh4U
	ppTXK3VWGnatYeZymsGCocChLEWmvsGITUPqHrX85e/FGQhsb0ufeWTjLjwCTrhOMHDFC6
	vyycysV4yINR87vh4XDpojTpVAXWc8u4buAcOjqEsOEFCKFPQQKot0bVBIh/DDFHbAd1b9
	DqjxfgG8NyemX9x1vDl5d2TvxUJZfQW05SrVBAUbT+7mqMwCWbvK6sl8YHjnVg==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 22 Feb 2025 14:46:23 -0500
Subject: [PATCH] sched/topology: replace kzalloc() with kcalloc() in
 sched_init_numa()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-sched-kcalloc-v1-1-4dee15fd8241@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAI4pumcC/x3MQQqAIBBA0avIrBN0KKKuEi1snHIoNBQiiO6et
 HyL/x8onIULjOqBzJcUSbHCNgoouLixFl8NaLAziKgLBfZ6J3ccibT1nSN2PbbDArU5M69y/79
 pft8PuaOK+18AAAA=
X-Change-ID: 20250222-sched-kcalloc-1d5acea7249b
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=WJXh6otmXryLoI09QxuBOmx096ot4bpbrMJcxXLcU78=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBPL1M3RGUvOC9ieTM2VkZLWTgrN3E5ZEZscCtJOEhPClYyenh2SjNMR0x5V0JmVnUx
 Rm5SVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0lrMGJXRDR
 uM1BYYnNvQ1JyOFpaUTNHaHF3WDF6QWNTV2dKYXZqT3ZPSjdxVzZQL0huZDF3ei9DeGIyLzFoNg
 pOTFF2WnA3Wng4MUtuMWtpTTVXK0xsK29za2hoOHNUd0QrOE1lQUdMZUUvbAo9WmhxNgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows[1]. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c10254dec985bba47b18f61be954d23f6..b4539b29fb36f6b2f0c5ca310620ebda29755e5c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1918,7 +1918,7 @@ void sched_init_numa(int offline_node)
 	 */
 	sched_domains_numa_levels = 0;
 
-	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
+	masks = kcalloc(nr_levels, sizeof(void *), GFP_KERNEL);
 	if (!masks)
 		return;
 
@@ -1927,7 +1927,7 @@ void sched_init_numa(int offline_node)
 	 * CPUs of nodes that are that many hops away from us.
 	 */
 	for (i = 0; i < nr_levels; i++) {
-		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
+		masks[i] = kcalloc(nr_node_ids, sizeof(void *), GFP_KERNEL);
 		if (!masks[i])
 			return;
 

---
base-commit: 5cf80612d3f72c46ad53ef5042b4c609c393122f
change-id: 20250222-sched-kcalloc-1d5acea7249b

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

