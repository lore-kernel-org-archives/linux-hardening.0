Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500339B943
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597862; cv=none; b=ruqIbb7yn/F10KPfNXIiaaQL9L65ELdksANfBOwjJZZ6x20GdkLu+qAmvjMd/lOJw5mrxUfpHj8rUh5BLyKn+XEthlsmHya6gOz5gVaiJA4XjluuUocBEiP0pG6AupdntigFt58PgKmgIRzvbRAplFXmBRl+C6zpEI7UngU3gmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597862; c=relaxed/simple;
	bh=nXl6ZQ3/GD5YYatYWGoWeRCafVQRWHiEuLMbA6V9nog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XEYgo2kx4/80hmSUGJN3zNtN5Pr9K2FSH9abLG5L8RA704OloQdTEuoojGjYgBVsACoyKbaR0IHklfgsNKFCn5YZh0D00DE7Sr13AcCuHrOo83V2YVWJ69MFya4UeLkKWeBkoXRDJNdfuEfx2QYMmu+ckXAM6mEkpdDRHdAFOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PCWPzIhD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PCWPzIhD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781597859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ULC5udusBPAUhyKoACmo8lOdoKKMnURiFTEboVxH9Wc=;
	b=PCWPzIhDWtdB/RElE8qmhvrEkQn7sRmosOv8hiQZ6k/we+yKiEZaEoBa4ef89xYjG2sYby
	HFXhE9FoGh/cAJp8xIMArfPTk3qxrKNyrkuxZ1y66a5tEmvB/zUyppE18G++406o8il73r
	8//cxHX5sd10nzqjRNrhU6TFNOEblzs=
From: Enlin Mu <enlin.mu@linux.dev>
To: tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlin.mu@linux.dev
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH v2] genirq: Add the entropy pool function to the PPI interrupt handler
Date: Tue, 16 Jun 2026 16:17:30 +0800
Message-Id: <20260616081730.4035-1-enlin.mu@linux.dev>
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

