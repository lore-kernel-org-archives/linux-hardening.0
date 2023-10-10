Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABF179B7
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC0DHgjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4903C433C8;
	Tue, 10 Oct 2023 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696942018;
	bh=knh9lxB2dNgPZ1euXXn82WdFpZKIB9XIHk6ythKlouc=;
	h=Date:From:To:Cc:Subject:From;
	b=dC0DHgjw3VtLh8cQ3kYe/L78FbRWlOvMsX9oohjbkBB9XPOui28VOa9BETiUJRM3P
	 IOkj/tgMvv/GpKQIixGpE+CjJ49llPZWCwsfvJiNrr/uiAPFAhfjYbMHsmxpdYPPT5
	 +3iG8hKPjY7TnD8e3DGGjSMwKQ3D4q1zc/Y7YYwdhrGg9teqbSVEUaQL0a/IyXiRx3
	 Md2MYGD9nR7kNWd3XHcS9uiZsksC9Pt7SyreonpU/rWUruXeyZ4Jh+v3r38R99of+g
	 NaMR28hHJAHMgwyUGFfkhqJ+TiSSMvGVT8eRzyRyr/tdgSOcwqCU6uIuRY5Xyt06se
	 jUMWz6hDK4JUg==
Date: Tue, 10 Oct 2023 06:46:50 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] atags_proc: Add __counted_by for struct buffer and use
 struct_size()
Message-ID: <ZSVHurzo/4aFQcT3@work>
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
 arch/arm/kernel/atags_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 3ec2afe78423..cd09f8ab93e3 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -7,7 +7,7 @@
 
 struct buffer {
 	size_t size;
-	char data[];
+	char data[] __counted_by(size);
 };
 
 static ssize_t atags_read(struct file *file, char __user *buf,
@@ -54,7 +54,7 @@ static int __init init_atags_procfs(void)
 
 	WARN_ON(tag->hdr.tag != ATAG_NONE);
 
-	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
+	b = kmalloc(struct_size(b, data, size), GFP_KERNEL);
 	if (!b)
 		goto nomem;
 
-- 
2.34.1

