Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F0AD2C
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773621719; cv=none; b=NgvD1O97qag3CNi5/Xpl0rd5c9YTjdJtpfyIHMBkfYHO3e6w0t52IF6MTJNRoxn44dcaFk/wg0KyUgib7aCt9WSBBt/4EtFQjLuXqp5lbixfNxgHp8P5TZ9LLT2ogUMyeK9HxpakP1rfkzrKWuUzjT/XKHZNVVNcVOtggZpSyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773621719; c=relaxed/simple;
	bh=kuEXRTeWf/8AKOmPoxmyZoAuGNBTvg0wBi1WKsDLmXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqJZ7Z8ubk0+ik2sae5Ssx70XEWQcsGBOVFoA4LETujT3Scioowa2bIXVL+MafyFOJt/f4HYflwVTItaoaYubuxDixymZkOhjn+d38vwHsmdvGwBzTpL+ciRD9mfMZL8KKiQ/yHI7oTstDsFl7m6Z8FIMrq1ElxQfH3Z2Jsh5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN/r6yf1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN/r6yf1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82418b0178cso2292906b3a.1
        for <linux-hardening@vger.kernel.org>; Sun, 15 Mar 2026 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773621718; x=1774226518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpEaCXx7J3YG0Lph6zn7bmRefcBWEhcsCVFdscO+mwk=;
        b=iN/r6yf1iSDluF9fj7MdwRTGFLrQ1WLOE/lH83/88SqLX6uiWaTGkQUJBVOHEHDLBG
         uvfsRjbuhe3kAfT1XDcrUOj1mrINKj3cyvBmtIAUgBIEXxqPgPQGYHYLnrI6486gc+TS
         sE/ffJMaB719oNB3XArirvYl/UsqGU0FS8BSK0/fFxMI1LwjG++HtsFZ9iNZ8t9KyV3X
         +4JCEr/o8pkMcUdPm6cKlLSVZsobvvSlXI2MVq5feZdz1ctUkS+TqIHQcNV4vKCJE5oa
         RsBtQZeBD+L0fs5gRdCf0SZaGXigYobegEFShO/CcDQdRDV3zt27wpOYlb5/9TuO8WJZ
         qUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773621718; x=1774226518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpEaCXx7J3YG0Lph6zn7bmRefcBWEhcsCVFdscO+mwk=;
        b=TbDtLLwdgycQ/Lkdit+TUAsmW8BL2fwsBs6zWzo+u0OmV7SeJm3jxL0Owf5xhTy60L
         oHsKeV02S/TzjwXQjCnhITcYb2THyLxv7EDSyfXMEf3dNjvA89/SVJE7P6QGJRImr/G3
         D2oKhYUxzpD0Kk+syJJEck0xeEkOAG9aesl9TgttV2RDD+h1s+oUxA/6nq/BirWA1Uid
         xSKL/ZR3rCgkQvdeJ+EUC/Tkempg8vbkn5c9gP4WECi2YewijBKn4196S90JYw64ZH0C
         QKk4djggWRhjRueOjVSSxKZrZY+mrLkbbIaiVtOo3zbaLyAwdpAvUWlYee1UPFE7twYU
         Z9oA==
X-Forwarded-Encrypted: i=1; AJvYcCVkWLhOTai2ae3zLswjfjUMDoT/Lell1ryK8J+im8igeeMG7u7Omg7JN4twHjpkC24pnD9RGXT5+wUPWm7RQ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQotnOnX5E3oSS+YnR/qsQ2LRj8oz3Vpp7mIosNTWL9xe6gVXB
	ogwO/H+6JrRyvZm9gYtxx++AZ5xHX9aGzEiwObLs2++JD8y7AvJ2T3ojROD3n+vj
X-Gm-Gg: ATEYQzxWpf8gLxJsa69DW6AtrhkiP0gsKv8mi6vC+eL6PppVlKMyyaEBC4/Y/rBxaN8
	X3ITJfy8Zh4fv896usVxD8TQF0GDIu6hTMJlb5/EM6ma7oglbO5MR2JtcA6KobeNWzu1kTkJqzT
	ZISb0oqUhpqERgQupJfzOJPa9d1yWX0L8ukH2y1GoQw/+A9HPQKG5vwCAuZ9XADgl5SVh/mxtQz
	oIHNUXFml8QdQHg43tgXqPwz9edqN5WshZRMzTXaa4sDKA3PgkQjJwF3uNPlybyM0ql0DwM7a1i
	Lb83YX4FHC2CPx9FfcQKgq/E3HaODE0yG0wWQjxc63hoRpxio3NFIzRjDDiu1VRKoJsTBO/Mqpf
	7baiJMCAZs4uPxgWNAo1FvyReHxGEHPVOZSiGA/8Dn0FuxAcTAaqejEt7oSVVjVYRHptWrRonUr
	X98NLZWYHPnHm2kiLCuLs8B1+pxsz0QyKttNbqzu2mznYM+TSFfHQnnZcczFFzqwO6bw==
X-Received: by 2002:a05:6a00:94c2:b0:824:adf4:5a32 with SMTP id d2e1a72fcca58-82a198b4d94mr9901439b3a.42.1773621717792;
        Sun, 15 Mar 2026 17:41:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07384a7dsm11975492b3a.57.2026.03.15.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 17:41:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] hsi: hsi_core: use kzalloc_flex
Date: Sun, 15 Mar 2026 17:41:39 -0700
Message-ID: <20260316004139.267912-1-rosenp@gmail.com>
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
 drivers/hsi/hsi_core.c  | 36 ++++++++++++++----------------------
 include/linux/hsi/hsi.h |  2 +-
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 7cb2dcb30fdb..f1b84add291a 100644
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

