Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A934F47E
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835728; cv=none; b=jyTOqOxy7q8SUDYukyX9EpXssKUXCjjcX7aJhnTFs8MQkvLAQbguVk4UzNbyGGC4jE9uokEZrlJ29jBAK23kQuLYJwW8CW1LxJybIHGwuIzo9JiT7ORaQEgAqBKlHncGWYAxNJRWyfI/N8LmTo8RCDC7U2dJpyACu27o57diZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835728; c=relaxed/simple;
	bh=DmIoKkR8KqK2qQF1bZkGkUZ6ggJ0MpC5LuN1Et+ZHLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iqc/tBLI9ZS5RDLE1argZG0Eskq+Po7fZ9V9YZSzMTRRCcbWiulaf890YWgUTMjVwgW+DScHJks5wN1pFofkqR4Q0vS9eaZSRKrD0Pis1TG3POznUsvi9RfSwV7ucOp0aScqHN7YM/iA+K62IdB7nXzpKIYCuKvd7ec3pN4TPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy2HvC5W; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy2HvC5W"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso4558100a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772835727; x=1773440527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4FMmOPA74qb/sr9utsKChtIdTy4B4gMndDtghHY5lQ=;
        b=cy2HvC5WTAgC+9fGtFjirUOOKH3aoUoHj4p2nUHBiiq9L08SGtyJN5ZBIn0qUunIR1
         BlhS10tpovGsvbiKB0F+0CLzTt52OBRYpPau9nGAFZw214BlwHljyMsyMqlKDbpEnxiF
         Obq/hxs4Epmty1XxuLMOq3Zn9KCU6Qu2vsZU6xs8CrOBm0rOYNVMltYP8oeI7avZW/Ir
         +Vj1cpv0iFZbW/I4zI9R4ilCEHP6u39tTq2QV0FbRB7Hs2vQRvKy5AavkUeZ4XsTxpQA
         rRqR8CeVx+kJsJT9Ys+gKtE4SdK5meBUD5NICAHnvXi/CblGPf0zGETwsKXh5PkHNLaU
         3+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835727; x=1773440527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4FMmOPA74qb/sr9utsKChtIdTy4B4gMndDtghHY5lQ=;
        b=DwZqKLz8PifIuIJJkmVMPF3jHk/0XGqmnt77dif87PUvFGIpq5xDBMQrhIxWX5hlz6
         Vc40F6eIvOQPPysznBZRi1eq5AFlWvg2/LegnK4+BDiEmbrqQ2fLoLBoyoBVv2qlgz+Y
         IbZNs5uhzZPBochJC0+CSJGxercFT0rIF8G1OXLj08vICty0RCEacg47kwvrdag4Hs63
         O+N/Mpnw2qM8hxp49RZZRgfBtIDuBm+IGhI6jltxDcwWv6AJglh187dn6Nwbev2n9fhZ
         ljuB66CQAX9J3HU1jHImsOk/Wd0m2OWWvbqC+EYZM+updAOL/O8xDRdYPF4Zw8m+6TW3
         M0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfdsB991fwRGzo6+6tTGdwULvidpdvEWnsRLOHUw9BjsoyPbluIBTqi7M++q7dLrMeXqYuF3YXFpXJZ7kWqVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9OTaCBOoyS2DH3GlD58NvgI2EvjpeGcFkRBtFu6u3rMj823u
	n3v00QZ7JsHHpYJUMd1mXMFSAUEstyAUuKth+C1Ops3dRimVT/yExeBN
