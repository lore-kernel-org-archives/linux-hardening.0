Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B5373C1E
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903077; cv=none; b=p8Qnt6jPzdHUSFPje28DET/WR/XdqVVtoBq21FRKjIcw9on/bnTj1eO9y8gjZv29T8n1lIgMPqCAjm5QzGW4G7g2GEYIk8EhRyoVKvuOZ0Hyzc2riV4F36I2T3zzgw7rB+Hyl+5M9Usg2Xk/2iX9IiM1BiVpoNPJtYcCixy3m3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903077; c=relaxed/simple;
	bh=I6azZYdblCJz5ug7vx1CsFyj0Va/RBwHEN4bN2GaLfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2g7awtA93DOKxxaHMOZfE57rRb4x6aDbPGypBJrs0/rDxvGN49JT9A0j0Aun/TGdlgdhrXecJDN5k/XUXzbydMNXA5kEexigwH0sn95rU02Q4r2BBlKG8PiFnFBIE/l7+ygIOZzOjC6ESr5QCXwSjwImO1IDLWZKVUiWjVmXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROSKQEPE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROSKQEPE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1665213a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774903075; x=1775507875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yi1MOTZzQiL1ZMjYlLUzoyKuclzjHlNpIloD5RD5TAE=;
        b=ROSKQEPEqcpQcsbyfeljCxmFZeoq9pbRDDafu7yTq8zBMMtMoVlUeuiNheXSnmUDGC
         EiVVtONyGJE01SAoP/Je+BF9+eZLCeD7PjoTIKRkNtiN5J4kwc/GeR5N7E8g01wpFcVU
         KnsUF/J2Pw7e0eHEEFxBu34U/D8r5TxZrZS4e0h898HzerH9+SH+UsnHyjElb1Omqy0k
         1BlI2SqQUw+7ZrGYL/7that9LBSFAA0AIPcs/tMTiUki5jShwyVoAuW1Klv6cimhUx5n
         +UgtcKbN3Cqvjyfja9zMG2078TqQfweaOR9DNnd/T7T9UGtVU/1Boiqu1PDor9AygypX
         3Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903075; x=1775507875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi1MOTZzQiL1ZMjYlLUzoyKuclzjHlNpIloD5RD5TAE=;
        b=VVXWnc8ux64hruQCM3ge8UgC+X5YlMqIEdqbCdP7RWYBL/LB4bgD7hZeiBUy83gVF0
         8XO9lu+3QkYRx7w/BJrZgHo+fZOV2dssWrxP+0PbxRMQRVZFFAwhPCjwBojBrUu4OWCD
         3WhKRNdE6ZGTwDngc1lG3veQQ02Cg9wwQSTlUXfq3+c+fVfj6NgmzPu9ZPkRAjU9hUve
         1xYawXyUHWxvTTZuxv0jTAxZTiPjaa0JPrXNRXd9pzaa+G7Gs/DKEcKSBXtrnifiib3M
         eD2AsYTMvqcuvptrMtZPgy0OxofqPWGJ2Cu2OCf5bcf7gpeT3rpWcbFXjdGnqjnQLiyl
         YrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfxFIQKSH9YSE9vqF58I1pMi8IHFm6Q5ezQOkzHEsDO+gavP+cSXXDANBWlwGofSzZ6udmiVVx2lAlufCiY1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDCWaeJxCFAkOu9iJhMVKn40Wker8uQANtZiGQYHKYoZqroyR
	OeXgKhjsXxdrf/UJA/lZ6bYQoZn76oOMIt2w8QtLhFqGIV97NTtRpqlG
