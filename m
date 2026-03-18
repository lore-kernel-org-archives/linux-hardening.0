Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638B3D648C
	for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861057; cv=none; b=lW6S3y/w4+YgbCdzH8+/KnHjqCsufgLqpu1EoSDGSMkPWawzhW8tO2QwMQ8AjrZAOktYf9Yk3u8PqxHi2/VC235iOceETF86NgPk/UUN9jMu0l6wYZmhuQtAsxmb/LYB1xYhR+DbbPwpY+lthuju/OUArEZ4HKw4BMjGD9PCvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861057; c=relaxed/simple;
	bh=tB+Nv6pjBL7gh/YSoN1m/+MbKOlsv6e5EOr2WdQwmn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQoiCxDU5K2gNqw8SkUnhpoIOI4tZsqtr/vg+ga3VOkZD1ZusvMtrL51Lc7TK0xEyMLtevHe3lu1C05WBMXCINm07S9vNOT04vGdzUsX/prDt9d2DTmXLI3IRS7zjWMFoUnp36C/aLAUPXFX5c/hIgYYccqg0+Ml/XgDqHZZCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXRrzcij; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXRrzcij"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so206966a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773861055; x=1774465855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/fuMQSCwheo92q+sJzp01BF5cuisAnFpxfybDN6btA=;
        b=RXRrzcijFCiysqSrTKYFo5cqpEnivzGnqYa5YXfR8XTvSouCJcKH6mrbuj1lWRDXq4
         AqI2hFwby6GrLaRHQfm8o+k4nRGxx2hU3GwdSVtr+OOKPJff4LCN2fo1pUBEJoJc1j4+
         ubW0flsVQEuA1mzNBtxCsGEjU6BNk1keSurSG04EBa5TyEcwDxu+CKXjgaP3Vt6fEC1x
         BSq+UXZ7aZZBzaQLc230bQsVW3uDrnrevvT0wQlTF9zPqmoyw2kPEHkXrBPjE12GiAYX
         1pt4Q9RVwkug2mkmOIE+2SYechuyB2lg8huA3k/EgpLErtLffbrelcQI+SogB978cAaG
         jKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861055; x=1774465855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/fuMQSCwheo92q+sJzp01BF5cuisAnFpxfybDN6btA=;
        b=kpZXl4AabardiDkWSXT0PzEcbrTbrUCw6+SVRDKJrG0RQDCCEDenYPgeWz+e56+1g0
         WYAGeuxbYjqTNBisHZYuTG7LYWm0N7cA4Jic7q2wqd0Jx9Yt4ZiaGSqGswwBbH9n/g36
         zHI5D4rO6ASejeiaYI7vAnj+SFyM7eYWxBwd6IcvgrErK5nHF2McJfKw7Ps/Ll0tF6l6
         wGARiJusT66metbbou1AZ6nPzLuwpnLkZyyMWM4BmfPi5RAvmE29sYuTviXiIYNwz8ws
         GrDApS3e+jo9Dz/p0qP8qudAK6ODrtsKBMuIRbCC+94VALgI+aBcmAQA8vh/rGR8RUMy
         tCBg==
X-Forwarded-Encrypted: i=1; AJvYcCVom8iAV6YBvi0p0vM2RkTtBpIZRMcMqlnL/91W07oqEKbfV6qOzfAXquJ9MeiGhPAxAZTvjwsjuaCH1vpM8OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1M0/E8Nh3WzK4jiPi1UX/YVBMDTz5Bye+4FxHBG7WvcxTz9J/
	DtfHmZx5cmePs4RZpjtIOJprcMPmKq3nTRGMjF2sWRjYZJfFvbfxRcME
X-Gm-Gg: ATEYQzwrYBJWFli35FP2GIgsF/EAkArh8mUxctZ8MkwyOV4MN+6myhWvy3tF7c2ncJu
	UzEgP41ZmBcMQ4gu2k5uWXrbjo5K71uuxeQdc2jXUUwlr8zpiI3eVNGugl1l7VfrOAO7qiksC9X
	neDdU84Jk3l466okFG1+cSTEYTkqKDpWmPr4G+sBEuW8z1eP+ULjX+KLysc7SDxfMpQcwJ18A5I
	2icIkei13nkF68NWqP9V0+mgTARZzdDXmcW+4napE8ak5NdsljjPXbX9/rG0fg1k7oiznmeZebe
	mGAhS1Z4S/UVHgO0v1Tn3Ztn1IDe3nkWmU1WopLTy7MTJxkPI89VB1p15vtgt4DQd9OhA9uexKD
	MTDrxfOpRR1cRAUTkmfQYu/O/lVs32r02znPy0/QudviSYAj5bH8+5qvAWiCtC6Q7vgImcA9qc2
	JYL74i1uKL0MRHVVBDW2FOP9yvC96Yw69CUyGCrEJlWzDAx1BWv7350og=
