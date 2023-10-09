Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80051F93E
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEZGlqku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46609C433C8;
	Mon,  9 Oct 2023 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696884298;
	bh=xqPPlteo+/irwg1A8Nmsg7I8TpquWpmsFmUvKGKyQHo=;
	h=Date:From:To:Cc:Subject:From;
	b=ZEZGlqkuZvJF2yg5oonzytBzx9hYOgBwyLTgVN0/S7cA1HKqyN7f84BevW/PYUGjZ
	 jm+fg16/Eoqtk5lixQKPZ1rb3J4iK1kAHnHvdi6G8QezxsgYveuaxfWqx9OwnvqiYI
	 aQGXJ8B+DRU9+0zi2Aa/G//zaR+6hzBdIZbsqevBzeBgCWE4h56/16MJHw8z5LqO4X
	 QdyEhvT8Fg/n9I4q5cLU0fSwzw6sJPWRc+vpRkqjLl1uZlLzMwCibT1ZPvklAcmTsi
	 D+u7jNb0ZgmaruYQcPbHlVcReX40dDp2VQhJFJZ5dRN47OZdKB7m6AVVbOvRw5shLm
	 qKhW28wJqYPSQ==
Date: Mon, 9 Oct 2023 14:44:54 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] btrfs: Add __counted_by for struct btrfs_delayed_item
 and use struct_size()
Message-ID: <ZSRmRj7leOsdUmJm@work>
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
 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/delayed-inode.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 35d7616615c1..4f364e242341 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -313,7 +313,7 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
 {
 	struct btrfs_delayed_item *item;
 
-	item = kmalloc(sizeof(*item) + data_len, GFP_NOFS);
+	item = kmalloc(struct_size(item, data, data_len), GFP_NOFS);
 	if (item) {
 		item->data_len = data_len;
 		item->type = type;
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index d050e572c7f9..5cceb31bbd16 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -95,7 +95,7 @@ struct btrfs_delayed_item {
 	bool logged;
 	/* The maximum leaf size is 64K, so u16 is more than enough. */
 	u16 data_len;
-	char data[];
+	char data[] __counted_by(data_len);
 };
 
 static inline void btrfs_init_delayed_root(
-- 
2.34.1

