Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CF3A2549
	for <linux-hardening@vger.kernel.org>; Thu,  9 Jul 2026 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631505; cv=none; b=ik8lJYQyE5u+y4ep/XrAFvhv+hsay/Bx31rrLqwg7WIywO0LseneCduJm4ZP7AvnxWyVRvLxyjwhKHkW2+eVSjz5576SetIOB5g3HPd1FG+1we9SNZtPUtC11xVr6PFiYoH6npp0D2Sz01dklWWY/RbfYHld+A+wGcfer/3bE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631505; c=relaxed/simple;
	bh=cQ7SfsCPBk6po4hsOzuVpl5ch8aa2mbSnyBmfFdzkF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU0CnN8/7RBqXC+rO95EcjApJMeic6/7XJWSweOCCf80N6El9pD8YQ3Bj/X/dHrz1rQUMfouLJozr9HaG0JQRSa4nWFAKv9bfy78Jn27lWMHDv+9Wd86j9cFPODruCE4GWgzvHV6UnwLoVtS2vudhGW3BIyCJQiSzSsqWDC4lvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Ly9YZz1w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Ly9YZz1w"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso3552685ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783631502; x=1784236302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuZ6nx+Txu/mNC6yFRWP8UoCFiju+bZ/Q1rNWL00OYI=;
        b=Ly9YZz1w1E7rN+P25qUcYG0GytoXPbex606SGW6dUAbzOJgXZgaXcTnwgjcaSdeNSz
         m5K+STheH/8MSRuZN7wMv6/EI5E7xhRhPU5ef40g4Hdmd2S6s55pZpDbbOzlzEjzJYWm
         5fn9ipZj/Ob0TzCUTiY7hcEM7NyPQdxG8iH28vDHqckifqtfm5kWK7qMnKaXO6sVPZNl
         E3jRA2IsK9retn2duMGlWvFW6jcsFUaXSfcH3dK1XmTcS4+zb7KXWK2ycLKh3ye2FKUd
         Ll6eis26KQW840ymEx0N8R1S18DZwJ1Zbn4Uhi9y/mmIizB4eb1uzWMlyidXxBsw2poX
         /tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631502; x=1784236302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuZ6nx+Txu/mNC6yFRWP8UoCFiju+bZ/Q1rNWL00OYI=;
        b=hVoxe2biGFHsDcXVUfT3Wh9giXLwdFUN2JXTV9Kn9tlDgdyam6euEif32knkAFVeS9
         i4EC4qEHVoB07C4+lOfjr0HMg4QWRN1XtLUOz07j2To/C2qfuyaFn+82iPIy9MdQCv35
         Qs0RgZIbEO3QRLxFdA+V3dP1DWQc/mllAh3EhsUbJawR2+TJ2oFJAJtSe6gWjVlF7kTD
         0XstMNKEcI62jCZuhcqml5u4PVcgNCeQdSb0lfoRhht7VGbIwzx3n9AGzmASGYsXvYlP
         5DfRtkJfxvtgVk7BaUQ5jYK+5Y271yU8TdFe84GS3o7T1joVUXHTj8AVWW5dm7ikhueZ
         Dqew==
X-Forwarded-Encrypted: i=1; AHgh+Rr1FswZHv7xlmt4+MaTlPSGgNaB4DjElF+fsQAkW85sddR2+VMNLcIAM+6z0kgNoxFnjd1trkrYa2kNtD4RS8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkK2Xnh7FIT/kmWNBu2dDMoGw/q4ejY2281zpnrwLc7+0HYgMx
	HX653y2kvhC2BUXqZAtr7hfR/mDj+jgKoOk2jZS1mdcWWB+RvIecrsCzkDR+MN6RWw==
X-Gm-Gg: AfdE7cmUZhK316TJRGeZWMNtOqzqwpWZnzW50YMBIH8iEft3n0sZeKIXJ/RQN2B+pZH
	wRkaz0jxXJvgk82J8F9h9hvU7/pJ4RlcDvCi/egy4/hKot/9B+qRkIzM0s/OVRMDVlTdoK0QOCA
	Gr8XCx+XFkZ569VBG2svydT7cZIsjyfEnF0gLgDUZnb65xMEtHhId9vhM9pots0XmOFrH1bMtY4
	VlEP8fDhSQqpY+VLAlADJZhDRyriG4XjIuHaE3zO5iYO52WnMYyT/qPZ8CdQf5/fxB+q01e3Kj/
	o7aE5rtyPE8iUBbNPBzbWnMkuqv1opKdHej1hQ77OapWPg+5Gu1S7WqgtIbWNco537TvPAqAOuZ
	Cw8ByHOlV8+b4vANxPkmqaNgPL4UIF06OQSw5DwF+JgSRrLR5C82rxBb4Tt2CdpZBa038kbpO
