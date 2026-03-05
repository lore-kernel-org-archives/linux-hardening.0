Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B093644C3
	for <linux-hardening@vger.kernel.org>; Thu,  5 Mar 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750673; cv=none; b=EEaOK9FOx8aUFLkSrunSsMvHS49miWExIBzsUh5aOTX7EinBelrG7j1IWiexUNfAqW3RtHdlC89MzAwz885zaFvYXlrqN7LACLZsjd6TTbHph7GZ+no+a8TGaD5wvGKa57FAJ763XCwcsrlsifPCa1lglVGSZFxmfodVWEamoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750673; c=relaxed/simple;
	bh=V8OViAIFO175+fJwVfJPKOAp+3BYH7KDrPqR+lYwjBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu9/IQ478ndRixOmsBLvQeILWT7QXAdWtp0IPhqwVh8rvsd85UtBXa7vkX7Ftxu/I/aDF8OiIt3FupwoeWaU4P8OclPn1Th1VLXes8zV9dvOizoQVGcQ5lgZ+3Q/XCSWMcWKdOA71EIAD0d7eriDqKgEL/05+cSi/KScNFtzs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlQyfeFF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlQyfeFF"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829865a8471so1337033b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750671; x=1773355471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOmbFn8ywU95rp5pZjzICmiW6tw+/7i3nDvDUHUWrQE=;
        b=XlQyfeFFyHR14UEl0UZvCtuGiaj6jQ7Rcal1+1j50h+Pp3qlQBEEV7JNCrYJAeJOr8
         8PRIbuWvebeXkW/aCJVKk7UBFJ8SropWlcc/aa7JweFAP2kp3/wGo3Hsp8cwBsWp3c3O
         JTcdYaXiR5Tn5qSv+5Jti6epVYnmsBLu1+D7taoQANu4EAVGWUCPCimQMCDguv6xHz3i
         hzAqAc1Pt5z19CdyqRzycz16s3b0ih6wyXgbhTCMedf7uoAhXeqHUkgl2KVFL5MQ8Au5
         YwV1mVOP66iFV/b56OD7Ua8h039FedCZ4V4oIfVfCsNnnhoLW1pOJ5FhkjpHvXheNT31
         uxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750671; x=1773355471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOmbFn8ywU95rp5pZjzICmiW6tw+/7i3nDvDUHUWrQE=;
        b=Wvn7wcjwfLQvQbAHzSNq6+ladSGlB9fNQyrEpAbvw4etu0poIX5s17rrJNIrHxSb3V
         c5biL1cP1UHQsf3+BBZscq7fHOwDdXf4n7+rsqhbHZLD8dY2NsPMmpmyo7heHMOQIkt4
         Xz8gc3xBcmopTo6Uv2Gdo93sxTPTxuurUQXjqK5HeJaWYxGVC73AKyt0zjU415bOPEhH
         VdTky12FvS9OzkcXjpnqIhxVNcmFzyp9JG20Jx+63BWZte+PQeVKP2/WvAY+lOzT/uG2
         uMNJ+DmOiURA0UXkNRjl69Hb+85eefyd7jHgBVFbeAyTMXYbHVXNDls56uGKfH6wnjmh
         bIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlDrL2kF1EN0v1yd5gyfHkWv/SoR16bQivEtnf9XDnVG65AFixDGU4Ae6321mN2RQ8n9Ae/+kWB5bOsBx0XAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PU4+vRcd52Kw1s26J8U9DhIb7Tkr3bM0xzChhle34pNx2OsC
	WoCENYzVWTdMvyKTlvC+SveOswZv/BObOqgFPJ5zb+Fuk/4hBm2f2s+P
