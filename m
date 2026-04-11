Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EC2144D7
	for <linux-hardening@vger.kernel.org>; Sat, 11 Apr 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775875023; cv=none; b=JGD4VBcP+8dv3whiSegMoFxoa57fcE+HPn/wdVY1UumadYCVweJRW7+YTWD6CTBB6q8hX8PKxsTdQzqcdJXXQTE7bAUUASGQOWdS2Fotg3jkyq00rAAmeEN0Kid9vr+zAnBHcnqhonFLX9ceFxkWxOKjZoN59znoUq/uiOl7/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775875023; c=relaxed/simple;
	bh=BFjWHuj38Nm56Fk+D4b3tbNLGWBYO5SNEW3mNCYAvSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKodSeRE9GONwUzDXItkLT0C+A9C+nyk6fJZ/SCb1uOWguiLJPR6T39eOLdsTZ7nPXcNo80L+omO7UV9G6gWANIP26VweIM9/CvPARxlAx6qwKFQO4S0N9VLKRnA1NticaRq2CThc6Fif3CXbNfFFgo2e3s2YFReiiYCGjl21Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM+94tUo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM+94tUo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so19101965ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 19:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775875021; x=1776479821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWU5hmGaOyknlwANldU6S4LDvr9Qn1n8t583iXoLjWU=;
        b=QM+94tUo84GzWzsd3sRrwPaqDpTEROqcLFLUG7svM5+hibTO4re2PkQZw8FhyE0mib
         XG1LtG6yK5HVsXy6XE/pW94hhc63zNdioE9fVUWxrFoxzH2enuN/hKfBtx+7eRmgexFZ
         0oB92elTWHzRmIa+KJ9EMq4k+Md/lJDObtFxSemu/6qCgGwmxnuH5cG8ufekZ9CH6Knu
         TqP2wIiXreOMxPBsKe3n13Nw+wZIebdTTWf2PSnwlGszqz/J1zzITp+IZOJlYutGSQcx
         UwifUOQjuC7byGzx0nnLI2WXotxAHRwUgiLZvuFpmgOtZa3Xz4EoUsFnVO8AGjjU7Spm
         v7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775875021; x=1776479821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWU5hmGaOyknlwANldU6S4LDvr9Qn1n8t583iXoLjWU=;
        b=V4SBWzJbAmucOWtP7gBidYV59pPg64zoA4dPb+397yRgvbV8I7Ut6hb5BCkT7IQBjK
         Gv8Y+jQm64NEpEUjDPSPD3mOwqlnC5Le1mx6XiruIPaVLmDhTxWmCyL5s81Sunq5hRTR
         2Ykw7PaUlH0mizu8KuMLK637N9tO75cAXd74BugpCz0te8Q9WMf3MtV6Z74C1H0Rwxsc
         GgDLQ/hoMpr//LXQxbQmlRuODMe1+j+gkczyb7N4fa7swVurB71CSCy10l/aQikDIsTz
         v7Yr01aYVRQrlHDZqsZZeRoK35XHVjpAfZqFL+gE25DvFVSgk61NdWweh0hH/MXTpkIH
         rz7w==
X-Forwarded-Encrypted: i=1; AJvYcCX0NZWCS6Mibykn9InBb/CGF0fLQR6bb6sdlejt4vsPBfWJ+os7wBMOh1FCAzI/8Cxh/ExAsRaDi1I/eftUGv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDZCljf0hqsdyCcZwaaSmSLiFlOO3OUXRNfIEY1ND0YrwmfOK
	naAhNi7s/6fL7Mjx3ynu2mi93T6t2F1HeZGJxkt7uk+WELKclFrFRQwexQbZ7A==
X-Gm-Gg: AeBDiettKLFLxqgtH4Uut99iUypWE7I2A3GxRabwRbBi6fcS/BSJ+pDjc22rAND44C6
	WnRuduf+oa36TXTLgKaFva+1FvYQj9ZIt2HeKGbZuImsTp4C5T/3OnzeUyWSyVG+BNlxv0xHP7i
	uDolhMdN5sU9Fg4tUh16krkJpR7aNYYPa6xE9+Mg/SHSVpyf5os2mbx5sogdW9pvZ+zMKOAO7qw
	67L8OwpIYoMr0J2ZEBd8tUnlK+nCRnP0cXrTGxc9QL27kjVfH64axsZTDLEb/YyklO4gTH5NXUz
	q5zaVDSvt1Xv/Grzbyp0CpOINbxozEJhb8wPVWfebb92n23gjpSvAn47jiVCEBCOmjId0dQx8yW
	o++eawP3EEwINWccSs3Awbpai0SUuJiFc5IzGaY3J0fBn9LoeBPzE061b3KxLPDfSce5txw6BhW
	XW9UILoFe3MQnSg6XzZOoCoifzi1gf2EFpP8EUl7C5/uT4HJenszXTX4o=
X-Received: by 2002:a17:902:ce0f:b0:2b0:708f:4dc7 with SMTP id d9443c01a7336-2b2d5a2a1a4mr58818985ad.29.1775875020669;
        Fri, 10 Apr 2026 19:37:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dae27asm42432295ad.7.2026.04.10.19.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 19:37:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] usb: typec: intel_pmc_mux: combine kzalloc + kcalloc
Date: Fri, 10 Apr 2026 19:36:42 -0700
Message-ID: <20260411023642.146890-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
 drivers/usb/typec/mux/intel_pmc_mux.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 1698428654ab..8b0a3dd3f940 100644
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
@@ -731,27 +732,26 @@ static int pmc_usb_probe(struct platform_device *pdev)
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
+	pmc = devm_kzalloc(&pdev->dev, struct_size(pmc, port, num_ports),
+			GFP_KERNEL);
+	if (!pmc)
 		return -ENOMEM;
 
+	pmc->num_ports = num_ports;
+
 	pmc->ipc = devm_intel_scu_ipc_dev_get(&pdev->dev);
 	if (!pmc->ipc)
 		return -EPROBE_DEFER;
-- 
2.53.0

