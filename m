Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A71C3F31
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286014; cv=none; b=tytOkhhfuryXwnMpL/5ljhgfFHgdPL2ZWrpLBJnJ7ppO2YU3YhPb2kdkTC6FRJdppW+JeNoCv0RhABwTht+Tw9TrH9/N9Q1o/GgzNfVvVNURAK5X/0UaEu23W1VhwriM/VQ5zcz7IHSSihu0IZJLQOY7aiU1QaAC+POl5tPhNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286014; c=relaxed/simple;
	bh=pg0YQExBKD1QBaMwIK+8w4kMFIM1KokG0edT6frwxlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3xNCgoQm61HCg7NKRMH22C/+SqOrMLM0az8BOxJoJmCV3/j1tXlx4ZZbF0m62TkauGkDjJZRiX8TEwySeLhZUP8QC/4TJVOuS0eoC+XTL+CI2uaCXGFFP0IL2Go2sSfmhARFKBtsJTTLDmxaXdLTnaQ9CAT2TpEl0u9Ze3zDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baA750o8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baA750o8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so4544595ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286012; x=1785890812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/PYQKf0JDqIIDQm8H4gTdIyq8keoILKfJLaIqCIM/c=;
        b=baA750o8TxoouBmAsc4HizWocRKLnAjxf2bdxQkuUWMcK6KF4GwTyTt8JdG/QQSTqE
         P3DUzQgeVHetVgp1BbeXhX0ZRYxf+1JrZ96wErKZabY35Gj3sqfVUK8wIFhU4W3X2ibG
         nS+eU+Al6Oq63tUnrjb9wSOOBvdRpulZ58kQQ0aDFZoWkd8UFxxHIoNIIJ6GApt+22dI
         8p15JmCn2En4qsSoNZ7qE5BvdOfAI5Gs2Eg1fAmCR7T3bwY7JhaoD/iiopgKUnvsBZeM
         ZQ7YHo4HuvEjWLbPybIQgLUI0O90B78M8BitpQ8TwmXKNcXQQVK77mQZrXWccPUTdljm
         G9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286012; x=1785890812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/PYQKf0JDqIIDQm8H4gTdIyq8keoILKfJLaIqCIM/c=;
        b=fNDaI5Oy8FKUbkcrA6sJa+tqpshuh4Y3YWojkRk4A/8pc9za0TQKURESk71dfKt9hR
         Ui+ErCS7A5WcB2yXzuR7hj9Vm6+rX7TRxJVbETqhlhduLhcRKJCGx4pzhEU+LDfYfISz
         LyGXYkJ8THGlWWninlAC+G46agy0FWCYkzN/bfF5MrSeyR891ODtngnvJRef74ATORG2
         u1xu98krRNRsyLPeXJ5oFLFsMbNW1bc2Uult/G29iv43/PStI6vXeAih+tBYAYiLTc/L
         m2edUKmiiYDWrOgBDWpMOP2cSsU+31p1fyLi5cgrYWVCMt+RqvoNKHnVMNpOeHZFc8g+
         8MnA==
X-Forwarded-Encrypted: i=1; AHgh+Rrb2akg2cn1O24ux+COyagZaZHa7Pyiv3mvGYHIHQNaIcGXv5JrY5obXMiGWigHwHq3ior8ss4DXORZH0mkH60=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrb40nyxlSJt0VVW7nYWO8TusZhwV3Khayimts7bvonLf+iYDN
	7EYYXf8wq3/R1Mg5uArUkiK9c6gSPlvMQaAoMx9jTELOxIPCt86qUH0v
X-Gm-Gg: AR+sD11wFrJ6jbGZpGrTAxiQg6NDmDfN5xRToLUN1ueoB+F3INDYBe0MTC5jDtyHs0y
	A1fWxDFOR3mYnzsBNOVAeOkH7KJkjNbKFK+8oBF+TFvkdy6hdOo6JxiI5UiPy62DytFeBO/bY9n
	kEPawYWvOLH6ivQbLWWz2WCmVyMJ9eKaPsFaPzGKCZRAr9tsvt3AlCSJ5gFgpLlaSa9YKvSoiVs
	wxFj1MEKJGm+KsG+XFHFV3/VnHGWN2FoycXuCy4+SfxNopRxQbqr01bsHomNS2BTs4Uz0wzEDYl
	3X54auZpm7FOvsVWkzLGn9Fs7ieVqDhiOfSVWZ2eZ+iBEqjZNBFV8qQ704KuYhZWMSS5MPFN17+
	/MVZUFbpJCdrB7i/3OcSTUpxugImPX33ELp8V6DP2oNhePi1tUFij1rDqbWI741BAMXwOG5KB4O
	Qh7qgMXN8AA0C4vqXeal2gettD85lGrxkPSu+Fme6nZ2YmiLhxnj46k1Cy+XYT1BosQnqJ+FBvQ
	ofC1jyiymEhdxqZL+ZLFBajUmR+RBBVSUoFZbIGAzokdwWG1giozSta47SWz+aoCRf54lY3hUmR
	SLphgvj95AvibujsP02W1V/iX5XT7NJ+18wA1Hg=