X-Received: by 2002:a17:903:22c5:b0:2cc:ac15:ff4c with SMTP id d9443c01a7336-2ce82879e00mr8739265ad.8.1783631501746;
        Thu, 09 Jul 2026 14:11:41 -0700 (PDT)
Received: from p1.. ([2607:fb91:150f:dd4:6d78:821f:ff11:b509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm49742475ad.78.2026.07.09.14.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:11:41 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
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
Subject: [PATCH v3 2/2] fuse: bound io-uring payload copies to the registered buffer size
Date: Thu,  9 Jul 2026 14:11:30 -0700
Message-ID: <20260709211130.543773-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709211130.543773-1-xmei5@asu.edu>
References: <20260709211130.543773-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fuse-io-uring transport imports each ring entry's payload buffer at
ring->max_payload_sz and bounds both copy directions against that value,
ignoring the buffer length the server actually registered.  Both the
server-supplied reply payload_sz (fuse_uring_copy_from_ring) and an
oversized request payload such as a large FUSE_SETXATTR value
(fuse_uring_args_to_ring) can then overrun the imported iterator and hit
fuse_copy_fill()'s BUG_ON(!err):

  kernel BUG at fs/fuse/dev.c:1053!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1022)
  Call Trace:
   fuse_copy_args (fs/fuse/dev.c:1329 fs/fuse/dev.c:1351)
   fuse_uring_copy_from_ring (fs/fuse/dev_uring.c:686)
   fuse_uring_cmd (fs/fuse/dev_uring.c:1226)
   io_uring_cmd (io_uring/uring_cmd.c:271)
   __io_issue_sqe (io_uring/io_uring.c:1395)
   io_issue_sqe (io_uring/io_uring.c:1418)
   io_submit_sqes (io_uring/io_uring.c:1649 io_uring/io_uring.c:1934 io_uring/io_uring.c:2057)
   __do_sys_io_uring_enter (io_uring/io_uring.c:2646)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

The request path overruns the same way, via fuse_copy_args() ->
fuse_uring_args_to_ring().

Store the registered payload length (payload->iov_len) in the ring entry
and use it for the import and both bounds checks, so the buffer the
server provided is honoured and an oversized reply/request is rejected
(-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
fuse_dev_do_read()) instead of panicking.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v3: propose the patch fixing another issue found by Bernd by Joanne suggested way

 fs/fuse/dev_uring.c   | 9 ++++++++-
 fs/fuse/dev_uring_i.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 0814681eb04b..248e5a3e340e 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -650,7 +650,7 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 {
 	int err;
 
-	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
+	err = import_ubuf(dir, ent->payload, ent->payload_sz, iter);
 	if (err) {
 		pr_info_ratelimited("fuse: Import of user buffer failed\n");
 		return err;
@@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
+	if (ring_in_out.payload_sz > ent->payload_sz)
+		return -EINVAL;
+
 	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
 	if (err)
 		return err;
@@ -725,6 +728,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		num_args--;
 	}
 
+	if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->payload_sz)
+		return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+
 	/* copy the payload */
 	err = fuse_copy_args(&cs, num_args, args->in_pages,
 			     (struct fuse_arg *)in_args, 0);
@@ -1163,6 +1169,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	ent->queue = queue;
 	ent->headers = headers->iov_base;
 	ent->payload = payload->iov_base;
+	ent->payload_sz = payload->iov_len;
 
 	atomic_inc(&ring->queue_refs);
 	return ent;
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 55f8d04e4b0b..efa7f034496a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -41,6 +41,7 @@ struct fuse_ring_ent {
 	/* userspace buffer */
 	struct fuse_uring_req_header __user *headers;
 	void __user *payload;
+	size_t payload_sz;
 
 	/* the ring queue that owns the request */
 	struct fuse_ring_queue *queue;
-- 
2.43.0

