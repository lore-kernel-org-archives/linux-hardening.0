Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BB35975;
	Fri,  6 Feb 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416421; cv=none; b=OBGfDePoVrMD8x5gU9DpdcZMKx6soyPuNo99ka3Arl2BSTdP1tQlzCIKRbH5NkIvEkIJvPrEqpBhZBKVY7EkuouqDwwbREw0W2QUYt7bZzfvNFLCd4o0BPdBsskEISRT4i5uI//jIEnD1/baw8YiHu5pML12XuKmclB2Lsfd6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416421; c=relaxed/simple;
	bh=2HsoN1VBR1y0hwjXSh8Wd5rLg6l2adaRRtQqZaF8KgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4O6A8koRKDJHFLaPulTv7KRJalnmA+yKNJ5xocSTpjdh1GYu7flTqXlcnNLGVgec7RTo+9VCcQEW3WGQ/2dvb1yYVOo5TkymW9EV8Y+4U2PXW/oHMHuXF3tRDn4DHa2hh4mHttVV3SIlDmK/wA1Mfyr3WlGLNeA82pzjk4UGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp71FYas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp71FYas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E13DC116C6;
	Fri,  6 Feb 2026 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416421;
	bh=2HsoN1VBR1y0hwjXSh8Wd5rLg6l2adaRRtQqZaF8KgA=;
	h=From:To:Cc:Subject:Date:From;
	b=Gp71FYasjaeDeTto+X1LAiwhDZTdk7XHqI4onnTkqCoWglt2TrEUbChbjjPchHoho
	 I27EKQw7HND9piZFkUX/gbGg+3G63B5xIaTkdYWywYUvI+EexN7Fsp5z8UbCPo+TLv
	 1jtOmfqqXFDP2EoS2UjddB64khSmKCzTRD93SLe02bsR4YOsEVjRKbCB9slweWDVsD
	 M6ebXZ3O0FHjdp1LyBt1tnowW2ajdHYToLZzohmPNKb4Ur1orvkmzU302rZ9cOoCQ4
	 g5qiVlWSKxsSQbJ9TKW6e7VHfVdqcKiFtaDT9JdWayZH7HlSzKG3rlSmrF0WTkwmg/
	 099NKurHYQjSg==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Wangyang Guo <wangyang.guo@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lib/group_cpus: Handle const qualifier from clusters allocation type
Date: Fri,  6 Feb 2026 14:20:13 -0800
Message-Id: <20260206222010.work.349-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=kees@kernel.org; h=from:subject:message-id; bh=2HsoN1VBR1y0hwjXSh8Wd5rLg6l2adaRRtQqZaF8KgA=; b=owGbwMvMwCVmps19z/KJym7G02pJDJltmdJtFarGdyaLO8lIFT1/cfSUsXyu+BI2BX71uzP/e L5Ynvm4o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJHchgZZiYmWT5W29nrvHDB zjtpmmXrL+Wd+6Zv7dV0IcrC+xLHJYb/kfFW/Ut2mjHbL+DeY7/vPhP39TtC3Rz2yixn+jRWdel yAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "const struct cpumask **", but the returned type,
while matching, is not const qualified. To get them exactly matching,
just use the dereferenced pointer for the sizeof().

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Wangyang Guo <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>
---
 lib/group_cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index a93df70919df..d496c5001961 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -320,7 +320,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
 		goto no_cluster;
 
 	/* Allocate memory based on cluster number. */
-	clusters = kcalloc(ncluster, sizeof(struct cpumask *), GFP_KERNEL);
+	clusters = kcalloc(ncluster, sizeof(*clusters), GFP_KERNEL);
 	if (!clusters)
 		goto no_cluster;
 	cluster_groups = kcalloc(ncluster, sizeof(struct node_groups), GFP_KERNEL);
-- 
2.34.1

