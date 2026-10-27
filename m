Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117055;
	b=tFzhktiPTaD4VUKPMqcbNEnkjjAkOdrWW5+zGfr3RBckh7QCItsC0MEbeMMdbTtQeNmB
	 nbAzzPu8U5v/h9wY17fCSWodqkI9Xx6Jx2XdydHGDezNtb8SdxZLUliW50AYE5lqyVTZp
	 zKCtfWPOmHqj4sxRElFxTFf7na1/o9+SiT62Em/ro9glZo6XIEJTLDv+7Mthr9bWqZVvK
	 25ItF0Y5bWbKUxk8E3+Lu7g0b8r5r4ZE3YNL3MFCEcY6NzapiJ/XXLYSMr16GXqOEHrG1
	 I/OfcMK1BPTWwZ1Ej9qASVColBmf0O06r8nKj7Y3ORwnjREamWWXgn/nYZr6+H8C3XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5d5oBiDNym+XgxzH0b6C3qDhntNhLNghMGNMGMVJJaQ=;
	b=w33r6snAcWQET0yITiOF6wxwthOqDuydkvfweVHPSXsAD9fVQdUA75p79/LTeeZ6976s
	 N6+DBZSAhjFpWqxIcoMEZipCpjYNVPBdKn887GClyZFfKvo9eqJ7YnT7MkSb6j4iOr8z/
	 1+ceRyII6bidw702M0ABuXBmHP8Z+E0Fimvlw771bXEK1DdnDnsQtAOdktlM5fsessgXA
	 0Bbj3LCA28yEIw+/G0gFJ4RkwEf35dEFQPGz7dfebhFgJh84JFVhR9ea0gQV5JFZDRACt
	 883QuiK75Czd+XcZoshFmgS3B+b6EE2lLv6Xgg8CWK80ee/yN/fqqowREwIT4/FHRFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=garMCfw5;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF9606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=garMCfw5
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso59789a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117054; x=1793721854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5d5oBiDNym+XgxzH0b6C3qDhntNhLNghMGNMGMVJJaQ=;
        b=garMCfw5pnI4iP8KIN59/ZxLf51UboH/1T4Stm+yj7le2DTh6DAsrzwhHPWrHa4sDY
         3bVHg86ty1uBiv1gXgW0sTS6maWRt3Tv9N446cCye4NeKcK8prb09govAUiHng6ogVZ9
         TA/hFebIbSn8HEae4L0SCJUn2EqPHlQkc99UTQsQz7c9VTqMyVl4IWGYvgp6uhjVEGYJ
         fbPwzC4gPGIo9w++1ljsoIkkZsU6VpBkFkDoT9jU5t99J6ubNfPn1OsX5yuoTmc4Onu2
         Gg+G9QE46RZMGqJCPE+g9p9Qk88Ol/fTcQG5xmWPW/XPOCzGsb9dJWbD6tkZSy3hCUGe
         dQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117054; x=1793721854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5d5oBiDNym+XgxzH0b6C3qDhntNhLNghMGNMGMVJJaQ=;
        b=ztISgZG9LYwtzmMVeWjuTCIbxmAP0q6GO6KLLDEwg4GOceaFRaWOGxeU5guFUMntTY
         PHy1B2fCkmNHrV9/mQtMmQfzTfH2lbTPl69vn2WfhiGiU4c1wQPZDnautXmnv/duIUDX
         oaqUoUrm4Xm1N9pde0OTbvGkf5i3biLTayNhQ+L8xxDCRYdI/IPeTt4wV40K4baH68wK
         nAxRAYl+YOpRjkJkxf5gQfBCFAjZ7IPaXq1z8/9xoKEJp7QacXFuxkHtay9H7nHebuQc
         MjoegtNz4XOzQc3+KfvW+HH/rAMEK9dlVmPYheFIilG7YAOUv/g/+qZBYWY9r1lYQRIx
         a04g==
X-Forwarded-Encrypted: i=1; AKwUvBzn7jP2uh7iT0lr/rXKdh6q6sB1R9h4Xg8SnhLsixs+8L1rtBQMa88W7ScotMXDBBPuppJ3Zzxg9OUSVF77DSI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzW+gfYW4cpQfO2bz8LPBgLCcdPrSfnnE1W+sPG3akqvJE75yD
	RhmItgZaljqnnMN1wCZGwcesv3WmWztrBgzeQgSykafHsypL+9VAP1+B
X-Gm-Gg: AYBFou2WDh9fyupzjz4AJgmSU0gJ7ZE35R3Lvw6LX+nbwHMcEwpAb1JM+4YDaqw1PrH
	zNTqNA4Dl+xDZwKw2PikGqRIeHTzglMNFoVWtHppTdxCF7H0Ir7cRxoNOM0qi80bRgEfPloHX4c
	eVkn/xGffwxw5WMHDgY4+ie3kW5PBErRCrvzbxEQ4xwj8ZCZcb9mnG1dIFJufhuB2PAxGCD+iR6
	Rb8+hDPzYDq3b+BIAUNjYhVl09szrSEh19r2LIMvzY7jjQ1NZZ9nYsHjI+5hP02PxtARPQlyIlm
	MiHNDn4bXKqpc0Ge30YGwarzNGqLSSpVd+kHUmrYl/YsA3J14/jia/qlPWDyV5pDbOSD+aXclAZ
	2hPufOJGf4vwhF3LsdeaPEZRHhkOw+pZFJDRRuDPXp+CtH3/nriDyA+zI6HBaM/tZljonhzzWgp
	xikYYaHUzPxQpKMPYxbbZBF3OErq382pvUsxOjQ4rLXoAcU5okwWwkNIU3IiU9NSYrSEKqMOmdX
	ibzT7IKgLF3z7kP/HEpNW/bhZnCNLjVO19wckmRmp18et6UvdtfmFwfhJBcRtvQW7I0kP3T2w33
	dqUg0h8u9OJAnd861zo=
X-Received: by 2002:a17:90b:4cd1:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3adead44808mr7894909a91.18.1793117053971;
        Tue, 27 Oct 2026 09:04:13 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb1e37esm8365129a91.4.2026.10.27.09.04.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:04:13 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	linjh22s@gmail.com,
	kunwu.chan@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org,
	tglx@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v3 02/18] mm/swap: slightly cleanup the code for hibernation error handling
Date: Wed, 28 Oct 2026 00:03:47 +0800
Message-ID: <098f63eaf6b12c7340d39cbfbff22678cdfbcb92.1793106426.git.lianux.mm@gmail.com>
In-Reply-To: <cover.1793106426.git.lianux.mm@gmail.com>
References: <cover.1793106426.git.lianux.mm@gmail.com>
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
index 7acb33cd8b71..cf8c0999655c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2279,21 +2279,18 @@ static int __find_hibernation_swap_type(dev_t device, sector_t offset)
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
@@ -2302,14 +2299,15 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
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
@@ -2389,11 +2387,8 @@ void unpin_hibernation_swap_type(int type)
 
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
 
@@ -2428,7 +2423,7 @@ int find_hibernation_swap_type(dev_t device, sector_t offset)
 
 int find_first_swap(dev_t *device)
 {
-	int type;
+	int type, ret = -ENODEV;
 
 	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
@@ -2437,11 +2432,11 @@ int find_first_swap(dev_t *device)
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
