Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869B25F7AD;
	Wed, 23 Apr 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375873; cv=none; b=EeSrC7TKP4uafl0WpZWb7T4FM+gRJk8/dDbH6Dcz0xpc5EFk+BgWdNafRxQUSMU0IXjFRTYSJq9V1itl4CkZ09T7Fw7y1Cc+1tACQ/yo83UQKUm68OMjeKue9wCUMCUNuXc6KyBycLPmdm1ycZRgOs9JCl9oKFWj/TBdfQfl9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375873; c=relaxed/simple;
	bh=PI0TRCaYpM1s692ZlvDtK0ScW8lDaLDSxH9CQpk5K1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXi7NDEtbclXAEDt65f7VivyEQq1C6RseoFZ73eQePy2bKowfCJQc6dvplFeybIhc8d24hYfqp7Efgj3w1RuMKUmEPu9INtkUv8hSZoQxmRs4aMlGU5OLUyDOH1pxkL84r6QzFtifPw3G9mg3ohbT3hwH2KLciN1578MzKSfj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2xNEtGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2xNEtGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132E2C4CEE9;
	Wed, 23 Apr 2025 02:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745375873;
	bh=PI0TRCaYpM1s692ZlvDtK0ScW8lDaLDSxH9CQpk5K1Q=;
	h=From:To:Cc:Subject:Date:From;
	b=V2xNEtGWF9hvwtDdGNIio0gDYFM90HshyGdAMOmIqJ5X6O66UNKUuu04tb9PBEDH9
	 q6FuE4Sfm+L3eCjh+pALQBwfOjMpdhCoQFLr86BjWfMJoGhJgd6WQIKsTM+HDI/uIM
	 zpgnSRiq8zbNlO6GZZlIrDDK7tkiZZJGy42U5qew6HHdz5iKaFeuIxQ+LXP5LG2VBr
	 l5KC0/c7a6eWs/+ee8XeHWbT7gLpmHjBWs9AAlp1sIor9bb1uy0S2b9whV4EjUMjBV
	 k6TAC0EvGP8JnAD414l0QX7HR8ofXc6IvgUq5uk8kGkOm+BJCcQSz6h+FKg1qVRytY
	 1yueKmJF29Jgw==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alejandro Colomar <alx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] EISA: Move devlist.h out of obj to always
Date: Tue, 22 Apr 2025 19:37:47 -0700
Message-Id: <20250423023743.work.350-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=kees@kernel.org; h=from:subject:message-id; bh=PI0TRCaYpM1s692ZlvDtK0ScW8lDaLDSxH9CQpk5K1Q=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkcQdVWT1tuPOJd7VKiajnRrfxx+JQzHOyTpggvivsvY 3JsjSdzRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESS9zEyLGSaorfLRfZpjr2r wKyH5Y6X2K5F6rY8/ml9JF5UJyR/AsN/F2uv7KK56Ys/nH8mxmy0SKbhcEiUjM28T8wVz4/zCZU yAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

I put devlist.h into the wrong Makefile macro ("obj") to get it included
in "targets". Put it into "always" so nothing tries to link against it.
Solves CONFIG_EISA=y i386 build failure:

ld: vmlinux.a: member drivers/eisa/devlist.h in archive is not an object

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/4a8ba1d0-d2d9-41f8-abf1-d45ec8996d10@infradead.org
Fixes: dd09eb0e2cc4 ("EISA: Increase length of device names")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alejandro Colomar <alx@kernel.org>
---
 drivers/eisa/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
index f0d6cf7d1f32..552bd9478340 100644
--- a/drivers/eisa/Makefile
+++ b/drivers/eisa/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for the Linux device tree
 
-obj-$(CONFIG_EISA)	        += devlist.h eisa-bus.o
+always-$(CONFIG_EISA)		+= devlist.h
+obj-$(CONFIG_EISA)	        += eisa-bus.o
 obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
 
 # virtual_root.o should be the last EISA root device to initialize,
-- 
2.34.1

