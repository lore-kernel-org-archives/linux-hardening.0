Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31D24B28
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707258; cv=none; b=hXvMgzEDbqx9YiFCEToQ9UXDV3/r8vI0iXGUBeyOoK7bXE5VxTikifUGKRCA51PnGKusRN/QQt+v5aDl9ir2XZPBbdU9vYsfhIFrCRLDQ6hoSSZPTtTPWvDzQjvmu8Fu3mFLkr+Npp19y7yKSCiYF7qhp7SZoT2FxoB+qqNSwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707258; c=relaxed/simple;
	bh=gNmjgpW/Y+P21Wq8CTMHqjQ/bWwEJX3LvBxNpqU5zVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBkSti0Pd170xQLrAlXjgPUtp5INV3uOLwRTT+faSR02bbHgkZRa34IH6Ix7sMN/E5CPHAdfqEuHgBmE0gfy/t/0Osf1DhiBDckjiP+eIZ2LuSJX4mcA5YRdi2wPf7UD/nUlAuaTYYUMwtvgRareZ+xoJihwdd6PDPv0HY+Fh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nopC97FT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nopC97FT"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829781b2b01so3267905b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 17:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707257; x=1774312057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl3Hhb5H1W1bOTwoWwjPrvMCUzzs+o+s/sL0FfKCb8I=;
        b=nopC97FTM6i8BAwa3VutD749G2ZkfpA8S93A3cw0cO0XaiGNtuxv4Otph1Srjf9LrO
         mzANeb+Zfqs786w3gysMLAaQZkM+c2UZSZNKqGpjwSPAGkzjtA89n43yzg7t9aJTHv/C
         D8QLUUKBk3RkM5nMP8rOCtQb2Rg17O4mjO2XOj/tO5WmYlj8zXEcAL2Np1OoBVbQedh/
         8IkysXu1POsBM62UWM50lits1XcfZCeO90ibkGE+yHQXb/jF3G4XD/G1tuDlIA1uuFDk
         NOakRCh3jUoVSTaFxltJmNln15ul0RpjZIJ04JdjrAbpZgccT2K3XkoEoNa+V+CW3WTU
         MqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707257; x=1774312057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl3Hhb5H1W1bOTwoWwjPrvMCUzzs+o+s/sL0FfKCb8I=;
        b=f3GPy7sCdOQz2FFGNIHLRUsy8KD+woli9kCYRQ7iVmtlVOSASmK3iQWb5qcW/gdhYb
         jIw1rQqtvEFIcsH6KtSEGENp9ZZXYxAFVQ7DdrDIRgq4I3u8gQ3GrBNCgt7vFamH3037
         lWMYWKWfvrvklRs6sb8wO5kLEgRc/dsQtqneCclKLNUCo5iB5ejCAuYaOg+2lfmsxWIB
         +1Ok2ILIMMXRUv/+RT3511HPgnRXYkB5bCXAWuyukeqSV9A9o8Bu0TQ07JjKxwvIsSB6
         05d3Ijc8/yOnC1lUTNpN+zgld9C7ovg4Cw7aEZ1eEf7TnqkVbDrp0XWazN3gFsIT89Om
         4Hew==
X-Forwarded-Encrypted: i=1; AJvYcCVJP2R74W7tAnYLLfU4cOEFnwaNyCYmtaOk2bhoWp4DbTr8daIewD5nTNcjWx2IEkPJOoUE3yWy+v05ayLX+9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyajUycwLiCbAvdyKh3mnQhiU8GNiwtDl6QQ/zdQwCzZJRBsjcz
	D0+0K2WH39T/fYMST4NoAXCAAZNzfmDz1nAsc2oW+HFofmcJSLPsUp5X
X-Gm-Gg: ATEYQzy2jERU61znRaGxaYU29iYKrgutkSYL+YmGUTQHLyi/CrQMmp8NIAd1xqYmUvr
	rNAUMDFANbcdGL4IiQZvczzLS5sU1NQ2Yfqc/bybIGZvHJC/DHM7TEHybRrhs+XyexAt+PBZvNb
	IrgvJU6cT9JnNNEGOBLWLaIjDFZFN6ycAy+SXwqaRR4KG18CxF3GaiOum4rt5cQ5kfi1qKWy6XT
	mpCd6m6Wa3WHDNf57akOA1gRpwdyX9I/4XJ4vWsHfw8k0bWhbosBRQUDty+9FNAuT+M5d57CDBe
	u9lPQljxhJIUil5u3G3VUxI2IAi8sy6Szi4XOIM9eZKgIZ85Ruy5d17F3mOA82DS069Ozfl0TC7
	CJx5AogBLIT4ev5MHx1pEXJmYSo2DX/9BXNkQaXhFZHup/k5v3appNvgBH1YLt+jRXSvceNz1xA
	yUCmnqYMctzeo+Fr13ayk9GuhK5eH1T+1/JV6SJJcpxAchWdEf5S+Nko4=
X-Received: by 2002:a05:6a00:130f:b0:81f:50b1:51f2 with SMTP id d2e1a72fcca58-82a198ac3b2mr13377514b3a.41.1773707256696;
        Mon, 16 Mar 2026 17:27:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340518sm14720798b3a.34.2026.03.16.17.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:27:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] i2c: keba: simplify allocation
Date: Mon, 16 Mar 2026 17:27:17 -0700
Message-ID: <20260317002717.70829-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc into one
allocation.

Use __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-keba.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keba.c b/drivers/i2c/busses/i2c-keba.c
index 9420c8b342b5..23ae8a609008 100644
--- a/drivers/i2c/busses/i2c-keba.c
+++ b/drivers/i2c/busses/i2c-keba.c
@@ -51,8 +51,8 @@ struct ki2c {
 	void __iomem *base;
 	struct i2c_adapter adapter;
 
-	struct i2c_client **client;
 	int client_size;
+	struct i2c_client *client[] __counted_by(client_size);
 };
 
 static int ki2c_inuse_lock(struct ki2c *ki2c)
@@ -508,19 +508,18 @@ static int ki2c_probe(struct auxiliary_device *auxdev,
 		      const struct auxiliary_device_id *id)
 {
 	struct device *dev = &auxdev->dev;
+	struct keba_i2c_auxdev *adev;
 	struct i2c_adapter *adap;
 	struct ki2c *ki2c;
 	int ret;
 
-	ki2c = devm_kzalloc(dev, sizeof(*ki2c), GFP_KERNEL);
+	adev = container_of(auxdev, struct keba_i2c_auxdev, auxdev);
+	ki2c = devm_kzalloc(dev, struct_size(ki2c, client, adev->info_size), GFP_KERNEL);
 	if (!ki2c)
 		return -ENOMEM;
-	ki2c->auxdev = container_of(auxdev, struct keba_i2c_auxdev, auxdev);
-	ki2c->client = devm_kcalloc(dev, ki2c->auxdev->info_size,
-				    sizeof(*ki2c->client), GFP_KERNEL);
-	if (!ki2c->client)
-		return -ENOMEM;
-	ki2c->client_size = ki2c->auxdev->info_size;
+
+	ki2c->client_size = adev->info_size;
+	ki2c->auxdev = adev;
 	auxiliary_set_drvdata(auxdev, ki2c);
 
 	ki2c->base = devm_ioremap_resource(dev, &ki2c->auxdev->io);
-- 
2.53.0

