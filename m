Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DC15D5A8
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969760; cv=none; b=HR2d7FIb+bSyqZAHtCiftsVRsQdxnLWugRINLvbKrzrjeeG6vD++cYfKZJvop3IoJbb5jk+aKKgwVEceOBJscTQAAVlF5Ezk/86qD66Dw27CNmuhcrnnX6X295cbAyItBmygMueozUXWf8M3HiOTZULki2JpHZcrpL3Vkan0dPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969760; c=relaxed/simple;
	bh=NRYAFFjPwwQS7mIFvZnh2t0+iUmsnpaZsL63ZPTCQ6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNtEZgVxojHrKl4gHJ9Q9dnczm/cF+vCnIBqgk/EwODLe1T/SOFUO1ufvuWu3HYw7BPaXnv/Z9/MZ8o+HjrTtClUHVebILLljWrc1O7T8ifHPm1o/Ne3MQ+vhPUf5SIJDYiT6hCmUgZEw65+oMhJKGWW/vC9D01RKULsUkLY9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E6nP5f4C; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6nP5f4C"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-595d24ad466so2475846eaf.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969758; x=1706574558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1DxNdRHBflJbmbDYuxIbQcedkbFsBliolzYulMuTN0=;
        b=E6nP5f4CcSoVdM6hp+465wgCFAfEpBoQ80HMEQwtTHIYc/r6ibKBjwJnGK4p7RHv/2
         7R2R7cVRu+XIOczvmdaxykFeyB4cXpwWL+obE00LcR7Y1gi95NeJGqYzNmjNGlMRwSzu
         QX6EJ8TJ8aYaZeFBU92XojjLeZxYDpD7i6aYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969758; x=1706574558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1DxNdRHBflJbmbDYuxIbQcedkbFsBliolzYulMuTN0=;
        b=a7wSbRT3d/sSlvFhhBX2m08teNhFYQU7Qw+CJKpjRvSQ/aPdDxmEt+r1eKEwHdWofY
         YgsnYsys5jLxGXxoF+W0ga55NQj0TpwV+SO12oB9qweuB0CZTAskW4RPrtnrf16kdS3S
         9gc1MmqGMPtenfPhVOWjzkig/m5vvTnIaOhlyWCsCYjvQtK0gjt/MuIpoTewKgBJmKKZ
         YUFGrfL8NvF0p/EPEP0bnwWArJz5bXodx9BjKNGXffvSIcKSeiTC8DzY8ng3Qp+pC9EX
         28fcgudC43p1TtoBd+QWt5OHevz/VsVCN4q4kJehmsG/NKrxIU9p0kP6VlJplInqAmxe
         Tkqg==
X-Gm-Message-State: AOJu0Yz1oaeNJ9G2suvh78iWvWrv6NPA2k0Hs+k6bala1W4eOe89eRfl
	f5akezcnM5sHlUqeLqEXveQ3XIYDDgG2EBhfy2IClZroK0vj5LELWb3xyoU1/g==
X-Google-Smtp-Source: AGHT+IEErLwhFdHhXqFPSHROcPX6dDCZlFhvJYjpwzygJo7X4gRnaoVAA+NbgzqckFw0q8wdbkYqXA==
X-Received: by 2002:a05:6358:2245:b0:175:cb7d:74ef with SMTP id i5-20020a056358224500b00175cb7d74efmr4887240rwc.25.1705969758150;
        Mon, 22 Jan 2024 16:29:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sv13-20020a17090b538d00b0028d8fa0171asm10226441pjb.35.2024.01.22.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:12 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jan Kara <jack@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 76/82] udf: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:51 -0800
Message-Id: <20240123002814.1396804-76-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=keescook@chromium.org;
 h=from:subject; bh=NRYAFFjPwwQS7mIFvZnh2t0+iUmsnpaZsL63ZPTCQ6U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMK3jte18rzddAc5u2oIbz/en8DIzVvj/9f
 tACbF2GE7mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JltSEACOR1X2f4YzSTUWirLbiPo7iFpAcmKQQuWJudbXBybocaEGktZ91dSkGU1ret9HSOaDFZ5
 ML1P9w6bVsuc8lDdJdgDv2SVGqJRdj+2+xI3rUyDLnwWqbiLeD/s4deHEfwMTW65MWW5HY9X/ue
 zMThSZ0Sy6b4g1lkai1AInfLI+GK6Eo5X+08+mkr2CCh986mej8lVGAb7/5oGG4MYe/n+8JmwtR
 hDiFUnLLkEEcjrsyk7o4jl8BRomBfZ/PWkpLpt2D30aJJ0gW9Miqd1hed492/DJIsX1Z8hYQBoV
 E7q035WbqjiEFbhszJBHtt2UUrv1/2In9MJhAOkU8MK6O+yU/rp6shdMlh01IHq/pc01dIBXEzV
 njNDI2L3U5+bq9jetWc0yaz2qt8B12pZcQ68P8dPxxLQa8x6hjW+exF1ZwE+UAk4fgcgyr0CEc+
 XjQJcleZ2OGG2Z7XtnNz2EShFPtqKrZ5qrPfI48add5Zp7ePE0Wepk3CjYI70dVNia8Y8BgwLWz
 041z1qmkwOtO3nLDGlRFoBWDFluTPvDhRSygJ/u1EkOtEj4EhOPt12zQZcf0nBMORvbHMzYoZIt
 3fkcz/f9xISf7jsy8iEWlxCATRXXc9k4XnIfY3Vn0fKZb2qZ9jSuDILDsDVvsYEsbFC8tB/WVbU gaVCGgqwVJIgmnw==
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

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Jan Kara <jack@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/udf/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949..5c88300c3de7 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -139,7 +139,7 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
+	if (add_would_overflow(count, bloc->logicalBlockNum) ||
 	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
 		udf_debug("%u < %d || %u + %u > %u\n",
 			  bloc->logicalBlockNum, 0,
@@ -390,7 +390,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
+	if (add_would_overflow(count, bloc->logicalBlockNum) ||
 	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
 		udf_debug("%u < %d || %u + %u > %u\n",
 			  bloc->logicalBlockNum, 0,
-- 
2.34.1

