Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565073B2FC8
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585076; cv=none; b=jo2JWUo1k+yjxyQuIwH7Wv9LJyNyHSK7jqxnu22NIL7TQSmXV3ubAZkS9Z0vMoJG92NJj3AmJ30y47HkduiD1qrA4U6TwMKUah/8JV1zaDGQHLNXiQqS2ggrPAZI4dIxGMsZsifsjsJXGor4NP+87aAZ7b5aTp/4JqRhLDc7wjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585076; c=relaxed/simple;
	bh=3r2B85G8jxTvd1UDrvTfWWr4k/Su/56WbzspyCx1XFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAHeA1Zy6wKCJsWZdf7d7MY7k9aQt1Iq1LOEiabHUEv4JWA0rPqu2mNE0hoq6ZL2CWduTHdQ5I6INguViA4bitBs4VhWRZ5fQvnSWqWBPqop5NAzODlUDkAZJdbb+VO5MH8BwXAIevVsPkNZDSAuNXB+AUoGf8zapd4gYLaiB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWtT9akR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWtT9akR"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so139922585a.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777585074; x=1778189874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwuWNAbQvKyN9/BBr9pqWcEyfCNuXgxlYdyugC/cdUc=;
        b=kWtT9akRJtUCK2npaNRBWH+1EdGmgya9FPgCU6FPgyfwp7YL9bJOq6U/fmsThMCbmz
         Cjh7dRNqxlQNsLNWC4wFh8TylwwEQ8oAfomYVkrAljQ1QNL5kSJJwnxqKcuNNk88l0Ib
         xN0IEPB+Dwa0Ae03lEV4Ct9MoSGhmqW8vQatF8ODbOqwbklhxvzUP9LkJH0Kj0P7gC92
         p83Gai8bIwmVIXHdXHwkP3m0Dj2cRkddy+gwS1UNRHL0qmTFIcCJ8OYGaRf1JI9W4fZJ
         kWi48K6ekScDNB0+ibozL9WXx/HSuN47/5FM0MGaWWi/OsGbofOZU4jnnJI/DUOvNACK
         a76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585074; x=1778189874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwuWNAbQvKyN9/BBr9pqWcEyfCNuXgxlYdyugC/cdUc=;
        b=eFAqXTwz9JcaaCbRrn0l2dBSduSRMu+kezSwK5D9a7YSpXcr3IcN14ldEfcKJOyjBt
         pdTZh0oHvIWshj9mxdZShv0SpY0xq4Ei3VwQYOvWVGGl6LHijZBqtpu8GEljWUGS8EVS
         B1Px88gk0AcOSjXwWa9EYN2MmNid82NQ2FjXkvMMb07zIQix5GkmNjsNaBjwKa1VjU2w
         k6Q7rgEa7QKIhHh3YgZMk9ppjqdvnjtxGuWKm48nw8ua9H4UX4h9FDBFn8Z2gWZrr8tQ
         mEw9hVv5aNv1SL9yRIXIjWp3ahhKV1vl1hhuRC9UPa5tr5P2TdHbmEhJFWhMS7x19x/T
         WFUw==
X-Forwarded-Encrypted: i=1; AFNElJ+JVUbiGJvb/K7IJYoEwfFPl/JTSY+rkGOfrhnhXuNjsAmdflLWSX5u+CtuBdhrIL37iTn6dlr3/l4KXwSd8ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xZwK3ZRw7Ie/UPKIuEnDdjuWvMOpOiYkConvzXoTDEvNRpnD
	ARlodv4NOSx5r6f6d3nLpbVZdahXB5Xq5SIii3IjozptMBckCigZHF5F
