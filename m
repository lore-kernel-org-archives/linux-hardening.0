Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F24176ADE
	for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951346; cv=none; b=iwkMUblHIZfgdSpp46/OmEdgg8kzJw66KW/tumCRC+e4L6fxv4qq/jpO5HOe7E29wc0H1GnR8ZUQmNiknZfFd6OrRI/1eDfF+Qz+1r15WDytYXEu4fxMnLsB+fE7DHpUOOV0D0B1T27ieGP2+BnvFoFbYYXK95revUDVaaIHZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951346; c=relaxed/simple;
	bh=0E1xN3HmdJGSZ6UQ0dNBxRKtgCC4EAAOtjwcoINiom4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTSji4Jaz941Km5NUBJplRWpHgQvgihdLzU8hfntruuqAxPhQ5j95FxDwuh5KAPbpZVfSTvtynmwS4tiWLn3pwB0I9aTvYjl9ws+KAEaXCJrgAHN8jjWHKnJQTRTdc6fbhSvtQshCUkA6myeF/H4qBzCLPE82FQggB7bm2pclmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY0brNeA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY0brNeA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742d7c8acfso495500a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951343; x=1774556143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jDnJgSgoxI+fR2Q+0oguo+U/G7a0RmU8BoRg3HRZvw=;
        b=mY0brNeAkVYRkkD8Q0qFwBVWEnyGzzTO9s5EZ3goxg1iosgJAtwkq4Qwro0p/FgFUk
         AX3p9OOSkVSxbcyT+pTO5qvi3ii9FVCplHm9pedXLPXDsdGxZwHBAlKlkTcmvAyBL/0H
         5dmNn23YWfH7zU1LP4fB2uU9X3HxqjKhxbfcBQQvZgVTHX9h7+Ke8K/w8LTGy1ja/10w
         JorGXMPJNYF2I0RWuRXjLz2GUaThQAy15T7LFmnRcHn41ZC1EVYh5xks7caxb9E7n8rf
         QC3uvgAWCiGvaVHkjk1wKwn9iYQqnUHcym8DlIXMYP9QrNesoJll9+T4GEr3VHa0guN8
         k+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951343; x=1774556143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jDnJgSgoxI+fR2Q+0oguo+U/G7a0RmU8BoRg3HRZvw=;
        b=CKoEYc9nUsGV6oRrKs4lENjHAhrZS4t6b+GgIlrvanz3gNwoGOAS11LhawYQD5hcJM
         /mMYXjfsKkBD/kBHXnu3Xrv1uia2vSYksbMVx0RGDzsPwAyCTIUXkXMEUMqg+K/7aQQI
         R5Xuzj+V+q/KD/OmoTJmKM2uFcMCyWdge6pH7VEn1CVeTIHBmRh1praArxNxqdSsBitD
         K92H4P8t1c5FltlWdiiYUOhFJBY5gXoRNOLr2XANpvgl1p0HE+2cMgu4Ib3FpjvnuB7g
         s6gKm8F4/78q+SLwL4Tvm/ldItJMu+r0XdYbfMv/kw32aNYG7ybvM0aNp2QgCfb1Z5ni
         1vPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd8+0HgZSa8VTm2VyGu2OcBy5ws5sSa+JONxcn27bophxwZTPZRK75vWvBr5O3mzDQMBTWib0RJXAmkUsvwcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxT4WDtfFQWVl113f36zSlfgEbmPMG6XW2g5xcsavHfzUSu+af
	f87Sn6+QGCP14vF33QBG/pdSuxF6db/l96LZ3vneBR7/8NvizG2XFvGu
X-Gm-Gg: ATEYQzxAObcDjQN6fG7gXKQlmQkkVheu81FNwXhkjeFj7p8imslp3WXqGSlsjRdGKKS
	X12YNuqfmlBocuQIiX0GOvv4X4wDSubASjnT4vyvCGMfSDH9+8CsDGI7Ef+yXyn7/dTzQ3roFnF
	nF2Qsbue5cOLB7+AXkrZO2fQlsxjxR/qx1AEVa2htI/Xjh2II1hKB+MdM8zmUdLFUbahA68+a5m
	21N6GwxWa7vYPHG2M0nWxKOHFIb2ZPMK/qDilohyhTUHV8EU1LYhtfKS+9gwuCiZylAQBBoDPHC
	f857Bf6GzNKbU52eW3a1gyGQoIyEeYtZkYVgtzeg4vqTPhWIKxGJIJZ6VH9o7o4lSaUzkv7jwdf
	ZUeUHfa0q/+LoplTZZbk8TEEUeo96PTCfn/SYwC6w35LrOdM9DQVmomRTPlcdoypABe64EIW3W0
	6s4RAqqiqzeObRLUCdy2f3aHgP9aZX8JPc3BQtT9XsD/33ABYNrjoAdwY=
X-Received: by 2002:a17:903:8c8:b0:2ae:46b9:c653 with SMTP id d9443c01a7336-2b08278b310mr4139655ad.33.1773951343394;
        Thu, 19 Mar 2026 13:15:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08368ea1bsm469005ad.68.2026.03.19.13.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:15:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] EDAC/mc: Use kzalloc_flex()
Date: Thu, 19 Mar 2026 13:15:25 -0700
Message-ID: <20260319201525.174493-1-rosenp@gmail.com>
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

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 v2: reword message slightly.
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

