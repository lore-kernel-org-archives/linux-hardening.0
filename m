Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07599241CA6;
	Mon, 24 Feb 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391129; cv=none; b=qIG7AI5gDE7jtAZN9+Tm/VMkhR5UYCIsZG0njnajUGMRAQvUrmyVr7GEjZeshKDFFBTgXbkHhMS9tUaLyxz46K6FpieRdDG9mrBaasSXadbK5YDwfZCD8Dp1KEXtLrvNRScUwmHgr5XcM9k38hhZ4OQIDogfvGRcB9fOluSFWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391129; c=relaxed/simple;
	bh=ZjDnXrksprqcdBpDIG/amfeXKgB6c4lJruai5qe5AhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRezzpmoXdHAjcx5ptw32YSazg4kDJ0ZZ8GzFMwNqKjkYeaAw7BNnepEuGjxr+a+7KqNYdIor2KycJDuqcWke6ICuNTWk7c/aaVPLx5LUapAbf5ZfXeGN0R9qcH/Rb6P2/MLT7uPudfLhaRlDzOJ5dbTGa0Nw6g+O55MPLQvZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO1llj0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO1llj0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C03C4CED6;
	Mon, 24 Feb 2025 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740391128;
	bh=ZjDnXrksprqcdBpDIG/amfeXKgB6c4lJruai5qe5AhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PO1llj0k12h5/Jb8CQuV57BkdgYfH/eqbVrzvtMdBv4G6bGDgxunu7xzsOu2NcAHI
	 PlCedtu+UkUKI2UZXTaIRl0ltFlFDeBPxRC83CzYSEPFqd9bp3ovwjLYLSljJxTagn
	 oQMHZa4qstKk4u3mvru+7XQSTjUiTQk13D5PzzBJChsWn2qBBphPqTK7QToFd0sa+8
	 1ke1OxIH4CQChKZDNFzuPV765Og8okFL3psFARQzGAGcWXX7OWRgBsLkFUxf0X+hBS
	 nkPPO3ctYZmqfgdFMDw2V+50D0ky4xivMPA1a1rP4V7OeKV3G3ikmsJPkHkS3frsB8
	 HeGzCJ72wsshw==
Date: Mon, 24 Feb 2025 20:28:43 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/8][next] erofs: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <334f60e884cc0314ef98731e60a1b419e462e2d2.1739957534.git.gustavoars@kernel.org>
References: <cover.1739957534.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739957534.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct member currently causing trouble from
`struct bio` to `struct bio_hdr`.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure `struct bio`, through which we can access the
flexible-array member in it, if necessary.

With these changes fix the following warnings:
fs/erofs/fileio.c:10:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/erofs/fscache.c:179:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/erofs/fileio.c  | 25 +++++++++++++++----------
 fs/erofs/fscache.c | 13 +++++++------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 0ffd1c63beeb..3080963caf78 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -7,7 +7,7 @@
 
 struct erofs_fileio_rq {
 	struct bio_vec bvecs[16];
-	struct bio bio;
+	struct bio_hdr bio;
 	struct kiocb iocb;
 	struct super_block *sb;
 };
@@ -26,20 +26,21 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 	if (ret > 0) {
 		if (ret != rq->bio.bi_iter.bi_size) {
-			bio_advance(&rq->bio, ret);
-			zero_fill_bio(&rq->bio);
+			bio_advance(container_of(&rq->bio, struct bio, __hdr),
+				    ret);
+			zero_fill_bio(container_of(&rq->bio, struct bio, __hdr));
 		}
 		ret = 0;
 	}
 	if (rq->bio.bi_end_io) {
-		rq->bio.bi_end_io(&rq->bio);
+		rq->bio.bi_end_io(container_of(&rq->bio, struct bio, __hdr));
 	} else {
-		bio_for_each_folio_all(fi, &rq->bio) {
+		bio_for_each_folio_all(fi, container_of(&rq->bio, struct bio, __hdr)) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
 			erofs_onlinefolio_end(fi.folio, ret);
 		}
 	}
-	bio_uninit(&rq->bio);
+	bio_uninit(container_of(&rq->bio, struct bio, __hdr));
 	kfree(rq);
 }
 
@@ -68,7 +69,8 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	struct erofs_fileio_rq *rq = kzalloc(sizeof(*rq),
 					     GFP_KERNEL | __GFP_NOFAIL);
 
-	bio_init(&rq->bio, NULL, rq->bvecs, ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
+	bio_init(container_of(&rq->bio, struct bio, __hdr), NULL, rq->bvecs,
+		 ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
 	rq->sb = mdev->m_sb;
 	return rq;
@@ -76,12 +78,13 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 
 struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
 {
-	return &erofs_fileio_rq_alloc(mdev)->bio;
+	return container_of(&erofs_fileio_rq_alloc(mdev)->bio, struct bio, __hdr);
 }
 
 void erofs_fileio_submit_bio(struct bio *bio)
 {
-	return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
+	return erofs_fileio_rq_submit(container_of(&bio->__hdr,
+						   struct erofs_fileio_rq,
 						   bio));
 }
 
@@ -150,7 +153,9 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 			}
 			if (!attached++)
 				erofs_onlinefolio_split(folio);
-			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
+			if (!bio_add_folio(container_of(&io->rq->bio,
+							struct bio, __hdr),
+					   folio, len, cur))
 				goto io_retry;
 			io->dev.m_pa += len;
 		}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce3d8737df85..719ec96c8f22 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -176,7 +176,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 
 struct erofs_fscache_bio {
 	struct erofs_fscache_io io;
-	struct bio bio;		/* w/o bdev to share bio_add_page/endio() */
+	struct bio_hdr bio;	/* w/o bdev to share bio_add_page/endio() */
 	struct bio_vec bvecs[BIO_MAX_VECS];
 };
 
@@ -187,7 +187,7 @@ static void erofs_fscache_bio_endio(void *priv,
 
 	if (IS_ERR_VALUE(transferred_or_error))
 		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
-	io->bio.bi_end_io(&io->bio);
+	io->bio.bi_end_io(container_of(&io->bio, struct bio, __hdr));
 	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
 	erofs_fscache_io_put(&io->io);
 }
@@ -197,17 +197,18 @@ struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
 	struct erofs_fscache_bio *io;
 
 	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
-	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
+	bio_init(container_of(&io->bio, struct bio, __hdr), NULL, io->bvecs,
+		 BIO_MAX_VECS, REQ_OP_READ);
 	io->io.private = mdev->m_dif->fscache->cookie;
 	io->io.end_io = erofs_fscache_bio_endio;
 	refcount_set(&io->io.ref, 1);
-	return &io->bio;
+	return container_of(&io->bio, struct bio, __hdr);
 }
 
 void erofs_fscache_submit_bio(struct bio *bio)
 {
-	struct erofs_fscache_bio *io = container_of(bio,
-			struct erofs_fscache_bio, bio);
+	struct erofs_fscache_bio *io =
+		container_of(&bio->__hdr, struct erofs_fscache_bio, bio);
 	int ret;
 
 	iov_iter_bvec(&io->io.iter, ITER_DEST, io->bvecs, bio->bi_vcnt,
-- 
2.43.0