X-Gm-Gg: ATEYQzwFOfsqkP51EaTtxAqBVNTa3L60lEM0Y327a+QvAqssOcn7eJZw7HGYYAH1OY1
	xlSdqLLzDAtc4Xf8D0Lu0dDv5HEJqU0wd0Cmhj4brU2wO4I5/ge/AOG1chqMihK99NgOTiPL8xC
	cD8QNmnefGYcSqncf/5r+gFp1tq+TwQY4mRbM+SBk0oc2ArJKaVC8iBW7WCltZ/SEmj1WEPJmq0
	ZlsyRiBn6TEPvIDopBlbOAZeyn0EeMDADwVKn7SqHco65PhnO/xhcGQ4tSvi6J4niz2J3bI2z34
	pHZjh0dGdFfvh+LxcSWzHMSA58GwuSIzxUb3gSNKm73jq+PE0QTOLr7+Vb0GApBDjLBvjJCZwah
	KJ1VDL1Pgr5YFjmbr7K//zhLRkwJG5qrlEUl1hyA1qU2Zyt/4iDBR8D/VGFj9wOHmyWS9uqRfnf
	eyfuDEPPTwKB++hSaw6DVcqL0blLAvUZw3WC4PIw0Cov2sy8S3EuNLI6Q=
X-Received: by 2002:a17:90b:38d0:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-359be344cbamr3132368a91.20.1772835726741;
        Fri, 06 Mar 2026 14:22:06 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c005e224sm4136310a91.7.2026.03.06.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 14:22:06 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:QUALCOMM TYPEC PORT MANAGER DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: typec: qcom-pmic-typec: simplify allocation
Date: Fri,  6 Mar 2026 14:21:48 -0800
Message-ID: <20260306222148.8200-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change kzalloc + kcalloc to just kzalloc with a flexible array member.

Add __counted_by for extra runtime analysis when requested.

Shuffle some code in probe to provide a clearer picture.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   | 27 ++++++++-----------
 .../typec/tcpm/qcom/qcom_pmic_typec_port.c    | 26 ++++++++----------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index c8b1463e6e8b..4b3915c6894a 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -95,13 +95,13 @@ struct pmic_typec_pdphy {
 	struct regmap			*regmap;
 	u32				base;
 
-	unsigned int			nr_irqs;
-	struct pmic_typec_pdphy_irq_data	*irq_data;
-
 	struct work_struct		reset_work;
 	struct work_struct		receive_work;
 	struct regulator		*vdd_pdphy;
 	spinlock_t			lock;		/* Register atomicity */
+
+	unsigned int			nr_irqs;
+	struct pmic_typec_pdphy_irq_data	irq_data[] __counted_by(nr_irqs);
 };
 
 static void qcom_pmic_typec_pdphy_reset_on(struct pmic_typec_pdphy *pmic_typec_pdphy)
