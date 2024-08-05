Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68E1494DA
	for <linux-hardening@vger.kernel.org>; Mon,  5 Aug 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880392; cv=none; b=Iyv5KJ8smmF5nl75yZAk0K6G6HbTIpW3akJY0Gx8q7fqtZhmJWZvf0L89ROb07mfLHGn8YsXTDTL+WAPRXqmoXu71I+uXeRMJWDP1ZxbyfkjT+735hLrJBMIxit1QsA6clmiEYbSnsfU/oroaJJI163tpS4ge2Wl1jpholo5Z/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880392; c=relaxed/simple;
	bh=37JxbYtgj0UGmkJjr7UoHvqcTRSFFhKr2Vl6ibBWKk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8XZwF/Cw2FbUyffu4iZWO5rgEqHTV12x67gtF8wnqAxrwyS08RtnCq6gZ/thq0ahBJLcdBTL4BEbpoxmD2HcZxe6KJp2kDpmObsFWKShq6sTlYXAInvzUzq8/R2jpJ7MKnCpwTOPM7GKW0QPjzknljfWFWJRhSC04csgN4sxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=f8pKmzbN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="f8pKmzbN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281faefea9so62090915e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722880389; x=1723485189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vqwe0/CvqutnT3l9d7/bTn3dqeHNjAfCcV9ZLukVbM=;
        b=f8pKmzbN0/ZM/QxuwCBdH+N06OQKotZqtz8yH41AO62ttbRG371WCfw8SQPPlOPT3q
         USIyL6ZRuPWeO4y4T3RBB8nu/6fcWTJTNK4xlUa4wRCFyIHj/NmXScXQ1QGQuGX3O++x
         zgIazL2/Ej4+AO1p3QVNXVcLKhpAqaSF9ojHA5Q/Gnh5XCARExOS989fbpe85Z4HMyzX
         OO913yMCiRfBcOG/+S6Q5lfgmyBt1D0yDfabqPoM7wkE18C/d65G0p116I1aj9DMK4St
         cRswLk4C5hmawy6SIjNGWqbrde8Ex03wWJqr8mTrcBGlLJFyp7MawCnmtEgehtEgvj7m
         phjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880389; x=1723485189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vqwe0/CvqutnT3l9d7/bTn3dqeHNjAfCcV9ZLukVbM=;
        b=LYyBMH/biLeIpinOgBStTU0Wr1OQn4EPk/K+aE4KX1AZnEWG5jQG1rlhdjcZrOAOdy
         muCMAOFvZa2DXnfMufjG6/rz67BDtf+OEH/NSB3QfYrsc0QC+KQGEgSq+8hnwORDGKnZ
         R/o7FjNNzpLofuZtmB8tgdWmeRPx/flZlyzfWK//TsYDeQdropblvi3UuWNxyp/kAKVE
         QX4AIvq8AkEj5+6B08U5OfvLa7sfMj0C+V7DJ8noPHIVeqqqyn8vk7uTUtAr/tFrsP9R
         qZpcocRqRPtzQ/kbFbaW97HMwTalIOVKiL4I9NmjD+KqUH/Asl46FJrJrK7Af7duF6Nl
         5MyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUotL77Ri1MEZswQhgfJjd2mIn/DhUWs3NKrMcVvw36pdlV1MAQDG4OGKyf29x8ofBXfZN5TvHydclPZzqfpnymrOQHi5M7sH5x66TvwQWL
X-Gm-Message-State: AOJu0Yy+me0lfBe7r0xvjuH2sS6nzAjm+7pHwXJ1YAVc6Sj3NUmfHpNh
	iYrldCbWy93BVHkXZjg+qSqlaFsTVQk4h5iydlR1CufpPUK6McvFq97//eIYjQE=
X-Google-Smtp-Source: AGHT+IFsapBhb8f6mICFhltKqRUHmpBomLHqM0Xug77XUaSdZlzbbtSgJltdKCGcKWuJfAdIFBDA9g==
X-Received: by 2002:a5d:6083:0:b0:367:340e:d6e6 with SMTP id ffacd0b85a97d-36bbc1bcadfmr7746862f8f.41.1722880388924;
        Mon, 05 Aug 2024 10:53:08 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06dfbfsm10593716f8f.99.2024.08.05.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:53:08 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] crypto: chacha20poly1305 - Annotate struct chachapoly_ctx with __counted_by()
Date: Mon,  5 Aug 2024 19:52:38 +0200
Message-ID: <20240805175237.63098-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
salt to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size_t() instead of manually calculating the struct's size.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/chacha20poly1305.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
index 9e4651330852..b37f59a8280a 100644
--- a/crypto/chacha20poly1305.c
+++ b/crypto/chacha20poly1305.c
@@ -27,7 +27,7 @@ struct chachapoly_ctx {
 	struct crypto_ahash *poly;
 	/* key bytes we use for the ChaCha20 IV */
 	unsigned int saltlen;
-	u8 salt[];
+	u8 salt[] __counted_by(saltlen);
 };
 
 struct poly_req {
@@ -611,8 +611,8 @@ static int chachapoly_create(struct crypto_template *tmpl, struct rtattr **tb,
 				       poly->base.cra_priority) / 2;
 	inst->alg.base.cra_blocksize = 1;
 	inst->alg.base.cra_alignmask = chacha->base.cra_alignmask;
-	inst->alg.base.cra_ctxsize = sizeof(struct chachapoly_ctx) +
-				     ctx->saltlen;
+	inst->alg.base.cra_ctxsize = struct_size_t(struct chachapoly_ctx, salt,
+						   ctx->saltlen);
 	inst->alg.ivsize = ivsize;
 	inst->alg.chunksize = chacha->chunksize;
 	inst->alg.maxauthsize = POLY1305_DIGEST_SIZE;
-- 
2.45.2

