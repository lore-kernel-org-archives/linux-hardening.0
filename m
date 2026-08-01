Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF7314D05
	for <linux-hardening@vger.kernel.org>; Sat,  1 Aug 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575559; cv=none; b=nTBjFhoP1069T5mDQ6lQg3GGje8JuG/AujWEP/aN9K8HQjFCpHcoW3Y3J35xt81YTfa4VZGSG2GNClJivvGeVY8mdbpCzhDp0evGrI4if6ry2Z7ZxaQ5OcqnuskwpZUBhOHb6BGigsKWEzTre72Crzr/zO7CfZhkJygVpLDDJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575559; c=relaxed/simple;
	bh=WtKwboX1I6TACBp1mPchjcTdLWsllHrSvbiZnJsT49c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJyTxdera6MSM8m64EjULcBLo9aJlialls983oGdRP6g0CIZR2ezfEezogXmXW1xVSEPn9hD0a7ItvyYeW1kWDAx1bQ5B6XB84803fD/oST6N6MO/+/OQjBpKhVdK2WkpGzAcvNX6jlMCZ9gowYv2f5Y738XGQ9Zb0Wgy7XCQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kSvakdbn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kSvakdbn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso18125965ad.2
        for <linux-hardening@vger.kernel.org>; Sat, 01 Aug 2026 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785575558; x=1786180358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diW7eq1K5OgM1EddS3mEle0ywoNtUEUmAHB/nUoYXXI=;
        b=kSvakdbnTPxX13Fpn/tWdUQm/L1zgBFHeQP+9rBJ/Z+5GVEdk6SEZ9AUkVzTCLt50v
         oC2Kaf1hsHNNfuGi0CfdOAWueL2qUo8A+NAVW4PZaMfAQ2tnU1/OR9zkbkfh9eawkpu9
         KHEe7kU0bhSP7msuvbpaIwbvLt/fITbGxzFrft+07FVLADbJ3gQBsyJBDbHT/ipDRqmB
         OMkuU2kES6d00ESeMVUwO2lxvoHpj05ERSql8jhl4EpRCoTEBesPBhNTeATpryL2d7cM
         IrJ6XY1vLztQ3Zeg2uyTV8ZjnD/nwZBaQbjT4xQnSjzTeQ3RXawZATKQXMyCytRJBk43
         TbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575558; x=1786180358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=diW7eq1K5OgM1EddS3mEle0ywoNtUEUmAHB/nUoYXXI=;
        b=JdD2t9WiimuvPeRG0zmxvZm1b9Feo1m9R6ZQhEQuyaeMYBOSPjUKyNUmklAIF8xLGY
         MEJS4FiiaWtaKHIkjQU47FrbhMccXHwimIiGMdi6htQXTrIyj2mtUiKgqM7IhdFvo0C5
         VdGEjyyqKVIm8VPrdssvLNAV9ohurzFMwq+PLrnWlsK9lEXUSoHMvhOfLiX/htRu9BRT
         6Ko4OgNMsVOt5wzspbTRZKlD5TpDjvM0jX/ypNixDKLMgPuLaPg+OlxZjlNfoe4ES4fN
         Hf2CDTVoaCR+veo1X5n4gdPSUOLxZfuMVgCUnuDBRp6L2MxIkb9Duy4GMz1T6UWjRYs+
         rpVg==
X-Forwarded-Encrypted: i=1; AHgh+RoajbvewduAR0Jgg42F1EheGftvCSL7AC2/b4YyYqxBZljXVw1YxxanFgYdGozerVUEboZGZqBG20gM2GOxYMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEEOmVa3B3dixd71jgwjsRorN2oXLIJtpoZDCOO+/aBfyt946
	jzG3FhbBPK/UOPikO/mKSFf+2dkdwIUtcRnXEc0zedswtclv515TvlgvOIuUkDCK/a0=
X-Gm-Gg: AR+sD10AlP+JQaBCPbY5O7Gg6foL/WyVd4DyVsrVDBvhlMSL6CHWofrX0iAwSEutehc
	KI1dWCVjqMP5wzN/JiOuH8kl/cNsw/dOC5u7MC1qfmE8N7nxqLSsqdAybPjqMPJBp2jg0Ofb7ND
	lbe/qX131PAMy6gO9xeOOxpFm/KuxDcRUneOToMIbW6vbvn9b0VEPna9yKg0MQad37CP3I582ow
	Inrt7yGtd5tj32wB35gnOOVTnZXBr+vGGDY64aUXHOHI21JY9bo84Bw5FbHEeASpzsUHCENqlTy
	7JomCUSkJhIirS2+Ghw9w5Z6JmyxcZL8mtk4n7VhWhSU0vJmTIs37TfcsDQo6fpKKEq7mesk8HO
	K2R/ayizhWaTmqQzU2GMBii9wwkAe+b5j7jMK1rgQJwyn7izes3uaFxPwTnax4n8uPDZ1VbuPYe
	MQomJmnJT7WccHvMEUCpj6gTLDLlEDwtWrjkpXpZIvy2lnQAkcVLqxUOCSF1hpR1l62tjI26epo
	doWX94zKJE=
X-Received: by 2002:a17:902:ebc2:b0:2cf:bf32:b754 with SMTP id d9443c01a7336-2d05219f1cfmr29858925ad.8.1785575557981;
        Sat, 01 Aug 2026 02:12:37 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae60139sm16175285ad.29.2026.08.01.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:12:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	sashiko-reviews@lists.linux.dev,
	horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	agordeev@linux.ibm.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Sat,  1 Aug 2026 18:10:47 +0900
Message-ID: <20260801091109.1933145-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801070548.365231F00AC4@smtp.kernel.org>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr> <20260731070509.1818665-3-yhlee@isslab.korea.ac.kr> <20260801070548.365231F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko-bot@kernel.org wrote:
> Does this early return cause a permanent protocol failure for devices
> with a single receive SGE?

The buffer part is right, but smc_llc_save_add_link_rkeys() does not
read that buffer.  Without a shared v2 rxbuf its llc_msg argument is
&qentry->msg.add_link, and smc_llc_enqueue() copies only
sizeof(union smc_llc_msg) into the qentry -- 44 bytes, which is where
the extension starts.  Same for the delete side.

I logged what smc_llc_fill_ext_v2() writes on the sender against what
smc_rtoken_set() gets on the receiver, over rxe with max_recv_sge
forced to 1.  Unpatched, the sender wrote four distinct rkeys and the
receiver called smc_rtoken_set() 427 times, not once with one of them.
With 1/3 and 2/3 the path is not entered; with 3/3 as well it registers
six values, all the sender's.

So nothing is lost -- what mainline registers there is heap past a
72-byte kmalloc, which is the out-of-bounds 2/3 fixes.

The changelog is wrong to say "nothing beyond the 44 inline bytes was
received": it is received, it just never reaches the queue entry.  I
will fix the wording in a v5.

Best regards,
Yehyeong Lee
