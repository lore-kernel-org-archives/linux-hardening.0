Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33032F5487
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271448; cv=none; b=DoI/Iv0p05a3srkyZNaKnHPb5EMg08DoZfkWNr7psUWBnUp0vfKQR85JFPY5B2/t9c17iMdM0uUgEtrtJf8FmBgA5M80CxJtBxgGo+7+Hn9UL2PyFrvaCbVqZVtHDLkNjJZUXUrbOzM57xhPzXJ5PhRJWTC1Hb/NjMd+rikpQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271448; c=relaxed/simple;
	bh=5x6P8nJwDE2dMBktvCxCL7MxySCiJKpx1mSlB5k2l7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Osa4uTiIbx0I4OQkgZ8lSVkHVT2YtbUeqyuFRNzfkKVwTkBdnWcA1azDWN5E7Hip5U27sMAD0IRpmjh5hneGfvuO7bED7q1b20agDhTARFxhaOc0HcYU5382fd7bQK9U9N/7p5at+Fu9MVJt8z4GZ1+AFdQp5EYFkVIQA7GyyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVHIAo0O; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVHIAo0O"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73aabd620bso234229a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271446; x=1773876246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKV6gzPWKf+kdTy1HFMh1iXAwf/N5tjFhknniuMmlF8=;
        b=FVHIAo0OTs0xVexbwy8CQFqCNz43JIoI8zD5/kMBuvUv/Qtx6KDiuyccMFCsOObpLR
         lOdbab3AV0RzpzOhjtEb3coKW2qnXwLNeGfdfybix5L7itKGndSKgEZVqMLqF3LyhKYr
         2EzPsB9to0k/DRdt9dwYEL1uSRSyLHYJrHpewDJVrfIaVtaMBYQg4yBo9XW8rEgY+Vsp
         EnZV4HYG/O2bTlHbbzeFZa3qK9w6GljdVKpWTe+8UTSJrqm+KlDIftMQeCbFPS57ag3p
         MKEDDP+lS5AM3rUpoY10oLWXLW/tpjK7af5E4Vdsgt7SQIVdpyF466IjaXCRsJaoOjxk
         yV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271446; x=1773876246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKV6gzPWKf+kdTy1HFMh1iXAwf/N5tjFhknniuMmlF8=;
        b=L2QQzErEr/DpON2iD+psypWx6LOco3bkU1UHACJyTJwo0o/z20/+9gJ6gxE0SecR4h
         UcrsMEgWBbu5bRetMY6l+5uyAw+/L8nCUjZXhTy9EtniXkBDAZt4dsQVqJ0BesKd/ojX
         ZYKW+j8Dd+A7KIX+SL2vjLAAk97rItU+4ovKATQOe8MIOzZc4RYRseZMXsj8mh1xY6AM
         VQEC4ez/WGJ9GUNbOfYxhxjJHJrVWguLZk0LxSEo+IlN3cIYwcxcZ6DP0Q5gTq9ssc6n
         QzTAGMndu1Zv9L4AZuVA06JhFfUOaGs+pepmbjHeStlqMcApCXlHJNTXelrS9ricD8qu
         TATw==
X-Forwarded-Encrypted: i=1; AJvYcCV2yx3AbJINHw5nQYmbBPKuEnBI5Xw4C82UMKetfQ/dIcH/VNU0Ocayqr8LjSsqiTitowliybu2hk/EkJ4X7ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+KW83+uNOH5ApY6D9UYSRj6zXZyF/tLxxDreW7Smo0FtPi5s
	D0bv4/IG6cVfi6NsgwWASv6Z2Vsk2L3/amPyxmBbouGL+kZYBG0KBOOEVynnSMNb
