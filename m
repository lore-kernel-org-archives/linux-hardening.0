Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC007EEA8
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523719; cv=none; b=nc1Y4DswHIUgHo5awOopufnNlTrTIJpxfwW+LFDXm7in/c+jRCTXSvlvt4lq7rzU5ZGbfg/HNkMLwsMt25eNpRkcSGdoAw1dllpl9gqBOXoOcRF4dnscGb8MeDLh9xDA6xUR2YowBYufgyjdgf9cpOtpd8ejkgqp0ufuDFO2gF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523719; c=relaxed/simple;
	bh=ldVkH82Ogb1CKzMVpqM/V/WVuLz1cIfwYBAeg4IRBJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdE9GcavEawKdi7FMOj7eJHpDqJ3yO76Mw2+gzl1/5zqkE3QWAGzsmWxdt4K1IMnAllp38UF49pShgtgEizGJolv//jK88aeu3M+N7dutg5SYKWDAQX34MG7K7X36VLRtjcD+yKWMUnKXDThJr4wSCWkkY3w+q4GA/+RWCd0g90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjOLlmtf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjOLlmtf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2ae8a0103so1669175ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 06 Apr 2026 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775523718; x=1776128518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtZf8qslJlc/Qs5L5CsqmY7NGi+VR5R6jMYyuK26CRA=;
        b=AjOLlmtfxw0+0QfSGdRB9VMleQoHQv9YEk2/92cZArjSutajN5cTGqcfOXcvYA7TCL
         +TY+ydstEJVBxK3mDUztJjkd19VD2CkEzUHdUndc/VwARZYi/5hKwGaN6MdzjVTMUR9b
         4JHRAlEkHZlIHTypd8ZQ7Dv42uJpAsglxarDdYJ9oz0ha3Lln+KiTniEwRDhyJPJMr5y
         uLdrxla38CIwFaUj2eDcLromrVYKWWm/jos/xjkNIbw3XNsZehJaQuC2kuBW1BfqZMBf
         PgqmVBk8WQpn/FWlblRAQtko408rAnTI7KQVmvrJ8eJCwIk5CAVC0rvGCO9LkbF0lDo3
         uq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775523718; x=1776128518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtZf8qslJlc/Qs5L5CsqmY7NGi+VR5R6jMYyuK26CRA=;
        b=hZWmgeBJv7oY3a3NQoDl2RX0u67EEvNn5x/qUcCw9ScGrexLLa/7595lA90CKBtNH7
         qUQdqEG+Uu5j17360c65GI81PI16l7PcEOKJzlfm37GbaBeU4D/Bd99R6Hh91vw00dq+
         l2WELsD+OiiXF+Qze9tBqjldndjwt+MTfhEYvPoRDK+s4ebV4JseIL1re19eboqZV8lK
         +fbE5Owwgp4WsqRg2xXLaJQRXM94lafZk0CTR3Bfyl3G9eyk0Ui5bL9J2ELUq1XT/2Nr
         qDiOWvseaTBnxsyhlWE8gZm+g8gXImjDcc13vUTURTx2yVXpiZdKgCz3VhhV0xEyVpCy
         Cvhw==
X-Forwarded-Encrypted: i=1; AJvYcCXeSEdBfRQlRmVVFJo2oAtw8QtpY85rRCqqsv03MI/1yRYNPY+RzZSzpByFlsKTDI1e/wE5gyFLUHrOssuc/28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJosT4+DTUX6wi2L7NONRl1pfQU9erwDOpsw9+2qDHc/JHMixU
	hc9i67wMrCfctl6sM5IrIWi5fHwAH0D/Chcqqz9o3zhxM+vYzQ4/g2DD
