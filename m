Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443514;
	b=eEuuk4226PlHtYXB8LdlU/roqhTwFEXlIHIs5IB4JMGwmGsjrn1yLnSEziqWBx9XYcxf
	 akcZ5cvxPwAZkTFwtI634Qv9Ve/u8Hltx90z/qOVfsI3qOEyEnjOhVSd1wKNA5nCBhhu0
	 o7D9PBRHmUFYmh1fTtP/vFBOFOX4iZmnMFl9osM1t05H3aiO8paB2HfZSrxQP/5nYHgJD
	 wK6qfJIrftnsYrhGn4pooXsKdbGOyXOu+tFKWI27aB25G+s2MzqHA82He2PTFsTisb1hA
	 vvL81A6+UNpTgUUofFTHppZExk8FkDCzR4eLp+kSSm+bj0qG0YInUqwIdNib3EA2RTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=phsdk8t17LQ5zdqcOPOzFghmL6S8vOZKS0iyfCAYlN8=;
	b=ScPW1HtYG5hXD30bYYCTKb9DqNAYmz4S4HFB5izlS09CyCU1zE+A7oj9k1v6OLzK+H0n
	 J068LtV5hQ1PLiFA9/dcqUVfVAtyOnM3KdQS0TVDMrx7ja1WAj0DrzN/iQlBbhN7Qd5w7
	 I4ZtBAHVYCt3SBNz3r+Fa3/RQ6MLAY8gsi7Gq6zXhHtSfIs2KofCw8i9bwb0je6k6900+
	 8byK6MTMi3w+5mej1seHczueZXZ+NYxOw17/gGic26NfWgfPjbl2nDuHj0v0Wxookoe1G
	 bf9hu5oqR4cu1tUFsFBpR/eFT4myXcC636hxe+0F+VhN4y6KbeXHAiA1fAATyHuHCag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uPhPqT63;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0A606A33C
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D0A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uPhPqT63
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2761c69fbso2104373c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443513; x=1796048313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phsdk8t17LQ5zdqcOPOzFghmL6S8vOZKS0iyfCAYlN8=;
        b=uPhPqT63Z/kUYm8RI/n60+78ArvChL11wK+GFtxUOEX/BSQuNGGOHPyfuOb9mAi0R9
         D7lOrzDGCsdNetndXtDYOFOzJuNKFFT8Wx00r0XrV4SjfiQaXQtjFvVA2+7WjEJhZTew
         5LhIySPP0b6jH+QAZl7wUjwSijlSp04dd8dKfvdX7Bbb5TpWKMEUfhIXNsZRTFIvR+pF
         FEspgWp5zJ4coo51Q6wKDSXKJ19xL5z1cbT+MRmT8/H1/jG3rcXMiODHpwai9gf+aCvC
         F9CCrXaT+nrxgsgJM9BiO5TnvF+gB0oNbVq86H9/3G38LC7Tk6qYPcxZjhRdMx80FiO9
         Om/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443513; x=1796048313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=phsdk8t17LQ5zdqcOPOzFghmL6S8vOZKS0iyfCAYlN8=;
        b=w63LPd5/9KX3fUbQahEAjAnhu6n/jJrxpha7kMbPrWtTiPwv3W+cSzkzLeBybXJnVJ
         mSQ1H7OriESZN25b8rczgHrYxhG2bL5fDO07KNd+bgLV//G6RepnA/ochZUCmiVxYsTI
         iptBCqq+JGYQ6eVfzEjeAZBPf/g4qTxaCIgCihXoSx41+lBK6+RzKzahVVIAAZNy9pPy
         Xuha2SH6DnKDRbgiBTsPGt9NWeDQe4fScjxYJ+IpLuPF8H5sq/Pzpf++6wVEsFHAILdW
         f4ao1EhXi1h+0pHAboJlNJiKKeoMggQsJTAwrdDBsALeDKXOjny7wMIjn+iAmXp5VMm0
         8l1w==
