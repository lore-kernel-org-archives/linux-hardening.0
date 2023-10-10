Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA065208DF
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG2qWorU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73107C433C9;
	Tue, 10 Oct 2023 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696942801;
	bh=Xi+Z6sMFlQ/asWuwXVb1mQI8aYoKAasoVIf0fri5JUU=;
	h=Date:From:To:Cc:Subject:From;
	b=fG2qWorUWCfvQAcOdg2BtGbv9Ro/K0B2CpaODoS/VnH9d1Bet0rngO4Io+dDpjVP+
	 xWEeIBTjpNic9yaaI0woBajR4QdJvM7htlnYU95Xy+b+dWPiDRtOzdFoWFNbHGJmGX
	 jmTIBA72fAJPmxZmwZ6Nxx2gFhjRkcOaKLXGDedAo6tWBD/JxLZ0NR9aEkEjJX5HOw
	 pIa+ZKnY0cG2xrcPx6nOz/ZuRjwXweE0onrNwFHyXr/8Goo2WFFtFHdmdJFUnlP/2D
	 8EVzEEDBVdK45ixmVGgQvtNo5YFccXrQ0B3xmoUrBzrmyF7B225nBkSc8Pd2jaXkqA
	 Drz3Xk1UTpdiA==
Date: Tue, 10 Oct 2023 06:59:44 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] afs: Add __counted_by for struct afs_acl and use
 struct_size()
Message-ID: <ZSVKwBmxQ1amv47E@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/afs/internal.h | 2 +-
 fs/afs/xattr.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 469a717467a4..e263a58b82ba 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1116,7 +1116,7 @@ extern void afs_fs_inline_bulk_status(struct afs_operation *);
 
 struct afs_acl {
 	u32	size;
-	u8	data[];
+	u8	data[] __counted_by(size);
 };
 
 extern void afs_fs_fetch_acl(struct afs_operation *);
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 9048d8ccc715..8b42cac51660 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -75,7 +75,7 @@ static bool afs_make_acl(struct afs_operation *op,
 {
 	struct afs_acl *acl;
 
-	acl = kmalloc(sizeof(*acl) + size, GFP_KERNEL);
+	acl = kmalloc(struct_size(acl, data, size), GFP_KERNEL);
 	if (!acl) {
 		afs_op_nomem(op);
 		return false;
-- 
2.34.1