X-Gm-Gg: AeBDievwhiBSgwfmEO994q6OHpjdMjt+Gr2mb1RxHzl8R6KFdOTCRna4k7fGQ57ek5o
	3W6tseHfL56xAmsuuGjLI0xGmGnfTTVl60bcNGaXLfcxs0z7k8HNgKlVDTseB5Pbly3T4++thel
	qBYmUf4J9QjMaI+pNBeZ5GfoAIp8QKgRTUl1uUQPblbPLBSzQpOdTX1fo7NoddDrqRGng2Sy5v2
	hvx6ntSKu8gXVxMFw4ZjvWDhvMwIlSNDrQ58xHtXxUGb9qM1qt9VpK/dAO2588AUttNw9LhpLzq
	dF5UJkc684Tqi+KqpIO4xelL73eqIj5gCsVbNOHARCV/he/n3DH447QUrAIky7cXKqtl9mRx+NM
	Y+fRs7JKpkQCempOzB5EuwnlOmvttDpPMw0otKlmE0PvUuHA2LduLIdhYNt5ar1YSjU1oCvFBYZ
	vlAZExpSpyzRc6tDICWM4T6ZVswXlfS0bdwsPVZe32tgpfWj6RgmTmPlo=
X-Received: by 2002:a17:903:384c:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b28176a464mr150754885ad.27.1775523718187;
        Mon, 06 Apr 2026 18:01:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747341a8sm153194735ad.3.2026.04.06.18.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 18:01:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] media: dvb_ca_en50221: simplify ca allocation
Date: Mon,  6 Apr 2026 18:01:40 -0700
Message-ID: <20260407010140.3229-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations and simplify memory
handling slightly.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after allocation as done by kzalloc_flex for GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index 1b91ebb8f667..a792feb076ef 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -125,9 +125,6 @@ struct dvb_ca_private {
 	/* number of slots supported by this CA interface */
 	unsigned int slot_count;
 
-	/* information on each slot */
-	struct dvb_ca_slot *slot_info;
-
 	/* wait queues for read() and write() operations */
 	wait_queue_head_t wait_queue;
 
@@ -157,6 +154,9 @@ struct dvb_ca_private {
 
 	/* Whether the device is disconnected */
 	int exit;
+
+	/* information on each slot */
+	struct dvb_ca_slot slot_info[] __counted_by(slot_count);
 };
 
 static void dvb_ca_private_free(struct dvb_ca_private *ca)
@@ -167,7 +167,6 @@ static void dvb_ca_private_free(struct dvb_ca_private *ca)
 	for (i = 0; i < ca->slot_count; i++)
 		vfree(ca->slot_info[i].rx_buffer.data);
 
-	kfree(ca->slot_info);
 	kfree(ca);
 }
 
@@ -1880,20 +1879,15 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 		return -EINVAL;
 
 	/* initialise the system data */
-	ca = kzalloc_obj(*ca);
+	ca = kzalloc_flex(*ca, slot_info, slot_count);
 	if (!ca) {
 		ret = -ENOMEM;
 		goto exit;
 	}
+	ca->slot_count = slot_count;
 	kref_init(&ca->refcount);
 	ca->pub = pubca;
 	ca->flags = flags;
-	ca->slot_count = slot_count;
-	ca->slot_info = kzalloc_objs(struct dvb_ca_slot, slot_count);
-	if (!ca->slot_info) {
-		ret = -ENOMEM;
-		goto free_ca;
-	}
 	init_waitqueue_head(&ca->wait_queue);
 	ca->open = 0;
 	ca->wakeup = 0;
@@ -1904,7 +1898,7 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 	ret = dvb_register_device(dvb_adapter, &ca->dvbdev, &dvbdev_ca, ca,
 				  DVB_DEVICE_CA, 0);
 	if (ret)
-		goto free_slot_info;
+		goto free_ca;
 
 	/* now initialise each slot */
 	for (i = 0; i < slot_count; i++) {
@@ -1939,8 +1933,6 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 
 unregister_device:
 	dvb_unregister_device(ca->dvbdev);
-free_slot_info:
-	kfree(ca->slot_info);
 free_ca:
 	kfree(ca);
 exit:
-- 
2.53.0

