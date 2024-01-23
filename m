Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603713D4F4
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970768; cv=none; b=bkgcNvaW/ZmLM1RcD8zb4CTKo5JV6QVl2cqn7sU0LNc7HwZo+XSUiejc2Nk0DD++d0fkYYBh+VIBPShOCDKnS46RhZ4nuk52CmhhAMoX7vM0dsc23nGwxpf3MImz24f+9rhTT7h5P5q3oAloQEKg+3D6GzGZuIKopIoIYu49+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970768; c=relaxed/simple;
	bh=WZR8DP53aWhUMhJpMj4CZ9RIOBxzp7ygRqxTQMoMeYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t40SCODg0MPnWobMlc95YnSdekyzsECh4GeJEs6TuL5DXacrtaEhW51+v8/D+u7BQviwuvclfiKZ/pShihBku+tTuDNWidYWrmSlDqjE3D7NgnCN1DbRh59jLyr7/ObF4HFImT0srk7QoQ13iyVuWoujxAqjt1LU0LGYj19lQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nzdh+4ns; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nzdh+4ns"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2906dffd8ddso1947202a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970766; x=1706575566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3KJ5I/uilVKWIX5sZxDEWyboawAxb7T38/MRRy/AI8=;
        b=Nzdh+4nsqDJcPrq1QYN5wtrpF88u6NPRTZoi7JjhPsoJxsI+St1E/LSbZyp0/JfkzV
         GDUfq03xLuMtN7ZN06ceIoK4D4sGTvF2OEH/17UwTscl7Fzdn0I7IRN3p2a9NP121ADO
         lI3YBRVXq7a4mvbbjo+48Ri1UbO6CtdfZ9+w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970766; x=1706575566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3KJ5I/uilVKWIX5sZxDEWyboawAxb7T38/MRRy/AI8=;
        b=isgUvHNjcpg0Kh5rEy8ETbo8paIWHd3Da88XFwY4p0lXvsDi8wOuU14lA7mBcf8ESL
         P4E8VxyZ+btrV52s/XVNF/2jbb+EVINAkKBmAd2YX7qpkD2DytRZXYrJghREQCo1al/d
         euUpbJaztSothnqydv0IRgy9GUL+jlEUARzyrmeGaHEK2Mm/dtJ+fBZiyBfklOL8qJqf
         RjX7Lp8454kqq9RUzzna0hMpYu2D44rge7VknrjOtm20D6SZ4LrqghmOmKu37F2hQ0U/
         Y7meu9fhabAZwrwJBfEQlfMpfCH8gdIqr/kJBXfe4OvqCbvdJRXOPiUyAKeQFkXt9m2d
         rnpg==
X-Gm-Message-State: AOJu0YwBSaFxhtGhSA9LTtUtyEi2ZApZTiLcIbRqXfOeKPJS5yX3gEo6
	vOpnhk63o8PdyPv1YzngTkLM+B/CWmH8/tlmKfT9mVuI7Ubcc/xNE0MKteIVZw==
X-Google-Smtp-Source: AGHT+IEeXyrTcy2GTeJ9XtG67uA2W53TBp8f+wQgOJZ4pd2pfMtrSlp3dLG1JJIDUVmVLNqmM2ly4Q==
X-Received: by 2002:a17:90a:6b84:b0:28e:87a0:c05b with SMTP id w4-20020a17090a6b8400b0028e87a0c05bmr2374190pjj.40.1705970765941;
        Mon, 22 Jan 2024 16:46:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id px7-20020a17090b270700b0028ffc524086sm10568431pjb.24.2024.01.22.16.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Nick Terrell <terrelln@fb.com>,
	Paul Jones <paul@pauljones.id.au>,
	Sedat Dilek <sedat.dilek@gmail.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Xin Gao <gaoxin@cdjrlc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 81/82] lib: zstd: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:56 -0800
Message-Id: <20240123002814.1396804-81-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2736; i=keescook@chromium.org;
 h=from:subject; bh=WZR8DP53aWhUMhJpMj4CZ9RIOBxzp7ygRqxTQMoMeYo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgM0MuXKRXzKz6P9gaIByx6Ha+nvmKs3dQ0P
 O+8CgmFoqOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JniTD/9tZtlILMGEKY0ggQVVN96o3hW7HM6cQwEPtdhvKS+YVeZmzxX1tpzwl2nHL0FRBw8sp8/
 3n9O2a1CKGeE1qP1XFG5nLey1iciPLp4hQA4+gBQuGdjIuAbcnXjZVa8y4O6JwfU8fuKuMImcit
 v6bra8xrveAYBHncT3x7as9aDE+GG7LRKuSB3EiPX5enR6YKQ9AjAJPZkJRQSU7I7LUzePuF7pf
 px2nhKBQcIcDBbFr2aZrptPXCLJFPinvp3MnPsEg8S78lMxKj4m94tZtOrVuTqBhso31jS8Z5AW
 YcXmSCyvtjkiaD5pDPQWauQlAQi7TZh3PEOuYd3MU75BuK0LobPknTPxrp39QxKNQik13HlJXDd
 SW6Ox6jV5DifJjDi/MAXpCACEy9FGzO7thzQks3x4WVESY3ow4m0R7cJLKScih5ImK6rVyutqNx
 pWV2WKuzV7oGEcLDwOaxCX4U+b+IBNkpqW41qzClTrUjgeEi2/FTNBC/3W7InGTOKOpZ+aKdxg8
 LEbszRtpDs+vrnrTLyBC1Or1/+2iAhrGvI/fhvLmU7ElC3MlBZNgHFwJVeeo6a26t46MBsc6W7H
 KRSZepdY+RVK8DWkgkXNMtNJ5+scDPVieTGTCE5NQcC3kLEMkr4nlYSOZF7ktB8EMeEiUKHf8MZ JoCCcRgn1M6x75w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Switch to a more regular type for a 64-bit value and refactor the
open-coded wrap-around addition test to use subtraction from the type max
(since add_would_overflow() may not be defined in early boot code). This
paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Nick Terrell <terrelln@fb.com>
Cc: Paul Jones <paul@pauljones.id.au>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Xin Gao <gaoxin@cdjrlc.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/zstd/decompress/zstd_decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zstd_decompress.c
index 6b3177c94711..2c87cf702ad6 100644
--- a/lib/zstd/decompress/zstd_decompress.c
+++ b/lib/zstd/decompress/zstd_decompress.c
@@ -585,7 +585,7 @@ ZSTDLIB_API size_t ZSTD_readSkippableFrame(void* dst, size_t dstCapacity, unsign
  *  @return : decompressed size of the frames contained */
 unsigned long long ZSTD_findDecompressedSize(const void* src, size_t srcSize)
 {
-    unsigned long long totalDstSize = 0;
+    U64 totalDstSize = 0;
 
     while (srcSize >= ZSTD_startingInputLength(ZSTD_f_zstd1)) {
         U32 const magicNumber = MEM_readLE32(src);
@@ -606,7 +606,7 @@ unsigned long long ZSTD_findDecompressedSize(const void* src, size_t srcSize)
             if (ret >= ZSTD_CONTENTSIZE_ERROR) return ret;
 
             /* check for overflow */
-            if (totalDstSize + ret < totalDstSize) return ZSTD_CONTENTSIZE_ERROR;
+            if (U64_MAX - totalDstSize < ret) return ZSTD_CONTENTSIZE_ERROR;
             totalDstSize += ret;
         }
         {   size_t const frameSrcSize = ZSTD_findFrameCompressedSize(src, srcSize);
-- 
2.34.1