X-Gm-Gg: ATEYQzz9aSa16yh/tIf/K6aWZa5iQdzK2qLJK7VtX9BQ0PVwXfsqmNKj1SjI7ByJ8Iz
	lIUXFy7DquH03MED4p+Fo69uKOBLIlaeyh52W9XbEuVDkzGDs5wlVesgi3Hsf6cxahiCgd42GWl
	PxRT8wryfzvxwgCM4iLIkrApH8Lgd8K8P0Yb+gQAOVgeVX0A2EfXicc8OmKTKRr4CrCVCaXRQZl
	aLUFMZ/tcczJFhhwxFv3o0bZVt+KsGWsTL91A1egt6N/8BHDEdjDlrGmukMUkLRhXtFomOY9a0z
	5buIRWI3/uYMA9+wS3M+BKuYlFQwwr3rafcouPnKgL/VDhrNCH18ARGEeIAepFLDB4jb4e0Pptd
	lmFq1Is0O/JKQX4jO1bIoQiwZR5MpLZsnUGLNVJ79i7ItnJHxXRoWwalE7XFnep9k+S7G7tBxY0
	00WtKaemLIlv9MMx/RUy6WV9tGJJMib4w9ukKF5jTli8fb8fvU925RWLa5q1bZJnZ5
X-Received: by 2002:a05:6300:6705:b0:398:7667:b2e5 with SMTP id adf61e73a8af0-398c6178160mr3760195637.68.1773271446144;
        Wed, 11 Mar 2026 16:24:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072603c0sm755037b3a.22.2026.03.11.16.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:24:04 -0700 (PDT)
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
Subject: [PATCHv2] usb: typec: qcom-pmic-typec: simplify allocation
Date: Wed, 11 Mar 2026 16:23:47 -0700
Message-ID: <20260311232347.18257-1-rosenp@gmail.com>
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

Move counting assignment immediately after allocation as required by
__counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: reduce chaanges only to needed ones.
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   | 23 ++++++++-----------
 .../typec/tcpm/qcom/qcom_pmic_typec_port.c    | 22 ++++++++----------
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index c8b1463e6e8b..a1d9315994de 100644
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
@@ -560,18 +560,16 @@ int qcom_pmic_typec_pdphy_probe(struct platform_device *pdev,
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
+	pmic_typec_pdphy = devm_kzalloc(dev,
+			struct_size(pmic_typec_pdphy, irq_data, res->nr_irqs), GFP_KERNEL);
+	if (!pmic_typec_pdphy)
 		return -ENOMEM;

+	pmic_typec_pdphy->nr_irqs = res->nr_irqs;
+
 	pmic_typec_pdphy->vdd_pdphy = devm_regulator_get(dev, "vdd-pdphy");
 	if (IS_ERR(pmic_typec_pdphy->vdd_pdphy))
 		return PTR_ERR(pmic_typec_pdphy->vdd_pdphy);
@@ -579,12 +577,11 @@ int qcom_pmic_typec_pdphy_probe(struct platform_device *pdev,
 	pmic_typec_pdphy->dev = dev;
 	pmic_typec_pdphy->base = base;
 	pmic_typec_pdphy->regmap = regmap;
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
index 8051eaa46991..6c6401187f58 100644
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
@@ -706,18 +707,16 @@ int qcom_pmic_typec_port_probe(struct platform_device *pdev,
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
+	pmic_typec_port = devm_kzalloc(dev,
+			struct_size(pmic_typec_port, irq_data, res->nr_irqs), GFP_KERNEL);
+	if (!pmic_typec_port)
 		return -ENOMEM;

+	pmic_typec_port->nr_irqs = res->nr_irqs;
+
 	mutex_init(&pmic_typec_port->vbus_lock);

 	pmic_typec_port->vdd_vbus = devm_regulator_get(dev, "vdd-vbus");
@@ -727,8 +726,6 @@ int qcom_pmic_typec_port_probe(struct platform_device *pdev,
 	pmic_typec_port->dev = dev;
 	pmic_typec_port->base = base;
 	pmic_typec_port->regmap = regmap;
-	pmic_typec_port->nr_irqs = res->nr_irqs;
-	pmic_typec_port->irq_data = irq_data;
 	spin_lock_init(&pmic_typec_port->lock);
 	INIT_DELAYED_WORK(&pmic_typec_port->cc_debounce_dwork,
 			  qcom_pmic_typec_port_cc_debounce);
@@ -737,7 +734,8 @@ int qcom_pmic_typec_port_probe(struct platform_device *pdev,
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