X-Received: by 2002:a17:903:26c4:b0:2ca:d976:95ce with SMTP id d9443c01a7336-2d015d661dcmr49142535ad.39.1785286011753;
        Tue, 28 Jul 2026 17:46:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d024b114a5sm1588145ad.21.2026.07.28.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:46:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] EDAC/mc: embed channels with csrow_info
Date: Tue, 28 Jul 2026 17:46:48 -0700
Message-ID: <20260729004648.601130-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine allocations to avoid separate
freeing. Also emded the actual array to avoid separate allocations.

Add __counted_by for extra runtime analysis with UBSAN.

Move tot_channels assignment to after allocations. kzalloc_flex() does
this already for GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/edac/edac_mc.c | 33 ++++++++++-----------------------
 include/linux/edac.h   |  2 +-
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index fd70caa85574..0fff56ce21b4 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -179,7 +179,7 @@ static void mci_release(struct device *dev)
 {
 	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
 	struct csrow_info *csr;
-	int i, chn, row;
+	int i, row;
 
 	if (mci->dimms) {
 		for (i = 0; i < mci->tot_dimms; i++)
@@ -193,11 +193,6 @@ static void mci_release(struct device *dev)
 			if (!csr)
 				continue;
 
-			if (csr->channels) {
-				for (chn = 0; chn < mci->num_cschannel; chn++)
-					kfree(csr->channels[chn]);
-				kfree(csr->channels);
-			}
 			kfree(csr);
 		}
 		kfree(mci->csrows);
@@ -222,26 +217,18 @@ static int edac_mc_alloc_csrows(struct mem_ctl_info *mci)
 	for (row = 0; row < tot_csrows; row++) {
 		struct csrow_info *csr;
 
-		csr = kzalloc_obj(**mci->csrows);
+		csr = kzalloc_flex(*csr, channels, tot_channels);
 		if (!csr)
 			return -ENOMEM;
 
+		csr->nr_channels = tot_channels;
 		mci->csrows[row] = csr;
 		csr->csrow_idx = row;
 		csr->mci = mci;
-		csr->nr_channels = tot_channels;
-		csr->channels = kzalloc_objs(*csr->channels, tot_channels);
-		if (!csr->channels)
-			return -ENOMEM;
 
 		for (chn = 0; chn < tot_channels; chn++) {
-			struct rank_info *chan;
-
-			chan = kzalloc_obj(**csr->channels);
-			if (!chan)
-				return -ENOMEM;
+			struct rank_info *chan = &csr->channels[chn];
 
-			csr->channels[chn] = chan;
 			chan->chan_idx = chn;
 			chan->csrow = csr;
 		}
@@ -272,7 +259,7 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		struct rank_info *chan;
 		int n, len;
 
-		chan = mci->csrows[row]->channels[chn];
+		chan = &mci->csrows[row]->channels[chn];
 
 		dimm = kzalloc_obj(**mci->dimms);
 		if (!dimm)
@@ -613,13 +600,13 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 			int j;
 
 			for (j = 0; j < csrow->nr_channels; j++)
-				nr_pages += csrow->channels[j]->dimm->nr_pages;
+				nr_pages += csrow->channels[j].dimm->nr_pages;
 			if (!nr_pages)
 				continue;
 			edac_mc_dump_csrow(csrow);
 			for (j = 0; j < csrow->nr_channels; j++)
-				if (csrow->channels[j]->dimm->nr_pages)
-					edac_mc_dump_channel(csrow->channels[j]);
+				if (csrow->channels[j].dimm->nr_pages)
+					edac_mc_dump_channel(&csrow->channels[j]);
 		}
 
 		mci_for_each_dimm(mci, dimm)
@@ -758,7 +745,7 @@ int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci, unsigned long page)
 		struct csrow_info *csrow = csrows[i];
 		n = 0;
 		for (j = 0; j < csrow->nr_channels; j++) {
-			struct dimm_info *dimm = csrow->channels[j]->dimm;
+			struct dimm_info *dimm = csrow->channels[j].dimm;
 			n += dimm->nr_pages;
 		}
 		if (n == 0)
@@ -904,7 +891,7 @@ static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
 	if (type == HW_EVENT_ERR_CORRECTED) {
 		mci->csrows[row]->ce_count += count;
 		if (chan >= 0)
-			mci->csrows[row]->channels[chan]->ce_count += count;
+			mci->csrows[row]->channels[chan].ce_count += count;
 	} else {
 		mci->csrows[row]->ue_count += count;
 	}
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 3902c3789510..3d8ee12c11be 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -448,7 +448,7 @@ struct csrow_info {
 
 	/* channel information for this csrow */
 	u32 nr_channels;
-	struct rank_info **channels;
+	struct rank_info channels[] __counted_by(nr_channels);
 };
 
 /*
-- 
2.55.0

