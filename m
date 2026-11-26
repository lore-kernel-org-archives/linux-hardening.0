Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696236;
	b=oi/PGlPxgEozM46TohSVN7GgSJEjWTFgcI2K7rfc9i922jssv+hqgiSTB7mtvMtZ26sQ
	 ECFwD6CJNvsezaUEnzGTfdlQ6kfNMzKxWfimyYIui1mjRThtPoZ6crRv10nhRxEMcP8BZ
	 cJxzhZW29S5vhRM+MmMZXO+EkNBssXov+4OSf39l0JCjLos+PHlkX3xOyKCA/azH4H5me
	 WhdEB7/QL7MJfZ8uRKJBRE8JNp5XCq7OHrsfdB1kZghyNHxkaKESIgFh21Hm3Ikzj2uOh
	 B/tylsXDaPwSTB/prZpSv4GP3n3sw8xVWNHnLzTKOp+xuQlti86k4T44CIPWRNXelhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=63ma5jEPd/DP2X+W+npb2v4pGvrjKq1tRkWvj8G+bR4=;
	b=4zWdsEPGY9i3N9s8xvD5L3sw7QcN6HE5ytgar1xaL2s++/YOlh1HHR3vWQB9WDHFJWWC
	 ggccQrOf5lv3HAVHffVfjZQeV6qLDeD0Ly85xlhVlrBld0ax04FngV3V8706Lkh0XXT5F
	 CIYjrcFhCtCjz6Zia8OiQvvSoWpLu9tuQiFYFuri1Y3xDQJeq5UoDok+J/gJvHpMhtCCt
	 N8P7N2M2rUe/6kVWGCzcgk+AccMpTeiwnUgsZaeIdoiAvH3XCLaL43lp2Bxgv5YzCDP2J
	 XcKRBpl5ZjN+YrMKGF/RO6wNL3ZH8prUfGC/+BVn+pyzNjBN/ZeHX1DGdvRuKp5jd9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBHDqqei;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE126606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 12:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE126606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBHDqqei
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385d8a00598so10236573eec.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795696235; x=1796301035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63ma5jEPd/DP2X+W+npb2v4pGvrjKq1tRkWvj8G+bR4=;
        b=TBHDqqei6c/mcTxI0hM5xqfOy0W0zplRonrs92qC3Qz9nrN8+nD4YNqrz+tTinKg2q
         IdWXnuWslppB3Ju1qm6vUzWdWZ1adfJiVKUcSet/oYT9xU7tTTIORL20cgvncoYA88LI
         8K0nr/s+ys8LnvAoykaKpQwRM2zYlyx/vL3MBijL6Qah6jGddyqVZrLEijEV70u4ASIR
         Qyz3A3/fAG5yiVkPd363Bhd3XJWWzognmWxUBI8fhp0ZuEBtxN+gvxcFkj1TRpQDwryU
         SPfMa/DiKvtm7V7tvyosW4aaZ6toYP9YYCWRApDMgfQGMA+LLt6WS3onVmsQlo4JUvyn
         womg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696235; x=1796301035;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63ma5jEPd/DP2X+W+npb2v4pGvrjKq1tRkWvj8G+bR4=;
        b=nH7BtrjN07uJ1edOlK5B+MVtROeg7t8KnLJV4WZv7ucJKlT3fGSA7Z7ITy08ZowxHZ
         +VfOHEdQ8kALfz5wC3isMX6bp7ai4LOP89LDOwRb725uPLeTArlvcZSDlIeJz8ONV4X5
         ht1HEsDQyZrQnjj3uYPtgEogwokVQMguAXMneTUDYV8/F7+rga9LeXAL7HHjQIwcZBjf
         KsVeLp/0FmK5me9DvDSNA4QQA0JDkvxWHs22CO6KcZTbmqA2mHtXBS74cKAFNEy0U/m3
         c/oqIRSqyxU9s5NQckwcyXZub2Eq1llDo3Nq5+hqP+IFsPHGMtoBVDMkjUBQ6pTN+XyV
         9Bog==