X-Gm-Gg: ATEYQzyoBIgeBnMp8UrWNBMbjNOmVvsBBMRY3unHkbG/iEVWAkQ8ttv2xtDUV8FMs5x
	HJe6gfGOzD6BXEN4F58XFDq3y5uXJq11/r27keR30ah0/JrrAVawKlEWbkxHuv9tyiOfXhdpErZ
	Rfs+2FGAS/QrAZzUIYEvhzzkE9hp5CHDMVCJk4HGaTWRj7nPFQdvLo/zeISRs8GFBwLijOvKoI/
	/PfBVPjXD2gk5mqtgnVclGa6aTZinlv3meTOQzMJsQIwoZX+CFNAeZ3e/zMTDIL6wpgCTixgnSK
	Kp6NVlB7FkvWpNrFLLsH5NVHWJbBMgfsQ695v8ioVEWIti/nY1ir7DGoyO6o8axvA6JwUs1biue
	PX7vfyER5E09YCtsWXVDAT+F/mDQjq9E6yA5RzVJD86FOPy1EhNjk9BUn1lXjnxXO6RKTwe5j3w
	Ft/9B9T7FSI8IeFL7RFqXsiO83McPBTJ4+GR3GKQ5s6lZjAYL4uBXOOQ==
X-Received: by 2002:a05:6a21:6b12:b0:394:65bb:d1b9 with SMTP id adf61e73a8af0-39858fdbd15mr159399637.20.1772750671359;
        Thu, 05 Mar 2026 14:44:31 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738877202fsm3565477a12.25.2026.03.05.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:44:30 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 2/2] mtd: concat: replace alloc + calloc with 1 alloc
Date: Thu,  5 Mar 2026 14:44:10 -0800
Message-ID: <20260305224410.14251-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224410.14251-1-rosenp@gmail.com>
References: <20260305224410.14251-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flex array can be used to reduce the allocation to 1.

And actually mtdconcat was using the pointer + 1 trick to point to the
overallocated area. Better alternatives exist.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mtd/mtd_virt_concat.c | 8 +-------
 drivers/mtd/mtdconcat.c       | 5 +----
 include/linux/mtd/concat.h    | 2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 33f9a63dd450..b56f2431974b 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -182,18 +182,12 @@ static int mtd_virt_concat_create_item(struct device_node *parts,
 	for (i = 1; i < count; i++)
 		item->nodes[i] = of_parse_phandle(parts, CONCAT_PROP, (i - 1));
 
-	concat = kzalloc(sizeof(*concat), GFP_KERNEL);
+	concat = kzalloc_flex(*concat, subdev, count, GFP_KERNEL);
 	if (!concat) {
 		kfree(item);
 		return -ENOMEM;
 	}
 
-	concat->subdev = kcalloc(count, sizeof(*concat->subdev), GFP_KERNEL);
-	if (!concat->subdev) {
-		kfree(item);
-		kfree(concat);
-		return -ENOMEM;
-	}
 	item->concat = concat;
 
 	list_add_tail(&item->head, &concat_node_list);
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 241d15235d01..c97167d51fe2 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -627,7 +627,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 				   const char *name)
 {				/* name for the new device   */
 	int i;
-	size_t size;
 	struct mtd_concat *concat;
 	struct mtd_info *subdev_master = NULL;
 	uint32_t max_erasesize, curr_erasesize;
@@ -640,15 +639,13 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 	printk(KERN_NOTICE "into device \"%s\"\n", name);
 
 	/* allocate the device structure */
-	size = SIZEOF_STRUCT_MTD_CONCAT(num_devs);
-	concat = kzalloc(size, GFP_KERNEL);
+	concat = kzalloc_flex(*concat, subdev, num_devs, GFP_KERNEL);
 	if (!concat) {
 		printk
 		    ("memory allocation error while creating concatenated device \"%s\"\n",
 		     name);
 		return NULL;
 	}
-	concat->subdev = (struct mtd_info **) (concat + 1);
 
 	/*
 	 * Set up the new "super" device's MTD object structure, check for
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index 2cd9d48958a8..f8d4d6ac1fc1 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -18,7 +18,7 @@
 struct mtd_concat {
 	struct mtd_info mtd;
 	int num_subdev;
-	struct mtd_info **subdev;
+	struct mtd_info *subdev[];
 };
 
 struct mtd_info *mtd_concat_create(
-- 
2.53.0

