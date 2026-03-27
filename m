Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455A33BBB9
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579728; cv=none; b=qMXgkqE9HI9//yq26ggbtROStLE91Eg4A2qlyzW7xuFpzaJnjNa4ct865CMrP7PNXALIeDQYmxSSkg8ea9mjwwvmu27Y54CByjsUcbMvh/awSYMrKDCG+T+woUv+T+R5/qh77D86LqtdBymxiy/5rK54UO/ieofhHZiNnyoEhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579728; c=relaxed/simple;
	bh=asWVsSVzuzmjm0bm4hjsbXuKHUxUkVLUJFLHVqPtcqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXDcE0viSfEfV5HQyDYCk6xDvLQWSwhzmfDGi2lH5nW0F8eudzCDweqoPcvVb3Blsvgd1TGB9Y2yM8CERQ/7FDSuAZb2JoGck/CTWrh0Ju4LLemkmJRtqI14gSIDWsFv1FIWz3gGmZo4EdQI76OUPr5ixQ4/Jk0y6wghLfjr6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfTVFbyG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfTVFbyG"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1076027a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579726; x=1775184526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDgkowu/puJ35XcKRoiAG5i+KHdrwMmbRhRH/tcCZpU=;
        b=FfTVFbyGklaYzY503EWsatILZoVfZp9S63X4v1OVr02t1wk+qHZ/CSeooKUAGzM9GO
         pvX5nW1YrhdRPr87kk4Ufcz/ksfM9rmWIWwfibVDuOPSqfXKTdCSS0Q92oAn3GoJv6rY
         KfdymvCLriJD8EL4qgZecp4OWCMiSl7Rx+XZdcDd4N4ew6FzetuvX4oGXtprdbrnTXOz
         EJpmgF2bstmvRECUD4gCsdNpvMa9gMK4/VyUpw4DCK2VK1lvSgsHy6X2pD8P6vXI6vbl
         OVJUtsqJRaSqZlTKRM+aqd4pW9dkB1i6PtKVB7gbDk2MwQ3+mbHi+bjfU1+/OErngGIq
         SM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579726; x=1775184526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDgkowu/puJ35XcKRoiAG5i+KHdrwMmbRhRH/tcCZpU=;
        b=LEBu1A0gwTgIg5mnU6H+211txW8M/+2Z6Nso68cLkbkximeatp1MZQRKJ70P870mCI
         UMHBPdk7WJyWEQydm0gMHgI/g57fe0M7VRUizIzOUSPJsubG4majpoPXpJNDRCJbrYn4
         XyZJJYDmOMge9TS6iMHTXo6qJh03yJ8le5O4JjQc6/MavH69IOreOF1iQKejVZpXX2FZ
         9cl3OGf952ozQOftF0lMQ4c4iiqXtRf2XE/w/vg+6mnTvKeIR2j/0bYbeMkZQYgaLZlZ
         7TxbvHONXPQxMGrQL99GoTGFYy2Aj2ZqNcEG0kE3g6relSI+3n2RLrVo6LhUgWZleacG
         uZEg==
X-Forwarded-Encrypted: i=1; AJvYcCXLD+uCMmNJIYqxXw+EGIcyRYwdJK11Q5Bx5lqRGQB/38fqLJJsI/0pmFZWw+hYEw8h95WBgDp+gho5dynAVb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBv+R0Sl8PTXZDHVTYBoECSZVMVSrNdJ8hIW2QKZXXPyGXiRlE
	Y3F0ZbeXjw68YNNCHlxaaFBpGvyZ6A+YIJl3F8C2ZvIxYKz3VAOz9FTd