X-Forwarded-Encrypted: i=1; AL+hErEXvN/PSE3ZPIxsDOw8Ox9hj1u8feKlzJXGvSa875ch2Vb/RbLdQ3fIekERCW057ax1xr8w42cANQWjaA/fwaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oSZTweYbGnyb4a0j828NZxBdm4FU4pygOuOwBXSlSay7LdbPe
	vBMLY9hSDf/WeiLvqr+G9bCYYmdnHUfe+RL+wz1zMv2ad9bNwd1wTC1s
X-Gm-Gg: AZFdTZf4AQqvaknRcaiDJFRB9M6x5G6VKv48HB3FruV/CZyJ8Iq7+NBic+y3a0/doPM
	A1i4/W7+IbgOqMxRfQVgJHV1meNLa1cxBfH07DhzF3mksgWovXFwxybLLP9Bf+G1Xi+riD2EZra
	nMMTrBP2+aQyvSKN7xzunh2ypJP7MeNjL3koB635fvl2ozvtZ5INOpH0hIiW8m0J42b1YvDVtSx
	xFot5CYFecA3stBmERLjULe7waNhlDfo4z8ak1JJgPaW/LjjI9g0DY2biCdupN4ADAeDysayt7/
	kHAV8v8UROYkm5cAaoCKayq+LHCkCcGmsTewquLFNRS8+qQtczMqz5twGTre4G0ZQAUYOqrujgc
	u5LjoCkdMtwYfgzA568wnIHdL3NeFBpM5v7aidGFuv3s1FDyWNyIM2nYUFLnr0gr+YLnOegBxbQ
	wQvajPRrEz/e5Ak99MMmMRGYjOTZcOU0g5IOfaqoh+Tllo91l62896ypccxMdZIxrY3mf/B88vF
	7BsQ59CrEWenV8mXZ6/07Apc4E8FBqKhFCbiCqaxNdU6XXbZms+y03qkyP2LslpwAbSro616LtO
	tlfGCAJSutY1Vcphya5eL3mWrxy5sC7O6qzLvVkXHI2QE9pvejzqH36lreGQmqpSJAo15zsgieu
	+Ltx5sA==
X-Received: by 2002:a05:7301:6191:20b0:375:e4de:96d3 with SMTP id 5a478bee46e88-3869e61da0fmr17122398eec.31.1795696234586;
        Thu, 26 Nov 2026 04:30:34 -0800 (PST)
Received: from HFGF46V04Q.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm61373340eec.15.2026.11.26.04.30.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 04:30:34 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v5 03/19] mm/swap: cleanup and document swap device availability flag usage
Date: Thu, 26 Nov 2026 20:30:07 +0800
Message-ID: <179569618256.54252.3159687265879392207@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CACePvbWLkZtdX-kedNHeFDRV+e3Hcyzixsc=9eENTrZVhiSjjQ@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <5a83cfe8b0992c65cf4cca1e8cd612b4de0b78c6.1795439990.git.lianux.mm@gmail.com> <CACePvbWLkZtdX-kedNHeFDRV+e3Hcyzixsc=9eENTrZVhiSjjQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
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

Hi Chris,

Thanks for the careful review. I kept the enable/disable helpers and
the call to add_to_avail_list() outside swap_lock from Kairui's
original patch, and later revised the locking around device lookup
and SWP_WRITEOK updates.

> Why is this change safe?

Both before and after this patch, setting or clearing SWP_WRITEOK
takes all three locks in order: swap_lock, si->lock, then
swap_avail_lock. A reader holding any one of them is serialized with
those updates. I'll make that distinction clear in the comment.

On the swapoff side, what changes is that we release si->lock earlier.
We still hold swap_lock while removing the device from the active list
and updating the global counters. The old code already dropped
swap_lock before wait_for_allocation() walked the cluster locks.

> what lock protects the avail_list, is that swap_avail_lock?

Yes. Previously, we set SWP_WRITEOK and added the device to the
available list under the same swap_avail_lock critical section. With
this patch, add_to_avail_list() takes that lock again and rechecks
SWP_WRITEOK and the off-list bit. If swapoff has already cleared
SWP_WRITEOK, the add is skipped. If the add happens first, swapoff
removes the entry.

> May I suggest splitting this patch into two?

Agreed. I'll keep the first patch to extracting the helpers with the
existing locking and operation order. In the second patch, I'll spell
out which operations move outside each lock and why that's safe.
I'll also keep the original if (swapoff) branch order.

Thanks,
Lian
