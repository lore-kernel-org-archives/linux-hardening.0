Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5980344DBE
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777518; cv=none; b=VEAgCNs5PhJk1gC07G1GlnfI6ZIXFE+zLh6cwDqhCxVGv0LztupHxye5v8LeUhPfFJ9UUyh2OSC3rXnVY2cAkJDzCaQvWLC0B3cwDgaOe9axr3E0tNl6Na+qHAtD/3bTALChzzVh0TqIwHJF35SxMexKyUhNjHjCUOQzAhas9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777518; c=relaxed/simple;
	bh=qsz1d/oevfNi4OpV9QErO5/xLrhS1DjMUh+I67nbjOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmp116pgmp+h+DM6RfDqsmvnAhenq89hyS3UN2Bs1UtwGVwS7nUiQnVEyp3dLBh5vmySCf9GNaOOAfDYpXtimeCv2Ag4cdK5hlKs+Q0YwLM0kf81Gm+htR8rca/BC57AixYVxpyt/qP8Dfzk3XFpTgB/sexQq5OzqEWMAz2bOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQPBfbAf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQPBfbAf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82995242934so126040b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773777517; x=1774382317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS8/enjwNEDrh+eav3dimYdFBJyNdQLwxYnBi25HGb8=;
        b=AQPBfbAftYIy/lqSFkqypuFUH6gtFQhf46xil0nAqlnVhCvwVf1J0AFXMX3B/oevv1
         AAFkSm6xzeV1kWXq6vn3qmauuN364GJBsYs5HH9py273uFqw3CbG7OY+ux0BRxZ4iqiN
         JQSKit7vW3TLIl3E86aNojp6qtV7926s1GpUwXaXPTFXC4D3KgXtT3KfgaFgPSnwX69z
         znEEI9EIAB4nk4RDeu/pPbRLr7+Jcr8xQJ/ilD606yacgeDYAmWqRlZcy3wOjo89X1Ud
         iZqXn24Y3tpEncRGp5w9BPT5DIFpEd/QydcoVxHRC8h4NoqAo1FoN8Z865MIr/BB21Ac
         4LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773777517; x=1774382317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS8/enjwNEDrh+eav3dimYdFBJyNdQLwxYnBi25HGb8=;
        b=VfL4uE6sO7ktD3IdfCfWWfVp020bOEMDe5KAWBN1FBy9rY5gMl8NLDf+Jlw+o3XVnK
         isJ6wK1tgQ5FFpOrE2T/Ex4Rzp5noZowOdznoum52Fgdczcw/Rkr9fSYwOKHQmeiY87d
         sMEBZvnPw21qXdCv9Gf1UaZA7SBTaeunUPYG+I3MsqYmxMUOw/KIJpXaexBybvnqdjId
         QeTXb2bg2gaQkRMAEWH+iAYn6dam1lz2dcm9SSKRtNt+EHCQ7RONR3HhvWuNO3tGLHNa
         ojjWhBPX8JBu0lEgJapM7ALQIyWAHcrbtJXWrz1REy/9b+P4rjzSVrIHlcugMZAyxEJd
         0gjA==
X-Forwarded-Encrypted: i=1; AJvYcCXSyg/XfX1c0lg7px3KXm+X5kqjF6N1HjAUbTdQk62/S/76fhr8iBRc22OxH0Fac76nHNKLSjMPywAY/yyh26E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxj56l7MQwLXS/CxyiEw9P7h5VkegLEqMXBT49yeLmQmZRMZ6
	tZybbJv8oHaLn/4Fac1cdJtSKvvdM/6naDV+gPOCCUtZfpPbVmkpOFwr
X-Gm-Gg: ATEYQzy2hENR06g6U+ac9+416lZoGjPkgYCe7YHeS1tYetkz4QBsIeCZ0EJbo0d5Ols
	MeGM3254y2tKjWA3EOtOhsHEd5I9p3nX8PlWmFO8ADH5mEYzFOBOqneXr78zBN1ddBQeSZ/EIiS
	vm+gfQQ9Kz9CSxxJ9ZrdBcuBI07oRpAD2haV831Iwx5XBWd5HH9V8R3xZrmAjkkm61nqfWSl9fJ
	WSbRZgjOv49gMxo7FCYHUjFBPCkwUktY0oap8Yl9qvfZk+70hrW+SemBhJKLHR6OA+BiOPkt9h3
	9RpYFzfl3gWJQYVtw3/+q67Oi6zgUZwTh2VNC2A4WbDQs/4z9F+p0jeCDqvJVVrUCf4NfWKN2h3
	UpBx7DedG+12W4k3tzrUPU6peL6Equ8OkellKhcRlV6A8FzOi+wOerp9DR3MU+FqIVlpqF8JX1f
	CBB6pxLHQMfzcmXXXhYuoKNvcHZxCe9OAfFp0PasgpKgm9GCelRP7xlcc=
X-Received: by 2002:a05:6a00:1a92:b0:827:33cb:c7a3 with SMTP id d2e1a72fcca58-82a5603a9demr4141015b3a.10.1773777517025;
        Tue, 17 Mar 2026 12:58:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b565930sm280444b3a.14.2026.03.17.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:58:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] hsi: hsi_core: use kzalloc_flex
Date: Tue, 17 Mar 2026 12:58:19 -0700
Message-ID: <20260317195819.15496-1-rosenp@gmail.com>
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
 v2: remove wrong null check
 drivers/hsi/hsi_core.c  | 38 +++++++++++++++-----------------------
 include/linux/hsi/hsi.h |  2 +-
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 7cb2dcb30fdb..001bcadf4b8e 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -342,13 +342,11 @@ static void hsi_controller_release(struct device *dev)
 {
 	struct hsi_controller *hsi = to_hsi_controller(dev);

-	kfree(hsi->port);
 	kfree(hsi);
 }

 static void hsi_port_release(struct device *dev)
 {
-	kfree(to_hsi_port(dev));
 }

 /**
@@ -446,7 +444,7 @@ void hsi_put_controller(struct hsi_controller *hsi)
 		return;

 	for (i = 0; i < hsi->num_ports; i++)
-		if (hsi->port && hsi->port[i])
+		if (hsi->port[i])
 			put_device(&hsi->port[i]->device);
 	put_device(&hsi->device);
 }
@@ -462,39 +460,33 @@ EXPORT_SYMBOL_GPL(hsi_put_controller);
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

