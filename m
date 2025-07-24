Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65C2E975A
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365407; cv=none; b=AICnsMtPLbkM/PPJ0LQ5q1O/pK0WZSNyQWSCEgzXk4cNdZhIaMrXR/v+0JBp9pln1ZrPyYdbP5J8/X0tB/LNYeGc7SXOa2ff31KQPWQVyF+8pmNrTUUZLMzs7lZTxmVkc7fMmMzMV4ldicAaqZkvLvoj6crVoE6D4Y9ldemx5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365407; c=relaxed/simple;
	bh=5jI4DslkjyJiQZE2KZ1KI70K82ssb8psrTPB6JrU6fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYHZhfSJTkZ5CX7xV4rjhNcIzijM7PWzQ6tnqMyRqMDsAiYnqbSOZuv3k49LKuq0E08h9sFGxmBb4EAOILnQnDLSB8/9Qhn+/isM7ONtIrM7lkTrqC9A9h5mgJ2+HX+AwSDNIbDKM7Yk5hjsZZhB/P+aIojJarSLI8/9zmdIsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVQlTHGJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVQlTHGJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d6ade159so6665105e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365402; x=1753970202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx+zx3hCg8Qz6JMSxLg+rjsObdnsN3uv3uvSypyoc0Q=;
        b=iVQlTHGJ4xtQ7RNKSFLjRG0xpbvSMhSWzygQvQWNrpIweobCi7oEbrHSeBlt+DniE4
         4xhPpdciMiwjDaxlqgi/WQNTk02AB0hzNo5/qgY7M7d0ovROZDKA5vOdLDwrKyMJpBpL
         rbxBWa1ZGy/4Syc7iYRijahPPiJrPpMfo5SloRBdOdPRV4tsZC+eXB2eKg4yrK6ayet/
         u8/5SDt6TKYe9IUDX7wtVjISOMDsBnM0RRcwIsmuYEXo4c1Ho9vDY06487FUd6ol9XWm
         y0hG4uwNd8ulghEu4SHFN/pLexUeHGf+c+3veUu3YpR90dqYiRMHJ7QKyu3WUxLKFYq4
         YNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365402; x=1753970202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx+zx3hCg8Qz6JMSxLg+rjsObdnsN3uv3uvSypyoc0Q=;
        b=mpnlLfufLmkZqrADKBNXAzFdvyU/11IJx+PvnlpMOLKSdjrevDBR4GORBjR+dfwW1H
         Dy+q+xTBhaI2yY9rYhM3Msslks1cz3OZEcJ86j+/bqUs3PunuwhPELf1wH1Nrs5GSt21
         o0LKa2qG1ATADe5vU1qu3MT00Yq9uk8sSCTYQ0NqYDpRqqEcU8bxvOoaaRbERaUjDuvE
         v6mOySm0ZlCCgzFemJ0KMPfsxFdzVPBtSJJHGyhPeT7DIsKUUPRZByA25vHtqMCdkfFw
         iKMLzGehYexopKQeq5APEWxdgn+hww0dm2P1CRwkGV7D21l9ZqZnsZzgTILkxM+/zTyX
         HPBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8RvFI/cE1UDf4CCvPO0kp4CjYmh9yw0FrsJnCYCkyiXZ5pBu1MuMG9HPTiaAJViPBxHg3Ci2sGsdsukzGJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlqltp69xT6a3WPPRnjvmCe5NTHN9xgs9RItqvWyCNAtxlLB4A
	pJ8ImPQa6Ivf+pCZLIT11KPwGJ0ekLak52Ozs6jxHi8raS3ycoQCGvQIL1adnphl9yM=
X-Gm-Gg: ASbGncvgtTj7a+3j5jidxKCRlQucBb+FBrCP30lH1Tzj4SLY9WIlEoELO+ibHohDWhK
	PX9Fxw0H91n3xkYPQtanPIZ1gBTcZEo233G8VTtlo3gVcl5p8aEEG6OhbBwdMPhf5+pKF97lRDW
	Oni8VCTzmPLrKF2vynes6wAScoAFqHXDWDjUjJip20Rh16fUN/JUTAFB/mM2X5phGPZCBmF011S
	oNEN0TpLm1E2RNSCK04KVVqXAEG/Q5iFgpeXRq/2AmzsWFHXAD+jlUwdz5wX7aEFm64R38gWIWJ
	YYfJl1FtzGdDHkyr17eKRQ04imqL4wft5pvqG18lW8tAYhmZaSbzX850i+gifMAYHKg5PNp1iIF
	jKjoTpvEo5xk53WoLpHsG7kC3xhuav5yCqE0kdGgt1PlosEmkAX4GxMSUabgb1QH78Izh2MuyR+
	WyFi6Z7gAGSW41
X-Google-Smtp-Source: AGHT+IGliARSjFjzMbqI3XaGwe/LefU8e+9kx8i0i+1k/+nyeMB8SAYvSTjLiytSObV6pAe7PVl9aw==
X-Received: by 2002:a05:600c:3583:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-45868cff2b8mr75404365e9.16.1753365402037;
        Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:41 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:05 +0300
Message-ID: <20250724135512.518487-23-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - node_data

Information on these variables is stored into dedicated kmemdump section.

Register dynamic information into kmemdump:
 - dynamic node data for each node

This information is being allocated for each node, as physical address,
so call kmemdump_phys_alloc_size that will allocate an unique kmemdump
uid, and register the virtual address.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/numa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/numa.c b/mm/numa.c
index 7d5e06fe5bd4..88cada571171 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -4,9 +4,11 @@
 #include <linux/printk.h>
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
+#include <linux/kmemdump.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
+KMEMDUMP_VAR_CORE(node_data, MAX_NUMNODES * sizeof(struct pglist_data));
 
 /* Allocate NODE_DATA for a node on the local memory */
 void __init alloc_node_data(int nid)
@@ -16,7 +18,8 @@ void __init alloc_node_data(int nid)
 	int tnid;
 
 	/* Allocate node data.  Try node-local memory and then any node. */
-	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	nd_pa = kmemdump_phys_alloc_size(nd_size, memblock_phys_alloc_try_nid,
+					 nd_size, SMP_CACHE_BYTES, nid);
 	if (!nd_pa)
 		panic("Cannot allocate %zu bytes for node %d data\n",
 		      nd_size, nid);
-- 
2.43.0

