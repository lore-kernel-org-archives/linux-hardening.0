Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73C37F01D
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007119; cv=none; b=dGECLHOvuIlKEyAS8TZ4LUnWOVVjUuqxxxW4r9vQhTeWl6dDYY0cnTdWOhoosBvlWnXxTQGITD9pt5M/iIhumJDEYWKIc2CWEGtjwn62XN3Ze30begg7weIaFp7tIYaOXUNMPX70A6wJSvrVy7iZertVxCMQ0dkBxNgDhtzT3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007119; c=relaxed/simple;
	bh=h7jlRf2IsDI9qQdqGv2bSdvzHPNhhTR1Nonfg/W40cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/n0B7Z5CL0naj71Z12YfsabCk3ksLnFPSRCCpdnJ5CcuRJI5BVUBKi/3JyP2GDE55Py+yK+ztRQdFRQGIIs5YVUSFAfBqsojbZU2VpveTBCf4Q+4cvYUgeXpZOqE97xOwxbqaGYTFCmzqtkYnUnmpRycRK13mwGXsSPUKTZYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=L2whPWgI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="L2whPWgI"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c9879395so4332508a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 09 Sep 2026 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789007115; x=1789611915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+mClRprXurGsMr2UxPPq1/QlRUj/VLPAMpoAcj6a2AM=;
        b=L2whPWgIXodOTfJfr3JwG3F5vO9y5tCMyLCBh7Z4vmFpj2dt7DB6UHuxwMiCCmP+Yj
         q/WaU65CJNtll58G8iWi1U6FmeYUpgzWz/BUqnqvNxzNKeWtuloSvajiNxFWTX7kpEQU
         tH7hWa7bSFcizXwOH7V/EO8GksAhwNL+orLBq6K6SVD82LTEeiBmmnKoyqzUgEcg4fYr
         IO64HT1l7kAjd4MyCZufmvWg1rmnh1NFZGrxgyWX1pDGTvf/oAJs+2nIgZ/F4zTK4q4l
         WGW5yWIeffU/yGjcnyn6FWu0ZlZdAH7EZkURia20epwBhGaT+OLPmm5qNNjTt1dYW1cf
         Xd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789007115; x=1789611915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mClRprXurGsMr2UxPPq1/QlRUj/VLPAMpoAcj6a2AM=;
        b=CEIyGjKqY7WyEtrmNblrchg+uCwYrt5as08dd1OcCGiANA7P5BeJk4fB2OaUlK8tYq
         iQTc/+1gUQwBQbzNswdhAp2qOShBH0zQ8u/fzXhwzpHNYzcuEIGpKSTO6zal4z+uIC67
         F6ZrnufRLFx6+73lSblDUU4+lBxft6NiUCd2BPgPncZN8sMs0UH5I4pgH4mJMjYcXggn
         ItMO3pOwy1fSAAzJeoB6oKP5aWMjYSYI5hnVoNgF2PzkmxMYZA1NxuQ09gfxhCt1CDQ4
         mYDREH5bHGIyba4vMlfH78K9FgLgPnjhOgIXNCe6Mobl4m7geNGqB5r3wsUM6fAh3CTf
         vZjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLQ9OhEhsKcCTQPqjOk9ov7+FShpjXgyYNu3ukdthsWY9pn2uj2g0qqR1xFEArnlPraPD/s8vpByPFjaiNISQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nK+yEYs6EfrpaDwL5ez8dWfDCM7+C0C+OujXd2UaW9N8DwSGl+
	jU0lmSQPtimfGQ7vgQ/P03yxE1HWGziuN3Dn4b6LL4K/9HtyDEqQToHy7EHFXrQW4Q==
X-Gm-Gg: AYBFou1btW2Hqi8VQU41IHRk5MP+w9rH21UCMd0/ca1lEh1XpHQMyWMNMHbnYjGqpFC
	QFuLzn43opt6NrWwo3lsfaIjVACJcb270YEJL4o0OC/UrBIcUru7hl+KKnYYnbsu687EWj+NbiK
	7ga057hxEJwOOr7a/bEXlhKyTeGrSEywkCIFqmfbf1g9+9kevcmkX9O44KlMDxgCXW3wxk/eM5Z
	+OmrimR+U6stf76VbZZfnd8yeg/pOD8LeiuVpolCWHKbc0KI6qrYW9yBRUMEOwZHINynv9IL4Kv
	z65YYnLnsQVy7TaxrSrV0d1+eDGV6VeEPWcUbOSx8NBxsne0g8I7+hY5vnV1kDY+XXuTdqMvBlK
	S+GjOhBn1dSdcixqScoPz3WYc1kYHbZRL5hGRldkmCjOfsvxS7csQ/Z9Yy5fMw6rOn5bcsio18o
	WeUwXb6cTIbduPrYb1XgmiRsEvGJ1m5F2iB3fsICwGuA4n5S9yeG8juqv60s8xe8KrkMcpFXCh2
	3OzmzQx13nRKAgCqXFTQSCFQpCHuxXlaPgggWIp+ByGqA==
X-Received: by 2002:a17:90b:498c:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-39b260d3351mr53425599a91.5.1789007115401;
        Wed, 09 Sep 2026 19:25:15 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm2688847c88.1.2026.09.09.19.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:25:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: fuse-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v7 2/2] fuse: return -E2BIG for an oversized SETXATTR over io-uring
Date: Wed,  9 Sep 2026 19:24:42 -0700
Message-ID: <20260910022442.3594649-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910022442.3594649-1-xmei5@asu.edu>
References: <20260910022442.3594649-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_do_read() answers a request that does not fit the server's
buffer with -EIO, except for FUSE_SETXATTR, which gets -E2BIG since the
value may legitimately be larger than the buffer and setxattr(2) reports
that to userspace.

Over io-uring the copy fails with -EIO for every opcode, so the two
transports report different errnos for the same condition.  Map that
-EIO to -E2BIG for SETXATTR.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/fuse/dev_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c6dd420c4034..6351f2470e09 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -893,6 +893,8 @@ static int fuse_uring_args_to_ring(struct fuse_req *req,
 	fuse_copy_finish(&cs);
 	if (err) {
 		pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
+		if (err == -EIO && args->opcode == FUSE_SETXATTR)
+			err = -E2BIG;
 		return err;
 	}
 
-- 
2.43.0

