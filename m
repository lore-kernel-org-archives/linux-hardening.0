Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E731B824
	for <linux-hardening@vger.kernel.org>; Thu,  5 Mar 2026 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696070; cv=none; b=Bg5uLAGJL/KH84l8tNLIxnsmklp/0vXyY+AlMtZ+9HQLL5V+DLWbnbWRsn5qws954f1Hfj3ObIEQjDePvlANNnIx8Ga3OYJu1DWihECMa6ZC95c8PZ3iN/kIbfjvF1lBL1MnDuMBPO/XvUSVMy9AYsDEZUM4RWcv8NZWQqVML9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696070; c=relaxed/simple;
	bh=MHxiNpiYg4UslTUbQeAmuvquHyi/On2XedZkol9Nn/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nazSao/LYkNVj+BdikI+L2NUe3xYnr0O/BvSJBq/9gdoFv8uPmxsX+z/fsI/Gfpfk8E1Wtt3zCGexVhOQcnm1Rcivvziye11fYZ6Zghl4mQW0ed/xGoJy4+nURB/6WV0HYHW04Hy+GnnTiXK6/DjHRTHl///A2oFAAsa8J5n9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P63IjC4I; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P63IjC4I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772696057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vrhmpsYNV6AoYX0jQ9J/i2Jc+3t5kMVOzCIjalv+idU=;
	b=P63IjC4IGxxcuTS7WhuQl6yfkOo6B4soN64++OupOMPQ8Qd7t/A75JO606nyKl82dJymoC
	Baw2Z9bvrTLPFexr4lJcOhjdi5aT7VJoJkZJK+AfnJSgPElUbrqgxquOaiOdyjxn0K1dpo
	v04jkUG5514uVuAlYpVX6jvCfXxzctY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v1] net: sched: cls_u32: Avoid memcpy() false-positive warning in u32_init_knode()
Date: Thu,  5 Mar 2026 15:33:43 +0800
Message-ID: <20260305073343.250702-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Syzbot reported a warning in u32_init_knode() [1].

Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
false-positive warning") which addressed the same issue in u32_change(),
use unsafe_memcpy() in u32_init_knode() to work around the compiler's
inability to see into composite flexible array structs.

This silences the false-positive reported by syzbot:

  memcpy: detected field-spanning write (size 32) of single field
  "&new->sel" at net/sched/cls_u32.c:855 (size 16)

Since the memory is correctly allocated with kzalloc_flex() using
s->nkeys, this is purely a false positive and does not need a Fixes tag.

[1] https://syzkaller.appspot.com/bug?extid=d5ace703ed883df56e42

Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69a811b9.a70a0220.b118c.0019.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Made-with: Cursor
---
 net/sched/cls_u32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 9241c025aa74..8f30cc82181d 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -852,7 +852,10 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 	/* Similarly success statistics must be moved as pointers */
 	new->pcpu_success = n->pcpu_success;
 #endif
-	memcpy(&new->sel, s, struct_size(s, keys, s->nkeys));
+	unsafe_memcpy(&new->sel, s, struct_size(s, keys, s->nkeys),
+		      /* A composite flex-array structure destination,
+		       * which was correctly sized with kzalloc_flex(),
+		       * above. */);
 
 	if (tcf_exts_init(&new->exts, net, TCA_U32_ACT, TCA_U32_POLICE)) {
 		kfree(new);
-- 
2.43.0

