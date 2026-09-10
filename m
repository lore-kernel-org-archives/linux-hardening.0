Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632B3A8388
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084277; cv=none; b=Sm2qfmFfi234UcwBoPf+cddd/94sABK7NB4S0jvVW7QmmxxPkEONJ27ME0ApRhnnFS+qBO5XHqqASC4wQJ0pKuIuCRQhvxsyifOC5eoLfk6pCKpdTzYCm06cdGyEqED/rzMxpubfNY/vN8j0dvoPadLDpmmPv1dDQb3TxkjZPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084277; c=relaxed/simple;
	bh=+HaBGFIUyITYyskn9PZOlaHjJY051XZvXtogon38VX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnURZPlW/Z9l11FYa0m3Je7VdGzJ524hhqZbPfZzkrK/kZbtcHSxxuiQUIqaFgAedEVbOFzdrQDncyBmk9dcejKg3T6fZXQch0jrRuiFSzBmzP3L9iahAOoGCcieY3sljGvrZiUMxT+sWVZpiYP46aqT1ZN6TE5FX+G0MprlApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=I7426kkj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="I7426kkj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc891373e0so2829375ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789084273; x=1789689073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJf7neT2i6yO923W0Lg09fbYqghzTKmlCOt7Ys5/ve0=;
        b=I7426kkj5eLCdd16xhsBDkq2B7GjWZCwad/0JPUanNwdsoWwNqsvVsaP4CmDaB/tsB
         8ATWPeNttn1l1YgBtPuDxO+VCcXGJskG79yqv2ZkV78oOh4a8i27xbBbLenL8Z66Yhbf
         6yR72MGkN9krUEwGOR/ssRSrjVqEpK8M6tqvPHWpCtWiCCXUpuwG2JE9cYMcq1JUrmzm
         vpJqe1hezp0lhbGWuVHKOqt9TmESuW5in75r1iiO/BBOF/EFk0bacnxPePFUUJ41x/b0
         an7qkFQ0J81RnLFtaXDnjDulMEbN4Yj3XWiI9H102ve5CGDLqcFR0CFUtjgB8RbtBBXv
         O77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084273; x=1789689073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJf7neT2i6yO923W0Lg09fbYqghzTKmlCOt7Ys5/ve0=;
        b=k04LL1zHh8ilwzB/cekDCc+VOyc8tCiS3PUVfoBD5OFOGXB9QG7Xqg5sqBvYlxr4lK
         +TaK0+0ivmTej/uV5pMAn/Elv8DG/vUes0ccSiZtgd7Muw5BVssGy0rd3FbJrh9Sacaa
         OExPd47laktILMPJGgVtTUzS8NmSiH2pWFRAGSSESJTsPz83quYYzSXBQL9//MdP0GAl
         zkzHOfqFUBRXfR11Zt3eZ9sT5YFvuE+CmY2HwRKY3pakAWsDhRVhip3J0Mjc2Wfo+E5B
         efMydbmvMErZTEwrudWmic+HzjOBUgUxxHRUa9RXE2YDvsWokzu12G5VxvSkZM3L7D8+
         Ta7A==
X-Forwarded-Encrypted: i=1; AKwUvBwCpSB0CvASpU7OzDbRJfkZdZHkxizVbysJQjbheHpbh87Lu4g5/OYJU8bfe6CWZ8DtwJ0es6gIslN82iZg0UU=@vger.kernel.org
X-Gm-Message-State: AFuF++nk0PmpHFfh56EYTmINFmXRijn9WXxiEse97u2ZoX4OLnHlWTUu
	Cx2TIiKyq3S7lCB3QCnV0WE1eLaAL24qkpKolrZ3j/NFqTY8arlcNv1rOIpzgIDTgg==
X-Gm-Gg: AYBFou37NBl//AGy95wQI/s3ZS8MfAeafEPXvOKsMDlUMvgyGTCIyRN+A4zc+YKAMJL
	po13EQDoMWmvl/iPhJ8+QUjFqAUohWRflP4mChc8XgpVBuQSAG9f+MI+khFHrJZyhtV1JAtDMrh
	+UhADayqKOH9fAUkZKVEvP4zeCkPH1/JF6x3jpl77P6y/YbWx9yztc0o/iIU1O5hf7ZEINGFD9W
	LsCrqVuaFfk2MjsDnrX4+EThxAOPksKF6rZoAvAboK0Fo1kLHHPuj+btxV2lVjqpS4izGh5vmTC
	szSdTfdqWT3RgojFjTn/11EVWz05wfL8VfH6wyAZoe3/iVZUQGFGbT7E5zFrvY9bi98hWTE/H3G
	GdDIUJscp8+Nbg17rEvDx0A3k72nXbHySrp8xiCGOwGZqioNpq5P98sNHIVmkTEOh3enxvU4vEA
	+NVYqNgd7EKHaapSQ2gD6+g9rpmtKTvGOjhtIUHWiKqHiL0HenvkGKU1673S/RqcYWmri+14VMe
	UnIcUkfNdhnx9V1gHmU+o+s2DTbynPw2Y6qqw==
X-Received: by 2002:a17:90b:518f:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39d9c1bef27mr2132199a91.13.1789084273337;
        Thu, 10 Sep 2026 16:51:13 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm1680718c88.11.2026.09.10.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:51:12 -0700 (PDT)
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
Subject: [PATCH v8 1/2] fuse: don't BUG when the copy buffer is exhausted
Date: Thu, 10 Sep 2026 16:51:09 -0700
Message-ID: <20260910235110.3922068-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
runs out of pages.  Over io-uring the amount copied is not bounded by the
payload buffer the server registered, so an unprivileged user can drain
the iterator and panic the host - mount a FUSE filesystem with small
payload buffers, then setxattr() a larger value:

  kernel BUG at fs/fuse/dev.c:1064!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 148 Comm: exploit Not tainted 7.3.0-rc1 #2
  RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1033)
  Call Trace:
   <TASK>
   fuse_copy_args (fs/fuse/dev.c:1354 fs/fuse/dev.c:1380)
   fuse_uring_args_to_ring (fs/fuse/dev_uring.c:891)
   fuse_uring_prepare_send (fs/fuse/dev_uring.c:940 fs/fuse/dev_uring.c:1057)
   fuse_uring_send_in_task (fs/fuse/dev_uring.c:1745)
   tctx_task_work_run (io_uring/tw.c:96)
   tctx_task_work (io_uring/tw.c:133)
   task_work_run (kernel/task_work.c:233)
   io_run_task_work (io_uring/tw.h:84)
   io_cqring_wait (io_uring/wait.c:278)
   __do_sys_io_uring_enter (io_uring/io_uring.c:2676)
   do_syscall_64 (arch/x86/entry/syscall_64.c:61)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

The reply path can drain it the same way, via the server-supplied
payload_sz in fuse_uring_copy_from_ring().

Return -EIO instead.  All three fuse_copy_fill() callers already
propagate the error.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v7: fix the panic at its source, as Joanne suggested, instead of
    bounding the copies
v8: drop the "recoverable" claim from the changelog; add Reviewed-by

 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..4148e4488d77 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1061,7 +1061,8 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
 		if (err < 0)
 			return err;
-		BUG_ON(!err);
+		if (!err)
+			return -EIO;
 		cs->len = err;
 		cs->offset = off;
 		cs->pg = page;
-- 
2.43.0

