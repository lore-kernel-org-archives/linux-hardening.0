Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D62D321D
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301142; cv=none; b=UpTnG+3cGk960MG4lYasvU2oeLzx23ndg3FWcKDpPY0A4kk46FT7PI8Dirk+7AzjukQMezEUdpHSUywbZyUYaAsT/7QvTel75f8U01DGOIxRxb3K29LaRucZJmEjA1jeNz3TrkgU01qM9La6AJsLEZe89b5utWeLtPdYb+Y9TdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301142; c=relaxed/simple;
	bh=iuY0eu+BymU387rMM1XJMjI1HagYP3+/DvDnpdvKptk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbCPPyBvvANZJUL4zPf42zhc6eHuEVE7xWMWKziPoqGlJSM9hsx3Ie+3i2mmaUrfm+PfECvmKQV4nrtDUnexifobhE1tn2dvX3tfJ90rvJUEB0ETkOKsADbccHMQ1bXH04orWLAVPg02G1qE1RlVD0mRfuQ0d5I8DPZ2ppg6kHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzJwr4NI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzJwr4NI"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so808593a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 19:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764301140; x=1764905940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwhniX0ZJtvZTg2p7tVmTaAUVb8Ox0D0lnQSPuzqilw=;
        b=OzJwr4NI/xv+qcQU9npxhzsw4koNsI3exa4k3uac+VKLDHR2B6fDwifd2N75bF4QGq
         mk8l5gZE2pF6kW3NJo8e5R3NkEKbSZbym0p3QcOWUQoLUCb8WAg6zLrVQV/vmhV5u4M4
         57kZ05d8v7Le1tT6PZ1kljCFSipbo4wyXzstF45wBShjr1IJeUY/ECR2kvrPgdu214sL
         GOdE/mLL58+dblXw1ySwyDjGwGrtu+62h7EAlgYCln6CR0t0jmT3kLIv9oMiPgOXOcoK
         LvVJdlCNHWYp9d7DopbvIvPxm3cWuLfzqjg5wUXiVaS2MVDNMmvrKg5EuiCP+APMSJ+1
         xWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764301140; x=1764905940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwhniX0ZJtvZTg2p7tVmTaAUVb8Ox0D0lnQSPuzqilw=;
        b=pE3SctTIneRP6ZY3p55mZg6DqJFXwWZHZd81YASAlkGO2dZBo08Y/y3ILQliETozVs
         BBwSgCYKRTxJwoC7jTRgGzzAczkb97FAEez8w9iklx3X5EZPQv4kV7+wZ9rjIQdjYiiF
         Ky3eYqyl6mybgG4fSnqu6x+OLGTKoDtExk1/Z4FUPusFYK3v3671+RECPUMwbM7Cw2G/
         a/gheKPKiDOeR0BF2ULbhvDXHG3izm63wYrJrf1q+KOAsBJ0ycp0L6nMhPMmUKlzPoZP
         rm5K7I8w+to4JpmGapW2OVQTMc1nfozXYA/0RAwkoAow2jzx/gHVHwTdFlRaqWE+CNS7
         zMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNXI/hdRe5BD5m3dRWAdGJwjeRTeMrFoeyNDHnbAchEvSkFaHoclHb97VpW9qGawy/tKnfqSXDXu/95zToNWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AVMPbeuE2vscUSZFhBUov3s1tpF9Wx7Unq2Nfsn+IB7p/H8r
	uOgMnt7zjsQoEEdi91Cy1g541UGT+7qJ7rvK6y9crpl6vO7PohULNqJw
