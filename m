Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236823ACA58
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084278; cv=none; b=SKi9H+bWqoNUfv2G14YCjLLRLE7sGiQ3r+7b4bnQqng6EsZme/jmsvBTF+Uju8uwRotVoJ0X37O+d+eqCmqxJ3J6sLrDebYZG1kb/ewiN6gTLnxMnXQyPJHqfuaBSFq03dJrT3hR6+3LhHtRgPLvuNyCtnUzCvJak3MTxKq0nGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084278; c=relaxed/simple;
	bh=OCNiS8J/vtMzaYGJaTFJG+hDAr7/vODQZ8hG3+Sh0ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8j1XyPxo48IMspWaGBHMlXH1DzWDhCUzKN2YwJjtp13cDEhkdGZ0QP7F5QU+nxcq0X42/ITbxDJ1vfZ7pDiu1n/If5ehcgdoqjRLdq78C+sWWxS4DySggiwNQzDO0qz7b1q8RkC2uhj7XdFp7NjWLCNT6tnjQldFa6utCfNltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=SvtEZn8L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="SvtEZn8L"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d715f4a587so3593155ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789084276; x=1789689076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+O46wIvOTz3djUW9pqtLqktDx+oddxG2jyQv83ES8M=;
        b=SvtEZn8LL2fhWKS36//StADSTGWLfMQpN1Ufr2Waw9qAT+xwzIT3pTNYCbhJfo/Niu
         oNmBJIH6jJUryFdvh20M93xKUpFdmPja7EAc9NnN5xHKzVPE+vj2LaKDFZrbhcVe9nKP
         x/zQK0mNSRsH7OMdJVxdiYxNxB0fqcsksCDN3CXSqP9BOKKL2PGTKzgbPMJp4e1cqP/n
         NNgmepXWwpR7Rveue7O2OlpY958mESQkQlgCM1XVr9S+gOUzRhi3QPgEHdB9ycLfm44+
         wBku1MWBQsjIhRaOjAPbzOEVa7syAR/70mkD7Z2UrIj5Qv1CiW6VduWx12dcuGHOYKM2
         lQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084276; x=1789689076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+O46wIvOTz3djUW9pqtLqktDx+oddxG2jyQv83ES8M=;
        b=BCPciSDqw1iGxeiz8eQ/xX/sXHf7aUEKRoMt8adDGxweBzlqKwNKSfFUcLCzYUQXio
         vfSwnxiFiLtqlDQ5DFxvS7Bbls5ajv2wYyL8qQXU71GQJb9zI85cSDA8dR1DBeMSr/+n
         qo2b4VOkr9UJeO22izyl2ImJ5eBBY+sGe1kZr58ALlKybvuDJ54HKyC+BeOplbNdGtNf
         wNaHW01FJO5bc4SQlO65tcKWgXwehXeRA9IZq0JqkEefU9DsP0SXuD4/JzxRgIesQv1m
         TcAWLnI5lUu8B8KOZPwWq0u/0dypa+R+12emty8rPtlnNxItLTFUdTQ94oXe9DOoeZtw
         rOlg==
X-Forwarded-Encrypted: i=1; AKwUvBy8rMt0uyxdqtn4lBSZkm6/xxANIcbmKLJsXFriVtXLXRijzI5i8lRpEdSdpb5UqyJNEPLQlGuOgZEs+UJjJBs=@vger.kernel.org
X-Gm-Message-State: AFuF++ma5sWZHgCVxxgErwvOQZFMhPPZ7YVLLYNETaH01EEKxDx2XAQV
	KmbgAR/fIL24rMoeR2C5XE744IZQ38MkuKyoG510Tcxh2XGxKTfI8Z2BkxN2lrlspg==
X-Gm-Gg: AYBFou0DzSEQqwioC4MICoTv0LF7PG5Y8catJrchGJ4fSduazZrMAM4gPMMackYSfDb
	Nkrb6TXpwRnuOUKylhsoh3DCZBx//kaj31+uxApK5V6X2gaq/1we/2OOhNgr5QS9KjkqlYMThpt
	JVBkXjmU1kzi0BY1D9tTE1jYY66scnjhheyRaeg5CgIWkzs8+SfhuHUUKP476OmRrGSsTjdcs9o
	ugVE/k6di/xRIXvSCYwDuYYauzRpz8RY76GiCzUtIxrE6WjEkUXHD4LmtsMpbA+4vPMOUaC2ztZ
	ybnCUeXE18lSgsIVeuI+u8lvBpXBG7rQefdpwLKePjRDha7ezi9THqpxfBeDYE2cpqW8B4y0xDz
	9z9Wz5hZRp78o2Gssb0Wz+WVwiNpc/uU+Bn/64STPeVEZRXyTyhHEmbdy5s4oqbTk+1Jn7JatLg
	C5Ku2NKyUrZ9YY9iwr5WeRtDB6tJ+pKVwSr9AO0Pt0oqMJ0ni25pmfDmWuFHjSBsIDyKB14EpJK
	67wEK1mYZVFKGelwykEVuiC4OG1awVqnL8X/8ycnrZNfLPZ
X-Received: by 2002:a17:90b:5388:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-39d9c0ac792mr2047057a91.15.1789084276484;
        Thu, 10 Sep 2026 16:51:16 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm1680718c88.11.2026.09.10.16.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:51:16 -0700 (PDT)
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
Subject: [PATCH v8 2/2] fuse: return -E2BIG for an oversized SETXATTR over io-uring
Date: Thu, 10 Sep 2026 16:51:10 -0700
Message-ID: <20260910235110.3922068-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910235110.3922068-1-xmei5@asu.edu>
References: <20260910235110.3922068-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_do_read() returns -E2BIG when a SETXATTR does not fit the
server's buffer, since the value may legitimately be that large.  The
io-uring transport fails the copy with -EIO instead.  Map it so both
transports agree.

Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v7: new patch, all that is left of the v6 bounds check
v8: comment on why -EIO is unambiguous here; add Reviewed-by

 fs/fuse/dev_uring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c6dd420c4034..460776cd69cd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -893,6 +893,12 @@ static int fuse_uring_args_to_ring(struct fuse_req *req,
 	fuse_copy_finish(&cs);
 	if (err) {
 		pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
+		/*
+		 * fuse-uring does not use pipe buffers, so -EIO here can only
+		 * mean the in-args did not fit ent->payload
+		 */
+		if (err == -EIO && args->opcode == FUSE_SETXATTR)
+			err = -E2BIG;
 		return err;
 	}
 
-- 
2.43.0

