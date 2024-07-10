Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF72CA5;
	Wed, 10 Jul 2024 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570390; cv=none; b=XGf/nD+uW4zABujyX5hEYqUux3VCxWwZ/TU2Ub+5LqnNv5mZ5KNFYM9nfU2u7rRfqD+ZXQNXSLyaFWsEcf08vA5KYHNiRwwpkuaEPeH58B6tp7TdyX48CyiJvg72RkjVDuJk+GhJ4RBusesyQKg34NaKJwjPX9dcNUOXkY0aPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570390; c=relaxed/simple;
	bh=hH6XjJwh6V5T6DG7L0RoEforFSSEUVc2U+XkuNZxBNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qv62RZ91b+/N7NIALdkAnXG1Lk/bL9TNz4bs7FtOJMPigbYPnX1G4M/dQ8ot4cMegP2QyT7/CTVM80Gsze8RoFo6cJ47L+7oDAHVE3H80LfHl7BL40xpgH5hmGTzwWvyAii8kk/qUNLMr6YKzzjDcAtYl/0XWk/nlIl5kchrBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icHRJ8B0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icHRJ8B0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCC3C3277B;
	Wed, 10 Jul 2024 00:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720570389;
	bh=hH6XjJwh6V5T6DG7L0RoEforFSSEUVc2U+XkuNZxBNE=;
	h=From:To:Cc:Subject:Date:From;
	b=icHRJ8B0eDG1Qx8r/n3MURe/rvL4idQyb6BGWWs/sO4Jg5Y51b+mldfvf7Z7lGL8s
	 RekzE5wmoMzjHzw6cibrKx49F9Y9dJpdnD/h/xl4tQ/8qnDUhIEJJ1qzE8QFAhWQum
	 kjetS56rHjDPBx1egrKvrm8jY/rgM7VgU4a7yR8dJdUO+xuedI3x+Rd2i3KVaiZFEs
	 w1NQzZLibrCX0NogCxW3EESNz3Lm/W12j+7L6UYkfiJpBWpe9ibNlOUx99qDG71i54
	 7xIVpAgFW8EJrEmLppexjOC9tQq6Nkq1W1rPKGCNTYezFS9wwNx7yEGYdHPld7Cdp+
	 zVJcilc4Lxu6A==
From: Kees Cook <kees@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm/kmemleak: Replace strncpy() with strscpy()
Date: Tue,  9 Jul 2024 17:13:08 -0700
Message-Id: <20240710001300.work.004-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=kees@kernel.org; h=from:subject:message-id; bh=hH6XjJwh6V5T6DG7L0RoEforFSSEUVc2U+XkuNZxBNE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjdITQN4XGi2gMp0xUR/LaBXup1y35hiihuVMJ 0WIjbRi1FGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo3SEwAKCRCJcvTf3G3A JlRiD/9yskQJyvP7pOcththEpmK24+FXaILTCqWmbqZgjvaF2/vGJO6zo74E5dBy1rTLJwRNJET UEEke92ESGPIy/VGTuFrSrbsUqqwP+uwq7RK/hde0EwXFQAYnvHeIu2tyl9Z5ZEtp3N3oTYUAY+ 6ui4VWM0EYrasSssRaGuCxawfBCt/YsGj9lGi644Hf2X/rz8HcE8DUWSYhEU+q4hgo04m6lxC/o InBKlWGH0lmcJdnlGO3zMAQjkxhmROVUzUHVSdkIVSIaGgewAjgafPR+XGIf9HCvKl5ZSRDGRAZ b2WZKknsgRrjdRAqlhBkC+W+MOHXm82Ue5JeMNhvYHc3ydvFInBWiOo0Q5ST9T0upsAlB1woe9g ypnHKWU0bGWqj35Gd2pBGrmEFurtoOIkQuZSseXdU7E3R/YNSTu7iHLnu4YDpbKuYxsivtso2po cimMrWcHZ8b2izLOHeVu7AllZagdP8PIny9J+m4urxt+ec6YUl6MRTFEg0xgGxxRbmVzpMrCy5G 2YSVeYTNBKVaVndVRcEdnUGRBw5HTZcgLjCLGV+Vn5DMAyAYxusnDkfjzHRMhZUPwov6YmjKA03 eYleQ+a12Aop6lsd5vVoD2JlUbtw8AYabkFiTj4ISXIh2ANXHvo4kM1AYeBM0rdvOYI6mez3/ph TU6iGeSfeAMoa
 3A==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the depreciated[1] strncpy() calls with strscpy(). Uses of
object->comm do not depend on the padding side-effect.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/kmemleak.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d5b6fba44fc9..764b08100570 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -657,10 +657,10 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 	/* task information */
 	if (in_hardirq()) {
 		object->pid = 0;
-		strncpy(object->comm, "hardirq", sizeof(object->comm));
+		strscpy(object->comm, "hardirq");
 	} else if (in_serving_softirq()) {
 		object->pid = 0;
-		strncpy(object->comm, "softirq", sizeof(object->comm));
+		strscpy(object->comm, "softirq");
 	} else {
 		object->pid = current->pid;
 		/*
@@ -669,7 +669,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 		 * dependency issues with current->alloc_lock. In the worst
 		 * case, the command line is not correct.
 		 */
-		strncpy(object->comm, current->comm, sizeof(object->comm));
+		strscpy(object->comm, current->comm);
 	}
 
 	/* kernel backtrace */
-- 
2.34.1