X-Received: by 2002:a17:90b:5584:b0:35b:9896:cbcd with SMTP id 98e67ed59e1d1-35bb9f123bcmr3740207a91.27.1773861055321;
        Wed, 18 Mar 2026 12:10:55 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc62f6003sm355894a91.8.2026.03.18.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:10:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] hsi: hsi_core: use kzalloc_flex
Date: Wed, 18 Mar 2026 12:10:37 -0700
Message-ID: <20260318191037.5661-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: add back kfree for ports.
 v2: remove wrong null check
 drivers/hsi/hsi_core.c  | 37 +++++++++++++++----------------------
 include/linux/hsi/hsi.h |  2 +-
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 7cb2dcb30fdb..754949f5ebd6 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -342,7 +342,6 @@ static void hsi_controller_release(struct device *dev)
 {
 	struct hsi_controller *hsi = to_hsi_controller(dev);

-	kfree(hsi->port);
 	kfree(hsi);
 }

@@ -446,7 +445,7 @@ void hsi_put_controller(struct hsi_controller *hsi)
 		return;

 	for (i = 0; i < hsi->num_ports; i++)
-		if (hsi->port && hsi->port[i])
+		if (hsi->port[i])
 			put_device(&hsi->port[i]->device);
 	put_device(&hsi->device);
 }
@@ -462,39 +461,33 @@ EXPORT_SYMBOL_GPL(hsi_put_controller);
 struct hsi_controller *hsi_alloc_controller(unsigned int n_ports, gfp_t flags)
 {
 	struct hsi_controller	*hsi;
-	struct hsi_port		**port;
 	unsigned int		i;

 	if (!n_ports)
 		return NULL;

-	hsi = kzalloc_obj(*hsi, flags);
+	hsi = kzalloc_flex(*hsi, port, n_ports, flags);
 	if (!hsi)
 		return NULL;
-	port = kzalloc_objs(*port, n_ports, flags);
-	if (!port) {
-		kfree(hsi);
-		return NULL;
-	}
+
 	hsi->num_ports = n_ports;
-	hsi->port = port;
 	hsi->device.release = hsi_controller_release;
 	device_initialize(&hsi->device);

 	for (i = 0; i < n_ports; i++) {
-		port[i] = kzalloc_obj(**port, flags);
-		if (port[i] == NULL)
+		hsi->port[i] = kzalloc_obj(**hsi->port, flags);
+		if (hsi->port[i] == NULL)
 			goto out;
-		port[i]->num = i;
-		port[i]->async = hsi_dummy_msg;
-		port[i]->setup = hsi_dummy_cl;
-		port[i]->flush = hsi_dummy_cl;
-		port[i]->start_tx = hsi_dummy_cl;
-		port[i]->stop_tx = hsi_dummy_cl;
-		port[i]->release = hsi_dummy_cl;
-		mutex_init(&port[i]->lock);
-		BLOCKING_INIT_NOTIFIER_HEAD(&port[i]->n_head);
-		dev_set_name(&port[i]->device, "port%d", i);
+		hsi->port[i]->num = i;
+		hsi->port[i]->async = hsi_dummy_msg;
+		hsi->port[i]->setup = hsi_dummy_cl;
+		hsi->port[i]->flush = hsi_dummy_cl;
+		hsi->port[i]->start_tx = hsi_dummy_cl;
+		hsi->port[i]->stop_tx = hsi_dummy_cl;
+		hsi->port[i]->release = hsi_dummy_cl;
+		mutex_init(&hsi->port[i]->lock);
+		BLOCKING_INIT_NOTIFIER_HEAD(&hsi->port[i]->n_head);
+		dev_set_name(&hsi->port[i]->device, "port%d", i);
 		hsi->port[i]->device.release = hsi_port_release;
 		device_initialize(&hsi->port[i]->device);
 	}
diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
index 6ca92bff02c6..ea6bef9b6012 100644
--- a/include/linux/hsi/hsi.h
+++ b/include/linux/hsi/hsi.h
@@ -271,7 +271,7 @@ struct hsi_controller {
 	struct module		*owner;
 	unsigned int		id;
 	unsigned int		num_ports;
-	struct hsi_port		**port;
+	struct hsi_port		*port[] __counted_by(num_ports);
 };

 #define to_hsi_controller(dev) container_of(dev, struct hsi_controller, device)
--
2.53.0