X-Gm-Gg: AeBDietgNGbIWGWKJ7u3mvATq7YSKY9pqLOQAw1NIELLW88fhstNumkbpNADNC8JpX3
	hwIhHgplZXieLn9o2k/9nm7JcwLinzA1V/sfAGu/BXeniBuYrOq0HZ9VOAbJC/G7hN+7gTxc6w3
	5kcpMW7I2MYOGd0MMhQDI37fRQ7VLXnjMrj5sVYe5yo/Ig+is/45YEpGUIHcDBb+9aDqItGvvka
	Gnx0i5ILNyPWKKeaVlD6C4rl7mNXHgoVMY1FBARHB5r+T58K/s21Jw+b3LT3JjipxCFEVS25c75
	wuev72E72zi3+qfm7V/HWLbZWg0V5mUHjXX/u5aIqV6wCNnlxxaJWuhS+G+gi9Rt6gB6RnJphnF
	cL9VlS/EvUSlOVMitnc+p74LvoHiuIDP+Ol3J4YisFE9B8Lay/ibVMTfoonPOHMLlfnc/p8GG0o
	QUU0TNE25a42GaDA6cpXd1UqXOebvkYpTxT7lNQTyUha8ma+wkP1iMXqZyAgHTxO5HT9oz/kvMP
	x+DaFPg0qvRPVfEeIyMyZn/XEU6G4jfwuqgZc07DLbbwjGoZcK9sQc4
X-Received: by 2002:a05:620a:461f:b0:8cd:8751:2b26 with SMTP id af79cd13be357-8fa89bfd6f4mr775977385a.58.1777585074216;
        Thu, 30 Apr 2026 14:37:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fbf078618csm28281485a.8.2026.04.30.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:37:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 1/2] scsi: be2iscsi: simplify cid_array allocation
Date: Thu, 30 Apr 2026 14:37:32 -0700
Message-ID: <20260430213733.54840-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430213733.54840-1-rosenp@gmail.com>
References: <20260430213733.54840-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kzalloc_flex to allocate cid_array to allocate cid_array as part of
the overall struct.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/scsi/be2iscsi/be_main.c | 17 ++---------------
 drivers/scsi/be2iscsi/be_main.h |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index fd18d4d3d219..aa5320535c1f 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -3992,25 +3992,14 @@ static int hba_setup_cid_tbls(struct beiscsi_hba *phba)
 
 	for (ulp_num = 0; ulp_num < BEISCSI_ULP_COUNT; ulp_num++) {
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported)) {
-			ptr_cid_info = kzalloc_obj(struct ulp_cid_info);
+			ptr_cid_info = kzalloc_flex(*ptr_cid_info, cid_array,
+						    BEISCSI_GET_CID_COUNT(phba, ulp_num));
 
 			if (!ptr_cid_info) {
 				ret = -ENOMEM;
 				goto free_memory;
 			}
 
-			/* Allocate memory for CID array */
-			ptr_cid_info->cid_array =
-				kcalloc(BEISCSI_GET_CID_COUNT(phba, ulp_num),
-					sizeof(*ptr_cid_info->cid_array),
-					GFP_KERNEL);
-			if (!ptr_cid_info->cid_array) {
-				kfree(ptr_cid_info);
-				ptr_cid_info = NULL;
-				ret = -ENOMEM;
-
-				goto free_memory;
-			}
 			ptr_cid_info->avlbl_cids = BEISCSI_GET_CID_COUNT(
 						   phba, ulp_num);
 
@@ -4061,7 +4050,6 @@ static int hba_setup_cid_tbls(struct beiscsi_hba *phba)
 			ptr_cid_info = phba->cid_array_info[ulp_num];
 
 			if (ptr_cid_info) {
-				kfree(ptr_cid_info->cid_array);
 				kfree(ptr_cid_info);
 				phba->cid_array_info[ulp_num] = NULL;
 			}
@@ -4175,7 +4163,6 @@ static void beiscsi_cleanup_port(struct beiscsi_hba *phba)
 			ptr_cid_info = phba->cid_array_info[ulp_num];
 
 			if (ptr_cid_info) {
-				kfree(ptr_cid_info->cid_array);
 				kfree(ptr_cid_info);
 				phba->cid_array_info[ulp_num] = NULL;
 			}
diff --git a/drivers/scsi/be2iscsi/be_main.h b/drivers/scsi/be2iscsi/be_main.h
index 71c95d144560..b5f8e746deab 100644
--- a/drivers/scsi/be2iscsi/be_main.h
+++ b/drivers/scsi/be2iscsi/be_main.h
@@ -241,10 +241,10 @@ struct hwi_wrb_context {
 };
 
 struct ulp_cid_info {
-	unsigned short *cid_array;
 	unsigned short avlbl_cids;
 	unsigned short cid_alloc;
 	unsigned short cid_free;
+	unsigned short cid_array[] __counted_by(avlbl_cids);
 };
 
 #include "be.h"
-- 
2.54.0

