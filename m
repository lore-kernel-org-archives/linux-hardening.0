Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F50433E63
	for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073261; cv=none; b=orlc8CuX97SPifJSrKi2dfWvlE7h+f/e4Lfb82sKriMwhtAOvoy/Yw/+RQ9+6UIAxXvJdZ67qLH4JLWhKv70kDVQb+V8FcCuirdKYXAvzdcHLRv+neq8z7AEL06bOQlAMbI/HE1LZ55lcnL8eekWBapOaMNmyCD7qtRuBgbUxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073261; c=relaxed/simple;
	bh=t2bCjvQESDfrtTkydLO1/4vSR4Czd2I4rz/vDz9rwe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm35EjLdpkO5gs8Rh3Zydqajac1zFROmQkcAghpsPBSivLpsSnUgWiyMhOqkSShC/5W0lmBV4F2pqbhzFSpM/9wIraY1pWKSfAZnoTPRy849g5hT5Ghnnd2gPwhOuSnTxJvN3vI24BistYD18PEXZ7NFHrz6jG0QKsUeGRLuP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=E5Y5HNDW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="E5Y5HNDW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso21347735ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 Jul 2026 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073256; x=1784678056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WEci7FoVON0/ZMv2IFLGjX0V0D6atEWv0SWH6c8vLwQ=;
        b=E5Y5HNDWvSxTdGqodS22W6ncRF8dv27eH5UVX429NgsfXd09KIAJrdvGQUyX34ddYf
         vZvMnCMhEhZhtC3LOFSb4Z4WiwbzGCsYArk8u1I2FGtmRuoGOohQzeANWLPKHvJKnqI4
         zz9mmSY5rdwmgsNjOFc/t45XW5mUhJCFLHVwBQvodWb91198ywkaOgUd6ceSlZs/pBob
         28LGcB6TTjozgL1Z9Coa+lU6+s6+4hEBS4zqZSZus1Zua/3W2BZ0Lt09XBjmYC5W1VJ9
         VWm3HaXRpVXVBk5kyukKWSYn5jhOOBJTaDip+qXh0i8cnLvXQwwyMy8MtpbESt5ZG/uG
         5BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073256; x=1784678056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WEci7FoVON0/ZMv2IFLGjX0V0D6atEWv0SWH6c8vLwQ=;
        b=Fj/bAwF8YG/TA1VZy96oi8kWm17wl8tiv9UpDGHuIkngj1GXI/y6wg5BkK6CE1iCkp
         yujETmknK28ty6pxVqyMkMVDrdwgOUqn+tVEYYOhrNEz/2U0zPnmabAOEmrBsnTKeHyy
         v5w3B3epshZT/W4oargyl1uzZJ3xtOaohvzzi9C99xZlnC5v0dWpbQPJxQpNpZHFwJyJ
         +dK/g0fDwGWY9s9rVuxmxb5wa0CvahdNu4Q8fGxby6ev2xtYNtaoLh0WJHJk/uTUYvfK
         HwVOPLhiVaIVqUa5o2fZXbT3ZP5m6cuUlptmgFVkLhOMF/PURUQ8hlO2EHe8G7lwDpXl
         xQ6A==
X-Forwarded-Encrypted: i=1; AHgh+RrNOhEbFgMDY00KmprY+CCvf4AlhXSWlsV05rNOypLLh6nciWlff7wWyo4FQwRsbZDcda1+soRGOuTRM7EgJW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7oTi6hCTdBnGv7W83c6ps0d8SILzfN+iqIvWNDSu/kmeikOR
	a6M+t1R6rhnLQdCu/o2H7+5t1J4ZFBSxUdeOw3sW2a8K+q0Q6HLmXjQTCkSfv8k9ww==
X-Gm-Gg: AfdE7ckTHSnwTYoQhOrUtXWltz25wsyKfAzpLUJZhJyKrw1blDDMS0yaFVVjPH/FoPt
	gFIN9hDaiwl/811pkAqiQL80PdjHLqthDPAQXqliox2dNDhuDolmG5lw8Mq3aWPxdRM0nzoTSUw
	sWMHvNPfT+8XR9/nAm4Q7+EZdV1u8JIUEjxAhh9dlE6rxw3gOfi7dk3GwggLvAlNR49PAqo6Lhr
	Gu5J/DbuOMwZB01LQZ77WV+B/0b/MqGX30UwEiZ7n1PEM8mHh3zKzZ7i7Sol0uW1O539I13djPS
	69D/n7ddrlRY50JTIiwWFx7l31bAEzkCrWXKA0I2ZGfp4q524j7ANpOTK1vYiItA3yCR3rFIZyf
	wK5aciVNCnuUZI1r3syrUGRaq2fdiIJkp4IiajGO1gdrl2VK8PvJWXsOPUeznYt6kJ9yx4DBzGg
	==
X-Received: by 2002:a17:902:e785:b0:2ce:b67d:cf06 with SMTP id d9443c01a7336-2ceb67ddf65mr114511605ad.1.1784073256262;
        Tue, 14 Jul 2026 16:54:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:1513:463e:34c6:f6a3:8e91:2983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm123236075ad.65.2026.07.14.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:54:15 -0700 (PDT)
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
Subject: [PATCH v4 3/3] fuse: deduplicate the oversized-request error selection
Date: Tue, 14 Jul 2026 16:54:08 -0700
Message-ID: <20260714235408.1666063-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714235408.1666063-1-xmei5@asu.edu>
References: <20260714235408.1666063-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_do_read() and fuse_uring_args_to_ring() both pick the error for
a request that does not fit the server's buffer, and both special-case
FUSE_SETXATTR.  Move that choice into a helper so the two transports
cannot drift apart.

No functional change.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v4: introduce fuse_req_too_large_error as a helper

 fs/fuse/dev.c        | 5 +----
 fs/fuse/dev_uring.c  | 2 +-
 fs/fuse/fuse_dev_i.h | 7 +++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b8e43e374b35..56c38aca7389 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1584,10 +1584,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 	/* If request is too large, reply with an error and restart the read */
 	if (nbytes < reqsize) {
-		req->out.h.error = -EIO;
-		/* SETXATTR is special, since it may contain too large data */
-		if (args->opcode == FUSE_SETXATTR)
-			req->out.h.error = -E2BIG;
+		req->out.h.error = fuse_req_too_large_error(args);
 		fuse_request_end(req);
 		goto restart;
 	}
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 4529505b2bca..cebd8f871627 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -729,7 +729,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->payload_sz)
-		return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+		return fuse_req_too_large_error(args);
 
 	/* copy the payload */
 	err = fuse_copy_args(&cs, num_args, args->in_pages,
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index b511aaab6bfc..4958158c0f02 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -13,6 +13,8 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 
+#include "args.h"
+
 /* Ordinary requests have even IDs, while interrupts IDs are odd */
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
@@ -367,6 +369,11 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	return fud;
 }
 
+static inline int fuse_req_too_large_error(struct fuse_args *args)
+{
+	return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+}
+
 void fuse_iqueue_init(struct fuse_iqueue *fiq, const struct fuse_iqueue_ops *ops, void *priv);
 
 struct fuse_dev *fuse_get_dev(struct file *file);
-- 
2.43.0

