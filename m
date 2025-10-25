Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39504319843
	for <linux-hardening@vger.kernel.org>; Sat, 25 Oct 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410486; cv=none; b=oWyrABftOWMqKyoYVQnEdIZp4tKp5mLZLW4Cq/PuBwDJ6KNGzZDtZrh5q+6ug4ez65k+BW7xn/Y29nfmQGt1a8ecNsjF2wcbFa4P6b1WunsB6SM7aWP4YyrojFxRseLHEmBa8XquC23kDMEwLWFMfFa4gJyqjqvB9yckUrDOxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410486; c=relaxed/simple;
	bh=7GwbfwFI4OnHwDpWdSIvynNWO47LZso8CXPD0pWl0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIE04NXD5t2aKQ9bp8MG64vf/y2Iem5Am2tpWI4WRRPUcpnNNQV7mHR8lZjMSrxR/5y4pZBdC6GFevvKt8UAcJbZyt1LQmzI2C2haQISQ0rEoFQ62wbS5PdBHR6pnGgk+cEZpx3GmCW+peYSoIaMftdSAw9iNTObV4svP/wFuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMoRVw/e; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMoRVw/e"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e4d9fc4316so34508101cf.2
        for <linux-hardening@vger.kernel.org>; Sat, 25 Oct 2025 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410484; x=1762015284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=nMoRVw/e47Ca2PFeJxQGcilQ0+7K/pEDLQw7tmgRePfrLJna7o3M4YgejGBdeZLUrE
         S3dkSVkPnYssItysHDNziPNz5ani9VPDt5wnM0lFVl/EEWlfABAT6vg9vyLR14/bM+se
         wYGzV9Z6exKNx9La/3E8WKdzQqG5wKpwkPooGNdiL5t6v2STACEUnGqZQvmdYtQ8Ld18
         bI+uVQqfk3/vDnzetw35OgPfnGNCLkeWB0nQ8qa+Dztpb8zTK/sjoy2q+4+FwBihknoC
         SKciyHsJUBU4KqBDmxil+LjI+CO6tw2Wxbp2EDtyRXelqLB4/wGWfss7AZm+H3opj8jo
         +Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410484; x=1762015284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=UXi3HtPO0O0wszwYrZfiQA0TpCpJgoJ8y3Qr4eAAO/0cSAsi/G9VppBcfzBa6gpB7U
         CQo8d/SBPyKotXOT7+fEzvlT13T8//fGucTtMxigaZ1sOmqAaeCiLuN0XOeAU8KJZC4H
         16RC3Om9tG0+XLmr/a080DV58Rb1LtueHiThwtG0hJwy6lmgOuhDYMTjOXQ8GtFg8lHj
         i9B5RbaADYkncRJuCGVIa6h8UBDKUcvpAAH7nylo66wF+moUgUCevOX7gmlcrdOqvmwr
         s/bNowD5+xozBaMCf+3yBV3dNtzihZp6EfwPJU7wWy5h/NN9ShnsJILLRFtC6lrgIbCg
         jrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/BfhTBH7DqSX1E/6T3fM3BKnJ+0+GJT6btiGD0gQbv3X2034eonvR01ukEniIR/BWZjSoJnrvFxUBuMmK4XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoBPqETqGuD9Dy+iZFerTmcg1XFpH3c1usPpfTOPvaPXy6UwP
	pO2eXdvv3dR+rRWO8Jn0nRYm1AF3wfrhLBmEJPkvMq0Q05bEPlR5YOZe
X-Gm-Gg: ASbGnctkt+yt/5VMsrTn3PKfq+n/Ua5N2YQCnNlRyOrBW/+eXYKlmKVS+qO/B7d3DsU
	YVKifo3s6HaG+dz1JB4TGKCCPuhfG9yIZHXAclrV2HMYLZV2BPhknbwd1Hv4Ha096qAPbo7YJ7G
	zFJGZWshUxsSNEGxiqjlllm/8r5N3qS9VR0YxAsXmcq+fBt8U+ZY+4oWuubJDeW8Tz7XU932CtZ
	9bI8YC+v4G9yKSSViCNwKdyOpcoD1r7rZ+wQJCYvvPQQZC/oQexKWmhHvIeSppbIvjAAd2Y1vsj
	eWX6radkLfjjWy2tPg0NyjGk3IW/rqxg+lPuVsEpeCl3JPzhXDuPsFC0S7jyzJ3tvTO1FY6hAZm
	AFGXv2ZtAaQWmKpNrnjLU1MyCvFK6E3dsz0vLucloUbwSTpxVCe80S/mH102VQn+ojhIP4j/Tr9
	2ayDHtAn0=
X-Google-Smtp-Source: AGHT+IH+bChMnhrke25hcunXp4ctYBzAwgqUPi/DPNGDmVtSwY5Yr5lQoJiKtZxVaRD5EDx9mjp5Qg==
X-Received: by 2002:ac8:7dd2:0:b0:4e7:37fe:b619 with SMTP id d75a77b69052e-4e89d3a5549mr397523541cf.65.1761410484101;
        Sat, 25 Oct 2025 09:41:24 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24dd30c3sm174457985a.21.2025.10.25.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:22 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 20/21] fortify-string: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:19 -0400
Message-ID: <20251025164023.308884-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/fortify-string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b3b53f8c1b28..0c95cdcca736 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -11,9 +11,9 @@
 #define __RENAME(x) __asm__(#x)
 
 #define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
-#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
+#define FORTIFY_REASON_FUNC(r)		FIELD_GET(BITS(1, 7), r)
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
-					 FIELD_PREP(GENMASK(7, 1), func))
+					 FIELD_PREP(BITS(1, 7), func))
 
 /* Overridden by KUnit tests. */
 #ifndef fortify_panic
-- 
2.43.0

