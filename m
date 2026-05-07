Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6D302146
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151916; cv=none; b=XBo3D58jOIpz4CaxfCc4nP0VI9ldU3Wfd51wJusYIbsFia/dMvF/uaVrDm2gSkH3AgBtQBjEKAlgeFvhlH3EavBWxKKf/e3YknqEVVbm/TnXPkw5Lyyi0TM+5eiq64oEac2Ia57Aup5qShAqgx5SNoJZ4T60RW3jd0xjt5K/c0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151916; c=relaxed/simple;
	bh=gcoVnuPbLQBwdWdcxYRh2eENj0ujltQbPI9VkwzTwgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa1Dv4npUf4eZ67Su7p79e8y1pdEvXNTCBI6qhR78Af5ZJSbGQw++ORW28t+pQ0yIMQAPQRFDdMntGC15AKemfIGX7JhH5usqCy2+MYuxHE2nrDPpW9ccPolN3RmiJMZE+6hD/WVSUwcvhAp3MqecmMspS+Zj2I1iSDTAVLT81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE0j+Jqt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE0j+Jqt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2babfd18435so2667815ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151914; x=1778756714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzzmv3l5JprSivqCZvNRZy1Z5+t5yN2JlhJPRVH/nQg=;
        b=kE0j+Jqtf9rvJGzGMQKuQhrtxqbsfYrH/Hnj4Z3UZDcFVInkILnqkjA6VJ979NSgKT
         WkgN4pV+BdagA90RJeK4pHbWF4gWcQYjx4UdFNzeIHtfvzNfWlqqgneHrslP+V7i1xNp
         aAplLQgnFtLrjuyKzyEXAMBdRk2jdfWIcDNMWhe/4xOMvdPfVZ3RVbr2UDKb6qm0asnd
         8YEx5ajtyTfaxmJef4XZmhuziZxb86oZndHnraSTkFD8WSEsrs+caJNyc08gUJmE5Mwa
         EDHblElcAgArBjujX67bR34jg+aF58mt3ONE8ZZfDIIVIgeUGFA1lzvU34XXFCRQtLPI
         4m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151914; x=1778756714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzzmv3l5JprSivqCZvNRZy1Z5+t5yN2JlhJPRVH/nQg=;
        b=rOAcbQCMxv2hv43zzUDVUoSV0KYkCYBdOc8C43feBQb+r1z60XlO9HWow9JtWjL02z
         UI/Cn865CqHNrvZUk7zEQNLp2bA7Vl9ko/394GMH9Ko9CgwYnwQdNIVFGiFso7eRO4U2
         ByKoUcXe4SiHNkjW3tIHjThNAdGC+C9CJV2Zu4FNEljvncwRujg8wG3nwg541sjW7xPN
         V/nY4T/7hfP61Nj7EzOus7eOcegFn2CTnFum7mcaSZpdGVBQi4XNDbPk0QVE9H8/+rrh
         cBBBXq9mE5YF9LA7t33dBkzgqGwdWwIWb2vx+Mxuujl7+kzeOX7F84venD0BGUuQ92+T
         wDLA==
X-Forwarded-Encrypted: i=1; AFNElJ8UlwklYtStiJ2j9E7NQJWYrOIQHdYrJhJwIGBJkLdoNhJqRojQwL26ltHEC+NcqEg1CYYZ9lnLDHhBVYa/U+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonfNnvCvLvqHZQYERwnSfWsrqNtz2WuzBdHfpvNJxnvdDltll
	VZH28hM59eV3RB36Y6jVnPbp6blugzBcZRCeCtGYMTxsVzEgsFtIfh17
X-Gm-Gg: AeBDietkU1COSaUMd8m8Deu9OXOhzRSH1+sxfDGvJUy7GTXz+s2JzzWwiPY1H9/+XOm
	ODGFi6N8VZ1WNJ9TY74bQv8aATBB9SGmoAI38ltPxijJUkLe1SHkVOh/oUUoZQRqdTRITIl6Aht
	PFSiTKfQtZMRsFljz4MfFEmqGK5+hUqw0eXdaODZZc1lDIJT2nM10Ig/4jINPL1+fRngr2CQdrc
	SEZ0Myxo7wRTUgzKcGcy+AyyRya9yuvTblvFSEEbTAqYQff7nZP+9YDJOtdKYDL2lvkoPZI3O+3
	k3uQqPD+5LbXVinc8SbLcXASj6t9GGu3HeubjBDqpXq5OwiMlKtq8P5t8c4VmoEtvZkbXlSj3gM
	yImJQvRvV6YDgXdLqK6poT70X5ZA6aOAWUnCdcgNd+aj+ofWjjYEUyjFTJgErlxRK1C17TV6E1O
	F7ZFzETmuvr9D6Y9EAaNxNuGzAdQTuEFSgDJwU02w9
X-Received: by 2002:a17:902:cec8:b0:2b9:8e63:71c8 with SMTP id d9443c01a7336-2ba793c04b2mr83245075ad.29.1778151914606;
        Thu, 07 May 2026 04:05:14 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaad7e4dsm22697315ad.20.2026.05.07.04.05.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:05:14 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v3 3/3] coccinelle: Add rules to find str_alloc_free() replacements
Date: Thu,  7 May 2026 19:04:11 +0800
Message-ID: <ecd2beefca98bceead680c4bd3c5df684472b69b.1778051552.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778051552.git.jqqlijiazi@gmail.com>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rules for finding places where str_alloc_free()/str_free_alloc
can be used.

Tested-by mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 7b2b76a42acc..516b30828380 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -7,6 +7,44 @@ virtual patch
 virtual context
 virtual report
 
+@str_alloc_free depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "alloc" : "free")
++      str_alloc_free(E)
+
+@str_alloc_free_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "alloc" : "free"
+
+@script:python depends on report@
+p << str_alloc_free_r.P;
+e << str_alloc_free_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_alloc_free(%s)" % e)
+
+@str_free_alloc depends on patch disable neg_if_exp@
+expression E;
+@@
+-      ((E) ? "free" : "alloc")
++      str_free_alloc(E)
+
+@str_free_alloc_r depends on !patch disable neg_if_exp@
+expression E;
+position P;
+@@
+*      E@P ? "free" : "alloc"
+
+@script:python depends on report@
+p << str_free_alloc_r.P;
+e << str_free_alloc_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_free_alloc(%s)" % e)
+
 @str_enable_disable depends on patch@
 expression E;
 @@
-- 
2.49.0

