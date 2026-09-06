Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77631B114
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658171; cv=none; b=B7yTSC7rLxf8rAFe933aMbcYRP6VHgS9oKFi2IxJA+DBmmiREQCtUGbl4SlQh2drz5RHkM1T5zKqnOayT8bC7VOCp19SZgZ5UpWoIGNC0RuvEqULPMIV1LLg7SFRtD04j28Lb30VNr58Vzlwj0iF+J+6klGDmGhKflUhxEI13FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658171; c=relaxed/simple;
	bh=7a1Ndwvoc4REla0vGLCnEWdMwph1amt4g7HmhXPWcCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3WI9UX1DrmMwvV7/l8y1UZQd/8DB9VQiBSzOlA1Dkv5gtERgrrrsGa8Q2VfLCAUQXRjFkhrFvZckMPM3gndJq2lfewr/1+xipLejfc8+qmBIBD8eEaWz7SCnvfiSrDXNz+H52TkC/UprKMLdELgpGNTQjTenHG7ac0WmVHjuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eAAHkKeG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eAAHkKeG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-853c07a76adso2204361b3a.0
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788658168; x=1789262968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oT8Nfdv6MGvf2cFqhsDb4n1/o/u/U/Uyjhc2N7KsByk=;
        b=eAAHkKeGXWX6PgPhM2KKRjBUbHf01ziQBAY1aIAfy8aW2YHAwnZOegM0M1adylhP+h
         BpC9QOPHJ7usrIa5BDy3LHeY36DkkIxnCDTMdYjksq58q3sicsFBywWuoHs6wOkjcSmT
         KRPx8H+nl9BDwVEaHac/FuSRgI3b2D9kJsO2RcVlYmk3hhJ7psGc0qakEudaDp4bEzQG
         7PgS1bPoSZYYfGj+p6miJoyOvjJyYxbNzlk6VltLG8WNr8j4nciUEIRk7krpBzbjAZmL
         CHCAnyOXCHHT25j91by5UXDCKhxf1KsIcCCl7ppNIpPw7RYqeqxa/2Heck4OosWw1nYy
         NiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788658168; x=1789262968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oT8Nfdv6MGvf2cFqhsDb4n1/o/u/U/Uyjhc2N7KsByk=;
        b=H/zp7t2phlQDVeGa4cQGsdRIXnP32Lk6ucPIXfbyu2VXnF4DcnRzRFlGiEK7i3M5un
         GUXCHAusqXWkHNUocvnpfJOCISy4ZcRn9cODEStfUyO6GZ2420vmpgHHmPXkUdp5Jcaw
         KnRVkzKsA02KW7Aip50nkvF2DJU+bO90Lt1wHfYS0A6+duv/RM//J1Re9nOoH2DaelSF
         WLEwRCtYTGCL2Wdq/+IiKZCckcezz6lL5Ji6KDs9cZptmnGl15yFpmIylFmsGf4F1FHW
         UuA3uvxRUGzK3j0jfWLWCm8cgar7T7ngr1GFYLNsQ3WWBEpotFAYWrr+TbolnxmEpsG+
         P0GQ==
X-Forwarded-Encrypted: i=1; AKwUvByu14Wf9ycVSj3gfYYYHj3ECfESWWWX9kfo0G6QWZIJVzbi8ylm7QHVuh3mVL1Ivq83byQpvITmRkVLLCzLV50=@vger.kernel.org
X-Gm-Message-State: AFuF++nbU7iPcLIEJwYicaQR+lOSTePmgawh8kvH+cnuTl8kWYJy3y70
	jDs0CVtFv/vEou3X5Bc2eUNuzaBq3sWtmrmZ97UDxI0t4S6/GlZL9CG8sWT91m8uWQ==
X-Gm-Gg: AYBFou3gWtO0eea0Z6QVrCmUBAexD6HKwZPjFobeBgXMCBvyX0c0QnwinZC6pqrYKAn
	KnFoEv0gQ4CLJA7b2pAf6HVguS86YR0Zy/Bv1dtJPdOn00CNRxjCrOKCQZMctnGLvsq1LHbWOuZ
	hxNiuTAx6PswL2S4oDX7KYYJqIl/+ydN3arSV3ct4Wapt3uKU0hZnbo4dH4/lF7uWlV9eZWZ/ru
	GeDgZOAlNbhaVgfz/Zn2kLZmE+Oa1Q5FQfHVaNpmoMi7A17fqWBm1rz7ji0Igay4y9rW493A79e
	tANQg9e1KjkDw93xTC0qKurdmNHN+O83nUDlq4c2Z2IR8XU7dj7WX/qDW1oDu3rFDJ7a0b9xgBs
	MHCMkVolS2efwXW5FP81YYqSph4Nj0mKHEYadhIeggKnptzFRMuoxG8dt3IqZOY/0Ec7QyjTIJC
	LkuNPDlboH3ZZgqVrqGDQ3ZIBhdy22oWmCRdRwA0D4/Z3/UJYY6TFgHL1cX1HokepWpt6JdXxXQ
	ueVnIP9Ybs+v+KNw3R5uohh
X-Received: by 2002:a05:6a21:e081:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3da39b4390cmr22662653637.4.1788658168307;
        Sat, 05 Sep 2026 18:29:28 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm17456853eec.19.2026.09.05.18.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 18:29:28 -0700 (PDT)
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
Subject: [PATCH v6 2/2] fuse: deduplicate the oversized-request error selection
Date: Sat,  5 Sep 2026 18:29:23 -0700
Message-ID: <20260906012924.1928316-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906012924.1928316-1-xmei5@asu.edu>
References: <20260906012924.1928316-1-xmei5@asu.edu>
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

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v4: introduce fuse_req_too_large_error as a helper
v5: add the explaining comment Joanne suggested; add her Reviewed-by
v6: rebase on fuse.git#for-next; no functional change.  Dropped the
    Reviewed-by tag.

 fs/fuse/dev.c        |  5 +----
 fs/fuse/dev_uring.c  |  2 +-
 fs/fuse/fuse_dev_i.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..9fa90a48357a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1613,10 +1613,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
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
index 981b7c295e5e..197d277023a5 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -898,7 +898,7 @@ static int fuse_uring_args_to_ring(struct fuse_req *req,
 
 	if (copy_size > ent->payload.iov_len) {
 		fuse_copy_finish(&cs);
-		return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+		return fuse_req_too_large_error(args);
 	}
 
 	/* copy the payload */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 4b412a76225f..5435ee069b4c 100644
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
@@ -367,6 +369,16 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	return fud;
 }
 
+/*
+ * A request that does not fit the server's buffer is rejected with -EIO.
+ * SETXATTR is special, since it may contain too large data, and is
+ * rejected with -E2BIG like the VFS setxattr path.
+ */
+static inline int fuse_req_too_large_error(struct fuse_args *args)
+{
+	return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+}
+
 void fuse_iqueue_init(struct fuse_iqueue *fiq, const struct fuse_iqueue_ops *ops, void *priv);
 
 struct fuse_dev *fuse_get_dev(struct file *file);
-- 
2.43.0

