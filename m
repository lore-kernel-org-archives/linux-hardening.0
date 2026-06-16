Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4894183C9
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604155; cv=none; b=ap9FefhNU87knxTWPMON/HBsweF+g63wIS8Pxm3lM4KK6nBgWSmfsytYm4Hp07DuJv7zMGf/gqfasp8F+5Bv7nSgOcJUHJbDEr7gr8FEDkjz5JBsvuqkf6XJLMAUkecKq8bKXwUJWPY2vgFdfA4f4I/RhTCB7st10fgsqMN5Fb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604155; c=relaxed/simple;
	bh=SvVYExW/Q/Hjd30SnIuldyN+ZO8S41XSiJz0Wzrg+oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CvFO/fPid6IjndzAldBPBnFNpQeyQQZjNBwUYFGLVKNcyaSnvELbhYHL6U7QB+Udnhdp/caf/4f3+2U1au8FvsL0oHBYpGbuya4K8uIjpihYYs0KgrVZ9ILgqs1RJCgJdM9n4jpHqbVgrkF1uq6o9oY5jix4hLkgVPTF1lsrkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QpUVcH6F; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QpUVcH6F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781604142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Qu7CbrKux96cswFy7p5Q7ZYOG3xsyjx9q5YsEYvsXY=;
	b=QpUVcH6F/ST0TrvmnC6KU2K+o0UC2+qyJCidJFScRPBHFT/j/paZws9On0er7VrKfakUSS
	grBhbYRCFXApI3TuFNtTZVAanzsjAADhxGZXYtCu+F74qNeYf972poLx1nFaqw5LwxGnCW
	cSZXNROPaN0/IzU/nRt4coLxYzrd4po=
From: Enlin Mu <enlin.mu@linux.dev>
To: tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlin.mu@linux.dev
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH v2] genirq: Add the entropy pool function to the PPI interrupt handler
Date: Tue, 16 Jun 2026 18:02:11 +0800
Message-Id: <20260616100211.3068-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Accelerate the entropy pool initialization process.
The function handle_irq_event_percpu adds entropy pool
initialization, but this logic is missing in the PPI interrupt handler.
I think this was simply an accidental omission.

Signed-off-by: Enlin Mu <enlin.mu@linux.dev>
---
v2:updated the commit message
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

