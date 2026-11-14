Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667761;
	b=eQf9ltK7rDwxxArDuwPsLOe2AVmXjUbr0hD/eZOmcD5Y76zrTjmGeY6ba4zZxAWsiH2m
	 h6PiS/bYZA0q5RrJfoQuyCt6AHtob6QCIfnSQAdGff9WuvdGDNJTpXOB7LCIYEfuzzK0q
	 3WuFBY3uyNqegmadoYKyQE1a7w0Dq+9C/ESb42rMS1cZa/Scqs8g84DLbkaYuuwnRqGPB
	 YyTxxm9aCw67EBfPvH2aLLsSXKNOcDwSzD9zruyNobOzbX6ylcgX4VdNrSlH3bcEnWDw0
	 jwjDcd2da5FIGv8WAn2cqzUhtbqCDYCh60A8AJDg8GKhC9CfBeelBUkZwAaqrURh7tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y2/DBpmjNNHeB2wLGkpV5YarrevGow3+qZX583Pk5bw=;
	b=P+/9bWLn+9CjmE7bCn3JvaexT5AcKF8w5gkKtEpHu+QRncBq3aYJ2wUdaxskQvClTX08
	 RT/rWLEoC/6i9bgVTloovFue1XPyN8d3ssfVS51uLsUuKDJOptqSLnQ8wPIRWUA3vgz59
	 zWHL9bwbqq3sLgZMkjB7Dd8gzpxaeiTjs2b6Gnyz0Jntm47AflYW5Z1U0kU2xjYbY1cq3
	 a/t0kXg08UhwwM2DHSnDQnk05t7Kih4NMBVw/M0jqNvsW921LAucKXl0pcqJM2nTsFblS
	 8AMZfSfAroFurOTq4G4YsmScHcA3HVa5Gem6DEOwq4lToneB4h6AT7wV74qFNfNBPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ci09glpN;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E4606A32D
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44E4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ci09glpN
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso673611a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667760; x=1795272560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2/DBpmjNNHeB2wLGkpV5YarrevGow3+qZX583Pk5bw=;
        b=ci09glpNs+mOtQ5xGsxwki4XErIpYQvmS7EJKkpHeu+qoe1i19BO8vfkAg243dpEKc
         QiYaQJzLwXjv0mmSX2Gty5f31fLFhcwiNApstIYcMeSTxv9eigaW+vtfnRxz+d6UDb3l
         8lo7Yp+ZSxWvL+lBoY/a1oc/UCTi56d+v1AfikVHPFTZehKtRI15wNIIW/Z0BE3lf1E/
         TTVjgAiHN6aK9bXmbN7szCnP8lZMmaLi+1kVIJNbyUyiLMiM8vlfE/zSPs1ekhfVkJih
         AlnfXQZ1pV/y5ujHlFTUURfZMc8kP6PfBAX+XMfQtZ7Gb8gOSUR2ZPcmYT2cKAWmUNN+
         EhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667760; x=1795272560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2/DBpmjNNHeB2wLGkpV5YarrevGow3+qZX583Pk5bw=;
        b=vag2dHxdiY6ahS+UFzXbRJ4zeobOV1YCCUFclcVKtEi1k81Ns7of/h7nE3Woa8kXrD
         QiVL8rwPM6lLpx/L1/bbfcf0jtL7aobuwHw+KO+Hp+LJxkAQEC7dKTDFpocWeYqM5fC2
         c4BnMrcM9uaT4SPOv56Ch43c0zCE8w4NtdDJi0ZtjDr5WFmHvvIzTTiL5HzBYNjR2AeR
         n6m4C+xGj6KU39x1tjYEyL6MYIoKeNgd1G6v1pJfSn+y3HjFj4ddJUTYQeB4d2A2uNXK
         3JXWMwAP63sujMExewMsyxAl4ycozfMPAYQMC/c9hHQFCF/qIFO5XF0C6fvKDtbp6laJ
         mQ6A==
X-Forwarded-Encrypted: i=1; AL+hErFIi5oKmsuFUoGMTlmDJO+gnBmohdOx+1a72En7iCumJE4qjs7NkAWwCbtmWdFNXXUg0UYqnLrh/u9/X3zKioY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+medOUUOIh2Sk5yOC5a6PKXtEJMzhfU0FH60Tp1Z8S+DrOtltf
	DPiuIBeSY8yCDZBnIDQ6do4APJSYLcNg63M8psh1J8OdG3S22+5ESlcA
