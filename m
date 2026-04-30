Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B839B942
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586468; cv=none; b=YQen+AduBocb5ZU7o9KDIoIjrvnScfy6ni/aYhSwvf9XhIE62Z5QIMZGsPmuom8+tdQhn0GDEgQA1jg9k7lEkle8T+h3Lt1dNupuN253T8+sdmr1MhjjNK03M9luXK2VzMcrD0gEHXbpG59YoH1BBVOg0ugm5/aikEVNd1O7wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586468; c=relaxed/simple;
	bh=hSO61MEHDuljEoCwQIOmP8GW7tSE2ESykmqtlCrWhlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9o1/71OM+hkKTHm7HifLwImDH0x5lLXAdDIFIPmY5i3NLqdL9Y6qea8P+ICsi5rxqhzN6WvwF1pKXMuHgTJb4mrrReJSH2LMMNzCQ3A7riRbxFztxVWQfuYYQV/wuBvWV1AHmmjLSsugGfeLKjtegeB6UB4zvEwhWslyGa4uVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zad9R65j; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zad9R65j"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83177129e28so658609b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777586467; x=1778191267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ9C3UXbI8sz5or31IBXbObkRFxJVWeprKwndPijx9E=;
        b=Zad9R65jXGPtl8owr1iPMYeeJXWRl8e3iVug3cwrGXnl/F5mHk6RtpGJxqfhmL8v+m
         1zfTRjsQ4WrOS6bYH68e7A9UittMNR2g+iFyBJe8XZwUQSH2QE1ixCZiYqiPJ9jFXZBp
         hK4DgqUdL9u2WLil7maB0lTcaEXdZIEBUpCNVdzRk1S9ituLkxmCnwoU09kPy6cEXyU0
         8IxT8ySYn/m8BTBpbNIo64ZVp3sFH9fjROic2C3oYMpUjQ/pLUWbcktDFnl+gHdT3JCy
         MxJYxEsYFsNVxRJBDepxYWWGZdRzQ8/6oXDLvqYqRb19V/uaqe1tro0wxu23+MrJx22w
         uMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586467; x=1778191267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQ9C3UXbI8sz5or31IBXbObkRFxJVWeprKwndPijx9E=;
        b=iW/Siwrl8TtYdfYPIWZcSOI5vAMh2hpZ+d0Fx/Gg8LxDhdAPvQT1eYTV8zt6quvQy9
         oPs2muIgOVfHXLtOqBdB7wV/JovpTvnxLclLO83q/ROaDXnfsFPV7DO5BdYnePI8nfC/
         shh5Jkmdvpmqj440z116GN2KN+jBeo8ANfe6DwNbi+/5WrRs778zXfA/XBq7GOrTI7Pa
         7+huhYoE7Ff2fr7t5nu4ohst+0pHG6sf+xvzhWoC9aqDijWzbv5lv9NpGcxeCVu/ieNT
         32siiJqewrYL18nijnlRr5O3tfusuzQJufZE1ZTgJekJHC8XC/6+B3+IRWUSmEwYM7V+
         fWLA==
X-Forwarded-Encrypted: i=1; AFNElJ83RA0hP14V694xfxCINKOwNYx4xx/xZ2hlCAqfwvNMb2OqwejS+1nrSnM/Vc+nhsP7PMIogJXrnPOlXs4uZpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySpaMe6Sou7Qp6NjarpesfKSXXRNRtWWI+M4trrWY2ZMS/8MAr
	B+DNtJm94cE9wO7iTKX7K8S2ika5V20jX7nwR+BsjrvQuR7VGQgYwnxj
X-Gm-Gg: AeBDiesWmH396SxWwg00dcbS0mywchQmxBXCWOyc8qirbsdGrGciTFAWD++fVPZmhFO
	NLOoB8wpwqxtKsOIflpEGrnUnM1iQNsAsROrWbYDPtp4QKcHUawmplBw0e1yY1arASuovSjvudV
	0JJCk5IMuP98GSfwk74FYlWTQgiGqs03+olf8P4yFONwN+uptdyh1IDNBCLaWt0RszVmipbdVcl
	+WiV72ENqFrXd74ZU/6zd92ksktL0NPqOqrqid1lqvYc4J+l2YgEOmR7TmwbOrNsBS2/cnosKb9
	myhwY5XKfYrRneCjOlrgu6mC3JPaLLR2S2oyBZoGXdcyy9HxaVqDnJoYAXGu/9KSVrBtMXAFoH4
	GTWfWtLIMGcn4KpWjv50R6TDJSn+F3SCU0nh3u+Vjpsk9JhK7Yq6eZ/AfMNil+0A8cPb6snZSlg
	VqrdTmCJNvIV9QjnwwLhGvj5n0O6CgDq9FwIj37vR/PACZQlDWi1po3yA40FaDW31KG36hLaS4O
	MJLy2wdeduBlmuIjjecJOhZBM2YoeQwL0hq7aozNWu5gw==
