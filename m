Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B46355F42
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895483; cv=none; b=So4OQ8+XF8DZRSCRFB53Gc1nD9p01A5BpD8uGKthc0YvLxa7jI4vog0nK6HufjuLKNgZW+8rYoFPnB45dbTzb6rLMvsx4+3t12DD8aa8t/f712ImnJg9IFFWK5PmzXGOAlSJA5+8/xadSr17nSQx9MPMIq6DbL8yMjYLgK1kpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895483; c=relaxed/simple;
	bh=3yHplyP6cPTk7dA8Fbu6IQ+wvbJ9YuU8YxRM56PGb9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWH4MTb0lmH9iagujGp1Cvsm6uZkJHuKC69qtfkoaNZgVwlZPbRqXv6AJ0vyLGOL24aSxH3BWmSWgCQi3yfaQ+bNiqUknQ+IsByeFkflLRdpvXGJZt91l25IOcKt/1qysUYoJCIMtypoD8aZjffbFgypynkCJzbYaYrWXK/jU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDMiNEAe; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDMiNEAe"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66061993121so3486994d50.0
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 22:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895481; x=1781500281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcd8e+vHsZv7J6v8xRkTQl7Dt+2KjrNT33WGd/GWDII=;
        b=JDMiNEAe8x2xRxepjM3f7GUcJNFlSa59APcZdMmgwLVIrWhtKo36JLSCXkRN+XOd+p
         lVx+pun7EPjWJXTUjmdTksqHeOABlGeuTomiaeM4ijiUegL+YswHtZV4i6crOsojiMf4
         HcOUGh2RGU9kAXBeGk+1n5YYJtVCoPl5nBVet4v/xG5BdouJ4KrjXIXgw3XOZU+tqTSR
         U5qP6MLr0+edpAo6BxX0G9MbHPFlpucNsVuCM0JTbjp5MzY/F85wbyu8pPUAOvS061tf
         MTVXOMe1e+HEGBIa59rG9o3V56aTPe1nWFxPu5yiO7nqqx5cqNRbc1r68C3gx2TmImgq
         ER0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895481; x=1781500281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcd8e+vHsZv7J6v8xRkTQl7Dt+2KjrNT33WGd/GWDII=;
        b=AHL6fh3UIOMsxeHS6zmypC/h25KEejXzTZVZXbSPe24H31cES95Cugj8OemtI1g8Gw
         Bs+xf5fLeY5SaBt6i2GON78mRkka0q4rgRjzH4boJEF6oXc1MB8eW7lF3aJSb3HjQq72
         knfSwb7T0oKCmoKiwfpcG8nJl+W7NU1tadW7zAzUIyupCvF88wIIvBnnX4HTrXtfX4P6
         lflMqt+Ow5MFmN+xwhU2i0ncl0niZKYlYuCbWTPeT2RDLNl4hnBJmkL+6oL3um858HAa
         UNF8RZpDbs6KHhtszT7qq263MalU+EDelTY2OAG6nXQpAYAyud07S+NygHgrSiKCuB5H
         uYNA==
X-Forwarded-Encrypted: i=1; AFNElJ+QG4nO4cbs4T5bNBerIvlJBk6JfPXD2NwqYgfFQg6tsbCnuSaGq56r9SoLlqdDynjCKoq/0awrtNgUEC0LadM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBPwLyqyVYyYl539+vbDjzhU3+Uz53Lz88rXZzA2xClQzdI6I
	wjhVp08adFRvhFmSOL/8RtEthYMBdYoSCMAqaugQKkk86MRYXon226EA
X-Gm-Gg: Acq92OGhKKrsVRkt8PRJhowf+KoTdmhe80B6zDnJAhwZHnjA6ox34PDPkoaRC23C1Pw
	SY/krk5nyqagvnv6ztEHIxuXanxpks6CgPJ7a0hi6cK8Qfxl6FIT7LzN9X7DuULSMBKonGYqMBc
	pJbn9oayMSPVWsmlaAe+OsCxL/V4GEZvTCLISfg+oCs6qwd+befW5HhkxS65omIPo8zEIGdnTEw
	4pqYa94JvdETwerdDcommbmzPP54VAp/hvPBLusCkzcy0qvkGCDudlqQUQgDIbIvbYhNOaDJBVR
	shf9GRDXFHbNjXh//KbWVsIPjNb9owWorPrVr6iJ4355z/cuvwuy/OT+JfajzTNDeKb2eTgiHiE
	tE32HtBm9RmQ6YfRfJu6EqC0litzkTkKTKhxdjGslbsC5oX/FEBcuZunzrzi7LZhYpLEfB0l4BI
	Uoqm8Pw6QWhMqXJm/vJ54o7cC0dGZ68ivr0HTPnP2gSHX6614aZa0eTPBXXig8KpTPBkHwnjn7m
	7OGpN6yDk8MrIW7A1W/l7aj0fkIhcAkyLdn6pApoVDb3A==
X-Received: by 2002:a53:d016:0:b0:65e:41a4:54c8 with SMTP id 956f58d0204a3-66106f8de50mr11106352d50.56.1780895481549;
        Sun, 07 Jun 2026 22:11:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm8853478d50.6.2026.06.07.22.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:11:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: brcmfmac: flowring: simplify flow allocation
Date: Sun,  7 Jun 2026 22:11:02 -0700
Message-ID: <20260608051102.6698-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member and kzalloc_flex to combine allocations.
Simplifies code slightly.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/flowring.c    | 10 ++--------
 .../wireless/broadcom/brcm80211/brcmfmac/flowring.h    |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
index df7e3bee19f2..35cbcea0abc9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
@@ -360,20 +360,15 @@ struct brcmf_flowring *brcmf_flowring_attach(struct device *dev, u16 nrofrings)
 	struct brcmf_flowring *flow;
 	u32 i;

-	flow = kzalloc_obj(*flow);
+	flow = kzalloc_flex(*flow, rings, nrofrings);
 	if (flow) {
-		flow->dev = dev;
 		flow->nrofrings = nrofrings;
+		flow->dev = dev;
 		spin_lock_init(&flow->block_lock);
 		for (i = 0; i < ARRAY_SIZE(flow->addr_mode); i++)
 			flow->addr_mode[i] = ADDR_INDIRECT;
 		for (i = 0; i < ARRAY_SIZE(flow->hash); i++)
 			flow->hash[i].ifidx = BRCMF_FLOWRING_INVALID_IFIDX;
-		flow->rings = kzalloc_objs(*flow->rings, nrofrings);
-		if (!flow->rings) {
-			kfree(flow);
-			flow = NULL;
-		}
 	}

 	return flow;
@@ -399,7 +394,6 @@ void brcmf_flowring_detach(struct brcmf_flowring *flow)
 		search = search->next;
 		kfree(remove);
 	}
-	kfree(flow->rings);
 	kfree(flow);
 }

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
index 818882b0fd01..f3d511f9a3c9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
@@ -38,12 +38,12 @@ struct brcmf_flowring_tdls_entry {
 struct brcmf_flowring {
 	struct device *dev;
 	struct brcmf_flowring_hash hash[BRCMF_FLOWRING_HASHSIZE];
-	struct brcmf_flowring_ring **rings;
 	spinlock_t block_lock;
 	enum proto_addr_mode addr_mode[BRCMF_MAX_IFS];
 	u16 nrofrings;
 	bool tdls_active;
 	struct brcmf_flowring_tdls_entry *tdls_entry;
+	struct brcmf_flowring_ring *rings[] __counted_by(nrofrings);
 };


--
2.54.0

