Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28B3644C1
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189378; cv=none; b=rTjSbKllhQfPu9DsYD9/60bbCduv0ll15H9FWyvqmU4pebsmNbiLEbyM6EQ7W+TQItyUWU7Bx6s3prTE3K4pM2tXqQnHxTbRlTeJG4S9oeoTN27196T7S4OR5EvIJAqIE3LpLF7hf9Iz7bv/SYbzIfoUm8XsapuJ8eZDWWthb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189378; c=relaxed/simple;
	bh=a2kTH9WO0kbFazr0+zBI5PqLV1v7J0wvNls8pK/Qrkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEoOdGYeVn/7XXk9IVvcKyn332bSPqQrNXkB7kuF2xuY6Ov91tQV+TPrgyH4ug/e9CJEjLtIPfHnIuPUVmKMttANrtjdl2SKEHGQL81W+bOcPZyeZm3NupYy6R06cbPUdfvLzMUMX8eRXSSWbssvx/77mH9t/5is9+g64NHjGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfdjcpVR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfdjcpVR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae8979dbb2so28008335ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773189377; x=1773794177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4bZiY8Cpboi1Pazjknf1uOlcdytk2lAEHQvqE3Jnto=;
        b=XfdjcpVRl1aZiosTke7o1nUMUxxhJDQgfPfCnQq4bTyVkon0J1WHdnFV78YYCRuNBP
         5hpJ+FgceIJAtUHmdQ9x1f+SbS+JvTIByMwSZi+kq9/6XJjgXvqZv5O4+lmzso1ZUQB2
         wUb5JrPKgPXqv92DBySGKsTp4f1UrLRSMHCVd5oGvF/26R3apFMHExIhd2sSv54bl0cq
         e94oghqH8ZB3PcgyGe56LJ3ZII5omIphA2+0EWRODG6HwfZbcDOaShV7I/v7nRd6Rads
         Sifc5Hq0RSDN5GmSduPPM0XFFuIU9/tKs3Qmuc3jnnj97EcNlkJAXwpUtcUCVr/d/xTh
         Yelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189377; x=1773794177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4bZiY8Cpboi1Pazjknf1uOlcdytk2lAEHQvqE3Jnto=;
        b=oACYGeb4PWhj1HcEvD7j6jEX8ERHSgB/3zsMjGzcYYwBpvONGiXyhd601+zIcrJFT8
         4fvGxQVggV1XPKRJ1cthWcNExU38tbrB9VEZmZI9ZVbjDhH1D6FzJdTtWzL+muae3t8r
         YsOweoL5dFjoxU0qxk5vvXbovfI4Omr0khsvVRgd6wyUSZi9oSpLT21wQ8iU0xz1Gtk3
         KxHY88/cH9pYzfeF+Ys63sa8JrLeiFYjs5natV3AP5f6kh8C7KvPEDHQ1kDeEfPQqES5
         q79c0ntnq7UgwnHzvWLNNGIcO+pg1wy25/n0CnP4CwIdcoEY25paVV+c7XlZves1aZCD
         xtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUu5NM/ZIGD/R2Jqdod2UYoHqtuilNea8RzmsOHef0yDQP5V5aPDmLoDdX6nM3M9zhtD+nD19U6syIAnoY5RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1TqvwNaM3uuBNWJVciEn0cvTNCOFdplHBDPKM1sNcwEa8EJIK
	Lp+RzW+8Wd1EarKghTtd2/Fq82Q6e0GEIWICC2/CFLTAqS54B/Mt3uWf
X-Gm-Gg: ATEYQzwH21UUADG/02/baPT+Z5KplXORb3f8u/eYnTKczDhdq79iyVWKgeXE8ZLcUcg
	Hh0BRRsanSUDScayWfWlewEwNfnAAP+JJXufKJ0A1IE1eqGal6j+ff0OsXliaDcwJ/Y2neKH1EK
	hfqynmSIk8bkCb8VE4Mr8a/7KWy1db+OwTN7iZhNG8UepSRpir24kdzGSm+KMo84jTy6QQ1itzm
	Foj1Uz3vGESCYg/k7UR0m94eFdAjXbqL/IqkqyrzCtY4X16bAITdztu1dKHkPJjcDAHkZEDh6FD
	5svq28JXHkbjmECGPEbK78TtqRsfV7EfiIzxnUyKYL9xoOYa3FTdPKYXEbQvBMx4AtqYGNQKepm
	gpNhfZW8bCezPTrr5IDJE23RHHwUsQygng7Z89/yN31UObzyVJmJAGzHusxQawCEZSfV9pXg0+R
	YvhzNISWuFnK1+ZoutVXwTwIM3lVycBFHAMPsAt2GB+e453HnHBl7M4nXkwCoQqnsy
X-Received: by 2002:a17:902:e88f:b0:2ad:ba80:df62 with SMTP id d9443c01a7336-2aeae892983mr7181655ad.37.1773189377012;
        Tue, 10 Mar 2026 17:36:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34d7d2sm4275805ad.51.2026.03.10.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:36:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] mailbox: hi6220: kzalloc + kcalloc to kzalloc
Date: Tue, 10 Mar 2026 17:35:59 -0700
Message-ID: <20260311003559.31990-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce allocations to a single one by using a flexible array member.

Allows using __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mailbox/hi6220-mailbox.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index f77741ce42e7..69d15b6283e9 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -79,12 +79,12 @@ struct hi6220_mbox {
 	/* region for mailbox */
 	void __iomem *base;

-	unsigned int chan_num;
-	struct hi6220_mbox_chan *mchan;
-
 	void *irq_map_chan[MBOX_CHAN_MAX];
 	struct mbox_chan *chan;
 	struct mbox_controller controller;
+
+	unsigned int chan_num;
+	struct hi6220_mbox_chan mchan[] __counted_by(chan_num);
 };

 static void mbox_set_state(struct hi6220_mbox *mbox,
@@ -267,16 +267,12 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 	struct hi6220_mbox *mbox;
 	int i, err;

-	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	mbox = devm_kzalloc(dev, struct_size(mbox, mchan, MBOX_CHAN_MAX), GFP_KERNEL);
 	if (!mbox)
 		return -ENOMEM;

-	mbox->dev = dev;
 	mbox->chan_num = MBOX_CHAN_MAX;
-	mbox->mchan = devm_kcalloc(dev,
-		mbox->chan_num, sizeof(*mbox->mchan), GFP_KERNEL);
-	if (!mbox->mchan)
-		return -ENOMEM;
+	mbox->dev = dev;

 	mbox->chan = devm_kcalloc(dev,
 		mbox->chan_num, sizeof(*mbox->chan), GFP_KERNEL);
--
2.53.0

