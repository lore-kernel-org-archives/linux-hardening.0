Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B83A0B13
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905034; cv=none; b=jiulciv2Itev2vi1xNzRBGKfOg52Qpt+csWarSCtxCQBQOW/P7PxEeNVXiAg60zKNZh/91udoteV8fVsHVwAywbiYFbHuO/JGG1h9ddRGClZGW7XNdM6wN34ugKyPH7ZvgiL/SQcdQYU7QzUJE11GQ1Z+KgJ/wENBOOgDFJX1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905034; c=relaxed/simple;
	bh=x6LZKPlnMnzPyi+3+BA5c9a8UQjqYHfNM8ypvVO0gGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s326Ho/PM689cWSmCDI9obepq2SGVV7uxr87VnEsGwdfzhcifWXk8SNoNyfyWAvfh7lA0etNHMlXHKfyI5iVdnXhvC3z/8u6YtVfieCNiqf5Gnva64K4yZ1ETxEtxgJ1BTG7RRvNm0BBYZtF+ENGbk4rht/LdSC6H3pksooyIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc8aNM77; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc8aNM77"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1398151a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905032; x=1775509832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEP0zXDzOr+l04/srVbHJJ5LhsariHaPANvTrx9+dlM=;
        b=Tc8aNM77OyRo1sD0vl1pAu3ucB/tsDS+KJgvrs300wSwYyzPlqR6MATOZsP51upUUA
         0FRWboluYmEq8AbXGJLhhI/vpXskYKVil6WJ8L6nB7iEv6axFUjwo4DawUAKt/qPKH+/
         SDecJwJtYWxnjsXug5dG/VWevgjpMMlT+Oah9QK0iSm/N6Kd45hkzAhq5KJTl/ElRF0q
         wLzjKNvkpbHIo3zOBO+pAdKMuihpKnyL+/26s0uztS1DNBgH4k6b7I+Uopo2rZJEQ4R1
         kSB/Gsj0N5km/XEBIZB4GgZg7rT3wNDYUO9at4oaqi4p7s3oZ1nKpYJ7s0AJoLlPPplu
         WqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905032; x=1775509832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEP0zXDzOr+l04/srVbHJJ5LhsariHaPANvTrx9+dlM=;
        b=ia02/RZoZTqz9/26K/QhCZLr7nquTPmMwnJ2JmYxsfZaEafW6nxg3OBTQROquMQtJR
         wJQkIT6eueMhBOxWPm1IshMnhNZFHNWmVmkyTozcvN3uo8oQAuXhrHDUbnbc9ssm0+x3
         2X3OpKd++JbKUMg2CgbFWsLLhFdgs2R03ItOxWSTHudKOOBREh3SW4VRN9r1z1FKh4LZ
         L5lZlJOEilJ3xLpwc9gz48VtfFtom8WWzGkKCJTFlzUYsJaFTUnNW/g+WK4397gBKWrH
         YD+Oau3wkpZyTJ5S4ZpM8+P8XavRvkxT+S/oOoZWP+W0wD0S4A3+wez5GO5DMzuTwbAt
         XFXA==
X-Forwarded-Encrypted: i=1; AJvYcCW1bgdDt7aQCV8iuoutTLdsJk1DatgLRzcO5SA08vCCWEPJmHybWXkjlJ/77CFhnUF+qNutOA/Mn+TMqD1W5tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiC2p3JFRRpdi9wSmGSvDFu4fu4Sy5NTaijAsQ6+3bfTdfVDA
	P1YBnFqoK7eeOBwTyE9blSMIQCrignRil/Cfz5wXWjnWJSpKLxOG2v9G
X-Gm-Gg: ATEYQzzG9WSeTvepAin65hPhojdEVnfGKn/iQ8ed79qQ7BwI2j8wwka+LqDGXGJpeTc
	uZBOhYq5qlrji0x56umDjqy/2y3JnkZSC1SZSVRixeqCPUgH+PAiO9V50LCXlDfswJksh6m2Hh5
	hFA7eEj3oMWn4RKJs5+1w2Bk9kbvzN/pV442u21rROTgfLEh8gcLGDX83L/zKBFPU2gFsxPDtoV
	FjMooeR0pQseuMx0ihvBE0GVRpLUVq+9ubGg9NTBrda43ISlS5YL9lsi14JSgl99bBmn0X9tkn/
	ZFxOUa7iC1b0OkK1zN9bfIayfP33x3Q4hStYZnO3uDcWfyr76Ja9K3YA1VDDjpU+Oy8/G36tDnr
	X4u2cPgXcHVyGLAMbZh5D3CmMcN8Q59MSSZKBHePhmvp2y6jp6KWhH5DrZr9zFlr0vvITvW/0cb
	OJYcQc8bkwj9c9Cr7+xoXilJXiO5YoruZ0zOpdVsqjHC6knunE/t3eDus=
X-Received: by 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35c2ffb6610mr12220806a91.4.1774905032521;
        Mon, 30 Mar 2026 14:10:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d94d289f5sm11648765a91.5.2026.03.30.14.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:10:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] thunderbolt: tunnel: simplify allocation
Date: Mon, 30 Mar 2026 14:10:14 -0700
Message-ID: <20260330211014.12121-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member and kzalloc_flex to combine allocations.

Add __counted_by for extra runtime analysis. Move counting variable
assignment after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/thunderbolt/tunnel.c | 10 ++--------
 drivers/thunderbolt/tunnel.h |  3 ++-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 89676acf1290..f38f7753b6e4 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -180,19 +180,14 @@ static struct tb_tunnel *tb_tunnel_alloc(struct tb *tb, size_t npaths,
 {
 	struct tb_tunnel *tunnel;
 
-	tunnel = kzalloc_obj(*tunnel);
+	tunnel = kzalloc_flex(*tunnel, paths, npaths);
 	if (!tunnel)
 		return NULL;
 
-	tunnel->paths = kzalloc_objs(tunnel->paths[0], npaths);
-	if (!tunnel->paths) {
-		kfree(tunnel);
-		return NULL;
-	}
+	tunnel->npaths = npaths;
 
 	INIT_LIST_HEAD(&tunnel->list);
 	tunnel->tb = tb;
-	tunnel->npaths = npaths;
 	tunnel->type = type;
 	kref_init(&tunnel->kref);
 
@@ -219,7 +214,6 @@ static void tb_tunnel_destroy(struct kref *kref)
 			tb_path_free(tunnel->paths[i]);
 	}
 
-	kfree(tunnel->paths);
 	kfree(tunnel);
 }
 
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 2c44fc8a10bc..55eb83900a2f 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -75,7 +75,6 @@ struct tb_tunnel {
 	struct tb *tb;
 	struct tb_port *src_port;
 	struct tb_port *dst_port;
-	struct tb_path **paths;
 	size_t npaths;
 	int (*pre_activate)(struct tb_tunnel *tunnel);
 	int (*activate)(struct tb_tunnel *tunnel, bool activate);
@@ -107,6 +106,8 @@ struct tb_tunnel {
 	struct delayed_work dprx_work;
 	void (*callback)(struct tb_tunnel *tunnel, void *data);
 	void *callback_data;
+
+	struct tb_path *paths[] __counted_by(npaths);
 };
 
 struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, struct tb_port *down,
-- 
2.53.0

