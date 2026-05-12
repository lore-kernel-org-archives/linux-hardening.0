Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BA19DF4F
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555320; cv=none; b=XHmngV4Z7CuatknRxJL58EeHhcvotOUzMGKUj2kR8MzIdGttJWnLgJ5CSsCYhOFiqcS0vyYb9hdPmAuJ7BVv1tFGg5TUjXaaPy/7cMsjYKahJ5M70+siSCNkYDdcS197YsZAcDqlm2WbWYRW6MeDd1JV5YK2esqyzxgZeIaaTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555320; c=relaxed/simple;
	bh=gAmzXq/kh2/0J+VJOCCvhxVpHA25HKK5zImC22DBs78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKjo2QBcR4/efiZGy3X8cVtWsOVjP8YyruTww2bNh5joPAM/ALmnfkuKGurr3PS6jR8Yw1zPFRlYDE+LpjX2z5l4d/SYCUzk9ugO319Re4hXc2cj0wJNHtMWvhxvQeEQShJBM6JbXsF4p2Uuq+DBNKA/Qf0I5mlouKifgcHycbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5zXwZlv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5zXwZlv"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2155228b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778555319; x=1779160119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+b46lVvwRD7028KBGuNIlvO1Ms9LtMkRaT2tfHmFNo=;
        b=V5zXwZlvJACBkZbCOygpEysIRlWSBsGJHFpSzwyXP7gqC5NZCqbqFOydDeQ+rHWVtN
         8HZD9d8BbtUnQlH188p9Mg29Ef65MeK8BoMj+h4mmlaOGsfb9gv0NaQ3JdWyzD5xwuQj
         WvSsQMQ+/Y6+GSZMFFMCZcO+QlHrkMymGv1GAZlHmQEhkHhyOgG0dPkHVr4LaEfWJJgX
         rfoNWWl27RfS/LMldH6c3ER/EosCZOdqABZWJmS/gqu0shNXxI+Gc0yEpHvuy7z/cNCY
         8GHWxCxqV0hjd++FkmKUtzTeN1LUxYZIJ1dNQlgJJXM3lPPM9lkU7srnwWAwfB6EpXIk
         r8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778555319; x=1779160119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+b46lVvwRD7028KBGuNIlvO1Ms9LtMkRaT2tfHmFNo=;
        b=qB0WexQS7lmwPnnyXz+iW4sl1h4FvAFgljhqTh0IvyiCIU3sve0LkB5+K/pxFVr1IE
         5eDO9ey7skUEVNHKxPfICqFu99XdUViFQbNZCVPGe0Y3jQpx+6vtiJ5837gkHo8E6dDF
         wybDGqRUvNNVtV43lwZ/XDWgly83fBDdM0O4DY50+ybwaAlLwblsG5VgvoWO7IuESQgr
         XK6buNXdPenHKK4EjA8xGi7mGwKLG+dTbLAkHCtOLVI2wHsL9nSaAGagyqItsbGtCOJS
         Lr+OA43pFlJAJzJNB9x5CQMc53Rfz218yxyb8OCbbxPKoRaNMvXZU0AA9pL2fMYuKGZ6
         TEiA==
X-Forwarded-Encrypted: i=1; AFNElJ8tgNTruHKuTqNEukR9EErQkIMPDWqescPAlkLO56phRHiNkPWMYj0xG+ecvOy4bwxeUoBgR+Rofv3ErtbRu7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzefz6B66f+hULue3fna4WgxaoY9uAOWep1g0i4cfqvp+24Z9BP
	bZD4H8mPTZ5yLIVIEHDRx/2pTcRZky3R2YkiuKFZXT2Z6lzp1vCD6KvaB+ljGcqL
X-Gm-Gg: Acq92OFG13DORAKGoe/vlmKc+4OglPsSxQ1CjpNyySX65u0URu7aJc04wbVKn9lvjdL
	C6knlcSgv7IqtTI8tDuWN9iJjXFf7P8rr2Hm7ouPdlG4tuR7n9Shv3kH0wW/F0RhyagNWvaqYa+
	hGB1OgGc8ltLk03MGnXvqL7JX8i047eSVA+fD/HsI5rVukbJXuHlat9UDb2QiT8N0kYszdjlkYx
	FI180HAqJEFYEypxQIcQzurKaUKv8Q4Z9y1X34rki9cQb76vLHbNmIzrMEE7YOmuaVyM5cJ1Mql
	goCL0o1iQwVevDEQTuhogWYFWk4sYTM7Kb0pKADrid0RtXCNnYe/vcjlrDBFl+WtEYjexf9UqtU
	YWHC/8YxrVdVNo2u+nNb7AnTNjfKL7LCIC5ljWN2xdCpewyHVUq+MEGTMX0xiPYSLgpX5a47+WO
	/aLyUCaoxgTpA62bQYrpRC03sl11ev45GIouO3sfoaH24n4iktcUm+okUzf3+3RtsLVfEMMk/8o
	AyNG5AgJ5Kl5RrdHL4uaTFWWCEQGMsLLig=
