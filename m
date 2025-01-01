Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F82BA3F
	for <linux-hardening@vger.kernel.org>; Wed,  1 Jan 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735730381; cv=none; b=qn2kp2FEUCNUoK/8OVN99Us2Bg0m56ZOVG0PIM/5ZthMHf4N3qjyXJ2aVX8hbxKOwzx56zvUDqs5ThtqBBhcOGpDDM/jHASP+Ysc9hyPCpnBhgkcTnlOXoJpu9D5nj5+gqhmLSUCdkWL+Cpdf+St3+znqEXS389682saFC1p+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735730381; c=relaxed/simple;
	bh=MOyVM6VPUggcpmAtAGJLOelORPskCZcP3v8Wns2eSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9JocsvdJU44JlczBXh5BxUVdkzkk0CED6j2RvVF7zk6Q8BYqqj1k2dpaqibQv5NAS7BL+4y6nFippIBZ25xaAr6qjSfzcGoDBdvRw3Qjizca9pumiDCNBebOu9pC6xRptbtTglPO5gz1ohSgbh/TDWvoat6FKcj3uSfh0DsDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=utRbw/0w; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utRbw/0w"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso113822531fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Jan 2025 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735730377; x=1736335177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSswlhZwspBT8vzUuKvPOVRsV/fJdpx4gV7MkEXaNcs=;
        b=utRbw/0wU7TBcrU/Hds+db5Fx4RhwnUu20DvhUYDzRQ3SIlwO8DHH1dp+P4Kp9Z4n7
         YDa+VxeBvzkfdgAhIQJjY3TB0eqmnL1phsE+Ug4F9aHqDQW1uEiyxCaMaYlxctklP/60
         XWuFei/dPYnmTTyWwrpRdbLh7/SGodtMG9gOjX8j6/4jF+mHm6jZ9WYc9SBseSyk/AAq
         uFzz8ZSvXrXLKHNH0HhJQS6lLfS2WUwFTIBHGbi0b+uEt78LJYHDMF9qh9Cmh9qLyIx+
         w/tRS5KcOcjUpxMtDfWq9N/RwqlBCYCThDakuidiLKdtidAHUPRNE1yoDqsOLHzw6k4Y
         hsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735730377; x=1736335177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSswlhZwspBT8vzUuKvPOVRsV/fJdpx4gV7MkEXaNcs=;
        b=BYctQbiHhEtGoURfVHSN4jkaNLvgtNxwOybZkPXw28CcFnQp5L9uKR8FY7uGevDbZK
         jd2defXA04KAAyqS8ytEay01csPWAjjcCgOolO8dU3hSAQyuZdjC5txsVseFtjA1vfpe
         G0s7H65hPy6TLIiA5kWX0Cw5xtCYLEsz4mlxVq5yS0GeqWNQBkWSdCQEHEbQBnpVKU10
         7HHLVBv3LwBy7xG3UCYyJELcyDvEuLwlcb4WJAcFzsmJjX6mV3zZICiaKwG2r66Vg5iB
         LBBijoYyVZeaP1iHr7pXyQTtmB51taRxRCLW0Q22iEihZBMFoJhjjCJkOEguzsVcBxP3
         GNrA==
X-Gm-Message-State: AOJu0YwlB0F9gpG/veuuJwtFgm4Fl/tLdwIWDIi7aq0sBWGFBTTZJywZ
	/Xbill77Wb9VUlx6e2ZK+iBabHV8oU65GtmPq6A3A3D3pUcjeIahjlGNynKrDUWy8xQ7CUcz9uN
	19x8=
X-Gm-Gg: ASbGncv9yf53YLSNLEsU+fFj/KGn/8Ak0VzPlzTIb7TXcKhgexHWGoTD6BBXdN7DIMp
	N24ahB6Kt+oeKgObqnacD9YkAAMYO1Wg68ta9Ui9Hytxf16TppjcsCNiwZk6abcW97k4ojldRG7
	eT9IsB8UKHumu0erFQVst+12Y+NUX6yP3aK5M41aRQdJSkp0WWdXZcph6qby5AySRNANQnV4QSh
	sbI1EbIK8TlMsO1NgbAh/8nKObOLxAHSVfETHW5a8X6qp3Kk6drE6WQd9K/sCybzp8i7Kb24JFN
	fA==
X-Google-Smtp-Source: AGHT+IEt1OsbZ/DbSPMkFhI4dBgCGz2wL7fDeMiivDfR9u5pSATPwYSRa+i+EJ3Y/2Sq6jI+RdmC6Q==
X-Received: by 2002:a05:651c:b1f:b0:2ff:c95a:a067 with SMTP id 38308e7fff4ca-30468548df8mr138119131fa.13.1735730377403;
        Wed, 01 Jan 2025 03:19:37 -0800 (PST)
Received: from eugen-station.localdomain ([5.30.17.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045adad2a0sm40284451fa.62.2025.01.01.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 03:19:36 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] pstore/blk: trivial typo fixes
Date: Wed,  1 Jan 2025 13:19:21 +0200
Message-ID: <20250101111921.850406-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix trivial typos in comments.

Fixes: 2a03ddbde1e1 ("pstore/blk: Move verify_size() macro out of function")
Fixes: 17639f67c1d6 ("pstore/blk: Introduce backend for block devices")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 65b2473e22ff..fa6b8cb788a1 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -89,7 +89,7 @@ static struct pstore_device_info *pstore_device_info;
 		_##name_ = check_size(name, alignsize);		\
 	else							\
 		_##name_ = 0;					\
-	/* Synchronize module parameters with resuls. */	\
+	/* Synchronize module parameters with results. */	\
 	name = _##name_ / 1024;					\
 	dev->zone.name = _##name_;				\
 }
@@ -121,7 +121,7 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 	if (pstore_device_info)
 		return -EBUSY;
 
-	/* zero means not limit on which backends to attempt to store. */
+	/* zero means no limit on which backends attempt to store. */
 	if (!dev->flags)
 		dev->flags = UINT_MAX;
 
-- 
2.43.0

