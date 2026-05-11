Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396C34A3AB
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540501; cv=none; b=Vh1o994W5rOnnIHj0q98xYkLTwNNPVg2Sv0EfaNr8zNlS67okR00bR+bxwTOz5IY4zeJuCe6GOTpxM2fZ1tMtOy7hK9+1buKRmymjcBwTQ+J0LmpgOYZd+RIrxTZkW0YdK+IvlzvEgJ9WzE4kg7c5d+b3D5EOD7rfELdc7rJVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540501; c=relaxed/simple;
	bh=4FFTVIrcGb5bEnEr3mxiZfFcOT2unW9/+Rjfsb9tZis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElLABk3LoHYiIjZqibvNXKYEDJ102bhS8rAC23qN8DzASON8BkutLxAeHpges+ArgkKl4TiDxppY220i8owAkBJvl5lP9vTCcpxLa7/qNXCZY0ByjWWAyGB+jXYte59AkBLHfABKzIiyVorFX11BCU1r8fcyQmLwwJGB0ySLUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEzXtW+i; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEzXtW+i"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660b84347dso2998624a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540499; x=1779145299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yrHUiu1eclhnN5DTCiPARDxM7SXoj9Pgm5FYtgWEls=;
        b=nEzXtW+i7/1PKQWSNBTkjgNZcMeBQROkpclQKITNPT1hf4iJbiQQqGOMdi5tY1c7jK
         sae8WeqNO/i3kw3v434tw44gM4Vh3Kav46ojBQNWaTuVQoBvQ1c9G7MEEODWKdqdSMpo
         sTmDXFzOkDF2K+qIZLcmJ3IA1McPskD7aZOfswN/Ic73VI+KYeWeHFMvjD229dthlckZ
         7Pw7CmYUiUgEdrPbmWR9RWUFPoxEHhuvAxS/CB946w8djUzW0+SV8KcyOCQ2gt794dVP
         lQE4deofuKkQmV65yAZRe4Gfjr2ECh9SoQ09Wp7h+3FO5wUA4ylhZHsPP47V9uScZjBP
         OWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540499; x=1779145299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yrHUiu1eclhnN5DTCiPARDxM7SXoj9Pgm5FYtgWEls=;
        b=ViNMR77MzkaDNDRGi9oSbRLAcM2bI0Fe3mE95rM0WAlBJwxv0MWYa1cSY2ymT0COCa
         7q6Xer/Hm/cFeBT9zdibd634h0a4LPoEVB1IAmMB3Il6FG0V/j9UOtfAED4OLpEX/tan
         SqYJ9Ok3gcNZjQxF5EkPQ+Tv0SfcVUCU5L4/GrwF0KwBHyu5hb1RtWRh9jA2My73crC0
         MEPpsGT9/0efdAO7zkCUAEZ7B2EVCfXSCQP/9e7gcB37rOlaQqCGWht7vYVuiAvypG8k
         +AM3LZB6c/oBKYjjT+ACkvnWX0flCnjp0F7Hj0/3yB1G0M2SR7QMLtVeH7gMNRodaCUr
         xQgw==
X-Forwarded-Encrypted: i=1; AFNElJ/85Mh0C1pf1G7LRYcSDfUDifq2NSwUwJHDSbyjhB6suEHPRzu+/SbtMv0wUy+u6US91aIv2fML+kiaBs68Kwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+/04kyH79yybh4A6GscKGeIIudMedFSaUT8x883QZM2hlIJ4
	FkwWVkOxUD6Q7gmg6j/XMmqjORQlkl6afnRpRBxXHRVTGk5Qns9OoAKC
