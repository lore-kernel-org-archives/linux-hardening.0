Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA52E64A;
	Sun,  9 Jun 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717936899; cv=none; b=iyKswC5vb8evItpLvzYEsm0Xldt2EWSHmfuu1YhqajvBRCCdou1Gry33tBQDsr2otecxf7erPeppftW8+yqLFcrUAxtfM8NW77IdFz0zQTAxnWQivdWabCHaFCXwqUdR8ldSiu5WtyGM8iu9ceK8/sn7EnvKLo+mK05X7g+0g0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717936899; c=relaxed/simple;
	bh=VxQ5ZVnh61dCaKiBJCdTdFoMX88pxW2Juk0q/pYhdRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sc37fJKNXbSzmMyAy6+lQhb+Iu619GsXLagYS1SoPco9oQwgdgpD1GBwY99Bqz2gwDlVrU4T2wsjK/WPODiVMVVxsigKYBQl3sr0JCTbJC3vT/P2Cfev73MFMOk8hOv+Q8c4oM7FEoY767NmPmVpKRbmzQTYRX/oHYAiT4NiDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIW7TVXi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIW7TVXi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6dfc17006so13011095ad.0;
        Sun, 09 Jun 2024 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717936897; x=1718541697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cf23nxdHeFgkRwPVZrD1JWaI4FpEFwucMzstBOMHqWA=;
        b=NIW7TVXihRaiYaOfvVqk9BckyxW/xmQ9sRAwuXuAXgzT/ddv0tUCoE7459cJkGKbgw
         c6sRL1xIbcRJZIXpBj8gq5pIf4J4pOjyTLtNktoOjCjkKtBML/RYfGJ72ZupzUpltjaK
         tFw9Db22aHd+cjQri/r0o2KHqho2dlKBlAwv6GLdh+stxPbV4koX0RUtl+aiuMiSjE7A
         CrLYjRMq7VVPYAQlxMS/p9aPDu+08BH/+XbdB4VlwcDKPv1mXWOF+EfGnHvc+uuK+HrU
         8eS0gR8Ch3l/jvhmSfcQbzcjxgMdu3Ui0zPwjU7/1cNfK+f1uHYWXYib1F2PYbcxLQOq
         VQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717936897; x=1718541697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cf23nxdHeFgkRwPVZrD1JWaI4FpEFwucMzstBOMHqWA=;
        b=rWUc5qMUl0c3SzpbGWJd3pukaZcKbuJmwgUbY5qRDVNJKhrn8RsK8Y/LLS40hxMYZC
         WVgtDU2+9WlDKMHDH8VGzJYdl29Y/RQNYJhBnjkzlX72UhXkduNmGR9yMdv4SdCwm1Wy
         k518NVYppsaV8GHIE5nXyuBtYlrwHi55cGVlnljbnUUY2DcwGEmHrN4V/Zth1BBAEok9
         m89nMNkKCtMb4f7osmscNXFGvSqUMHZSmaAaOZMBLR72Q9PdkGus1Yzn55bBapmitsMO
         1QdTedx6WyM0Hpen5H5MlVVM7z7oEybrfOr3pfWIZ4eiR7H0FVu3XGw/8bJlO6EV6kmd
         B4eg==
X-Forwarded-Encrypted: i=1; AJvYcCXx1c878hcHNrXtpj8kB2QF9NpGV+w0r4CmYcEOaTLd4HC3Cl+y5Gisb4nY5nM4i9JQA3eUHmM9/KPt6BS5oSvpSuSYpkzJnTnbP59mjSkgs+RVuvrnBw1FHosj+v3w+gAd7GvGXtXSfvjsyDa3
X-Gm-Message-State: AOJu0YzBfuctXMCQQiBvHsn1nbELVyTLQxijqhMugI44sl7Xk7QALRTK
	GuujHC62yPr0hhXU/UhxJz9n482rhb0R4W8QrkEf4Rts8o0hsGZXw4UX3al2
X-Google-Smtp-Source: AGHT+IFM2w014+Q/HonIa8KttAfbXETdNGzigbqJB3eJok4sZhqsrj0nNjkLw58YfAg3vKiJyLFmYw==
X-Received: by 2002:a17:902:c401:b0:1f6:751b:f2c with SMTP id d9443c01a7336-1f6d02e6b25mr77675145ad.25.1717936897520;
        Sun, 09 Jun 2024 05:41:37 -0700 (PDT)
Received: from dev0.. ([49.43.162.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7d2ee7sm64933735ad.168.2024.06.09.05.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 05:41:37 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH v3] pstore/ram: Replace of_node_put with __free() for automatic cleanup
Date: Sun,  9 Jun 2024 12:41:24 +0000
Message-Id: <20240609124124.51166-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __free(device_node) to the parent_node struct declaration.
Add initialization to declaration for ensuring scope sanity.
Remove of_node_put from parent_node struct.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---

Submiting v3 after making Changes as per feedback shared in v1 and v2.

Patch v1:
https://lore.kernel.org/all/20240415161409.8375-1-jain.abhinav177@gmail.com/

Patch v2:
https://lore.kernel.org/all/20240605214944.22113-1-jain.abhinav177@gmail.com/
---
 fs/pstore/ram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..f8258e4567c3 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -644,7 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 			    struct ramoops_platform_data *pdata)
 {
 	struct device_node *of_node = pdev->dev.of_node;
-	struct device_node *parent_node;
+	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -704,14 +704,12 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	 * we're not a child of "reserved-memory" and mimicking the
 	 * expected behavior.
 	 */
-	parent_node = of_get_parent(of_node);
 	if (!of_node_name_eq(parent_node, "reserved-memory") &&
 	    !pdata->console_size && !pdata->ftrace_size &&
 	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
 		pdata->console_size = pdata->record_size;
 		pdata->pmsg_size = pdata->record_size;
 	}
-	of_node_put(parent_node);
 
 	return 0;
 }
-- 
2.34.1

