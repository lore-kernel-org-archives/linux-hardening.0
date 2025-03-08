Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6A8BFF;
	Sat,  8 Mar 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459995; cv=none; b=gE2lnMXLabEfGTHYw9v7my0k3vP/R6xDdvMVaBPKQar0j7yL2jjoM28iTVbOLA7rNibESv+By5gUeQct2f9UaEb452XWgWm8zHY/9iv+vXTnWaYDve5RY2CYZTtmi3c24amIJTlDUv9SMMSelup7QX1VRUJwIsrXoqNWkgOsPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459995; c=relaxed/simple;
	bh=6ywE/KCsG0OSGAcCoBVFTnvWrFMrpzEIEtPG/KeiqYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bfAMUW60Ap7q7l7HQG6e1pRdI9Xp5yIVBWfKaviuOdL+yn+pMyczxL1prVwx258RsK3A1wbgZ9ft4t4MYMrDBJH0l5MBLEuge37d49qfS1SATMT1L1/sQXpz1eHkTr6N6EH/ZUeFP7mDKTVWouHbiazXfbbgx69kbhTMN8pLAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=jEO+Wnq4; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="jEO+Wnq4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z9C326Z90z9sp5;
	Sat,  8 Mar 2025 19:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741459983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VTH4EiXKCLPkA8f3JyVPpOxN9JqCF6IoIwgh5tn62r8=;
	b=jEO+Wnq4qhmkOYi6bWahHtVIyqAj/MLjKZBGDYHxNuy77zZXyDOV2btqyiN0xayGKKPZ3y
	XA1tl5ydjzksnAJT/ntl8t/Evbt/JvEKvwYMNX8tnvl0iWPiirtJiDEtwn0eaUxX6X4K33
	dQGGxYev1HDjH5yaa6Gw7mONaQjLXYAhdw7SdLrrJxReT1DTmh6DLPy8IC5qb81EdQNiGl
	QiALYUTLShDqRcHSyiPRmknPrKkQA+V/iutnFrHSzQ8/ZEqekY0aaw3PucFXTlpdbI0hYV
	Q3MzRnbjEjY19IYPrNY9xWSyTcU65NO1iJfWMBgYd9Yj+FrOJ3XU29vdbjXZzQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 08 Mar 2025 13:52:59 -0500
Subject: [PATCH] ALSA: ctxfi: change dao_set_input functions from kzalloc
 to kcalloc
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-ctdaio-kzalloc-v1-1-804a09875b0e@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAAqSzGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwML3eSSlMTMfN3sqsScnPxk3bTkNBPzJItkkzRzEyWgpoKi1LTMCrC
 B0bG1tQBmipiKYAAAAA==
X-Change-ID: 20250308-ctdaio-kzalloc-fcf47b8c4f74
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=6ywE/KCsG0OSGAcCoBVFTnvWrFMrpzEIEtPG/KeiqYw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBKK1p4RDFGZXVkR3U0cy85bHhuV2VIL2RlY0x0WTl6CnkzKzdGOHpZK09DQjZIR1RW
 WXpHSGFVc0RHSmNETEppaWl6L2M1VFRIbXJPVU5qNTE2VUpaZzRyRThnUUJpNU8KQVpqSXB1V01
 EQXM2VEdKSzA4VytMNUIvL0ozdm1QbG5sMWVieXI4c3ordFNsLzNrYVpHMGc0dmhENC93dDBNMQ
 pyVFlYZkdZd3R3bXFmVnNjZC9STjFLdFdvM2Rkdno4Y1VaODdod01BdFJaUSt3PT0KPU5YVWkKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4Z9C326Z90z9sp5

We are trying to get rid of all multiplications from allocation
functions to prevent potential integer overflows. Here the
multiplication is probably safe, but using kcalloc() is more
appropriate and improves readability. This patch has no effect
on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 sound/pci/ctxfi/ctdaio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 9993b02d2968c6c6858475f7ab98d4e90e7ffe2a..806c4d7543877ed74f8ec2dd894cf6b76af6f314 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -159,7 +159,7 @@ static int dao_set_left_input(struct dao *dao, struct rsc *input)
 	struct daio *daio = &dao->daio;
 	int i;
 
-	entry = kzalloc((sizeof(*entry) * daio->rscl.msr), GFP_KERNEL);
+	entry = kcalloc(daio->rscl.msr, sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 
@@ -188,7 +188,7 @@ static int dao_set_right_input(struct dao *dao, struct rsc *input)
 	struct daio *daio = &dao->daio;
 	int i;
 
-	entry = kzalloc((sizeof(*entry) * daio->rscr.msr), GFP_KERNEL);
+	entry = kcalloc(daio->rscr.msr, sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 

---
base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
change-id: 20250308-ctdaio-kzalloc-fcf47b8c4f74

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

