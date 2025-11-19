Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53302DC77E;
	Wed, 19 Nov 2025 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592885; cv=none; b=qXsPD1abUj3ZYrOquBU+9jJhRCX+0YYFnT2K25cFR3DIdF/BTzuHYLEB+oLR5xA/2T4dGcui8DrM9CQlqscaDma4TeLnUR0msuY5QfXtg1hN5ILecMUY3DeTTUEI0odUgnIo1+piHPfuszrJl+Qzj+kKaH/xt9/MC3FtTpcNGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592885; c=relaxed/simple;
	bh=evRf10KLlkgghicnG+ujSW3Il6OzrjlVgGjTINYs7IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6dZGDJdHx7vmyaMoHIyUVQ55gY5Ib5AOqsuR8k7THYr2lgswj1Ui9rg+gwGX9r6u711CCAGZWCwROSWOJO2YHhNDXVsA8KEh1wnuAi13Wxdv0gLhVzHK6WlfkwmGcDR9wtw459iUm+gStIAWAv8wDeoufKNMIVLf114X4cCgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbVRDGgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbVRDGgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E0C4CEF5;
	Wed, 19 Nov 2025 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763592885;
	bh=evRf10KLlkgghicnG+ujSW3Il6OzrjlVgGjTINYs7IE=;
	h=From:To:Cc:Subject:Date:From;
	b=JbVRDGgo6trdW+Oy1Pe9AfUgKOQLUOqf6UtEomcbq4I37ghBVV5tiBHk5cNEny42s
	 AUQIc77HsaOlBaitldxEtQPlM/w8SPcZq8S0atHY3IpjCWyl+bxOACSkvqOjgSE8R6
	 edOVOkVuqdiIWhx9f80y5j+jI6ZHv1+mJjtkud38pfq3m8f5IcuH/CRgeIjd/v/Ydy
	 Zn+3JlRKAen7Y6GkL9oLIAQrFgjQkDCARGugcVo1OOh5D/eFQaEFyAPqfT9210FVWV
	 PqDxyBCQYwLZ6NzHYf1NKKopkR0F40jkzr0c/Os8la32hbCuxkSvoJp5WulY4nHG94
	 2iU46X2obOOxw==
From: Kees Cook <kees@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] module/decompress: Avoid open-coded kvrealloc()
Date: Wed, 19 Nov 2025 14:54:43 -0800
Message-Id: <20251119225439.work.741-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=kees@kernel.org; h=from:subject:message-id; bh=evRf10KLlkgghicnG+ujSW3Il6OzrjlVgGjTINYs7IE=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlyXpumVnfvffVkMe8EWZOL5qocLB+83G1vq24RnDxBr GPNqks8HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPR/sDI0PLbNKx5x5s7fz5o LrzUziNuJvhuZqPC8qdJqV829x1MuMzIsDT24lzOqQ6dQd0W+lZ6M+Q0XgZ1zV/lvGZGnu3PBp2 PHAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace open-coded allocate/copy with kvrealloc().

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: <linux-modules@vger.kernel.org>
---
 kernel/module/decompress.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 474e68f0f063..36f52a232a12 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -17,16 +17,16 @@
 static int module_extend_max_pages(struct load_info *info, unsigned int extent)
 {
 	struct page **new_pages;
+	unsigned int new_max = info->max_pages + extent;
 
-	new_pages = kvmalloc_array(info->max_pages + extent,
-				   sizeof(info->pages), GFP_KERNEL);
+	new_pages = kvrealloc(info->pages,
+			      size_mul(new_max, sizeof(*info->pages)),
+			      GFP_KERNEL);
 	if (!new_pages)
 		return -ENOMEM;
 
-	memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));
-	kvfree(info->pages);
 	info->pages = new_pages;
-	info->max_pages += extent;
+	info->max_pages = new_max;
 
 	return 0;
 }
-- 
2.34.1