@@ -560,31 +560,26 @@ int qcom_pmic_typec_pdphy_probe(struct platform_device *pdev,
 	struct pmic_typec_pdphy_irq_data *irq_data;
 	int i, ret, irq;
 
-	pmic_typec_pdphy = devm_kzalloc(dev, sizeof(*pmic_typec_pdphy), GFP_KERNEL);
-	if (!pmic_typec_pdphy)
-		return -ENOMEM;
-
 	if (!res->nr_irqs || res->nr_irqs > PMIC_PDPHY_MAX_IRQS)
 		return -EINVAL;
 
-	irq_data = devm_kcalloc(dev, res->nr_irqs, sizeof(*irq_data),
-				GFP_KERNEL);
-	if (!irq_data)
+	pmic_typec_pdphy = devm_kzalloc(dev, struct_size(pmic_typec_pdphy, irq_data, res->nr_irqs), GFP_KERNEL);
+	if (!pmic_typec_pdphy)
 		return -ENOMEM;
 
+	pmic_typec_pdphy->nr_irqs = res->nr_irqs;
+	pmic_typec_pdphy->dev = dev;
+	pmic_typec_pdphy->base = base;
+	pmic_typec_pdphy->regmap = regmap;
 	pmic_typec_pdphy->vdd_pdphy = devm_regulator_get(dev, "vdd-pdphy");
 	if (IS_ERR(pmic_typec_pdphy->vdd_pdphy))
 		return PTR_ERR(pmic_typec_pdphy->vdd_pdphy);
 
-	pmic_typec_pdphy->dev = dev;
-	pmic_typec_pdphy->base = base;
-	pmic_typec_pdphy->regmap = regmap;
-	pmic_typec_pdphy->nr_irqs = res->nr_irqs;
-	pmic_typec_pdphy->irq_data = irq_data;
 	spin_lock_init(&pmic_typec_pdphy->lock);
 	INIT_WORK(&pmic_typec_pdphy->reset_work, qcom_pmic_typec_pdphy_sig_reset_work);
 
-	for (i = 0; i < res->nr_irqs; i++, irq_data++) {
+	for (i = 0; i < res->nr_irqs; i++) {
+		irq_data = &pmic_typec_pdphy->irq_data[i];
 		irq = platform_get_irq_byname(pdev, res->irq_params[i].irq_name);
 		if (irq < 0)
 			return irq;
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index 8051eaa46991..7c5cf8061f04 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -169,8 +169,6 @@ struct pmic_typec_port {
 	struct tcpm_port		*tcpm_port;
 	struct regmap			*regmap;
 	u32				base;
-	unsigned int			nr_irqs;
-	struct pmic_typec_port_irq_data	*irq_data;
 
 	struct regulator		*vdd_vbus;
 	bool				vbus_enabled;
@@ -181,6 +179,9 @@ struct pmic_typec_port {
 	struct delayed_work		cc_debounce_dwork;
 
 	spinlock_t			lock;	/* Register atomicity */
+
+	unsigned int			nr_irqs;
+	struct pmic_typec_port_irq_data	irq_data[] __counted_by(nr_irqs);
 };
 
 static const char * const typec_cc_status_name[] = {
@@ -706,29 +707,23 @@ int qcom_pmic_typec_port_probe(struct platform_device *pdev,
 	struct pmic_typec_port *pmic_typec_port;
 	int i, ret, irq;
 
-	pmic_typec_port = devm_kzalloc(dev, sizeof(*pmic_typec_port), GFP_KERNEL);
-	if (!pmic_typec_port)
-		return -ENOMEM;
-
 	if (!res->nr_irqs || res->nr_irqs > PMIC_TYPEC_MAX_IRQS)
 		return -EINVAL;
 
-	irq_data = devm_kcalloc(dev, res->nr_irqs, sizeof(*irq_data),
-				GFP_KERNEL);
-	if (!irq_data)
+	pmic_typec_port = devm_kzalloc(dev, struct_size(pmic_typec_port, irq_data, res->nr_irqs), GFP_KERNEL);
+	if (!pmic_typec_port)
 		return -ENOMEM;
 
 	mutex_init(&pmic_typec_port->vbus_lock);
 
+	pmic_typec_port->nr_irqs = res->nr_irqs;
+	pmic_typec_port->dev = dev;
+	pmic_typec_port->base = base;
+	pmic_typec_port->regmap = regmap;
 	pmic_typec_port->vdd_vbus = devm_regulator_get(dev, "vdd-vbus");
 	if (IS_ERR(pmic_typec_port->vdd_vbus))
 		return PTR_ERR(pmic_typec_port->vdd_vbus);
 
-	pmic_typec_port->dev = dev;
-	pmic_typec_port->base = base;
-	pmic_typec_port->regmap = regmap;
-	pmic_typec_port->nr_irqs = res->nr_irqs;
-	pmic_typec_port->irq_data = irq_data;
 	spin_lock_init(&pmic_typec_port->lock);
 	INIT_DELAYED_WORK(&pmic_typec_port->cc_debounce_dwork,
 			  qcom_pmic_typec_port_cc_debounce);
@@ -737,7 +732,8 @@ int qcom_pmic_typec_port_probe(struct platform_device *pdev,
 	if (irq < 0)
 		return irq;
 
-	for (i = 0; i < res->nr_irqs; i++, irq_data++) {
+	for (i = 0; i < res->nr_irqs; i++) {
+		irq_data = &pmic_typec_port->irq_data[i];
 		irq = platform_get_irq_byname(pdev,
 					      res->irq_params[i].irq_name);
 		if (irq < 0)
-- 
2.53.0

