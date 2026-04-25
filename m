Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4431F192E
	for <linux-hardening@vger.kernel.org>; Sat, 25 Apr 2026 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081341; cv=none; b=KfpterEq4yKRh9qv1EnOXR/QKiTuGdybBRBy7PpM81fyz0q3XX1zj19QOKp9K++KXIdJvekA1SvliQtk3sB9a6m43n3pk9KOh103byphbRIYxArjN9PFavUi3C2cyUfDsWzITzFKNgjLX6kJIxaVpkvzJOM6LxrPhxXnnXaRdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081341; c=relaxed/simple;
	bh=mj3qfGYlr+bMveVNY0NmGwQ8Jz+/4iRwZC+w+LJ21Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/IIYVdQ93+yiNxOuuaDm+vGIjGL3CzTQjKLZwfdGeLQG7rxcmLzZjDNGaeXzba4sMHUO7Ljgto5Lk2rGMlK/Pv3JI3n2TIr9wfSF8Wuo+Pbuw6heZgrJL7SWS+UiPT12WKAIclBg4Z45+ro4m8+Cc+aHUpAeHADI5fe/9qa7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtNcuHTq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtNcuHTq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3614826eca4so7598889a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 24 Apr 2026 18:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777081339; x=1777686139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OxYR+RFt6UrbmMauhFwdJjJ5w7Lq82SA2vzvpVn2KI=;
        b=TtNcuHTqY8iR0xBAIn/qlkWOiuLT3CMqmKxEL0x6cgAXG7sP0QN2htCPZc5KeZxjE8
         cQJy02bNPs+jD5Fh7W7vIO09kChXVTkMcKbrg+uDd1hRPplxoP95eYi+PM7qxgmbUv1S
         G12G0LI0yVSlb7NZfwhk1ckzgZNGet6Z/UoiTIX1eyB2hD5/xN4+uY+/jNEDeBcQvgci
         InTnxYPGIvl1gDB+ds1VHXkEt5P9Hb6q7Lb0y5lB6TmL5KFyG0pXlgUpBEGM8Zyovigj
         waJRvO02yIwlWF9f+cjszwDpdkh0AdnUIg/R5ntxH860gzUOogPREcUzO9ZjFGdCdAOf
         KRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081339; x=1777686139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OxYR+RFt6UrbmMauhFwdJjJ5w7Lq82SA2vzvpVn2KI=;
        b=Zm/FB9ciUOf4JPyshKnYl4s8ahmgNnJUnJbuiZdOChsHQW0B/jxYk+AJy3TOa2mWbf
         zh3XJpCpxdmlbRTzaJJCK8CDvoeeN17UWhAvQeXetix9eSXl483wM1kLJ4Cwf1fJD4hp
         dw3SInO9SEdon0KRpMXHpN9Ooqf9MLCzoKrDWfQgWIXyPBsTSC3AXgh2AmiIRcUFzaN2
         UPOGwgm5mmM5yJrKfZOfYDD5tRuGvOHirQd7NkkXzSkcXKGY8uFAZfQqgcowQHDFZZH0
         74zEaie8uptdTheaJRTIwhSzHBzSp+b5lF3gzvR7L1cScvTXKgSgFruXKsEtQCq3qBw+
         ndhg==
X-Forwarded-Encrypted: i=1; AFNElJ8rczdbbRAfqH9eM3Pko/NPVjstClhlZhfByQCrIYnzt53QrxhqaIbSL2mhy5E1zYSLv+bO3IS5WquYAzU22X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwYloz2Q8VE9bfoQ4t6Xz797LjagzyE5PJP0ppGHu05nblDqU
	/2dmqOBg+otJxUZ+w93hQpsz4Dy1jLQUFfJFFWZHqicJ3c55ttFrXu0ZVj1/Zw==
X-Gm-Gg: AeBDietq5JtpEk6HGq3tsw7ONpu+TPGuSiXf3O3ELbPQLkSPp92DceNOQxeNoFjFnF9
	ELwHBjdMe3OIquJqlcHSpXehrZn8DLaoF4T73j+MO451g24jYkclz3TQoI71tsRqQFHDdzQcn7g
	Bz9mCUCNMA1BgebtTmvp/cYfFJuAx6d69TECmR3XESjd9pzStV2WsPHbC/5/XvAAxGkAXFfVoci
	xYugl7L9JpmeZjc9cXFTbnfFuKb2+JjXaUCnHGY54UYADu1dmd3Ee5M0+qHTW9NGE77K3a3ko25
	xqvQVIQ5PnHrQKB+qHc3m9dFNB1fWdhFAdok/iqx/OFpD75rsteLTYzqIag6SuqyUpJndWjaCVe
	RWRB6ac8twdbjmgG1msVRbBbC+zFLfEunbhPY7ulQardUk7ppRAkrdewjNZcDzgCDFL2B+P+Nq3
	B2jVuBHDS1qrmca7gVidF/ZpeniBdgMiPITP2kUt4mtwOMaCUq0J2yGRTaMDOk6Id4epTkxY9Y+
	2yOxgt1nrvMetpokMhZSSIrfoiEIPHog/Mr
X-Received: by 2002:a17:90b:4fcc:b0:35f:b293:7ac6 with SMTP id 98e67ed59e1d1-361403bd8camr37022135a91.6.1777081339252;
        Fri, 24 Apr 2026 18:42:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362c69b8257sm9967412a91.7.2026.04.24.18.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:42:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: typec: intel_pmc_mux: combine kzalloc + kcalloc
Date: Fri, 24 Apr 2026 18:42:01 -0700
Message-ID: <20260425014201.439251-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flexible array member can be used to combine allocations and simplify
handling slightly.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 1698428654ab..e22b070a140f 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -151,13 +151,14 @@ struct pmc_usb {
 	u8 num_ports;
 	struct device *dev;
 	struct intel_scu_ipc_dev *ipc;
-	struct pmc_usb_port *port;
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
 	u32 iom_port_status_offset;
 	u8 iom_port_status_size;
 
 	struct dentry *dentry;
+
+	struct pmc_usb_port port[] __counted_by(num_ports);
 };
 
 static struct dentry *pmc_mux_debugfs_root;
@@ -731,27 +732,25 @@ static int pmc_usb_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *fwnode = NULL;
 	struct pmc_usb *pmc;
+	u8 num_ports;
 	int i = 0;
 	int ret;
 
-	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
-	if (!pmc)
-		return -ENOMEM;
-
 	device_for_each_child_node(&pdev->dev, fwnode)
-		pmc->num_ports++;
+		num_ports++;
 
 	/* The IOM microcontroller has a limitation of max 4 ports. */
-	if (pmc->num_ports > 4) {
+	if (num_ports > 4) {
 		dev_err(&pdev->dev, "driver limited to 4 ports\n");
 		return -ERANGE;
 	}
 
-	pmc->port = devm_kcalloc(&pdev->dev, pmc->num_ports,
-				 sizeof(struct pmc_usb_port), GFP_KERNEL);
-	if (!pmc->port)
+	pmc = devm_kzalloc(&pdev->dev, struct_size(pmc, port, num_ports), GFP_KERNEL);
+	if (!pmc)
 		return -ENOMEM;
 
+	pmc->num_ports = num_ports;
+
 	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
 	if (!pmc->ipc)
 		return -EPROBE_DEFER;
-- 
2.54.0

