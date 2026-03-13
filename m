Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA936C0D6
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439017; cv=none; b=l+2Vfn6EWZZ7FhyFjVRIepWfU1Jwm75y8orUPbHjiq607kJ/UCgJdEE3Y6Dt8TL1U6j/z/KZL0HN78dGUh7siw7F4UsMJ2xXPX19LJVWchp8V2VXZGaRogQccEJz3OB+FNtkcKuL75Fnofcl1GhAcvKQ9nwgJzFZ+NuekzdgiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439017; c=relaxed/simple;
	bh=p8xoIArBlppC30RwPeF/veB1TKIg57IxMIAFYPp1Avc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KF9rctAHRJERiV2AekT918m78FppJFxX9JhNnbFSls/dYHxh8qg+oDr3LSNTbis+yJg6DZt8fCUqAVNOWXzYl74LSefKoOPx7kLi/v1vNg1ZGUcE14LiarHwqmn5RpaiyPOtodWAd2eeBDLfolhAiy6Jixr4mHqYeKM12aBtYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVetRbZj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVetRbZj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae5636ab04so28781485ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773439016; x=1774043816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWNsUFZ1Eksh2ypyDZx8PXfQxHNZvOE2Wf+PolOcJnk=;
        b=CVetRbZjWF91wFZExEMyz1juHqWATFtlm3hQMneThDeDTmce2Lc7W55lEntPRZTdlG
         SX3GyqNXd8rMldJqhgf/bWkkqmTKBpcYWi5Gj+jug3915zz1pG/N1Ua68aRBOk2yQAMM
         734UoX0v7v8X4qU4NPtl4AfSE+ywnglGECksDa01Z5e/pVo7gH4pJDII54S9nYcrwouG
         GdPYkq4xclfSp8ynh4+0pkx9+yshF/622vqjzlFYBtAUdcsOeNhbkA9RcgQ0TdGhAU3T
         B+MErMB9YTmVKNMTOFFCjHkoxE1UuIRxuyr789L5RRcklnBUhqjkL38hfjFDcviMPdv8
         af2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773439016; x=1774043816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWNsUFZ1Eksh2ypyDZx8PXfQxHNZvOE2Wf+PolOcJnk=;
        b=NGMRq8eeiv7pHGrGDRCqrci3bwPispO2D6rtCQx1IVRG6+nN1WnSj2MsdRQgtg/46R
         6eHCHBPd6X7PWGF26UHITQdWITD9EXxbyXzqnwix3AJJAWk7wHPbNLBtHMvWn/qUWO2w
         YuIaSAKwerMhBnFy+dxewYDlYWXmtDbxPryqL5EOUf3ZUuuk1F9GoBc/wwemZSVY3ELM
         SdbDLZQJ8+uwIavU1ZrGnpzRR4rPRwDp+llY6A/1V5Xe+cHRzHhcy3GBJIFfLrUNTvTp
         dR84D+LlndqSH93zej+rJUR304K74ddid59pPWC2Px9U6rbxxZq1aKkRpaQ5F7Jv9IjB
         Ou9g==
X-Forwarded-Encrypted: i=1; AJvYcCUtscCxPNckbpM9qoVdK7FvCNTujOCqNZhYVPMDQc8Kb6ffH75dHuuwDF3464L/rwMCw9ja043qp0Is+HDJV2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiA4PaVzYzK2hAXTxvNxFFLIzZ70OhAEj2sCxIuR+qILMro27d
	yd8ESqlvmN9wW0YxAb1tvTfsaqxsU6py3SFIe4sVEf974DH+xl5ddg1n
X-Gm-Gg: ATEYQzxdHC9+KJHunitgstqmwOEYrZpbPna3sJ6XnaIwbH6H+NE6sKpVrpbqZCKDIzt
	udB1bnx7BZPjqjCy9GPNHNZ4joFqgyr7tY2Uk6Xzui2HLzUGDIz6nk8Xe/NMkZLv1Qb+RWumhZ4
	F80BdPnqsn3fVBMMjXiYl5MSRfwhJBfHk+BH8SNF1ye2+HD5EIIRUt88r7WPX5rCy6jBJyr8e18
	gj+za5D7zsTSU0DTeWlpEFnPGp8jtj4OKyf+qGMAbiBFV68F0u3N6RvN1XXv0lQkg6QieuIkfhl
	NzL8534R2funmAiSXzWgQrYfrl850Ox49P+mf+RPb4HXCp1JTGxxZKij7Rc913UJKLv6tV2K19F
	xL9xspR5PiE2ABBp1vKEyvfs/pRdZlMFrGAXfUDK+Bq3EBe6huseccLTD6iJx/cpMsuoag4Qa51
	JDDu5kORLhurUnkA8Tkx416O056B4szEpR3oSOs9h5nNBPss7QEUhyIWAWhVHnUgw7
X-Received: by 2002:a17:902:c947:b0:2ae:c795:6b37 with SMTP id d9443c01a7336-2aecaa48f77mr49883485ad.19.1773439015829;
        Fri, 13 Mar 2026 14:56:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece5c9737sm41513475ad.25.2026.03.13.14.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:56:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] EDAC/sb: Use kzalloc_flex()
Date: Fri, 13 Mar 2026 14:56:37 -0700
Message-ID: <20260313215637.6371-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 v2: change subject
 drivers/edac/sb_edac.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 09d4e816404b..7b282dfd093f 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -364,11 +364,11 @@ struct sbridge_dev {
 	int			seg;
 	u8			bus, mc;
 	u8			node_id, source_id;
-	struct pci_dev		**pdev;
 	enum domain		dom;
 	int			n_devs;
 	int			i_devs;
 	struct mem_ctl_info	*mci;
+	struct pci_dev		*pdev[] __counted_by(n_devs);
 };

 struct knl_pvt {
@@ -771,21 +771,14 @@ static struct sbridge_dev *alloc_sbridge_dev(int seg, u8 bus, enum domain dom,
 {
 	struct sbridge_dev *sbridge_dev;

-	sbridge_dev = kzalloc_obj(*sbridge_dev);
+	sbridge_dev = kzalloc_flex(*sbridge_dev, pdev, table->n_devs_per_imc);
 	if (!sbridge_dev)
 		return NULL;

-	sbridge_dev->pdev = kzalloc_objs(*sbridge_dev->pdev,
-					 table->n_devs_per_imc);
-	if (!sbridge_dev->pdev) {
-		kfree(sbridge_dev);
-		return NULL;
-	}
-
+	sbridge_dev->n_devs = table->n_devs_per_imc;
 	sbridge_dev->seg = seg;
 	sbridge_dev->bus = bus;
 	sbridge_dev->dom = dom;
-	sbridge_dev->n_devs = table->n_devs_per_imc;
 	list_add_tail(&sbridge_dev->list, &sbridge_edac_list);

 	return sbridge_dev;
@@ -794,7 +787,6 @@ static struct sbridge_dev *alloc_sbridge_dev(int seg, u8 bus, enum domain dom,
 static void free_sbridge_dev(struct sbridge_dev *sbridge_dev)
 {
 	list_del(&sbridge_dev->list);
-	kfree(sbridge_dev->pdev);
 	kfree(sbridge_dev);
 }

--
2.53.0

