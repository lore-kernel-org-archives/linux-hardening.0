Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457D15D5D7
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969762; cv=none; b=M3BKbduyEqFEGvfnzkfGO7e8f5Y3ZRs/KuSNyY0jfY46mqlF21Imz5EW3sjacD7PuTW7iJVqnW92AW7chhUSEwhnpSMOYz4eqpb4vHiXMO2A5cDHe2y5X/+YNQ3fjufNfRbJwfMFRwucTNSxbbKuNMoxGtDiYAmde2sg/5IxMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969762; c=relaxed/simple;
	bh=8qeORySSyeeOFCvn5wyOgST7nKcIWdoDreQsWgVCbpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diY0yL6fUT0+MUnz16QYoh8x3AS0CQa0/XNf9FrHRha8BjRY/V+kcDjx4JQVg00ii+s1SDHafwS6cph19/evhnIFWq9CyvVDiLJopkv1uf9/r5FpH7eDyhltlY9lUbjSaxli2uzWmY6kUxpZ13PdOivdLOs3Pmj3uf2oKlVfuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lsGrQNAQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsGrQNAQ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dd72c4eb4aso5602b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969760; x=1706574560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jj6O26KYu1fAV2IWaDbvOkUC3P2XNQ8BTcng3nNITcI=;
        b=lsGrQNAQmADn5qRVD1lLMgRKwIgeB61jxoLB6TiTzQtwHE25WItR6I6facgZOKK30G
         /NYBIPmCVRn1sIANNImk8Fwrr4LYMCPttFukLDEzYS8XbwIvLPhLc5QDMTQzvO6wBJRc
         Cry0adtAJTSI1Li4ECWo3sE++EfAKZrTaOiHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969760; x=1706574560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jj6O26KYu1fAV2IWaDbvOkUC3P2XNQ8BTcng3nNITcI=;
        b=exTamTp232MaLCoblCoHYVkMVcfXmS/xtzCFihxQNhr3U+jTOJYvregqEQFTlZ5+Qn
         KAIk/g+g4jTzm8zunQEXkn9tAGyL8eY3G/6ETeJVhGuITb5tfbxytGWH5qhtzePfgQTn
         0Q+R6Vg0fH+SSdEsEn6p44oZ4Jpsb3CWbCts1BlDY8SryvPSMgltjWGy0r9wCcsluuiX
         jxNbnhzHd/36iS3A4sJr4aIkYtqbMDhIHFxajI84I8cUORJJQpIYFONaxMhj8ICw0zug
         Oev7bJGcWXIXlyOlvm2UdIn3lFVUqJfhRsBmn3LDUDHi/dfhy17d4fuBCp6ZKu1tb95x
         gtzA==
X-Gm-Message-State: AOJu0YxVcmXForVioWWkDZALw7aI9sbRdPt4JBl5AazXPM+cPipu0DMr
	Atsu9K6h3Y+/pcUys2Q5P1DBa1XZ3C/Neadra4ivffIHrxADOLw+0X1+QgQF/g==
X-Google-Smtp-Source: AGHT+IHAQChb7g8SI6STief9SKN0djwi9CiRmcDxVV80wtZwD8CFDo3iPR3Q1VR95dnOuAqo1f2PZg==
X-Received: by 2002:a05:6a00:85:b0:6db:cfd7:956d with SMTP id c5-20020a056a00008500b006dbcfd7956dmr1855388pfj.31.1705969760561;
        Mon, 22 Jan 2024 16:29:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa20-20020a056a002d1400b006dbdfb7624bsm2598975pfb.170.2024.01.22.16.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:15 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 66/82] fs/ntfs3: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:41 -0800
Message-Id: <20240123002814.1396804-66-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=keescook@chromium.org;
 h=from:subject; bh=8qeORySSyeeOFCvn5wyOgST7nKcIWdoDreQsWgVCbpw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLYI6HJPlV99UDk+QdjoC7axWmLKoVJvfrA
 yjhVrtzy/eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JlSvEACT09RyU2KoE3Zx24RyCPuIOZDDteFSvGfF2qQqodQJh5m+7FyYk21boUYR5X6kbtJH31j
 qGxql0FY+H1zojgKB0eVDOYVZegBlrJh5hYoIyl6xHKAHTjxblXQ4pwBtfFuF2LgLLHM1AVNuw5
 bDF2vNEPSeLk0QsAh+h563cxPosIEeFPEZ2j29FlkDvzvehudmsvOH/DE7ZewkH+gwkEKB8J/da
 nCKiXsFoJCcPtn+MAef4L5CCLTTYsb/TAIgEyyacfc5PGITpPXTEfPzgfsoMYykbtGzFGxI7iRp
 Kwczfqg81OIypvkDfnSXc7S3aRu/0piZoZAuDKJrvh41IGWk4+cQlraNxBwIr+5wid3dVct7vRa
 A6RnI7gi0TC+ccHq0ByecHe4oOiSKhI/L9fu2F4P/FnhOQ1b7q7Z3hZpsR9DFUEadjtBEX4XUrt
 nrRLvENYt6roKvpFwo6NURFWfw2AX9EdLQw+pjv+HdA4Xejxobwh23hRVmfLTMetGyxhT2QjAbc
 h9kXTwFpEkrvzmcxDROc89dIt9KB5uMIaz4esBi6HhXFmlwWxCIY7VfqPnNApp6FbzT863SJsK8
 iWlg8vi2F3zQOzatwoqImnx5OhCud313Yi/+J4TPb41HJMWPYa5nhGq9GcIaGk0kViuK4kMpls0 thVhlNnm5s2FwrQ==
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
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ntfs3/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 53629b1f65e9..8cd738c1dbe6 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -235,7 +235,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		}
 
 		/* Overflow check. */
-		if (off + asize < off)
+		if (add_would_overflow(off, asize))
 			return NULL;
 
 		prev_type = le32_to_cpu(attr->type);
@@ -266,7 +266,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return NULL;
 
 	/* Check overflow and boundary. */
-	if (off + asize < off || off + asize > used)
+	if (add_would_overflow(off, asize) || off + asize > used)
 		return NULL;
 
 	/* Check size of attribute. */
-- 
2.34.1