X-Received: by 2002:a05:6a00:1d99:b0:82f:2070:2683 with SMTP id d2e1a72fcca58-83cf5a419admr15730836b3a.21.1778555318763;
        Mon, 11 May 2026 20:08:38 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdfb0sm21124259b3a.45.2026.05.11.20.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 20:08:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] EDAC/device: Use flexible array for instances
Date: Mon, 11 May 2026 20:08:21 -0700
Message-ID: <20260512030821.47802-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store EDAC device instances in the control info allocation instead
of allocating them separately.

This ties the instances lifetime directly to the control info object,
removes a separate allocation failure path, and lets __counted_by()
describe the array bounds.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/edac_device.c | 13 ++++---------
 drivers/edac/edac_device.h | 12 ++++++------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index cf0d3c2dfc04..30a1fb392fc4 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -59,23 +59,19 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 			   int device_index)
 {
 	struct edac_device_block *dev_blk, *blk_p, *blk;
-	struct edac_device_instance *dev_inst, *inst;
 	struct edac_device_ctl_info *dev_ctl;
+	struct edac_device_instance *inst;
 	unsigned instance, block;
 	void *pvt;
 	int err;
 
 	edac_dbg(4, "instances=%d blocks=%d\n", nr_instances, nr_blocks);
 
-	dev_ctl = kzalloc_obj(struct edac_device_ctl_info);
+	dev_ctl = kzalloc_flex(*dev_ctl, instances, nr_instances);
 	if (!dev_ctl)
 		return NULL;
 
-	dev_inst = kzalloc_objs(struct edac_device_instance, nr_instances);
-	if (!dev_inst)
-		goto free;
-
-	dev_ctl->instances = dev_inst;
+	dev_ctl->nr_instances = nr_instances;
 
 	dev_blk = kzalloc_objs(struct edac_device_block,
 			       nr_instances * nr_blocks);
@@ -93,7 +89,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 	}
 
 	dev_ctl->dev_idx	= device_index;
-	dev_ctl->nr_instances	= nr_instances;
 
 	/* Default logging of CEs and UEs */
 	dev_ctl->log_ce = 1;
@@ -104,7 +99,7 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 
 	/* Initialize every Instance */
 	for (instance = 0; instance < nr_instances; instance++) {
-		inst = &dev_inst[instance];
+		inst = &dev_ctl->instances[instance];
 		inst->ctl = dev_ctl;
 		inst->nr_blocks = nr_blocks;
 		blk_p = &dev_blk[instance * nr_blocks];
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 24c1921aa490..72414ec8ad6b 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -199,11 +199,7 @@ struct edac_device_ctl_info {
 	 */
 	char name[EDAC_DEVICE_NAME_LEN + 1];
 
-	/* Number of instances supported on this control structure
-	 * and the array of those instances
-	 */
-	u32 nr_instances;
-	struct edac_device_instance *instances;
+	/* Array of all blocks for all instances. */
 	struct edac_device_block *blocks;
 
 	/* Event counters for the this whole EDAC Device */
@@ -213,6 +209,11 @@ struct edac_device_ctl_info {
 	 * device this structure controls
 	 */
 	struct kobject kobj;
+
+	/* Number of instances supported on this control structure. */
+	u32 nr_instances;
+	/* Array of instances for this control structure. */
+	struct edac_device_instance instances[] __counted_by(nr_instances);
 };
 
 /* To get from the instance's wq to the beginning of the ctl structure */
@@ -342,7 +343,6 @@ static inline void __edac_device_free_ctl_info(struct edac_device_ctl_info *ci)
 	if (ci) {
 		kfree(ci->pvt_info);
 		kfree(ci->blocks);
-		kfree(ci->instances);
 		kfree(ci);
 	}
 }
-- 
2.54.0

