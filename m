Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81828B4FA
	for <linux-hardening@vger.kernel.org>; Sat,  7 Mar 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854211; cv=none; b=VwxT74urD+gWZHTY9PjMgCejStdHEgOPrcC9qsqZF6+tBgEedwQnCk8tK/Mo3FS8+r29QjFpN0Qn97HbrL2sRuR3jRzV5Dbccmr6ji69zWktdfhJnPjRv/yPTTko3PGIcVTSjS4XbulcgBVT50gYp/RTAp9eAHykX2IdkHOdu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854211; c=relaxed/simple;
	bh=En+FSzjm9b3yZ7RTDdGPtQq3dmB2SMEVaIrfb8fKjrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHjzJEo+slTTgnPfNQPQVe9idOfl1KjsnIHtIX2VlL2n3M8ztwzl+rHeTKxg9mu8jNjac6+tWgKIpnWJqWOOunAAOo8DRUx78x2L0d11JGZOR1GKyx5URbmBuyHXwXvbMZquEVLbLToHGyKVRkDYMmYp6GPuc0stJH11YxmJsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmW9v62h; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmW9v62h"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so8649112a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 19:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772854210; x=1773459010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUfuF25BN8uUpJXhc6fQg9RcsbS0Xj7nnWqfeLrQ/Xc=;
        b=mmW9v62hsRnt3QJRlMY4Yha7OWE/d7Q3x75zo1Dsw/OeCWFcNPPet7n0nldJaHWRcV
         T/4vKOLqRtk9hsMXvMUTqGke3IFjLQ42oq43F8WE5UwXit4zLoBv0/VxpQNL0sQK79qs
         eoOqv/rT1G1TuZtsNChswA4OxAOJjJlkVeLCmCa+ixtZJU9Li1eyPnbW39bAL71Nl35B
         6ieazO+yrZC9UseWQ5Kya7lLpKb0d/frvElwvz761nr4bE8zvNZw37ZAI79h95oM0XFt
         o36QH2AbirI2Bkd7qA5sYeZWRQfngei943C81IWGUAfADNF+ONI+ljIynvMcmTJtLMHn
         jRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854210; x=1773459010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUfuF25BN8uUpJXhc6fQg9RcsbS0Xj7nnWqfeLrQ/Xc=;
        b=HbaGmBjMpgGbh3+9TCSRa8rE67gXuOjU/l2+Vrqx+eF1nbWZr2K5pdYTtZUo9MZhB7
         KFsubwX+QMM5pDjK80s0mjl4V6oIseDn7NIEXsuBquk5725RF8Ju8KfstaKia1l6piYH
         VLErvo2zEodlI5bxZndRGh/nwZtzqUQIU+5T2Oy6SMtsR84UBHmYDqE7yZnTkuMp7dBR
         1bxAiwL1lHXlcV4fYi5JB8t04eISxtTu66k3lVxVLmngxXLWl1UA2HPG/raWIhOaW+1S
         M2nf/n2T7EGJAc3OtwI+EnBUtF2xCVQ9ZB9oiWC+1VL46SLx05myYYFF6XuOYcPTL7iy
         BEmA==
X-Forwarded-Encrypted: i=1; AJvYcCXVrfq7A0SSuZsZtkMwvd9RSNUdTKjcQUTTp4EsucpunrrN/WN4HLcR1qc5dYO5IvzH3p31QHXaqscolj6kqPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFW74INhes0Rq89Lv51DjAyyA9B/PrCOnsSOU/PfnfXNjNazZ
	mjVA+6iBN0wbiYdfZU91z52uv7fmJCP7TKnbVYh/LSQ5Yrmg1oqt6N3F
X-Gm-Gg: ATEYQzxZAIS19zo4sDBBANxq7fPjVxpF3NRF/ypI1yEYRz2zvDOwAz9LX7d7MJ18RA+
	JPU64OZ88+AW+pK8nEyd0SlIIbfW/nrQdMHsa9llNutr7SrhXx3G45LFxu4gxhSBTxq3bJso992
	OSNAV/UlMWnOrlfu/DEIUjXW7uD1WDt7vDn0lL3YzqgveI9+uD4vQMl6Z9ClxtM57AMeu8QdW2J
	TZXLfPWCPfPBmuNM+QLAbUluM8lCJdVgq1tnHtx2DCuLZWTHm+6BiOzya/C4/pIXMiAhgZQf9KX
	aW8PJ+bw3JHS7ONbgqZLBQEaEv985mtaFtoeH/hR7QINXG9ztXZBNMLK7tNnJ5ok1Jm1KJYheaV
	TcT6ybHLR+QCv7QR3zYP4ovrhgGxnIjmqGhYvKV5dNfozmRutbtFTn14b11YLSOWrMlXL60Am6V
	MZTol0prjQtA67HintetJ40b79fl/HQiRckeJRRIT3Xu27oBSF7HrLSdI=
X-Received: by 2002:a17:90b:388a:b0:359:87ff:f34f with SMTP id 98e67ed59e1d1-359be2331d6mr4219798a91.3.1772854209474;
        Fri, 06 Mar 2026 19:30:09 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c003c51bsm3548732a91.1.2026.03.06.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 19:30:09 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: core: use flex array allocation
Date: Fri,  6 Mar 2026 19:29:52 -0800
Message-ID: <20260307032952.642014-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of embedding a pointer in the struct, use a flexible array
member to avoid the + 1 trick to point to allocation after the struct.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/hid/hid-core.c | 6 ++----
 include/linux/hid.h    | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 840a60113868..6bd6cbf26c6d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -127,15 +127,13 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 		return NULL;
 	}
 
-	field = kvzalloc((sizeof(struct hid_field) +
-			  usages * sizeof(struct hid_usage) +
-			  3 * usages * sizeof(unsigned int)), GFP_KERNEL);
+	field = kvzalloc(struct_size(field, usage, usages) +
+			  3 * usages * sizeof(unsigned int), GFP_KERNEL);
 	if (!field)
 		return NULL;
 
 	field->index = report->maxfield++;
 	report->field[field->index] = field;
-	field->usage = (struct hid_usage *)(field + 1);
 	field->value = (s32 *)(field->usage + usages);
 	field->new_value = (s32 *)(field->value + usages);
 	field->usages_priorities = (s32 *)(field->new_value + usages);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2990b9f94cb5..e2c3e2528582 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -524,7 +524,6 @@ struct hid_field {
 	unsigned  physical;		/* physical usage for this field */
 	unsigned  logical;		/* logical usage for this field */
 	unsigned  application;		/* application usage for this field */
-	struct hid_usage *usage;	/* usage table for this function */
 	unsigned  maxusage;		/* maximum usage index */
 	unsigned  flags;		/* main-item flags (i.e. volatile,array,constant) */
 	unsigned  report_offset;	/* bit offset in the report */
@@ -549,6 +548,7 @@ struct hid_field {
 	struct hid_input *hidinput;	/* associated input structure */
 	__u16 dpad;			/* dpad input code */
 	unsigned int slot_idx;		/* slot index in a report */
+	struct hid_usage usage[];	/* usage table for this function */
 };
 
 #define HID_MAX_FIELDS 256
-- 
2.53.0

