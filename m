Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF03B0AF3
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583073; cv=none; b=dob8hZp5wdJxy+kZI/YtHSB9RXxgSTjLRLUDX/3LR7N9Nf+ajVAglePn9KUqCUurL2r+xbr+4K1AsFjzukFJ7nkhnzSB3cS/irYCfdPbxQd2Uo+hZLrIRfUNpPsKIVmyRTS6uTdeJQV02WgteulC2NK2DMZV+4Vjk2p1Kd5kH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583073; c=relaxed/simple;
	bh=/Ym5QeWDmS8aXaCZ0dJMdfBuuWVO2xCRZ9rCNhhr6qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSyjrC5dWCUjbIOwf73+mP35EbvqaBig0Hfp0lNii4FlZ9fJLDbk/sE0oEKuq+7vJ/INkkR1prpiCNids9UiCRY60xnv+WkvxI5qgTWxjQnXjYXDyTXzcf9pjxvu7WKHMIPsKfm3wcGqMP07/3jDTeKHAyA58lAkaV5LzyDGGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ89f8Dj; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ89f8Dj"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-362ddc1de56so877788a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777583071; x=1778187871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GuOdTdW6Yw0LouknCktkX27HwvULvRGgOoDUGd76UIY=;
        b=hZ89f8Dj2u7Bu8s7wEKPYWVBBFlRhGzGmdqjpA2+6Jro+Lc768XxltP2JVR/wKoDGt
         rlSTlqD11KXWn/gQQ4amPQt/WaAbOKtqb86Wp+R2/uY+9rg6UVux9P0zRYo++Yb6wD8E
         Mo7+jY9ObJ77dW2FNTjBBzoe1470Y6uPNe7tDSjcdn4vmDlJYPH7UUr1ru82jvzryQNG
         q4T4GBXVBfh74PGRwKMOh5BggwoBlVE6B/ZB1PG9Zv1WQgVkLAL/Li5rGubSqap02k3G
         I2FWVDzWlGSdPp5KDvXbDENFCAM4OSBjnyMdaHQbuGkyJM2cR6FAO3yoa/QdlH6z/AlM
         PyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583071; x=1778187871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuOdTdW6Yw0LouknCktkX27HwvULvRGgOoDUGd76UIY=;
        b=JbK8XnFy6enQKV/Xm/3S86xBiScxV9dw55nK8KDOZnf5zHxbi4fBlzXTTDYOymSRVZ
         ZEuqNWSA8/OTrDEytcMyfVu9HWxIDty6u/tcWsVs2vf43kfuPMVg4RmeLMXh+5Aly9hq
         ZM7G4pGKm9Xe8EyK5FaJ4ZI6boYm+mjKLYzUXeyXnVRiF/a2McQshGHWzZXMGkqlIk8z
         h0WjCoWfceY6WVX8+ptUfyS0bVFehtZN+2Bq6Zyl3GptzAYWdrL9BX7yoRbcX5veXwIc
         wXU93oy1hNrTm3Qn3p1fND51tYe4BCqRk5OnLWrjpsUAjS2X2CilbgGINPibS0ZfOnMR
         U++Q==
X-Forwarded-Encrypted: i=1; AFNElJ+c8MIHw6UoTX6pCMwe66LJvWIQnta2efD2plUt+K3u9Bug1KK2f380uVKUOZy3XiN5UmtI1ZM6ImH1GeAfoPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXhk2jyrw9M5/5T7GyySmTcJB+CxXtlxwB1YO5DwHHNHODV0H
	CX8O4t9ldB8tc8uR/nkSPE757FRHOrhv6Hs+ioVJYz0HNi2piGAN5iB68WpDjQ==
