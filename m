Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F93750A3
	for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439159; cv=none; b=cMdnniZvw97gz3kpVrrvs1G0SaB9QRFpBitIQQiBqN1jGHlSMfGFNhT11JT+kxe9t8GQ4zAoNyfoyiAQiSIGMu1v07aY+x+AyqtURDopqVSpk+W34NgbFY02xyVsMjqSYQMiHRkBLb4sbkJ+R3Pol7Yapj2LRAVmB4aru5pzfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439159; c=relaxed/simple;
	bh=tnZSHpQFUD4e3XsdMf7OhRHyt80RmLLxLzOFmS5r6yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzo1UULE/D3/53OI2BFhRD5tERQmDAsxi+et6UKm5SdqIjfhZVy2blFD9NioOb/4eu53KFBIZQYFLh6vZcoJCqxxj0Ci/pNeVewAPvfoxXECmGMl7SdXp1pNR8/0nbIBPu+i/aro6JRaeiIcMbtQ0ZtNzjKJ0JNdNGxKSbZjaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghsm+eUT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghsm+eUT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a1a36f0c0so1458941a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Mar 2026 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773439158; x=1774043958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMGP6NrDc2l/cDWCsF6VnZBoId1E/2ANAkyblFCOTU8=;
        b=Ghsm+eUT6J+ww9QUIbB2cc34XRMIc3vkXKllPWpKudBO1dG6Kp9ksKzLQVY9Zxz3oX
         DhE3LaxsOzXO0qOg4t24bRtZRjo5/rEI/0g896iHdlD/K42SFMn0ZjfOhwD5zoWHw6QZ
         /ZtXP+2UGLLOdWGOCgszMAJTpoEB9ILTYyAfaz2ogO7Ss2y0GlnSQNCoie/tDWScaf6s
         hbavDyEpaT+4ezcOhfcbPP0GsyBjRm7agKGOaLrM3vujs9NdHCIIZONV+Lhbq9ny+LV6
         8Xw6gqtjEz9GYPjFbFff5KXEHP4Zm+2Ace7VBrutcL9nlkvfq5UFoif6/7lWzK2ZJBXu
         A1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773439158; x=1774043958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMGP6NrDc2l/cDWCsF6VnZBoId1E/2ANAkyblFCOTU8=;
        b=jg/sSC84bLy/2ekdSMTc5TJ22emzUtNrUvwVJ2E+6ZcXUROM7q/POi7R+/yvdCgm18
         ZPDVSNvrnvsOtpWEwLef8H/yDwqyNFUAR8lNdvUV9K1farMbUhjH51z+1cnk1NAWXdir
         iNF6ifjQs8MNKFSKY0etbo15R6XHfR0I5j7mEIMM+s0iyDSw+xGMFnuRFi8mabSd9xtM
         xwwrzclRd6BpQ4rmynKqwdN+pa7PCfoapMzZe24QFk9RZM4YVQ2MHyt9hUXUaseL9S9+
         qtPSye39VglLp1d70kpwslfKyadC7YQa5kG4TYJAbGeaGDHgKEbKmTqbdKXiyDqPLDFT
         IMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4Qd8C4W4fZbnY3WqFfumFYT6fG4ehiCQwb0EEWmilVX2VFaTYa+4hDTR/W52K91TkLbrijkIaU3TqSEZswU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeQDrvCGoXXEbAXIJ2J/rH6MVVt3PTWzfXJxFQaokfG98Gz5+
	DunDzRyV6Kb482oLfOkjXiLt5fh2e9DV6MuaGnBpvTKE35SJrIwWA6MB
X-Gm-Gg: ATEYQzzchIgPTcKvSs7BPxOPeCQVhYL4U9I0aPwa8CHezrrQtqhiQtgjopwzXCjUz9V
	oGKzUVrqx407TXzWrfyTvNGYYWFcNXzaeGwm26eS6rFh17frgZFRPnHfS+KB56BCF9PMh0fNbeI
	+cy8Dma9E/sTOIBDF1OjBgdrG6JabVFPG2pVBQDPUxOrvZoQo3Z2cItBG3mpaQDbzrOeoB6m2ee
	jYkUgSAm+TB4W8D1VY9iFChJsrE827JreFEmKM3ctppnT1wtw20gBSL/XbfIo7ljQ707NErHtaj
	TqfPgwnCSjUOCxiIEYfA1RcWBuvi31kwDKqw49VqL+lFv6AQ7IbcvIWGRpn5ZQgauDdzUn52Lxv
	PZgtajIqipkG2Q4AsK/kZ9YmdZpxJfWrFUEhCRR+bgRs5LgZKHOToyksz2MOzpdsdsmcynUsBbg
	cvlJ2t4LDRvZhtruo1huNpj5/VRuQjZnCjuFyh3/q0K5OPxj0jja/fyQ==
X-Received: by 2002:a17:90a:d006:b0:359:8e1c:53e with SMTP id 98e67ed59e1d1-35a220b54d6mr4474536a91.31.1773439158195;
        Fri, 13 Mar 2026 14:59:18 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97c960sm2673529a12.4.2026.03.13.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:59:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] EDAC/i7core: Use kzalloc_flex()
Date: Fri, 13 Mar 2026 14:59:00 -0700
Message-ID: <20260313215900.6724-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 v2: change subject
 drivers/edac/i7core_edac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 0f783173d0ec..b87c4c6471ea 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -240,9 +240,9 @@ struct pci_id_table {
 struct i7core_dev {
 	struct list_head	list;
 	u8			socket;
-	struct pci_dev		**pdev;
-	int			n_devs;
 	struct mem_ctl_info	*mci;
+	int			n_devs;
+	struct pci_dev		*pdev[] __counted_by(n_devs);
 };

 struct i7core_pvt {
@@ -455,18 +455,12 @@ static struct i7core_dev *alloc_i7core_dev(u8 socket,
 {
 	struct i7core_dev *i7core_dev;

-	i7core_dev = kzalloc_obj(*i7core_dev);
+	i7core_dev = kzalloc_flex(*i7core_dev, pdev, table->n_devs);
 	if (!i7core_dev)
 		return NULL;

-	i7core_dev->pdev = kzalloc_objs(*i7core_dev->pdev, table->n_devs);
-	if (!i7core_dev->pdev) {
-		kfree(i7core_dev);
-		return NULL;
-	}
-
-	i7core_dev->socket = socket;
 	i7core_dev->n_devs = table->n_devs;
+	i7core_dev->socket = socket;
 	list_add_tail(&i7core_dev->list, &i7core_edac_list);

 	return i7core_dev;
@@ -475,7 +469,6 @@ static struct i7core_dev *alloc_i7core_dev(u8 socket,
 static void free_i7core_dev(struct i7core_dev *i7core_dev)
 {
 	list_del(&i7core_dev->list);
-	kfree(i7core_dev->pdev);
 	kfree(i7core_dev);
 }

--
2.53.0

