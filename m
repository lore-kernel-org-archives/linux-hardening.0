Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AA188735;
	Fri, 16 Jan 2026 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524996; cv=none; b=G8D6tWiyuCMwA7hzLqrClsm5HD8YzwQuoYfTV3D2mLiLoZHO3JyWGCzzDN4DLILdBlx7tianldogEtzfnvyYUFNKX1Ubgeo/I/rLlddQyFH5BpJkFsAoNPTc9xS54AHqZSbekwJB1SDsnpfvoClUr2nRUZlnTS0VTfwf4bWLps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524996; c=relaxed/simple;
	bh=mYox5MYpkOddmossMivdO5FmTxbPtTyeWN9spmG5Hr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UseTV+QOloW6JkejROh0A1RBtLVU8tPpasiF4Ro0/Eyc/K/6nbVRlvN8haTyOqDeMFdxoPhM2raS+UpzlnZvfSzviU+gVojZ+5wzKNpnCIrKMsII9U4h2osOrT+CfuPxS3xyjzgxfBB3Q7/Njgo+3ME/m75JGq+bNLB0ctBBt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+JRnoKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+JRnoKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E4C116D0;
	Fri, 16 Jan 2026 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768524996;
	bh=mYox5MYpkOddmossMivdO5FmTxbPtTyeWN9spmG5Hr4=;
	h=From:To:Cc:Subject:Date:From;
	b=G+JRnoKN9iAIOb3d+CF3ntkwoG9QgdBVcCsh9WpLVMQOIgvNDGPcBmLET2DwlcBG5
	 k04UJurWHMsU+8crOpbzzPNh1E9Y5gQNd8yHHsSiUmy1cOGif4K70dLNG5VJcV4ktQ
	 zuaiDg6R0hYtvw3I6JAM7ME41O20Ix28em+sB/knN4u+DfyQKAum7G3uP+okgodrvA
	 27TbzWg3K84BaRJrBTRIEOFTfWtT6BrIqd/FzSpJS12H2kFrjf6z5pJzns2ZBqq4DS
	 2eGf9DCbzCggtWoinruRb7HuKGrWgHkhv/DB5XgrhaJRQD2yIJg6P6GcLdsGs5ugKp
	 iICHkKHGkXKtQ==
From: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: pstore: Remove L: entry
Date: Thu, 15 Jan 2026 16:56:32 -0800
Message-Id: <20260116005631.work.387-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=kees@kernel.org; h=from:subject:message-id; bh=mYox5MYpkOddmossMivdO5FmTxbPtTyeWN9spmG5Hr4=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmZPfv15hpr9CVnaFoEZPFdErfbPeEjn8KVk7P/THa7l fzI9c+jjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImUZzL8UzSxkzHTWjYhdZ7e 2iCp+U+uPLlYEnpIQqr8Xe+lju05bQz/yy1ku1cctHTwcZM8oH5JbrmdplZt693dxwvkSwUaf9x lBgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

A lot of SoC series end up getting CCed to the hardening list due to
their mention of "pstore" in device tree or similar, and this noise isn't
worth making sure I don't lose pstore patches by having them show up in
the hardening patchwork. ;) I can use better email filters instead!

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Tony Luck <tony.luck@intel.com>
Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc731d37c8fe..02c2cb7accb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20961,7 +20961,6 @@ PSTORE FILESYSTEM
 M:	Kees Cook <kees@kernel.org>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Guilherme G. Piccoli <gpiccoli@igalia.com>
-L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
 F:	Documentation/admin-guide/pstore-blk.rst
-- 
2.34.1