X-Gm-Gg: AeBDietsYbwNBOwvMAT6ZX27ffFmTNN7GIXszMoHIkXxqk8tdhhpspiAdwN4eKjEJyJ
	jY0xP/m+0waLj5BzBO/Y5Vj1Ipx/DkYsT+ruj7/Kk2yV0wwbn9BNuA1MwyotAPfnDUV0scsioQP
	hT0TVdmcZPyWREnc2FvN7Rtum89Rz85tDqkY+ZdGqAAOdszw1rfiSSLqXDIaCxXhaUzHw+WGxNN
	u9D+IH6x+VgryXfLT3k730xUvyswT6zwW6VloLTEpT9/wCwTsGBzbd+Ug9xQoBaRmQ61yiZYx5S
	X8JnmoSnv46MfFRY2zLyfmt9ByTz3wM87P+dWFciHA6astHcwiOX3cUY9maZsxhyqJF23Uhl4bM
	ppZ6FGGu9j3jLJVenodbrwUu5ZwHO+J6dNNnzZ4ZQVbP/Vq4xOytn8Lb/ENuBQp2yqcBZ+nG3BY
	yfLdwekU4yE/MDkgLoNrE7ctpyjPwSrHaE7x07xIlMLwrx91aEzoJiXUCcVFJbXEnXiRe59l190
	/UHtx7rU+kxTJgsE4AGd2xybTsszlYPZSsAWoQE5deTrg==
X-Received: by 2002:a17:90b:2f87:b0:35b:e593:b1d7 with SMTP id 98e67ed59e1d1-364ef3a7c4bmr256089a91.12.1777583071151;
        Thu, 30 Apr 2026 14:04:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbba635dsm487794a12.3.2026.04.30.14.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:04:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ALSA: seq: oss/rw: allocate evrec with main struct
Date: Thu, 30 Apr 2026 14:04:13 -0700
Message-ID: <20260430210413.31185-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to simplify allocation slightly.

Add the header as flexible array members require full definitions.

Remove null check and just kfree. The former is not needed.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 sound/core/seq/oss/seq_oss_readq.c | 13 ++-----------
 sound/core/seq/oss/seq_oss_readq.h |  3 ++-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_readq.c b/sound/core/seq/oss/seq_oss_readq.c
index c880d4771169..6b474615ced8 100644
--- a/sound/core/seq/oss/seq_oss_readq.c
+++ b/sound/core/seq/oss/seq_oss_readq.c
@@ -34,16 +34,10 @@ snd_seq_oss_readq_new(struct seq_oss_devinfo *dp, int maxlen)
 {
 	struct seq_oss_readq *q;
 
-	q = kzalloc_obj(*q);
+	q = kzalloc_flex(*q, q, maxlen);
 	if (!q)
 		return NULL;
 
-	q->q = kzalloc_objs(union evrec, maxlen);
-	if (!q->q) {
-		kfree(q);
-		return NULL;
-	}
-
 	q->maxlen = maxlen;
 	q->qlen = 0;
 	q->head = q->tail = 0;
@@ -61,10 +55,7 @@ snd_seq_oss_readq_new(struct seq_oss_devinfo *dp, int maxlen)
 void
 snd_seq_oss_readq_delete(struct seq_oss_readq *q)
 {
-	if (q) {
-		kfree(q->q);
-		kfree(q);
-	}
+	kfree(q);
 }
 
 /*
diff --git a/sound/core/seq/oss/seq_oss_readq.h b/sound/core/seq/oss/seq_oss_readq.h
index 38d0c4682b29..d8e1e7504d8f 100644
--- a/sound/core/seq/oss/seq_oss_readq.h
+++ b/sound/core/seq/oss/seq_oss_readq.h
@@ -10,13 +10,13 @@
 #define __SEQ_OSS_READQ_H
 
 #include "seq_oss_device.h"
+#include "seq_oss_event.h"
 
 
 /*
  * definition of read queue
  */
 struct seq_oss_readq {
-	union evrec *q;
 	int qlen;
 	int maxlen;
 	int head, tail;
@@ -24,6 +24,7 @@ struct seq_oss_readq {
 	unsigned long input_time;
 	wait_queue_head_t midi_sleep;
 	spinlock_t lock;
+	union evrec q[] __counted_by(maxlen);
 };
 
 struct seq_oss_readq *snd_seq_oss_readq_new(struct seq_oss_devinfo *dp, int maxlen);
-- 
2.54.0