X-Received: by 2002:a05:6a00:301f:b0:82f:2d48:f906 with SMTP id d2e1a72fcca58-834fdb82c41mr5623569b3a.12.1777586466805;
        Thu, 30 Apr 2026 15:01:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad7873sm614130b3a.38.2026.04.30.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:01:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 1/2] EDAC/device: simplify info allocation
Date: Thu, 30 Apr 2026 15:00:45 -0700
Message-ID: <20260430220046.72371-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430220046.72371-1-rosenp@gmail.com>
References: <20260430220046.72371-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine info and instance allocations.
Simplifies allocation slightly.

Add __counted_by for extra runtime analysis. Move counting variable
assignment to after allocation as kzalloc_flex already does with GCC >=
15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/edac_device.c | 23 ++++++++---------------
 drivers/edac/edac_device.h |  4 +---
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index cf0d3c2dfc04..9c21997a50e0 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -58,31 +58,25 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 			   char *blk_name, unsigned nr_blocks, unsigned off_val,
 			   int device_index)
 {
-	struct edac_device_block *dev_blk, *blk_p, *blk;
+	struct edac_device_block *blk_p, *blk;
 	struct edac_device_instance *dev_inst, *inst;
 	struct edac_device_ctl_info *dev_ctl;
 	unsigned instance, block;
+	size_t alloc_size;
 	void *pvt;
 	int err;
 
 	edac_dbg(4, "instances=%d blocks=%d\n", nr_instances, nr_blocks);
 
-	dev_ctl = kzalloc_obj(struct edac_device_ctl_info);
+	alloc_size = struct_size(dev_ctl, instances, nr_instances);
+	alloc_size += sizeof(*dev_ctl->blocks) * nr_instances * nr_blocks;
+	dev_ctl = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dev_ctl)
 		return NULL;
 
-	dev_inst = kzalloc_objs(struct edac_device_instance, nr_instances);
-	if (!dev_inst)
-		goto free;
-
-	dev_ctl->instances = dev_inst;
-
-	dev_blk = kzalloc_objs(struct edac_device_block,
-			       nr_instances * nr_blocks);
-	if (!dev_blk)
-		goto free;
+	dev_ctl->nr_instances = nr_instances;
 
-	dev_ctl->blocks = dev_blk;
+	dev_ctl->blocks = (struct edac_device_block *)(dev_ctl->instances + nr_instances);
 
 	if (pvt_sz) {
 		pvt = kzalloc(pvt_sz, GFP_KERNEL);
@@ -93,7 +87,6 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 	}
 
 	dev_ctl->dev_idx	= device_index;
-	dev_ctl->nr_instances	= nr_instances;
 
 	/* Default logging of CEs and UEs */
 	dev_ctl->log_ce = 1;
@@ -107,7 +100,7 @@ edac_device_alloc_ctl_info(unsigned pvt_sz, char *dev_name, unsigned nr_instance
 		inst = &dev_inst[instance];
 		inst->ctl = dev_ctl;
 		inst->nr_blocks = nr_blocks;
-		blk_p = &dev_blk[instance * nr_blocks];
+		blk_p = &dev_ctl->blocks[instance * nr_blocks];
 		inst->blocks = blk_p;
 
 		/* name of this instance */
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 24c1921aa490..4562461a3e8f 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -203,7 +203,6 @@ struct edac_device_ctl_info {
 	 * and the array of those instances
 	 */
 	u32 nr_instances;
-	struct edac_device_instance *instances;
 	struct edac_device_block *blocks;
 
 	/* Event counters for the this whole EDAC Device */
@@ -213,6 +212,7 @@ struct edac_device_ctl_info {
 	 * device this structure controls
 	 */
 	struct kobject kobj;
+	struct edac_device_instance instances[] __counted_by(nr_instances);
 };
 
 /* To get from the instance's wq to the beginning of the ctl structure */
@@ -341,8 +341,6 @@ static inline void __edac_device_free_ctl_info(struct edac_device_ctl_info *ci)
 {
 	if (ci) {
 		kfree(ci->pvt_info);
-		kfree(ci->blocks);
-		kfree(ci->instances);
 		kfree(ci);
 	}
 }
-- 
2.54.0

