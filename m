Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BF313533
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689850; cv=none; b=sQvFDkZ09ADfcQ1G0LxTHyersVYQvGhgUC1yKUCTpY5kxlilOZLRvu4o0LY+2CDAKziU6Om8w67agq3v9L1c26j1YcwZohSHpM5Vxw5iFUmBi3w5AZV3xqyHC8/KWOPT4zF/CrkAFJ9+/tdXaB4xa+9Z8sp2WT4qpVFlvJ3mQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689850; c=relaxed/simple;
	bh=/BXmkvpKDtyn0qN8V/YK7rPLmRpgpvD9OPV5hibBmzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI+WR6rIi82V7eI9ZtS1O1X0MV/dKGATvJ3TIeOIruKR6PGCYJY4pRRtsJ1PxnRLB7cayTGGuoJpUSmmFXd8wtJJ5ux11GmW/ZhbKfyC0n4w0Cr2iw1d/sUpDexEe+GJn4cuFx8EKdJoi3+g3CJIkqq+A7Ay+FXkGWHHOQd/Cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZypKfUU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZypKfUU"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6051aeafso14662127b3.2
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689847; x=1758294647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvjoC9HrZ6XyeC1MmkaG/lWnbuRS5G1sVQIYvweJDZo=;
        b=YZypKfUUilMWvSOC5tKJEyTgzwdJPYqeNXJf9FaJuF+EXB5614ExOqocoFR2zokgth
         z3v+NG9SaCReUJAEdIU5jm6VnckPGRDxYmiM9LwJagc7Bpa5LgpuBr7qnGwepz712IiT
         mH8TKsy2EmsmpRajtRjKlT/mJCeGbYpwZvepubkvev3TsBNjKxOSdSFlSd1w6aEuZ8Vu
         GsoRgc6QC8knFhDDZrEYduQSljdhI9SK3vYc/giECpsxh7v/aR20rIV4kGmo+TLP4xsp
         laTJy7nJ6KfD276gyuuXGUDUPP7scjNJRSCam+HDlAUrGAz0C9rIOBc0q2Ixh1snPk6r
         Avzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689847; x=1758294647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvjoC9HrZ6XyeC1MmkaG/lWnbuRS5G1sVQIYvweJDZo=;
        b=VX+DMqEnI3wzZMHF5lsKNnFFZJoAsmcvK7KnKjI2RUK8/xQJ/h9GmOtoNBjC6Ka7l5
         D+vvJJ/LOgcORK6+lTkUzdf8SzW1zzGVMuQ6aKtaeZr0jBF7vDWW3p7vnYLvxHfQ1NDA
         18FFfTb4r90DFxKFKis7oyM6u6ie/SXpkrElhyNHdBajfH/c1xLAnXA7daYtPTSyXe+X
         SP0OkZ03wCCdFFjokRRHyW2moqwXd+KzKvq/DotUhRArUC7zj32EeCTlxCydWc3I7D1v
         GJjLsxneRhnNJhgLyemwBV95h37jIFlYDqoD6nzoXi/8WLuZ5VC7bRp/E7k0OGMXN/Vc
         Y6zw==
X-Forwarded-Encrypted: i=1; AJvYcCXjq3gsQyFtFWE1ZEFHgNa+gfwBnilBo5tVgcXZz3EFWp2dvX1CcjC4KkEUY0Nb0jF5eXiqsKt2MNtPD/yvtdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8y5Dw8XiiPK62IAbgInBdJ98gOiDfoC/1rUk3hMJNKE8t/5C
	g+ib42DeaBt7iPjQryvetGdGt5EQOqV4YgidvKg7QRk9r+TsMH+MrvmCYJylHvJ3+xs=
X-Gm-Gg: ASbGncv0P4o3pvDeuGqJh9++jcI1l/vs/+r/g9ORW3l07mYhcfi4A6j9VuFFyQhBiN2
	ippxrGO9Yn52lyTvJbpTooJlLcFuuMK0HeBmei9TG5H/OqcReC/JMMkMVLIWhS3ERxYN27Kfwqe
	nKfUno32Q40Ngg19fZiwznWaEd20OAOU3yJhiwhNWU0kjgZQr185lV3KWNqtpNqQDb96fEA/fVd
	y1zxkZV90zYvlmdhcL8fO2BpWL3CB8P6bLN+WIBrFpHkzHB8Sl0pHO0AylC7dKqkqwJ7a8kXwvJ
	Hr8qjuvVNqWniWMoAMzpf/pM+BqG/RJxV9wy+3vAdkZOYawP0Jw9Mz1fMF16ldp4J/hGCDCnDjn
	fPGtPwQscsy5AXrhRktxMrghzCzTr2ogGyQ==
X-Google-Smtp-Source: AGHT+IG0Y2LxTvBY/AtHJvp89fVFaBOgxCKmySrObEvM5zSsJDKwSvyDpIHnZ+Ay7rKBasM7LP2xug==
X-Received: by 2002:a05:690c:768a:b0:731:1bc7:7830 with SMTP id 00721157ae682-7311bc77c1fmr16987957b3.23.1757689847322;
        Fri, 12 Sep 2025 08:10:47 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:47 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 11/16] mm/swapfile: Have nr_swapfiles as non-static
Date: Fri, 12 Sep 2025 18:08:50 +0300
Message-ID: <20250912150855.2901211-12-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_swapfiles is required for debugging the kernel, and needs to be
accessible for kmemdump into vmcoreinfo.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a7ffabbe65ef..2ef51da2c642 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -63,7 +63,7 @@ static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
 static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
-static unsigned int nr_swapfiles;
+unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under
-- 
2.43.0

