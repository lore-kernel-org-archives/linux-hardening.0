Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B58315D49
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043913; cv=none; b=jQXWBpHUq562OlWXenY0i4iuKQol9qVyx/mm04mejV+/FaZfVJsMnKRrpOQoPWP2R8L6rRP3ilglv1keHGb74ERmzU/4CpwibG4YxEXM4FJaJaYShA82FvfpkC17og99o6fyx79j5cUEfMtcNz3FFVufQjeNSTxMHVf7yYlw1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043913; c=relaxed/simple;
	bh=25uPJG35jMpSwWwmNLycgRCZaGsl+PNdPy3/92HsGh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VglK9nb629JYP769GPAzgaNO9gJmTO6vRLNEtvGABrEHQDJGC0IOpI66bpRZxyCa+WYqUIsU092Hoc1cYGGY4iT5x0X9Df4hnO2zeYNz1B6t1Fd3rbD+7q/K6wPhyjhSkcyCcIzzRUD5PXRZUocNacqlxT0F/DNZJzncUVExd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2c6qQAi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2c6qQAi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso54832055ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043911; x=1781648711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNnl0xTEZP45RQ7ZoZEn+pJMzeJwUx2jPnwEWCmckDk=;
        b=p2c6qQAivpFaly95C2ObAfJFEZrHVoSFSSKCbDc4rwKU2xZQQ/GvZOwsLGGDLDv0lf
         EKN3PT7w6uk2vWeZuXFnJsZXO2XgSalmY0C9Q6+XXCwQY3hqUBUrQnr3Wn0HPnSCkkZf
         /XTKK9u/zccX+VoGc18I2V9HiNGQhWmgKQ0iRcACN8AmFWf6mOGS4kBU0sC4050N8aE4
         ldklq/nZ/oyLoZHN+s043dIDDZ/0L5jtAurXRyvCdGquqDTFuxhBnPY69SFLoYSN4ihI
         X7O5zsYG/2rw/lFbg5dioqJWvzKAUubv8tuXo866Jo4pmmieCDCYwegXgmDeUhxllS8t
         85Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043911; x=1781648711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNnl0xTEZP45RQ7ZoZEn+pJMzeJwUx2jPnwEWCmckDk=;
        b=CFrUR4bXrgcmw4g/OintB24tpKHmR6u5lz1FwU7JgeoHbkMkxdA+6VzipFzKlpXSl/
         zZYHdW5hqKCKDgiAvHa8cMWgOG9AlNTYibjWyKEla1xxZIlvpf1esd84u6mGVIUhHUCz
         ZqoSGvLZdEBkyeOSNWqNHmGZe7GeszQ5Qsd0Xb1B+7NrdbLzof4r+PvvBNkvBQspQCNV
         b1jaUufAi2DfPSOOOuijMgIYak9DRGIfPsrJ7aXzVavJsaW+tqH4CZ8zWFCFTZ3Jq07/
         lUtbp+3o2hin7hb/M0RuujifPfVTWVVmNmjnDau1ninhNMtXx7EHaxaAn0wG16rmHlDw
         vCug==
X-Forwarded-Encrypted: i=1; AFNElJ+KGc1KFGrxiZ/jIpkj1LhV2Qtj6vF3D9K1q+HElk6qm33yv3Q0QYmVe2/MHa5zdlgoSKFM15pGOdfivA7lRtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzE9X5Ayke6iRYrlmo7VXAPAnL0Y0bkOe5pgARYAFigxG3vkS
	H/yIM6cjPKBFdcFpmVHf73Q3PVsmdGeg3YGJ0QjA+i1voGPCpv2zuOCU
X-Gm-Gg: Acq92OF+bfNPloqoXtfRhvEoxXmlrpHwt+2+y2TD4HIMxyia05LLRK3NjvGYnVl1ydD
	bQzIXMimx0SLAlrbNe9oHlguHDUov3C/JHQHMqytjPQh825nM+axiXICl6YhRumvqUVoSdN3ZAE
	67k8xqX7bcFsni554s2wHO8NwOL9KjpuI3MyvLBSAuoKUqtvxV5yyHG4SMb6o2fRfJlS9Pz9LRL
	/1hRkqowokHDRGI2kilXZSk4+bhF0u/SUE+b4nxmNY9aK1wqrcjv7QLjygy5NsElUeoVBoGNkX7
	bguIYHfaD+OSL4+HIp8op9yPDAub18Iq35/7zKK/UuXmLKZK3d/ksq5TP1pFf9uD4flweS2x6Pb
	vszyLehV02DVo9vJVAWd92qrJhkZ2Nw8MhYnf3HhmYrNtVE3P0hop4CE22D7TogAS44QnFKb67b
	Ilql8pWcZ9hNoUhdqcIqxwOkdrUhpYSIZ3d3hdu/airYUN3Qs4iBEIO6J+oTpcM8cd7+VJgvt7d
	wm9GwBA7dkz6odW5TQk+aPy+DWTAbWYcUhoXaLWxt+Zlg==
X-Received: by 2002:a17:902:cccd:b0:2bf:82c:6322 with SMTP id d9443c01a7336-2c1e80e41ebmr241260645ad.3.1781043911561;
        Tue, 09 Jun 2026 15:25:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm228817565ad.52.2026.06.09.15.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] interconnect: qcom: simplify allocation
Date: Tue,  9 Jun 2026 15:24:54 -0700
Message-ID: <20260609222454.37352-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to reduce allocation by 1.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after allocation before any array access.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 v2: fix kerneldoc
 drivers/interconnect/qcom/icc-rpm.c | 7 ++-----
 drivers/interconnect/qcom/icc-rpm.h | 8 ++++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 23a1d116e79a..ca4c8a944755 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -479,13 +479,11 @@ int qnoc_probe(struct platform_device *pdev)
 		cd_num = 0;
 	}

-	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	qp = devm_kzalloc(dev, struct_size(qp, intf_clks, cd_num), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;

-	qp->intf_clks = devm_kcalloc(dev, cd_num, sizeof(*qp->intf_clks), GFP_KERNEL);
-	if (!qp->intf_clks)
-		return -ENOMEM;
+	qp->num_intf_clks = cd_num;

 	if (desc->bus_clk_desc) {
 		qp->bus_clk_desc = devm_kzalloc(dev, sizeof(*qp->bus_clk_desc),
@@ -507,7 +505,6 @@ int qnoc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->num_nodes = num_nodes;

-	qp->num_intf_clks = cd_num;
 	for (i = 0; i < cd_num; i++)
 		qp->intf_clks[i].id = cds[i];

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 7d1cb2efa9ee..cdd5f444b152 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -40,7 +40,6 @@ struct rpm_clk_resource {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
@@ -49,13 +48,13 @@ struct rpm_clk_resource {
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
  * @bus_clk: a pointer to a HLOS-owned bus clock
- * @intf_clks: a clk_bulk_data array of interface clocks
  * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @ignore_enxio: whether to ignore ENXIO errors (for MSM8974)
+ * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
+ * @intf_clks: a clk_bulk_data array of interface clocks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
@@ -64,9 +63,10 @@ struct qcom_icc_provider {
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
 	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk *bus_clk;
-	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool ignore_enxio;
+	int num_intf_clks;
+	struct clk_bulk_data intf_clks[] __counted_by(num_intf_clks);
 };

 /**
--
2.54.0