X-Gm-Gg: ASbGncviLdFPyOwVucW+hKw+BnshfVh+HeiJ7IE6ntvTVOwe2NLW0LCUCzpzp3NIM23
	QRc6VVsar9xBhx/PUx1TtSdKN8yKq4HDzskTZusTei/bWp4dblDRXMltQIoHPzIMBHGQZUXUy1z
	N1aPRMFTJDbuL8V0dkXD28b0SKAqW4jiMB4/ubThgPOYZhZ02pBS9eTVpXy9T4rj8Xc+cYIEwHF
	hGn1HYSTh/CDiuaZ1zEjsSQJHk7IhUryDVU8un9O6hipNf/qCDf8yf8HikJVA1lKIUZqJaUH1Bq
	BpVOIie7r/32CTSepqbocG9MGa3ABJDA/Qzaj3d5UkTTcKK450hQGRiqpv5czKT/dL29wsDgXzY
	6mqhPT/5ZwhaDdhRNQDIN4GkUFXddoJg13PPeZoMkkqHHpHuOl1shb3ruRFxkszjZ5Cl3sfWdlf
	2HdztmG4G6TdSKyucNxmqxcZmvvfsCXhQWrUhfxpXU6PQ=
X-Google-Smtp-Source: AGHT+IFQ2Ov7eS6bsSc2meQMzLbFTsAskoTl1ClkVsMkfKfn0z0A0du/1yMbRirUj4yvFp5szxoFeg==
X-Received: by 2002:a05:7301:5795:b0:2a6:a0f0:d7c1 with SMTP id 5a478bee46e88-2a9415a402dmr7943316eec.12.1764301139978;
        Thu, 27 Nov 2025 19:38:59 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03cc7dsm13999469c88.5.2025.11.27.19.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:38:59 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: [PATCH 1/2] overflow: make check_shl_overflow() 128-bit aware
Date: Fri, 28 Nov 2025 00:38:29 -0300
Message-ID: <20251128033830.331426-2-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>
References: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_shl_overflow() currently evaluates (@a << @s) in an
unsigned long long accumulator. When callers pass __int128/u128
values, the intermediate is truncated to 64 bits before the
comparison, so the helper always reports overflow and returns a
zeroed result even when *@d is wide enough to hold the full shift.

Introduce __shl_eval_type() to derive the internal evaluation type
from @a and *@d. On architectures with CONFIG_ARCH_SUPPORTS_INT128
and compiler support for __int128, it promotes the accumulator to
u128 when the promoted sum of @a and *@d is wider than 64 bits;
otherwise it stays in an unsigned 64-bit type.

This keeps the accumulator unsigned (avoiding UB when left-shifting
negative signed values), preserves existing code generation for all
current 32/64-bit users, and fixes the spurious overflow reporting
for 128-bit shift users.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 include/linux/overflow.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 725f95f7e416..ca8252e625d5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -175,6 +175,26 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * __shl_eval_type() - Choose evaluation type for shift checks
+ * @a: value to be shifted
+ * @d: destination pointer
+ *
+ * Returns the internal type used by check_shl_overflow() to evaluate
+ * (@a << @s), widening to unsigned __int128 when available and either
+ * @a or *@d promote wider than 64 bits, otherwise using unsigned long long.
+ */
+#if defined(__SIZEOF_INT128__)
+#define __shl_eval_type(a, d)							\
+	typeof(__builtin_choose_expr(						\
+		sizeof((a) + (typeof(*(d)))0) > sizeof(unsigned long long),	\
+		(unsigned __int128)0,						\
+		0ULL))
+#else
+#define __shl_eval_type(a, d)							\
+	typeof(0ULL + (a) + (typeof(*(d)))0)
+#endif
+
 /**
  * check_shl_overflow() - Calculate a left-shifted value and check overflow
  * @a: Value to be shifted
@@ -199,7 +219,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	typeof(a) _a = a;						\
 	typeof(s) _s = s;						\
 	typeof(d) _d = d;						\
-	unsigned long long _a_full = _a;				\
+	__shl_eval_type(_a, _d) _a_full = (__shl_eval_type(_a, _d))_a;	\
 	unsigned int _to_shift =					\
 		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
 	*_d = (_a_full << _to_shift);					\
-- 
2.43.0

