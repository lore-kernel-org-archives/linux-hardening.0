Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9A1C8606;
	Sat, 26 Apr 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648645; cv=none; b=hAWOYk3rZXej+21DiB9gYTyHvTiRs/5RdEAQq5axiN/Xu298krJU6usem/jgTwk5aIYA/8ABkixaBZWRzXxJ97DNtm0zdS9PLpgeOwq1l8YwoYnEQgXD6TVxXmDIHOKMLiwOp3dPhxlbeykAEsLV6x/ljK/gho6ois8EbJYw6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648645; c=relaxed/simple;
	bh=yez/cfhVZ1vJtH4ueunCt4/6+v7Qxj9PSi9szUEY0Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCfixHU7wApAqYae0PELppE9ZFVeIIjKL5kCiH6T7fV6U2fkm7gtKXtN9EK16UQ5cOJpjBiB27+gT43v7m3ONbqRVHTsyQGhlfYnIwdlr2Pl7q5BH0L8/lid6ZAD8ZQYlYiunyd0whfhTI/NpV9r3PJ/HXFSMbi7hy2sjpIznrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3BYUhDJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3BYUhDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97FDC4CEE2;
	Sat, 26 Apr 2025 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648644;
	bh=yez/cfhVZ1vJtH4ueunCt4/6+v7Qxj9PSi9szUEY0Rs=;
	h=From:To:Cc:Subject:Date:From;
	b=l3BYUhDJhzTJqpqal/6ebfjqJ+65JZc5XV9uOqv9MWsfC8OkbkKZjTS0wKv8qjcab
	 wFQr6mtORgu5ZnF3xjqQuJtavTpMMItqemkq2fgLt+xCJoELgYXYgrBI6jrPjz236z
	 jX3Gc1BgLc/F4lkQzs3Sw1uBVnVnzDckSZ4ryr9HVr2NxHwdP9rudIWfNYHdDG89t8
	 mSzsjA3bBu2GVhxsAgsP1Hk/52GCElRKeNUVVAfYmds/ntFj9VGEUzD8se8ok2nY8n
	 ZUozJoJPTxiu7WTjyxItj0FSd5oQGx2qxGw6VUsD3z9qEm+u5Qh9dusGHblMEQjJR7
	 Yvc1+yzKE6glQ==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] module/decompress: Adjust module_extend_max_pages() allocation type
Date: Fri, 25 Apr 2025 23:24:00 -0700
Message-Id: <20250426062359.work.358-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=kees@kernel.org; h=from:subject:message-id; bh=yez/cfhVZ1vJtH4ueunCt4/6+v7Qxj9PSi9szUEY0Rs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8NQzcZ54JMRQ7LH7/O7Op4JvAE++PF5Jf+4uIfbt5+ Jycb/LzjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkcjmBkWGpc/2Txy2lclxIk rzROyZq6Qe7oypTNtoH3lFTWG5lVCTEyfHS8fKo5uHqi3CQBddbtj0NLp+ZuD3y51iuvolvU7Kg kJwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct page **" but the returned type will be
"struct page ***". These have the same allocation size (pointer size), but
the types don't match. Adjust the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: <linux-modules@vger.kernel.org>
---
 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 474e68f0f063..bbb2a55568cd 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -19,7 +19,7 @@ static int module_extend_max_pages(struct load_info *info, unsigned int extent)
 	struct page **new_pages;
 
 	new_pages = kvmalloc_array(info->max_pages + extent,
-				   sizeof(info->pages), GFP_KERNEL);
+				   sizeof(*new_pages), GFP_KERNEL);
 	if (!new_pages)
 		return -ENOMEM;
 
-- 
2.34.1