X-Gm-Gg: AYBFou0mSd9doxxeIpTcWyyiYO4Guu1OMOO4hdYFtmtYf3xlno8QetnksPNROhMijG5
	crSkiyK0/dBrF6VoJtDnUD7rF/hDsyesuI10khaSzovqzT2IocOmVdmpuJ7EcBN8UXWZ34DFH+D
	AnCWppmbDNWMa/ruoKtGWoe743Hg2pJJHEy0iNRah/21Hw0aX8MQxfFQYWpglKd/Zyq0SeNbt9D
	qnLmWDc4SYJWlBWKF+jgiQUc82wTmr1bwNsFqpva9Fe0CAdxawrIkf1aM9saBqPgOQNJzEyzC1K
	G2vvie4Hsaf3Qex6whfwpEcKcF+MM+dEzt9Eptt0k+lo6ECnzOiU7hKAWxnzkAWoOsFV4iWNecC
	2eTW8dLRCKdqYf5ZNZDzZAnjryPVzKW1GE77/gD7zeY82iFiUeTeye8/YiyHmi5O+d1Jc9isf6G
	m7AYrZZbKF8dYjaodnR8n3CO2sMIt23+FcOsmDm6Eaj/VYGULDAFTadCqY45Y8CL0pwnBLTE3Dt
	Zd3gS1WriaTeRJXl4BHkQ8kuYbvBvogzEXc+hP1OH1n7HCUtNiglrSTcdhYDnaMTvdOL4hC2O47
	0p+FvnQXPBeI+KAO9uwjd/a0MefJCaQnTMUXSQOlQcElkB6stMNIHihEsX2vwRLwPZadEAhO9dv
	j5o1op0/a6s5C7g==
X-Received: by 2002:a17:90a:c88b:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3b1b0ba890emr5889521a91.59.1794667760115;
        Sat, 14 Nov 2026 06:49:20 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm14353082a91.10.2026.11.14.06.49.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:49:19 -0800 (PST)
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
Subject: [RFC PATCH v4 02/18] mm/swap: clean up hibernation error handling
Date: Sat, 14 Nov 2026 22:49:09 +0800
Message-ID: <2951eed4feabbf1a72dbcaedfc011782d9885604.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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

From: Kairui Song <kasong@tencent.com>

Restructure the error paths in pin_hibernation_swap_type() using a
goto out pattern to avoid repeated spin_unlock() calls and simplify
the return flow.  Also simplify unpin_hibernation_swap_type() by
making the si NULL check inline, and clean up find_first_swap() to
avoid an early return inside the loop.

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c41c4d26a7e6..c69a924acb74 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2331,21 +2331,18 @@ static int __find_hibernation_swap_type(dev_t device, sector_t offset)
  */
 int pin_hibernation_swap_type(dev_t device, sector_t offset)
 {
-	int type;
+	int ret;
 	struct swap_info_struct *si;
 
 	spin_lock(&swap_lock);
+	ret = __find_hibernation_swap_type(device, offset);
+	if (ret < 0)
+		goto out;
 
-	type = __find_hibernation_swap_type(device, offset);
-	if (type < 0) {
-		spin_unlock(&swap_lock);
-		return type;
-	}
-
-	si = swap_type_to_info(type);
+	si = swap_type_to_info(ret);
 	if (WARN_ON_ONCE(!si)) {
-		spin_unlock(&swap_lock);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	/*
@@ -2354,14 +2351,15 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
 	 * the same session.
 	 */
 	if (WARN_ON_ONCE(si->flags & SWP_HIBERNATION)) {
-		spin_unlock(&swap_lock);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
 	si->flags |= SWP_HIBERNATION;
 
+out:
 	spin_unlock(&swap_lock);
-	return type;
+	return ret;
 }
 
 /**
@@ -2441,11 +2439,8 @@ void unpin_hibernation_swap_type(int type)
 
 	spin_lock(&swap_lock);
 	si = swap_type_to_info(type);
-	if (!si) {
-		spin_unlock(&swap_lock);
-		return;
-	}
-	si->flags &= ~SWP_HIBERNATION;
+	if (si)
+		si->flags &= ~SWP_HIBERNATION;
 	spin_unlock(&swap_lock);
 }
 
@@ -2480,7 +2475,7 @@ int find_hibernation_swap_type(dev_t device, sector_t offset)
 
 int find_first_swap(dev_t *device)
 {
-	int type;
+	int type, ret = -ENODEV;
 
 	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
@@ -2489,11 +2484,11 @@ int find_first_swap(dev_t *device)
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
 		*device = sis->bdev->bd_dev;
-		spin_unlock(&swap_lock);
-		return type;
+		ret = type;
+		break;
 	}
 	spin_unlock(&swap_lock);
-	return -ENODEV;
+	return ret;
 }
 
 /*
