Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3C1F30AD
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774500465; cv=none; b=pAwS33OlzukZ+zp+XRFWwlOoSFvOifcLIj4R7P92sSaEzqCwIRXWmdl9cu2zOevAubMKbkoSL77or8SbVCQ7Bae1oh2br/CNonmKbB7X8CF68lbC4m3P1ZzSihtcyXQxWCifWYKackZgYxyOpTD5jlNGM7RguJmV6otZcCcESlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774500465; c=relaxed/simple;
	bh=enIePZES9mAwzHxii83XdVR79QMLNQ6733M4z2BEkbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWczN7dmUaphOkMw02PFiXiKK+9sMSDgUAGau8dpLUavwVwQ1T3WQ6a2YEPR5AHp00uPwXxFu5q/hsZFbTqDdAOedCv5lri/xm36lT6GNiXBiNMqxhdExtc9qsC44SFAR6sUGtwrGGb1T9abBlVQu7yqpRclF1eKlTkBDi51b7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzUl5+Ou; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzUl5+Ou"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748257f5fso843480b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 21:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774500463; x=1775105263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqgSX8Vcy8BPQx9f5LK0T5izva2Jdg4IuF4rO/Z1qI4=;
        b=IzUl5+OuHpjvkiT0CONK1rt1SgMjUpsVsWDjjxrF2oM/tWs//j3mZaDNpuzjfKhd/c
         1CrS2ptqyYpTZXcACiFQMOANxRZJ5n5mxDCdT4hCtenkpN6S3iLuoCVsnHz0eWYMYv42
         D0zcuMnE1wqgIcGLYoY28yQzmnpxGq2LH9bA04rV9Btbb7gaTP0/wIJScoUwuxjjnaib
         3iXpyh75NAPxATH9UMEafVX+meSdf2cJC8EbnJzNbucVw/IfgecLhvjXiiR7OFVpgdZu
         xgPQwXntRzwN3FOF03CLbfVikOxDsXGZOfhQgsL7BJaFDvhL4y5Grzt2QNvfcg71yz2y
         LeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774500463; x=1775105263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqgSX8Vcy8BPQx9f5LK0T5izva2Jdg4IuF4rO/Z1qI4=;
        b=RRQZXAYtIu6xoY4Nqmse8oFm+/Y8X0W9wzNwZI4L8dzlxMRMl0AThgMps0WZdww9m3
         rG8OJikCJXSZYkta1jlUeVt30BkA7fbwe9KJD6O9h56m7RYIeghr8N590wEC7qeOlOo5
         Mt67EqdkikfZXiN+Fv7BiiY0tqeRGSWwdn4pz44jUBrbqD1KDq1SIATGd/4LCmJt89Yu
         rNL2kI4Vw6z7ttSPj92+lI1I5sVGdR+AmP52c1nD+rufhT74MII/7wfaOH8X27FQO/LL
         A7DiyDdVJCkddhhIjof3cYf3dt/7Oresn0qHNAyiDos18Lb/NhSGsxAPI1vupdWkrqnB
         swMw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQg+gJCjir2fNZc4k3N1iVW7yZkMH9d0SWS89MlA8DGN9APON1lzz7VinepJmFgRetyGRIjJZfsqKts3EHro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGD95bC5jqsKoKszOk1tYjDP6CRiFoCs8YVhy7Fq8K6gsquKa
	IBVDr/I8oAFdnngSgpPKTmtZkwDTwbHRDzxGA0v7Byb6rMRUm5M1rYY/
X-Gm-Gg: ATEYQzx36BiMUsG2CQoWd/TgD7hmsHkyJ/FUW5T12WUVPd4wac2kWVN1iOv+347Y7J/
	Kb86ZqCfOX4HckO+6rzap6treqQnj6IqxYgjnAOqpRfoTbD/UYL/iKH2dKMvyNzLIlFMpCZfkFg
	kY6ukCeZ44P9O/+96w8knIsnkVwb43pArmoeyPCw1BHbU9XMTYtI9W1X/hmlI0ZYgNtLpVny1rF
	ln5/txPtRvlDASKvdK22DhcnHbc3RdBtfGE7YZZROXOlJHTnpzOYJFicFV4thCLoyHDN5y4s0YM
	7VmAbcLL5DjneHsviWB0zCXtruu0hJM2b8nmut8EoWBuSfbZZPCZvtg+WVcCzYkwDJYhhwwWH14
	W762KnvHn9YIgTcPWkqGoRDlIiRm0B9VZ+Lbn0lieK/Goekljibe+OoknfIFN8IvB9yR4yFtHJr
	86wKnAEVcsxkG8Yxd97FFvPBsDRCyuwQZN6Na4Vnev8/lvBjEh/VNCZCQ=
X-Received: by 2002:a05:6a00:cd4:b0:829:7a62:6a with SMTP id d2e1a72fcca58-82c869c8e3emr176965b3a.22.1774500463220;
        Wed, 25 Mar 2026 21:47:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3c0e3bsm1438979b3a.45.2026.03.25.21.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:47:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thorsten Scherer <t.scherer@eckelmann.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] siox: use kzalloc_flex
Date: Wed, 25 Mar 2026 21:47:25 -0700
Message-ID: <20260326044725.234216-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper function to allocate a struct with a flexible array
member.

Add __counted_by for extra runtime analysis. Add counting variable
assignment as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/siox/siox-core.c | 5 +++--
 drivers/siox/siox.h      | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 3e8f3b6a4555..b87e2a12d640 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -689,10 +689,11 @@ struct siox_master *siox_master_alloc(struct device *dev,
 	if (!dev)
 		return NULL;
 
-	smaster = kzalloc(sizeof(*smaster) + size, GFP_KERNEL);
+	smaster = kzalloc_flex(*smaster, buf, size);
 	if (!smaster)
 		return NULL;
 
+	smaster->buf_len = size;
 	device_initialize(&smaster->dev);
 
 	smaster->busno = -1;
@@ -854,7 +855,7 @@ static struct siox_device *siox_device_add(struct siox_master *smaster,
 		}
 
 		smaster->buf_len = buf_len;
-		smaster->buf = buf;
+		memcpy(smaster->buf, buf, buf_len);
 	}
 
 	ret = device_register(&sdevice->dev);
diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
index 513f2c8312f7..e6809fcafa0f 100644
--- a/drivers/siox/siox.h
+++ b/drivers/siox/siox.h
@@ -27,11 +27,12 @@ struct siox_master {
 
 	size_t setbuf_len, getbuf_len;
 	size_t buf_len;
-	u8 *buf;
 	u8 status;
 
 	unsigned long last_poll;
 	struct task_struct *poll_thread;
+
+	u8 buf[] __counted_by(buf_len);
 };
 
 static inline void *siox_master_get_devdata(struct siox_master *smaster)
-- 
2.53.0