X-Gm-Gg: ATEYQzxUrLZXGFuJJS7XzPpeN7TEoO+TsPs+DSdM8n5d1UNjzYA0ZWsPY7FuGL0A/NJ
	CTXt3p4lEzjI+hSVId7OmjTsiBLTMRlxB4hq7K7ifX8n65fPnWlNvubmEmnZ5x3hOoavQTPV6aj
	w4RONGImFzj/Zmv4ZbWshLuSdCqZ/NkPWXkajONXVjhXYG0gONK8iTu2Pe0fVGydJYsiXM9+sBl
	zfLVxqds7bMb/FcigGAqotqaW9AwR9dv7l2fLM+JU1qYNkbz6lGB9cFTwZEVLAIh62MH8pNscyf
	f2wNUVMfLgOlGVYK17dq2skA/a35BFl8FP/ibtJ6mMYpbVb8b7yFd/wp3Odd/0HaUFh8XuJiO8W
	qwGWpkkEKX5z9jfHE8hSRJ/BnnWXAEne6dGYFVHo0H3xTrFkx42N8A5q3N+hIbyzus7Yv1Pe8NA
	e0+C+lrtwxUSvnVrZUGoDjX5kkAdGz7MsZaBojiSv7gACqZSaXB8ekZDk=
X-Received: by 2002:a05:6a21:7a45:b0:39c:8c0a:d09b with SMTP id adf61e73a8af0-39c8c0ad0fbmr14357138637.49.1774903075051;
        Mon, 30 Mar 2026 13:37:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cd7d0410bsm260281b3a.33.2026.03.30.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:37:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] ata: libahci_platform: use flex array for platform PHYs
Date: Mon, 30 Mar 2026 13:37:37 -0700
Message-ID: <20260330203737.3995-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify struct ahci_host_priv to use a flexible array member for an adapter port
PHYs and use struct_size to combine the allocation of this array together with
the adapter private data structure. __counted_by() annotation is added for the
phys field to support runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 v3: update description
 v2: update commit title
 drivers/ata/ahci.h             |  3 ++-
 drivers/ata/libahci_platform.c | 33 +++++++++++++++------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 293b7fb216b5..9e8b6319025c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -357,7 +357,6 @@ struct ahci_host_priv {
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
 	 */
-	struct phy		**phys;
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
 	unsigned int		irq;		/* interrupt line */
@@ -379,6 +378,8 @@ struct ahci_host_priv {
 	/* only required for per-port MSI(-X) support */
 	int			(*get_irq_vector)(struct ata_host *host,
 						  int port);
+
+	struct phy		*phys[] __counted_by(nports);
 };

 /*
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index f37247e7a5cb..6e072d681341 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -482,15 +482,29 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	struct ahci_host_priv *hpriv;
 	u32 mask_port_map = 0;
 	u32 max_port;
+	int nports;

 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
 		return ERR_PTR(-ENOMEM);

-	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
+	/* find maximum port id for allocating structures */
+	max_port = ahci_platform_find_max_port_id(dev);
+	/*
+	 * Set nports according to maximum port id. Clamp at
+	 * AHCI_MAX_PORTS, warning message for invalid port id
+	 * is generated later.
+	 * When DT has no sub-nodes max_port is 0, nports is 1,
+	 * in order to be able to use the
+	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
+	 */
+	nports = min(AHCI_MAX_PORTS, max_port + 1);
+	hpriv = devres_alloc(ahci_platform_put_resources, struct_size(hpriv, phys, nports),
 			     GFP_KERNEL);
 	if (!hpriv)
 		goto err_out;

+	hpriv->nports = nports;
+
 	devres_add(dev, hpriv);

 	/*
@@ -573,23 +587,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		goto err_out;
 	}

-	/* find maximum port id for allocating structures */
-	max_port = ahci_platform_find_max_port_id(dev);
-	/*
-	 * Set nports according to maximum port id. Clamp at
-	 * AHCI_MAX_PORTS, warning message for invalid port id
-	 * is generated later.
-	 * When DT has no sub-nodes max_port is 0, nports is 1,
-	 * in order to be able to use the
-	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
-	 */
-	hpriv->nports = min(AHCI_MAX_PORTS, max_port + 1);
-
-	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
-	if (!hpriv->phys) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
 	/*
 	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
 	 * target_pwrs after devm_ have freed memory
--
2.53.0

