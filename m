Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CD32C321
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567136; cv=none; b=V9pJbVWb7yCYxPkq/qmfUD8mh6mhq2Wx1JhyDxhJJ+KsioUTOFLBxGgiRmrbUkDawPXbkllq649/nc3IIz+5blh+1mHZ+7/+ANCDseZSH+OZ7tOP7PzY0dZ3CtUR3bvbWV0yObYbLRkEqkfwfQpOBHF1cWhPx5wkfHMeF/jycHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567136; c=relaxed/simple;
	bh=o6BmMGmoTbTaL/NtdpUUmzGGU5vJ7cVEMCY9+Mbhsuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Se3KmuS0QIr2fMFCTP7MC1W94tFLERZCO/N6dbA/p21y3cPtKDW0Qx+ml/+DB/XpZE7DY84JtFk+sX9DCNfS2UUPrmnwm/ypaX93v2dEK3qtWIUcg+hmQKrr+RkgqXx6fvgAc4/Lf//sdFeva34Nuph/tUcei5IP/wRh6xlrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N97gHFJI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N97gHFJI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso18020315e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567129; x=1764171929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgfZoRmCPzcZDOEfTe8kWXd16fGbdAbRWXioprv0N44=;
        b=N97gHFJInsFrGAqWXSOC/t/ip/ZFunAGSLYV+sKzWA5YLMvcNzF4HcIjkZQ30w+/8l
         b2NEkLl+5wQZEeu2dyGiiYvoGvRCs9uxQGYtRFf2HU7fxvjIk4olW8WnAVRi8eVxFZx1
         UlSE+dC4+lWgzhgCrkKaUvADoNcSRGotpAoValiwpGmbEaFUryttt3FwhmktPXVdic/A
         vsUycPOVgkU2YZZgl4vqzYcWvwH/bfSrTDwhlAI/HbZ3WDsvUwLkf+NrIuto02BJ/h0d
         eIzrHPrz8EVcC6kjiBrbDOdboOa8zfoPHPFQMvNaobGZfCEACLBLqBnUpMX2REFiOVt4
         D1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567129; x=1764171929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgfZoRmCPzcZDOEfTe8kWXd16fGbdAbRWXioprv0N44=;
        b=BByivJbWucc+eHnLC3Hj4onw6nysCLHyG7LFNa1wEI/J8i0oBep4n1jBh8qdm/E/Dt
         6kaB1cd6L7K4HoFIoXchO0AoyYGbqF0GrgEZ0wxnLT2/xJVWoUHO6FVIKIutFSQfViHT
         EjxplVfnO1bJMwxncOB4zGWJy/Y4t9LfPz+gVJcIjYlM9P08uhp9jPAKF+va3/YoRbZI
         n7Mx+lN3yuQ3mG5DcIDaJOgHKfobU05lx49xpmKD0edyN2BOFWoMah3bTBIWRPMVKel5
         43+K7ZaAYo/JZ2yFqU9Iav19qHxSDyXyfbcYO+HxlOvjJ13qo05Fb8uSaKoRnfHpWord
         w9eA==
X-Forwarded-Encrypted: i=1; AJvYcCX/dVKk2Hrgq8j8lCS71zzG2lQGvFC5i3idE1fxADGBk1wHCd7DN8qU4Z1/D5rrczUOqtwR/XMePaclefLNE88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpV7w6Nkdtl/WR+bAPwUSga4YvY2JEZNIQ8O4EUW8sZhX9Je5l
	0zAOxIzqo1FF1XskIIBXmnZ1ttKiCJVdTa5ib0vKrVFQpd4Nq9qkiJUCgifYodyfKog=
X-Gm-Gg: ASbGncvrOk9YMoIghxwjwuKMLNhCh491iIaZP+NgwcHj6kACY1jux7pMqGvgYTWOSMz
	qdyoLJ6RV1ydDHr4L+OzFG/DGwvdyYo+ngIr4FVEKN6CvJO422kTeM+J1TKQzeTgcGTfK04SfMU
	ue3cBr/LjYx1zcUxwf3rs4s7DpncLDc6Cr1XusU2BFqucdO797KN5CELk1OB1wRt2YT9tJ2MugK
	bgn+Jy729beF1URzXY2x2dlcQfNA35RNvw/XlSoUy9Uv73XyLJKpLEsWSWQWo4mZDnzgQA64dZC
	P0DfvBCeAz0M5WArf78sm7MYp/vOUM3RSIIwpc/4rbNbAA5egxHP3RPnShDSUbCDvqH2uEitFO4
	2OKyq4j7EievFeDoBSkvoeC2naDkiUUL73Ux4REX7lungboO3aPRO6AccfAb9cz/r6kN5o9heNu
	N7oTwc0doCFgE5oVpbHeGfbn7hBAAQSg==
X-Google-Smtp-Source: AGHT+IEsAcddfcsUUvEjJGVD9iD03mMaqDkbeYnd/gOudjAAgUoPc2H5D0xayvELD1uec3MJtxxFcg==
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4778fe59a0bmr205474775e9.2.1763567128896;
        Wed, 19 Nov 2025 07:45:28 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:28 -0800 (PST)
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
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 07/26] kernel/fork: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:08 +0200
Message-ID: <20251119154427.1033475-8-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - nr_threads

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..c85948804aa7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <linux/pidfs.h>
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
+#include <linux/meminspect.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -138,6 +139,7 @@
  */
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 int nr_threads;			/* The idle threads do not count.. */
+MEMINSPECT_SIMPLE_ENTRY(nr_threads);
 
 static int max_threads;		/* tunable limit on nr_threads */
 
-- 
2.43.0

