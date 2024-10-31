Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACE1CC16B;
	Thu, 31 Oct 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412541; cv=none; b=K0pgr3nHum7vbkCVzFNVD4k4yQuMF+lEQ74KzOwvH8y8u3+Ho6z4eyZlmAFOiuNEB7OnLSiu3Klwt0bCCShJk/IioV2ScC4gKGGlmj/BVHTeQcTk7y9+8Z/sYlG2eACIvx5JWTacz+LyH/Cmyd6EKG4IBnW10svGJvhHlRVD/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412541; c=relaxed/simple;
	bh=yutUsvb1FUVH5buEW0gYjKOsQp9qHQzY/jhDLgy2lXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkOxvEyjpUW5caJylNZ+Hdj4hPfo25ikH3c3W6n0IEgDBPG3nGMng3OLBKvbUObffuDiaJyleFnePFGbxCDkjWfcU40NUBWE3jNUtDsxd4nMCgxtxg8qNHrLoGqCfklNCNQc3MGN385+bV+KYtyQdwaAt+h6e6JmFzfD9q4z9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG1RKJrn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG1RKJrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7550C4CEC3;
	Thu, 31 Oct 2024 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730412540;
	bh=yutUsvb1FUVH5buEW0gYjKOsQp9qHQzY/jhDLgy2lXM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZG1RKJrn8jr573OZF3cHW0oxRY5FdmKu0jI7vbJ6lfqAzbkp3yp5J7GJXcgw6SyXH
	 jfk0q3xQcmr9sGPQdhN7Z4H86z2K+gOBSbuA9VqJ0y1bMIRAQcbWT1XJ7Ft5BJ+Iws
	 HeKzTBgFGBvvRwNe0HXL//0cVeKhKXHsnvyfP3e1849ALZeqDmHTiJ4ln+bBk5Leg/
	 ytagTPQj00J2m3PTWbVfmPbzd5/X73skSlye/pW3mkJKhwUQg8OJ4NhwtlGfJ1fQJH
	 xG7oB1eEQ2bdehnud5Vh960AUHSNYPwKVR+uU4nStgoIVLYBksnev8IW2Ubf+karhS
	 aWOkftigccduQ==
From: Kees Cook <kees@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: exec: Mark Kees as maintainer
Date: Thu, 31 Oct 2024 15:08:55 -0700
Message-Id: <20241031220853.work.354-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=kees@kernel.org; h=from:subject:message-id; bh=yutUsvb1FUVH5buEW0gYjKOsQp9qHQzY/jhDLgy2lXM=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnK/78ZMgXEszCFxqypmJIie+6A9nzWmsP+U+eW3ww33 TQt+t2njlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn8NGT4X2V4s3vuBkUTwQPB SjbmbzUv/3aQUclxtQ9obvl89f2HIob/4a0uU7e9KikQ2NTVPOHDuZ85jLvMVmesS96lJeEuYLG QGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

It's more accurate to mark myself as a maintainer: I've been keeping the
tree up to date in linux-next, etc.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-mm@kvack.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 009501905386..c9cd99cd4a4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8488,8 +8488,8 @@ F:	rust/kernel/net/phy.rs
 F:	rust/kernel/net/phy/reg.rs
 
 EXEC & BINFMT API, ELF
+M:	Kees Cook <kees@kernel.org>
 R:	Eric Biederman <ebiederm@xmission.com>
-R:	Kees Cook <kees@kernel.org>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
-- 
2.34.1

