Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02127426D3F
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490409; cv=none; b=Ge/dXm2pGNgc+BUVjXR+RmJ5hm7JloEcZy4K7GSSg8trLQ8x4l09t53lcYr8K0/we7fS4o1qRdQL9UFpPWNdUBmNRjq1HFB79KrZIQad9A9vJQcdxx5cwNegxH6WoRlPheYw0/Ns0G0bMVcOqZiCuflNa8RmyRPb0kVgBKx+4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490409; c=relaxed/simple;
	bh=9IHT31oTZmV0VeYxdRkHXlkyLp1UBl78qnhC3GuV9I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFSxk0UiBNtAELZIS+ivCuacZvi2z7EEjUKMp4yGm8td28u8jv4t2XUp5OyYVuIv4WBEqdBFpstxe4/LC1+pHOv3zMLpxJXlUmQCPJqWnvwt6byUGAcvn/jFFD27sAdfvxIy3gYTPfs0e6fafWnOaWL1pBFW3cKfby1ZYEi52MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=B//ZdEyq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="B//ZdEyq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cedda2ce6fso1324265ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1786490405; x=1787095205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8gUR5XNd4P4Fr5D6DF/rwFxtm19io3AVFBF1yERCCmA=;
        b=B//ZdEyq0eHyplW1VuMeZfathIb4Cy9FarpRcqrYluvBh36Yg3VNqjGnb6Daf6zRru
         if8zqlIX6HuFyENTZHx5MiNxoZmqomD9CuKNI8bPOCY5+lt5YbGAEAkF1vbRrayjwkzi
         AfBtKa9p58Kpfu1FaUU+ACvMTdi8JxETsxsUUyzjw7JCrDdfOc4xe4caTVOgeQooyWDE
         yfrDOHUZm1dCt5bGkieWR76LndaJrt8XfKrQ76QBP7XrMVXLOhsWf3lsTc4Ofq3Qmbq2
         eY76lI4UpCATWh//JDZSWVUZoMbmK6bcctf5RAH6XU/C7bm6Y6SWZQAT98AWLOh12ghh
         U9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786490405; x=1787095205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8gUR5XNd4P4Fr5D6DF/rwFxtm19io3AVFBF1yERCCmA=;
        b=auKVRZ5m9fLEsCSPDRpso8scG0pjTjxbvRJMPRzk4lvcO2CkUIKe+bqVx3eWeC8R4n
         TqgVPtx/IyxOUGa9Xp6c+FC8RCEp3/yMV8fKE3VJrpSuUWKYdT/bI5vUo4QjrYYyw21+
         7b5cjqwye0hsaiu51iWUZoj7cNdLgIxp24pWKPni0SkjL+Dj5GiY41Ku9rm5YI9kbS4k
         Z3g/0l+9sa0LXbRORz2bNKsGYpG1fYlJsjVJJUGkihVL2hG96S4PXo8TeGWIKuGcdx7W
         9pfWijMCOMuwNjq8Fy4YNk8ejUdotFYX+jjTedb76mIEXwZRQ7AXie5M+5y2jLf00tq1
         oVEA==
X-Forwarded-Encrypted: i=1; AHgh+Ro++yiKxLe5Rerm7fzqlNunGQ63mxVhCw6GLxjf+1EvGvvNMSkjg/mTd111f/WNLKJhzvgb8X+LXNMjZ7zpDaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LSCoXnF8idlaYD1Cj6QWVFpF+tSkmAdQpWPiP5ywv1G7T3Hu
	uaUEYW07iYVPy23l4J3AKunfi5HytKZqguw9DkBjAxxRd6Xib5AGS/ZN9R0VfZoGS/E=
X-Gm-Gg: AR+sD13Qdjm8gkXVRQd07Zp7JPt/CTxNFBXOpzD/1Y5z0wzO2aMYrK+KnlsCoQTHps2
	kUAN9hN3WdpoA9TxjMhdQVTKzrA5WnecTEahvidNXE6+diCj/S9jEP7HY5E79uELuJoAnZuYbTd
	jQJMm5WSgHOvnsvExKk01FqBvJzJ77A9t5Kacm85/AXfQ4FoPsyJNnoojOlJ7SWHAw35ltpiCgf
	mcAShT/0PizFvPNJ9U7f1/whlfnLWPTQcBviXyZGeASxNK5/cxGWrXLtCNiUj8pyThBsnw0puq2
	9bd30DpdwNWjtDsT91Tv17MxnR98dG1Y26AKmsseOPyn8z5fj7NnquscsHILKLUEd86Iqi9J4Ep
	VunRpM9XzgGCwX0hKUAUYveXECkj55qahhTrriNYYQk9Qk/Vc3JdSR93pLwAAkbH0RdXSae6t7k
	TJ/UANGlGhLWzyEKEodncDyPZzGgpyrJhInwSjDHYiQfv+97CJMGzhRtbVGdhPkWpNQWJ43tZpU
	k1YGR+qpoc=
X-Received: by 2002:a05:6a21:b90:b0:3c3:c080:71ca with SMTP id adf61e73a8af0-3cc3f218cc3mr674091637.0.1786490404833;
        Tue, 11 Aug 2026 16:20:04 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:365f:6c09:b402:1986])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbedbac8842sm1177810a12.30.2026.08.11.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:20:04 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: leitao@debian.org,
	horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v6 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Wed, 12 Aug 2026 08:18:59 +0900
Message-ID: <20260811231902.47089-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a use-after-free of the LLC queue entry in
smc_llc_srv_add_link(), patch 2 bounds the peer's rkey counts, and patch 3
carries the tail of an oversized v2 message in the queue entry so that both
readers are bounded by what arrived.  All three are tagged for stable: a
tree that takes 1 and 2 without 3 still deletes rkeys read from whatever an
earlier message left in the shared receive buffer.

Changes since v5:
 - 1/3: leave through the existing exit label instead of repeating the two
   kfree()s (Breno Leitao).  The object code is unchanged.
 - 3/3: add the Fixes: and Cc: stable tags (Simon Horman).
 - 3/3: assert that the two DELETE_RKEY_V2 layouts agree on the offset of
   rkey[], since the parsing code indexes one and the existing assert
   constrains the other.
 - 3/3: limit the copied tail to the largest one either reader can use,
   so the size of the queue entry is not chosen by the peer.
 - 3/3: the comment in smc_wr_init_sge() described the memcpy() this patch
   removes; correct it.

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

---
v5: https://lore.kernel.org/netdev/20260801094208.1937951-1-yhlee@isslab.korea.ac.kr/

 net/smc/smc_llc.c | 122 ++++++++++++++++++++++++++++++++++++----------
 net/smc/smc_wr.c  |   6 +--
 2 files changed, 98 insertions(+), 30 deletions(-)

-- 
2.43.0

