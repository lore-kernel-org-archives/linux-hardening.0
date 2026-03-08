Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD0288A2
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004362; cv=none; b=PF1wvbILck4+dV+Uzom4mh7HJtrvsVDbcCK3UeKS9LkHiSR3dGsZocyjfbhXh1JzVoBRmu1UvF1002cVgS5uE7TL1aq337pGP8lykISfX8go3v3CIArmmI+WuGvh3E72luJBmH+bWASY+oPqcdgaZYaZdu4DxWMseBST77ZAd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004362; c=relaxed/simple;
	bh=O3YdQzw47RaaB3oNmJm+L0X+L/dFe9AGPKqOiW7K/7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBpv6waBFfkxoKu4papeFXpiydNcuAl9Yncq6t6NVC5rXmVRv+4I/LRK2YH0c4WzBoDzvWqRSe1wEKCLpckVeUIZ+v5xAh7sM3Oka7eyFxsjG4Jqqjc1wceAWuOxXCNXsOTN300g/IXT/pRw9NR7M0HiIuZwcWWv5+uhXkOtxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIxHwykD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIxHwykD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a9296b3926so84001795ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773004360; x=1773609160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVUEHpGLZsetFZXD2hp6GWpOMuo456n8g2SApWKR0cQ=;
        b=NIxHwykDAft74Tuo+Ex55Ugf80AFDxhYdE0acyRI/hf0C8JJHJaP65CBJS63j9y9+J
         ePAmKSZ7UJNIL/slsui2lWQJiA49NiBReAyip1cO5K82UUDodKYP3NJNkwH6Y87wCRVA
         nOzvr4THE0S6yuSKjVZCBNVbs+SYAxREd5YoyS0RmytDTc+WHfT8J9NTvORoA+R+YCLO
         t19AzxyR4EbB2ny/n2Gf+2OpXpFOaRzd1rCB56KorrOiK6zc/sutean95fy7n+Htipns
         cZ7AN7y+lzPPFPTUyBCGIiCOgnfV9NsBRYnTqpq56UYHWwHtqA4gQy7Y8QWoQ4dA9FPE
         YmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773004360; x=1773609160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVUEHpGLZsetFZXD2hp6GWpOMuo456n8g2SApWKR0cQ=;
        b=u/r1fWrVQGxgjF89ntGK8CllFBZzMmPN50srXmJPmBUM+1hhieTXpW63w91PCfcK0Y
         q0o1C8BT9wcPkFmIS6uJRBiyQKv53VA/ICG0SHt4v2neOCz8Q5y+EL9WCIsjHu7p2sVu
         KpT0oUABafoWq1jjCe3JxTmfqouuz+BMEqP/K4jdSMAMVoeO5apS3e6tra2qk3GT/wzE
         R5f9+rNf2IXgTWF3JXgptjkoCbP6JR4rNOPZ8WoY0ofe+o2A2vPcnBSwe9Q1uBqCyjKR
         FD+oZwsyxl1PiiArLUCgfQFL0hvvhiVtRJoGcBNVG66ZMJsvjrkRqdpl7ZXhlj//NEyQ
         1lVw==
X-Forwarded-Encrypted: i=1; AJvYcCUX8gnPHlypqINjMdzwZPPWzOQNq0forEt46UQ1GdZrc/xkNyZ6KQg2YSHq/001/oBhprBpZRATsKHhTMweKZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsCfq8Fg3/1pLzNoA8+XckGSXbsMZ0UgAIENV5aq8cCaju9r7
	wbopG++R/aVA0SdKtUJpuWRvfA1Yn0N8ELmeCQENCIPqsucoBDT1q1w9
X-Gm-Gg: ATEYQzz+9Y4uVZq17HiPN31AsKsF80a8jnrCFR/cF4Y7adBYRNcHYqI7cF4yxKqvcyg
	j8P6s03OW4YyQDX2kPuIuI1iGyfYRWS7TanNpPQUTKK8wBHw3R6Tlu44csE/WHMALeW99xhHV+N
	zQISIVkgaVq9XjijiRwFkhJwdHGmNj224+cSDh7fuFbhyciVXK0Rc7zkC6dZ09iKMt7eZfGYJAb
	fLcI+fTM3haHA8AUvV+nyUmsYJicoGTeT1UUbcINx040S3oWEm2l/isUYlBvR2uj3wlX8AdndYO
	OKcXMggURBSEMbSsgNBv3EZ3rDVm4qA1glrpKgWtnEZichaertlHD3bKXypbrjXnkooZ3nhUzbX
	EOFGjKPkNXLuag/IUg1Xm0ysRIRTkjHz9N3bI/LZPF9/VojDmjJMKW4owW4l38E/dnsVWpuAAhO
	oJQA95zz3FNX1zoFZ+t7OzR15uzt9+UhcxgEZcI9ERQhyo+Pz2IdRFlQ==
X-Received: by 2002:a17:902:ce83:b0:2ae:45bd:9b39 with SMTP id d9443c01a7336-2ae82416b18mr89231215ad.12.1773004359649;
        Sun, 08 Mar 2026 14:12:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad894sm119471255ad.80.2026.03.08.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 14:12:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] drm: dp_tunnel: use kzalloc_flex
Date: Sun,  8 Mar 2026 14:12:20 -0700
Message-ID: <20260308211220.33759-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation by using a flexible array member to remove a
second kzalloc.

Added __counted_by for extra runtime analysis.

Simplify assignment loop. It always returns true. That is,
max_group_count is always equal to group_count.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c | 26 ++++++-------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index f442430d8de7..aad1605b956e 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -188,13 +188,13 @@ struct drm_dp_tunnel_group {
 struct drm_dp_tunnel_mgr {
 	struct drm_device *dev;
 
-	int group_count;
-	struct drm_dp_tunnel_group *groups;
 	wait_queue_head_t bw_req_queue;
 
 #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
 	struct ref_tracker_dir ref_tracker;
 #endif
+	int group_count;
+	struct drm_dp_tunnel_group groups[] __counted_by(group_count);
 };
 
 /*
@@ -1893,7 +1893,6 @@ static void destroy_mgr(struct drm_dp_tunnel_mgr *mgr)
 	ref_tracker_dir_exit(&mgr->ref_tracker);
 #endif
 
-	kfree(mgr->groups);
 	kfree(mgr);
 }
 
@@ -1913,33 +1912,20 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
 	struct drm_dp_tunnel_mgr *mgr;
 	int i;
 
-	mgr = kzalloc_obj(*mgr);
+	mgr = kzalloc_flex(*mgr, groups, max_group_count);
 	if (!mgr)
 		return ERR_PTR(-ENOMEM);
 
+	mgr->group_count = max_group_count;
 	mgr->dev = dev;
 	init_waitqueue_head(&mgr->bw_req_queue);
 
-	mgr->groups = kzalloc_objs(*mgr->groups, max_group_count);
-	if (!mgr->groups) {
-		kfree(mgr);
-
-		return ERR_PTR(-ENOMEM);
-	}
-
 #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
 	ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun");
 #endif
 
-	for (i = 0; i < max_group_count; i++) {
-		if (!init_group(mgr, &mgr->groups[i])) {
-			destroy_mgr(mgr);
-
-			return ERR_PTR(-ENOMEM);
-		}
-
-		mgr->group_count++;
-	}
+	for (i = 0; i < max_group_count; i++)
+		init_group(mgr, &mgr->groups[i]);
 
 	return mgr;
 }
-- 
2.53.0

