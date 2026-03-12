Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85373282F0E
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292114; cv=none; b=bLsa2P6pkMoWBxZMZzhbhyDp5Ino3j8DG+qFTfmIKJvHNo0pm6Pcd9qc83faW2hDjLmxHKcFcnCqU2cUuACrbc3NRO5KFo8Ny7rNdUX4gyI9/wppGgH+jiyt8nTN5ngQOLPRuTCyW+Kdc3fCU9a0wp6umaa+RbXof2TZbIibNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292114; c=relaxed/simple;
	bh=VoUnsqUa2CjJvSkODbwmVCtNMW5aOlRcr358eQoOc1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbIKYuAOXQ8Ne8HYB9o0om9t3FzuDQlNlZ5r6gEUPQDn8LHUjjhKtZdOrK4BkaQPAwHD1/ynr1LoPJpmuQPY6mYLk7H5O2cGVTC5cJFGIJ3xChn63P4jQ9nEAIgHNq7wNiqF1C1hemEZzXNCoK7URxoNsiR1+iwFQfwBRohDA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxfy8ZyW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxfy8ZyW"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c739d32b72cso361069a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773292112; x=1773896912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLyWI/vZ6KJ+d4HD/0yXDVb44fVq/X3hpM9ycM+cxjc=;
        b=jxfy8ZyWtJLsmZnOeDmwPDWWkffARsHuhAFr7CmVzpvV8hdPyAtgfaw2tdEXW/riNL
         Kp3uo9HwT3yby293nmBCHXhubc1w9Wn+fuGHzu2QKy1wgqRhyo+GLNrk9Jt5tBsE6axw
         fa2EOfHqoKCl6XdKE/SVYm0/sTUzWV7p7ZXdhOeFtVkY7OEPCMda69Cu/VAj5RbX7i2C
         xmpY9GBBxc+jW10SoBlsAswP3vlN9xreUaYXozHolx62Ua2yTCoaNgXM78vw5mzJGNfE
         i5T+xNIQ3+31BQsw+X00KEQwoGXHySD7cVLHDNsmd/bsSqqZiSp3Wdwn6f6/vPcai7Uj
         eLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773292112; x=1773896912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLyWI/vZ6KJ+d4HD/0yXDVb44fVq/X3hpM9ycM+cxjc=;
        b=RxJT20t+0tpzuGp0nHfj4j3SKzNGzjUKIIC84k7wzGPz//0+3GAU34yIy5DUf8aqgX
         ++/lUmpKIdlS5W5kEBNdKSwVxu5FJt0JtWeleicM9xZt9ErU/TfSeYnO9aQWJBXMTDv5
         5LwRAJ4JR3gw9maHHiT7OKuGEagHp+zFZ87RNfp3hldNqrOI/9VvoG7cTExkmlBq1MmU
         pdBBnSNpY9p60Ite/3Kxo3jDALGoOunBxhIO2pjE1S+GbFiKD5F/KJ5VVyBGVVWG+eRE
         bMyX6zsjxUDlGqPNyuIIkmF6EQbJfa5FXVxhQ2f8zvuDKErQIVQP5Wf+1kWNtHzAeSNq
         KZAA==
X-Forwarded-Encrypted: i=1; AJvYcCVOmNcToDn07E5GOinMvWxVYDCcKrQItNBshMS+vKWD1LT1yM68NI8E2YrZ44hLSLCxJGXNkXI3iWK9dx6oMvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUS8kUbsUyvMZrK1489gorNGgvm39I9fYSKtUKw2bakPYNflcW
	kWDwhIEYCYuJ7w8a1Y3u+R86wmzJbaZZX3/122UmBuqvvD9IKxHifMA7
X-Gm-Gg: ATEYQzz2mGXSZ1iF0KktBwHoa/kd/ulMODHc9zWOIMdTwlxT0vbDQgCBe5N1ou5+Si6
	elmGEhWzo67Ka/Vbs3gNwmmI8UiJEQVTClaY4PLxmDhe+TeLnpynr82dTqFQuz78QPtyXubyIGh
	+GeZxGz+4nBDsXsNc+rjG3/W1dU69FpRem3Gw4NVrQVLyiboZgGyqsNWQJPx4iInkn3roKdT3fP
	ScaeZ2dwJAx/SqDJvCM+19kvdOlOeimpyfMiObWfPOETWrT415mFlaHPeNMHDSbIbSbxvvEaZIw
	lIrzAhMzaTuhpfCgay3wgYAgLjKzqgw3m51qtaX9uudvUQTGq6pDk3KtoTsqGtzn6XEwDKfz5zV
	hQ9Zc5tNL6K4XdXwgkjaC8oQf4C97M+NJXuIza7p7nx9NaMJodWdlVm8ChGmTs/D1YG1C9vneTB
	4IVZCNPegDclDe9UKo7wy8u5f9d1LgslPipsfglUa/ikUH+wm4lJ0rYw==
X-Received: by 2002:a17:903:2b0c:b0:2ae:3dcc:eb19 with SMTP id d9443c01a7336-2aeae7be9b2mr55414965ad.19.1773292111873;
        Wed, 11 Mar 2026 22:08:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae2228f5sm42044625ad.16.2026.03.11.22.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 22:08:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] EDAC/mc: Use kzalloc_flex()
Date: Wed, 11 Mar 2026 22:08:13 -0700
Message-ID: <20260312050813.9915-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change kzalloc + kcalloc to just kzalloc with a flexible array member.

Add __counted_by for extra runtime analysis when requested.

Move counting assignment immediately after allocation as required by
__counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/edac_mc.c |  9 ++-------
 include/linux/edac.h   | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 29e9828422bb..1ffab0269aec 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -203,7 +203,6 @@ static void mci_release(struct device *dev)
 		kfree(mci->csrows);
 	}
 	kfree(mci->pvt_info);
-	kfree(mci->layers);
 	kfree(mci);
 }
 
@@ -361,25 +360,21 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 			per_rank = true;
 	}
 
-	mci = kzalloc_obj(struct mem_ctl_info);
+	mci = kzalloc_flex(*mci, layers, n_layers);
 	if (!mci)
 		return NULL;
 
-	mci->layers = kzalloc_objs(struct edac_mc_layer, n_layers);
-	if (!mci->layers)
-		goto error;
-
 	mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
 	if (!mci->pvt_info)
 		goto error;
 
+	mci->n_layers = n_layers;
 	mci->dev.release = mci_release;
 	device_initialize(&mci->dev);
 
 	/* setup index and various internal pointers */
 	mci->mc_idx = mc_num;
 	mci->tot_dimms = tot_dimms;
-	mci->n_layers = n_layers;
 	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
 	mci->nr_csrows = tot_csrows;
 	mci->num_cschannel = tot_channels;
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

