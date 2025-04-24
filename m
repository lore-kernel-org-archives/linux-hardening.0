Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98627FD7E
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509699; cv=none; b=L0CLERr02QnqxnKRabR+1CxhNiInYwjWiFXgs8QO2AmNydKbPvQWd+xh4jqrb37M17SjbFMKwOfX0jSAyOXJq9QSlVQDof4YurK3tRZAlnabO/eP/S3RRhWQo5/yn5hoHELm2IeIfjscta79JrkfH9enBSJI8TjAad2Bs4pHuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509699; c=relaxed/simple;
	bh=trT96QgCgVDrBc0MoA3K88+bmYgHM/EQgdAqOFhrA+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3uliP1egM/wPOrPZAzW1adeDQKgMgFPDAZRbGsoVBonIxz87UunXhPlkfhRpKUiupu1l/48nQ8ZgUQ5TKqmDYnHTysmXWKINIdldG/apkpFGvIKwYr5vwVS4FhryEVdj4jLO+6dQ8tcR8Mi7J30R064R3h/gocSSP62GEu0aRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiTlApQO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiTlApQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAWubhdfA9Swt08Co7tCZjaqEOxAWrvXKOxLYkC60r4=;
	b=QiTlApQOjRFisE+2pZ8H0ebn/RPsPPVTKd6rLyxIkHUQtmSoT58ojSJlWgpb+yr9zYDQCU
	FZq+rBth4KiyjjWzQikYU05fqLyeNKR88ys6G3Uzj6jyh2dCeUQRY/yAbNWcEVHVXlu5th
	z77kGrGvh8EpH3jUjN2mXIilEK7KqE4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-pPtJ62dBM_KEYoFRkj0ycw-1; Thu,
 24 Apr 2025 11:48:13 -0400
X-MC-Unique: pPtJ62dBM_KEYoFRkj0ycw-1
X-Mimecast-MFC-AGG-ID: pPtJ62dBM_KEYoFRkj0ycw_1745509691
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 092A6180036E;
	Thu, 24 Apr 2025 15:48:11 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68C0B19560AB;
	Thu, 24 Apr 2025 15:48:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v4 8/8] mfd: zl3073x: Register DPLL sub-device during init
Date: Thu, 24 Apr 2025 17:47:22 +0200
Message-ID: <20250424154722.534284-9-ivecera@redhat.com>
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Register DPLL sub-devices to expose the functionality provided
by ZL3073x chip family. Each sub-device represents one of
the available DPLL channels.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3->v4:
* use static mfd cells
---
 drivers/mfd/zl3073x-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index d0022dfb0236c..a8971b86db121 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/math64.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -910,6 +911,14 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 	return rc;
 }
 
+static const struct mfd_cell zl3073x_dpll_cells[] = {
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
+};
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -973,6 +982,16 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	if (rc)
 		return rc;
 
+	/* Add DPLL sub-device cell for each DPLL channel */
+	rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO,
+				  zl3073x_dpll_cells, chip_info->num_channels,
+				  NULL, 0, NULL);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc,
+			      "Failed to add DPLL sub-device\n");
+		return rc;
+	}
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
-- 
2.49.0

