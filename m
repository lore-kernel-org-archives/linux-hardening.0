Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1D495AEA;
	Thu, 17 Sep 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679653; cv=none; b=ewqYMdqpZlUqyoSyr7GbktkHtd+A/83o96uyjgRRQGUF3cDcWwtfF7J67Zg8LQFk2OMQ3MRM8f+7jBQV7Vi/s7o2T6PusM1g3XVkkU3JPA6eynjWZ7IVCPMSWBgiMmKwb2maS6JCoDEs7II+ubCh2NRP1Qi6yqCAJQwwCnNmlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679653; c=relaxed/simple;
	bh=vF/C/jh8Yyq1TttNkZ7wvPqg6Ta/Xu02VhcAcdrtyP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a4Eg0GMslBlq1tdYTv6Y5UdCL7i2XvdaQfzcblnOtbSxmeGMuBrimmvbIiEoFtleeG/huw0tbg1EVJt67XO/+85WOBLpMqsia2CCkjK3GRm2uUrOJLXacYEAPcLTXKXKqkm8qWw1tN0Du6YrAMksajt8bwyrm1x7vfkTqYFYnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4EHs5DI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4EHs5DI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1031F000FF;
	Thu, 17 Sep 2026 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679651;
	bh=Sc8ieypAeHqBZdmMtqdCr2cjquV+KlJHxrA4JO+plA8=;
	h=From:To:Cc:Subject:Date;
	b=d4EHs5DI7QHVqfX6qf1ElETDdIxJdP+4tnyZ/Hx6tc0LndoQ4zxSJB0TSuPs7x5pe
	 8ZIC8bZtiYtoJNtSR+6Yo9U6Ou+y6bLsV/S+4ipIsG0zA3M6fNMRn7CKZfrPSnm9mt
	 OalUvMeNxiB5ZK8py3xuihj8z91SmEgrfONdT3xl5qockxzqSKUp/8LQSh44gBgpbM
	 k6aScPS5wNOUM8xKtuRobunwJMeIo5Z1i1k2Qkxh4DfPigbsPJ/eEmYkAx/bTCz/pb
	 7Khccxo5XAHvopDQc6VepvazLlyJUUtpJ1786zJHuZKuoiUdBSk1Mtbg4bXutWxnF1
	 3LgSFtxX4ee7w==
From: Kees Cook <kees@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next] octeontx2-af: Allocate ikpu2 with ARRAY_SIZE()
Date: Thu, 17 Sep 2026 14:14:10 -0700
Message-Id: <20260917211409.i.425-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168; i=kees@kernel.org; h=from:subject:message-id; bh=u4FLDg6ay/ceE56fC27/idBYNlgegQ3KQZ0PQKlaN9o=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIpSCn7xiE/dzPMWw9r64iszpX1mhf5rCdy6WvvJaa 8r28KvMHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPR1mb4xey9bU6D1d0zZTMV Jk+UE/037fCvyLYvapNfpz0tutVR9oHhf4zBeYcdWV1xIYopU26ULpA5HLbDQ9z/b0H4d55Xin/ /MAEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

This is allocating room for a copy of ikpu_action_entries, which is an
array of struct npc_kpu_profile_action, but it asked for a single object
the size of the whole array, which would make the allocation type a
pointer to the array rather than the "struct npc_kpu_profile_action *"
being assigned. Allocate ARRAY_SIZE-many entries instead. The resulting
allocation size is the same.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c34f8d86cc8a..42a601976db3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1959,8 +1959,9 @@ static int npc_apply_custom_kpu_from_fs(struct rvu *rvu,
 	fw = rvu->kpu_fwdata;
 
 	/* Binary blob contains ikpu actions entries at start of data[0] */
-	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
-				      sizeof(ikpu_action_entries),
+	profile->ikpu2 = devm_kcalloc(rvu->dev,
+				      ARRAY_SIZE(ikpu_action_entries),
+				      sizeof(*profile->ikpu2),
 				      GFP_KERNEL);
 	if (!profile->ikpu2)
 		return -ENOMEM;
-- 
2.34.1