X-Gm-Gg: Acq92OGNFndQUX45qDwwLnozjtlNzixX0H2uG8A5NPa4Jo0jPnkIZnxzcdnT/TJUXgF
	nIq9ESxj0KMb/qeKNUvepEEprmPuvem8AfL5Kr4B8H9Nq5XXbG9tJREGBFQhObr99hSuAOl01JT
	o1OpZeL1BCjvj/QijtocaP/D4IuJbAnK0TDHQsUg4dTVOcF+PhAfwoTfyJhAplEiM1repiT/fTy
	LP0K3gH8C8eSe3Sp8dYwuBNHJZzNu6HjGik2fhj0C21UtaN4w/eivBEhac+KNsZgSbJIc/q+VsX
	DMsr6Pdjog+ViD0fLjrGtyXKVxla5Q1XJkY0pHO0Xhso6pERY4oSHhweSXdSJwMOPL3rFC+UlaH
	bPTump2qPddYf3GlaXlrEdRNPEtsf3AetzDy4S/QA8vDgzv83Pq2kHaNdjKoW1C+OnSWufSV0e3
	HswOva7LpG78H3IQM7DbiLrB+LhdKbNUZbNtnghJqb05dlDb/3CKWOW7bGLOtk9/9dFcOPWdTrU
	HQ+Q6ckz3L+0Tw6TyWU09kJfLrZ/xG5Nlg=
X-Received: by 2002:a17:90b:3502:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-368b27411c6mr531978a91.26.1778540499305;
        Mon, 11 May 2026 16:01:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ace2a5cdsm312982a91.2.2026.05.11.16.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 16:01:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ALSA: asihpi: Use flexible array for control cache
Date: Mon, 11 May 2026 16:01:21 -0700
Message-ID: <20260511230121.28606-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the ASIHPI control-cache lookup table in the control-cache
allocation instead of allocating it separately.

This keeps the lookup table tied to the cache object lifetime and
removes the extra allocation and free path.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 sound/pci/asihpi/hpicmn.c | 16 ++++------------
 sound/pci/asihpi/hpicmn.h |  4 ++--
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
index d846777e7462..0674fd854cc8 100644
--- a/sound/pci/asihpi/hpicmn.c
+++ b/sound/pci/asihpi/hpicmn.c
@@ -641,17 +641,12 @@ void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *p_cache,
 struct hpi_control_cache *hpi_alloc_control_cache(const u32 control_count,
 	const u32 size_in_bytes, u8 *p_dsp_control_buffer)
 {
-	struct hpi_control_cache *p_cache = kmalloc_obj(*p_cache);
+	struct hpi_control_cache *p_cache;
+
+	p_cache = kzalloc_flex(*p_cache, p_info, control_count);
 	if (!p_cache)
 		return NULL;
 
-	p_cache->p_info =
-		kzalloc_objs(*p_cache->p_info, control_count);
-	if (!p_cache->p_info) {
-		kfree(p_cache);
-		return NULL;
-	}
-
 	p_cache->cache_size_in_bytes = size_in_bytes;
 	p_cache->control_count = control_count;
 	p_cache->p_cache = p_dsp_control_buffer;
@@ -661,10 +656,7 @@ struct hpi_control_cache *hpi_alloc_control_cache(const u32 control_count,
 
 void hpi_free_control_cache(struct hpi_control_cache *p_cache)
 {
-	if (p_cache) {
-		kfree(p_cache->p_info);
-		kfree(p_cache);
-	}
+	kfree(p_cache);
 }
 
 static void subsys_message(struct hpi_message *phm, struct hpi_response *phr)
diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
index 8ec656cf8848..40af7329587a 100644
--- a/sound/pci/asihpi/hpicmn.h
+++ b/sound/pci/asihpi/hpicmn.h
@@ -37,10 +37,10 @@ struct hpi_control_cache {
 	u16 adap_idx;
 	u32 control_count;
 	u32 cache_size_in_bytes;
-	/** pointer to allocated memory of lookup pointers. */
-	struct hpi_control_cache_info **p_info;
 	/** pointer to DSP's control cache. */
 	u8 *p_cache;
+	/** pointer to allocated memory of lookup pointers. */
+	struct hpi_control_cache_info *p_info[] __counted_by(control_count);
 };
 
 struct hpi_adapter_obj *hpi_find_adapter(u16 adapter_index);
-- 
2.54.0