X-Forwarded-Encrypted: i=1; AL+hErF6YxyqUWpBPWhgofQI19Bc5MpzhA4H6MY/ba+dL+zdVOGg7yguW+3RyL5qLcOkC2MudMHZDNc8JHAt5rHrZBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oLXa4/LsgoiBriU/CAAQv9x+LZn3rQ5rhGMSPuH8Z0Ym0EYk0
	lv7k6uAqTs2LoOG9+p0u2cg2WBWiuhlYGyFHNCJ7jXjIUmRUzVLZi9IS
X-Gm-Gg: AZFdTZentm3/I5RHP6a5jGoO14g3cNOIt0fSdUTi2CeFh1xrz85Wd3j6KW1m+x084Bq
	qXUVe71PwJx2aww7Fqg6sIIgFZpNwR+xd7e7q6i+9Ne+kO/z3d099oi1mcnsDqpy+zRZAQoioaU
	WhoYJMJaK7Aze7njIpJP8FWDFaJfTzagCqmnMzQYqG938wKglbXGfZ/wk6Oy4t4aG5hCzQYY/KO
	zZYFPoCEiA2iPSAofou+9zU1LpM8ltXLKPFM6L6jE0vJgtGWvag/8/wex4nTiuEZnuVRSj3eM+U
	0tQD3f1wPrGv7kK1wTmf8TefUFJXtJHSEIRJDi27vlIfVpBe6m6HLDXwQJzu8TsWl7nLJXPwVj9
	LHndecWkOVwzdqZZhBHO98TeYKADspxuNiI6gwoA0aUYu4Wn6rlmARgn46IB1PgtXRlKXm+ebf2
	sWfz0DfY1h7tcoagF1kDzIoJCHxMWAwJ3kIMqPpegjW+Fmjc3XruQg2UZ0Hpl4zyAdNxC/2v+E8
	hZ7Gvdrscj02fvbx2VRfIL1Rfxm7x0S0/Z0aj0GXBa6/BwreRFPib37DQQvvuQmnN8+nwfzytJ/
	3QAoRno+o2HNcujEfWVRBQsbpy3r3fBmCfJwPfWeVJ5QPXpEUnMWBJTg/Nz4oCAlcMqz
X-Received: by 2002:a05:701b:450f:10b0:1a7:78a3:bda8 with SMTP id a92af1059eb24-1b56f87ae87mr4467587c88.27.1795443512936;
        Mon, 23 Nov 2026 06:18:32 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm27824408c88.3.2026.11.23.06.18.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:18:32 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 10/19] mm/swap: mask the off-list bit when checking whether swap is full
Date: Mon, 23 Nov 2026 22:18:17 +0800
Message-ID: <0d61898075921b05c626accfa34a60e16472b556.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_to_avail_list() clears SWAP_USAGE_OFFLIST_BIT with an atomic
fetch-and. The returned value is the old count, including the bit.
If a freed slot has already been allocated again, comparing that
value directly with si->pages misses a full device.

Mask the state bit for the comparison. Keep the cmpxchg on the live
counter so that a concurrent free can still make the device
available. This also applies to the existing plist allocator.

Fixes: b228386cf237 ("mm, swap: clean up plist removal and adding")
Link: https://lore.kernel.org/all/f53b388e1bcf6840457fe5041e989a3c0d0cc4df@linux.dev/
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 70913402a265..1ef5f1ead656 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1347,7 +1347,7 @@ static void add_to_avail_list(struct swap_info_struct *si)
 	 * that updater happen to be here, just skip adding.
 	 */
 	pages = si->pages;
-	if (val == pages) {
+	if ((val & SWAP_USAGE_COUNTER_MASK) == pages) {
 		/* Just like the cmpxchg in del_from_avail_list */
 		if (atomic_long_try_cmpxchg(&si->inuse_pages, &pages,
 					    pages | SWAP_USAGE_OFFLIST_BIT))
