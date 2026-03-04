Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A7370D60
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662555; cv=none; b=txs717ctljCI5M0l0c3dasYo5HJg+xK5m8v4Mz8DcaKhIU8H/RYFvHtb9j00gDaaZaOi++IZiMiF7SyvEMM57jXU4yVnX8hNpEu6F6adRAmoJPxm7RlFTzJsyXKG2aBrwPWpPxCa8hXjApLHoZiYTLrSPz6v8ChxI+Uf2fLAO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662555; c=relaxed/simple;
	bh=BJvpKKlOTH0Z+xL55mNE8BURDICg+ZGGrGioGa5Lenk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xya0Qww3llPHDfRjExYMah9DbngtI8ZxiFcP9jr63FBU+cdak/R9z3Wi9/+riwtFwnY+g1/lIapfTei0yBHI9HH1UPNyjBZrA8NBj3t1RuqOoWv5zTcBLIVxaF2ViexVGn+1w8CAyzxkYzq646dOKz5IXQH4ypX8Kj6RrTvitCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg0Uf/P1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg0Uf/P1"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-827307b12dfso3952944b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Mar 2026 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772662551; x=1773267351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6xGxKiEmjafobho7Pm8BBn/5trBV+odB8B7flKPqK4=;
        b=Cg0Uf/P111yR5kBgi/aD/u7rparPuxQrDrT2gRUDWtb0uQIxOHZuCahJC2uPR4BVG+
         L8mld1EBfrSEL4XbRVuBWBLCILcYblVUCoTouWDtesaGGFgge06PZhwr6MeSuAkPRpw5
         h+QHUBiYItAdemQf0COHztvqcQjeHZ6mNAix9aZeetMCPM4ApMC0EPg7EKIsI0pkCd9E
         QNkhyxCkkHm/misXI8ohtvyOdEW56min6jxGnoGp0CP59ZD6u6wqYO1uMK1zmsoMavyN
         mA+NCJ1XNhObpqSoJG3hG0uG3LG3tGOh1Vv9TodS17GXFrgyfxRNwHsae8ZqELN9M65v
         ljSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772662551; x=1773267351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6xGxKiEmjafobho7Pm8BBn/5trBV+odB8B7flKPqK4=;
        b=QXVdR81fifX1+4hFzIrxGIUe6DAhPOyU9ioU47dHrCek6NOtqem1qypGE1gRDDjhoO
         q0RNpZlZuETvfMnwy78knV8+yNVIpf3xuqzxLaVHofJa4p5Wz5k6QrEjMKDE+nADkuSk
         21k5/J7XMLZ6ELYQskhHZKRcxFvf9x0KgSAFlJWo4qc7vjqzC1Ks0nDXIeipQ7YMTUij
         6RHAOsTzCEe7PbDDHUhGoiQmmM8SjdFRgzaGR72FE9o6lapuWOGtirmjLKavZVmSvy24
         uHWiIv1sNA8QYqLGxdVQM8ZOCG4AT+JFAqMp9/bL8AocLNOmWqwNolB16DVFvzmTSQpw
         CPaw==
X-Forwarded-Encrypted: i=1; AJvYcCXDO9bq54ah63+0LQRukwJHi4tiLRDjMbJHz8QfER392I1pv8ckcu/wArxd2P/okmKa33tOI9WdgLHXGOR+ydo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRkZu/ND2t6FNYOz/Ro5uX5hdoKCSMtkt4acKAtyalBvxP1Mb
	nO9PKJg5uhtI74j9Ei7CgpXbDw5JoQ2KAOg5I+sRy+Rw5iIaz/D+zmVt
X-Gm-Gg: ATEYQzxCYoZ+6+ytPalq9sNja3xNv33s1KOyPT4/Qwa4ITFV0fLBQ2022EPaKndZBVY
	TB0ktgA25jLM0t2RCn9tFgbFX5CpsdxPLIZEA5Ms1v2llMm3Fzr6IVz42Y8wOYm8v0Oyrkvip91
	VhhcWjbdEfR4zN+/rTPTx9xYzfLwz4Abi4OCNSPcfru0I2kuKJxidWhuEogZpVUT+xEMhFf1pqQ
	I+5hZ6xGngAYghTxA/2H6b6CGQ7Jar3YPm3DYLDKOxysDwPcjYSthJwBHMxGP26DjM+YIgNs1hJ
	ihIgiETSmdSD8tAtRchvkKj02tc7/hHtFWvp0rqQSso+sOn34BxpWRh3Vba/wSyeZ3USvmDuOrp
	OxmMggyajsu2tcDJmxCx0IsdrFS4TfYcgR2lBZGONPRW0JXaHd8cJi5aIUmGdErNKhuvHsT34cp
	HGVi6r4zCrnHATt/JOAImkVhy4C8+QaLRCc7F98/k7RpsrWyd44s0jQw==
X-Received: by 2002:a05:6a21:207:b0:394:782c:cb8e with SMTP id adf61e73a8af0-398425c24d9mr73436637.28.1772662551223;
        Wed, 04 Mar 2026 14:15:51 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa6203a6sm17637399a12.8.2026.03.04.14.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:15:50 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 2/2] mtd: concat: replace alloc + calloc with 1 alloc
Date: Wed,  4 Mar 2026 14:15:30 -0800
Message-ID: <20260304221530.15018-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304221530.15018-1-rosenp@gmail.com>
References: <20260304221530.15018-1-rosenp@gmail.com>
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
 drivers/mtd/mtd_virt_concat.c | 10 ++--------
 drivers/mtd/mtdconcat.c       |  5 +----
 include/linux/mtd/concat.h    |  2 +-
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 89e223edac6a..b56f2431974b 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -32,7 +32,7 @@ struct mtd_virt_concat_node {
 	struct list_head head;
 	unsigned int count;
 	struct mtd_concat *concat;
-	struct device_node *nodes[] __counted_by(nodes);
+	struct device_node *nodes[] __counted_by(count);
 };
 
 /**
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