X-Gm-Gg: ATEYQzzG4JjninTgTUwe/u3+6TU1urqaEk+KXXAFl90YatTJjR0q2aLRekKfM3d+fUb
	ahoRrFU+b6DJWJg5/u6LPx1BOu6gXbvrON/H8YYi07PBFNkzQUVaMolP1DZJmIpbS282tYQrNyQ
	5i2PZ3NqRhaAjE2XdQYI+hzXuIwavJ+06HFxX0V0ZOViqZ1IsrjJ7Es1sdbnEHRyuehqBWkGOTR
	8eS0bF/Gq1Zp7UffirUn0MJ+38sLc0wDz6HXD1gCAR2Tx1OAvwHFnRQegY35PLNNVJ0uqG0LF1d
	AIVdlVgyyVw64U3tP0Nld/Vn4Ffs31G0v/INMK1MCdMbRRUENCcQAZSQYeIyZTGb2uqiiwI+NBA
	FpqHTfIjV29FE+J+Hzo2bKRtXjGj2gOjE7dNA3YcW5WCdOi/gWXCJY3YDInXPgTCsKDXAAlncs+
	cqVKDRh/IzQmbsEEf1Ri0l8y5A8a0V8p7Wd0BjMItpj6PVZSau2cNgMzg=
X-Received: by 2002:a17:90b:3fcb:b0:359:d54:846f with SMTP id 98e67ed59e1d1-35c2ffad934mr983155a91.7.1774579726440;
        Thu, 26 Mar 2026 19:48:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22cc0943sm2994487a91.13.2026.03.26.19.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:48:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] EDAC/mc: Use kzalloc_flex()
Date: Thu, 26 Mar 2026 19:48:28 -0700
Message-ID: <20260327024828.7377-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert struct mem_ctl_info to use flex array and use the new flex
array helpers to simplify initialization.

Add __counted_by for extra runtime analysis when requested.

Move counting assignment immediately after allocation as required by
__counted_by.

Move memcpy to make it clear that this should have been kmemdup_array.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 v3: move memcpy after n_layers assignment
 v2: reword message slightly.
 drivers/edac/edac_mc.c | 10 +++-------
 include/linux/edac.h   | 23 ++++++++++++-----------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 29e9828422bb..07d3f73bcd23 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -203,7 +203,6 @@ static void mci_release(struct device *dev)
 		kfree(mci->csrows);
 	}
 	kfree(mci->pvt_info);
-	kfree(mci->layers);
 	kfree(mci);
 }

@@ -361,13 +360,12 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 			per_rank = true;
 	}

-	mci = kzalloc_obj(struct mem_ctl_info);
+	mci = kzalloc_flex(*mci, layers, n_layers);
 	if (!mci)
 		return NULL;

-	mci->layers = kzalloc_objs(struct edac_mc_layer, n_layers);
-	if (!mci->layers)
-		goto error;
+	mci->n_layers = n_layers;
+	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);

 	mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
 	if (!mci->pvt_info)
@@ -379,8 +377,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	/* setup index and various internal pointers */
 	mci->mc_idx = mc_num;
 	mci->tot_dimms = tot_dimms;
-	mci->n_layers = n_layers;
-	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
 	mci->nr_csrows = tot_csrows;
 	mci->num_cschannel = tot_channels;
 	mci->csbased = per_rank;
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa32f2aca22f..deba46b3ee25 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -541,17 +541,6 @@ struct mem_ctl_info {
 	struct csrow_info **csrows;
 	unsigned int nr_csrows, num_cschannel;

-	/*
-	 * Memory Controller hierarchy
-	 *
-	 * There are basically two types of memory controller: the ones that
-	 * sees memory sticks ("dimms"), and the ones that sees memory ranks.
-	 * All old memory controllers enumerate memories per rank, but most
-	 * of the recent drivers enumerate memories per DIMM, instead.
-	 * When the memory controller is per rank, csbased is true.
-	 */
-	unsigned int n_layers;
-	struct edac_mc_layer *layers;
 	bool csbased;

 	/*
@@ -609,6 +598,18 @@ struct mem_ctl_info {
 	u8 fake_inject_layer[EDAC_MAX_LAYERS];
 	bool fake_inject_ue;
 	u16 fake_inject_count;
+
+	/*
+	 * Memory Controller hierarchy
+	 *
+	 * There are basically two types of memory controller: the ones that
+	 * sees memory sticks ("dimms"), and the ones that sees memory ranks.
+	 * All old memory controllers enumerate memories per rank, but most
+	 * of the recent drivers enumerate memories per DIMM, instead.
+	 * When the memory controller is per rank, csbased is true.
+	 */
+	unsigned int n_layers;
+	struct edac_mc_layer layers[] __counted_by(n_layers);
 };

 #define mci_for_each_dimm(mci, dimm)				\
--
2.53.0

