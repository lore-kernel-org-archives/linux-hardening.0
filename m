Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F63D3331
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589074; cv=none; b=O7Ay1hdm3ErkNKqR8dvq57HQkSLqU2vpobDl3LjLPPRNjwq6rrACQ4/I6deVHk2ziVt8qXZOjalGe4ldZaWDbx+HbUDLo2sy4ZKqttUc/AGE6gJKRsUupZQwuqnpx6XZh4YGXtENUNFCrWl16iDB7ZIMXFABqtZDMt61/kDxT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589074; c=relaxed/simple;
	bh=cNHa0UknnrrU0x/Uuugmu0AmfcZ4a2qTiBnVFrg64E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uG8PGUxI9m+gDPWQ/4Dmy92EfcdxJKIRqTHtmTf2kKqabPT/mDM6PFilHbrL91fw6TFc4xEEgapk8ZlAMe+wyM4ZMu/BpObtsgmvOoJIb+Zz+TRILWyF+PiZqkvyIc4gb2dYDxPFbrOlMxsOxn7wp0oQw96nKw1+w44361cmv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rcZodwy2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcZodwy2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781589059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EmoTDZetUowpwZaJUWA2L2z1q0xsJ1Wz2o6SEjNKHPU=;
	b=rcZodwy2V5fFO0YIz/59R5A+48ShgtS7aGp91LJNP/Ns+0hYawc1LQxTShU+/gU8DXFQ1d
	ckO0Sp4iJOsp10e0pffNRzGjm4V6R1piQTkizvK292k00/BBDdd8hExuCUsfeQ07wLM9t/
	DXJM6BWfVKCMznspquiRp7IFHa7R6eU=
From: Enlin Mu <enlin.mu@linux.dev>
To: tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlin.mu@linux.dev
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] genirq: Add the entropy pool function to the PPI interrupt handler
Date: Tue, 16 Jun 2026 13:50:42 +0800
Message-Id: <20260616055042.3923-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Accelerate the entropy pool initialization process

Signed-off-by: Enlin Mu <enlin.mu@linux.dev>
---
 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1..cbbd7e7d1156 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -926,6 +926,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		trace_irq_handler_entry(irq, action);
 		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 		trace_irq_handler_exit(irq, action, res);
+		add_interrupt_randomness(irq);
 	} else {
 		bool enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
 
-- 
2.39.5

