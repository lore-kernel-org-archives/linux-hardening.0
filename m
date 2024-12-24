Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A81C5F25
	for <linux-hardening@vger.kernel.org>; Tue, 24 Dec 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055055; cv=none; b=Ef4ttqwG1cPIJ1LCAVMdAiswvvfhTHXTI3mARq6sWIAheCpgxvvSJenVWI5oRNnh98t3FK/JIampwjgDKiLe+jsqtrWPoFG6Ko2vC8VQpMx14jiLkpKsL7G4EPrUkOHWsF+gvAfSNVuTQ9BSljAdfpBRXXACSXZMe/3I7j+IdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055055; c=relaxed/simple;
	bh=RcIk/IdDJ8Yb8jjVpgAnmL7a0OmXjZ4Xgqt9tR0NeUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hd5sja4K+xCjCTU61VXABkNdqGrky/s1FdvlB1eiAIxr7N5ry0k6VEmXJVwksRdXkE7rE7BZp1zlAcU3Hp1cQAsKkuPasJKONGHOqojHkRCAG6kzzphWWcU3Ng+EBPaXJ14lFCczEvtsbXbQRdc4DeJrkPaHpPN+b/A0Pg19WF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAx1xAAz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAx1xAAz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361f664af5so59041055e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Dec 2024 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735055052; x=1735659852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hb35l6jb0hEK+m5G5hYlabpclShefZCv8OWTt0AIF8k=;
        b=CAx1xAAzOOLd08gKpHn1nj/GWQS/vaQ8Bnhei8kL2+C2Rc8Q5Fmsb/6+DvnXqgpEEz
         6AKZs/GfLtV6EHDwyGUhhCvpXmOizHibDkX+rNDsxBF4gHT/fbEIgXtXGrv907KuGWLg
         EpDgdwz0niSpipDTnP3Lj3E0Q43ekpnNkcIxfsmqrOHKwHQQnStfMgJDOFOWF2BCs4Ld
         WuB56gH98IqcTFmJZVprdmkCMM7L365ScNd8auuSCsyzzeC90s5i7hkBnRogMdMlQbuw
         S7RcXvhhRD4VLyBvlboflQMePQSqrjfsLQlvf20ahcmGOUNHspp2dIyXmPckSn/PfSxW
         P4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735055052; x=1735659852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hb35l6jb0hEK+m5G5hYlabpclShefZCv8OWTt0AIF8k=;
        b=B4I84VJp8Y9p3PgYPNAIwrEQWnOi5QEgd0uRLLySp6R/P5Xy15Rq/avML5YijIzuTK
         H3CI14LQabD+u87TCpG4gjhvWzXHNTlAjubJvg1QvLPl26JIiqvamvFEkoKuZvhkqKRZ
         3srFv58KcSXryKykB3VgzWElH1eT0z3CBdvhH2bWPSneAo/hNqySpvbxcUccFKXsaMJf
         Xq6HPcGkR0CMWbXJjhHz737uMVgsf5nee4WwyoZcqBjmp+vqcNoXu25hpdtcXz3gaTKH
         sz81S7Z4p5wUe8gFTbSs24Szqfd0tmk+gHVArxjMYMf2LKugXxuolhFl0iz5v7dOTJBN
         jbEA==
X-Gm-Message-State: AOJu0YwASpFOb2tFdWdPAqK8Ndy2u6fiL0jHXGLh0SDmAkxbtY3LtgtC
	Xp5FmY+1hKgg9o764CueD7YPtlyKDAUIb4ljYtt6np8k8yevMkW0Mm8t4973xYNpXQFUj75m1mc
	8BlQ=
X-Gm-Gg: ASbGnctuh+P6ZntnksZcsiDyU1or9xtRpuHv2hk4mURFiFeesezzHOXLXMY+2+5e872
	G2UNXHhhqD/f9YUyDdBA+fjsPaQC2M59/kHG9xYWWvWxgG0vvQwo0ub9qs8fLZ0GLE1cgT5M+fD
	JFRcsNlAkYas5JMs4+Lm+Z9jkOgWgW6497zhG91M9QGCWlEkODU7F1q1RcM0uE2opG+zrF5oLJx
	GQuSmD2ufzAY11KwEXNR1t+2/qG2u4FRBbQy3UkgOnmTa7s8mT9a++rDBI2uIHSiw==
X-Google-Smtp-Source: AGHT+IFs9PG1FcptbC/oMhT+zVnkcQuTigDS50ugiMFXNWuoa/LvTV9vpxrdL1JqRIHSEuMlq6ZokA==
X-Received: by 2002:a05:6000:2af:b0:386:3752:b28c with SMTP id ffacd0b85a97d-38a223f5c3bmr13231338f8f.41.1735055052048;
        Tue, 24 Dec 2024 07:44:12 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219578sm173397945e9.20.2024.12.24.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 07:44:11 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] pstore/zone: fix trivial comment typo
Date: Tue, 24 Dec 2024 17:44:05 +0200
Message-ID: <20241224154405.295840-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/conpressed/compressed

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 694db616663f..a4ee4e04d1cd 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -43,7 +43,7 @@ struct psz_buffer {
  *
  * @magic: magic num for kmsg dump header
  * @time: kmsg dump trigger time
- * @compressed: whether conpressed
+ * @compressed: whether compressed
  * @counter: kmsg dump counter
  * @reason: the kmsg dump reason (e.g. oops, panic, etc)
  * @data: pointer to log data
-- 
2.43.0

