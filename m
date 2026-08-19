Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B83BB66B
	for <linux-hardening@vger.kernel.org>; Wed, 19 Aug 2026 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106801; cv=none; b=gHz3S96MHGsLIIjW3GLAxLdbKBQZmEMpMDddXuOcqX6U0JEtbcI0l0D9aM8nifh3TtD8TkbeeH7f5wBK94ll5AqlISHVNQlCZsZavHm4edIK0BQUpQ1kocBEbH2Enxb3zg+iPvW0DHnL5QoyFOhxq+NGBJS8Y58Te1PG9kOJw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106801; c=relaxed/simple;
	bh=KbiaYdST825OypEoV7XDa2SfQ25BArmjG8UWZpsc8wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQfqyksuLXCEiR3FRfwEBjRAlNmRF3PWk/q+QEm9M2OWC9Jfuc0/+w1hGVqWcBRh6nVeaB/GvYL11ed801uBX9F+GnvEhN4YtUplBXtRM290hpwnh21Y4g7GBl3smj1YbS6c6ouDMQ5C9LuoI6WNx6W8gM3Ydbrn9TukH6V6VMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=OalL/Zzb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="OalL/Zzb"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so548903a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787106799; x=1787711599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgYieFKziqFiGeOaqNKzx6X27Iiom9cGSOGSf1oWB94=;
        b=OalL/ZzbEQ8h8NLaW8PHeu+f08u50MSzBjnDN1shqp1cL/4Z6bhPf+BBBh96YLGNuR
         +5Y5q5KBk7lT8oYqDkhLkKTAjofnelXfy1e9YVee0+ONSaPSbQyhJetNNr7ESKRyQ93f
         2qgQ8gFummxVxm4gf27p66VSxPO81DEOrKRqekvLlo8V01x34QJtRCeOHCj2GBMExc2O
         gacisGsQ5WpDQ1B2mKX98AA0raOloVvum7c2m6md3rs8QtMnwU15/mEY26Js0WDPh3QJ
         DYaTl9XxD7b0Rde53Ekt9krbx9quWY6OPeuo/EQSjoxwg4XcR/2YMi7mVZ3mQqOJames
         JIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106799; x=1787711599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgYieFKziqFiGeOaqNKzx6X27Iiom9cGSOGSf1oWB94=;
        b=McGWnIB6E/aI5Ae+6IRk/r3AjNI+S2vbuwQJ2PGla5D7lOC5EGW3dvR7n83S5gm6+R
         tMFtr9WIMkSVYldX2BFJBaQyYqGdmxpAiG04V5rSzJ+atgwfXVhX6thvngSpohS6lml7
         TBPYCTSNUAyhVdhobG1BM2sfdWCp+XlCsobV5VALpIHkQjlYcEA8WgqNLdWTuXCByorR
         /5WLEgyOvULU6dryNjS2jzkH4cIGYu9NWhkIrqlxae6Hb2VV5jyoowXAdg+YVFDC8VKG
         DEMZvMrLoqwDUK5JoiXpwNgnFxYsZQZ/PehXPeJbvFCOrZqjSGX8UjnAW3fWqEZrJk/C
         6W0g==
X-Forwarded-Encrypted: i=1; AHgh+RorudSnypx5Zdrp2ioOBJylRWzhcoBKKR3fYjqeM8Lka7nFXQaaGQatURDO3hFH4sopjObWqnlBYTSEHPIQmVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvMc3the+5HqUfYDQyIaSIqLKS/RnjQkTfPu94Pj/DbJzyH2l
	4izlnDgpNurcJlAoBDk/Tgf+H4yzToOD+FotqzB3QDCFtUbcpem4KIIEb9LJ8LZSSs8=
X-Gm-Gg: AR+sD10Zz977XFsSw60DvI4MVvqB1IAXnwzBiWWuuQqsfN4ewiriD2bGJqAfUoQGNa2
	QWMJlXqcdT/Ti9psOhOddYMGfLM7RYb/1EOcubhrI7+A1UcGrDUzGBZQJeywgCM3Zv4GBvj8Td0
	lFj4hNCMLJP1n1MSUinDX2YLGUg4/EoJTdM8MPLkitvE4nbsvGd8AQUuKn+zet6/J11LnA0VmFr
	0A1LBfBYRS9ap39a87pU0Nof85mB6amYfkapLih5DUSQb5G5i/FnVQi0VFFjaiWPkFIGVEDRImi
	8pNcrEc+oFFReFivusFi7mhsDLoCG7IW1cFqF0+yevLr8yO9mrrvs6NJPNE17akkeJ8ceNEQS6R
	sq/QH5W2+t57+3p10Rmb+ieb0yoCq53iPDrvjg0REFS9Yp5TrXCw6WzFViirURbfRGZSoAtA4aR
	sjAFbbcHjQ1RDAphwdecMZItdzU1pjv6GN2a6qpEKsV9iR6BdndeRgqGHvhLbjFc3lBt3g
X-Received: by 2002:a17:90b:4488:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-395810f21dbmr2355384a91.16.1787106799073;
        Tue, 18 Aug 2026 19:33:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f9aaa12sm786281a91.5.2026.08.18.19.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 19:33:18 -0700 (PDT)
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
Subject: [PATCH net v7 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Wed, 19 Aug 2026 11:33:03 +0900
Message-ID: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
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
readers are bounded by what arrived. All three are tagged for stable: a
tree that takes 1 and 2 without 3 still deletes rkeys read from whatever an
earlier message left in the shared receive buffer.

Changes since v6:
 - collected Sidraya Jayagond's Reviewed-by on all three patches.
 - removed the extra spaces after sentence-ending punctuation in the
   commit messages, the notes and this letter. No functional change;
   the three trees are identical to v6.

Changes since v5:
 - 1/3: leave through the existing exit label instead of repeating the two
   kfree()s (Breno Leitao). The object code is unchanged.
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
v6: https://lore.kernel.org/netdev/20260811231902.47089-1-yhlee@isslab.korea.ac.kr/
v5: https://lore.kernel.org/netdev/20260801094208.1937951-1-yhlee@isslab.korea.ac.kr/

 net/smc/smc_llc.c | 122 ++++++++++++++++++++++++++++++++++++----------
 net/smc/smc_wr.c  |   6 +--
 2 files changed, 98 insertions(+), 30 deletions(-)

-- 
2.43.0

