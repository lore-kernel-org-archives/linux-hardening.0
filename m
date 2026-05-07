Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC52FCC0E
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151886; cv=none; b=HQEtlzEVu+ZdPjRPtL0pRKcaYlNcRAkAzglAP4BbYSr03E5+EggjXJVj66DdGM9XzlCE+XtUBOzHwDWkqonzhDF+2MhA+SSyDZ3HrMAjxx0xpuscjFnd+RDUyl3XZDSKURYvD5bpJKdjLML4tTYNUSPmu9h+kH5XEtVAEOkPPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151886; c=relaxed/simple;
	bh=bfnro7lC0SX75RPEYNQ7AwHvI7lAtJW9SMFg33EzcZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVlzewGZeukjUQQCao2iRf9wfcZ7r6MUTWnOKev7Z2buP9ecL9ceDPKyb5uHeSWTw19qNROZJhkLHP3IGZKrfRG9Z7CuWnS3WEoFiEvINlKJe2rTH0Za66ZFNpfaUVnIxjui4UEy9Die94hF17SZmvMp9Kla1/QiXu9jD0xofsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTWFSqDq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTWFSqDq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-366070f71adso499354a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151884; x=1778756684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5t0guh4qBPWqIfqEewnhQSul9ffMeJXpGrTuXU3Dlc=;
        b=hTWFSqDqW5/WS/4ecUTWvAQHB3o7ccE51nbIPMV+kerq+4R9kBJUIkZPIyDwmhAKoO
         DdZkqxsm9SqVLzRg4GhGLiN7glpcHR/u5EA1SnLrq+qmM1qHLIslXniBe+h/aOAGUxNn
         oamuBW/rv91w/SOWiCNbppNmQqv4SAzubTsO+b7ExUijuiu+bS5e5Es99DMpupTF8NAS
         ahX/FyizCFxVa+6VU5q3A72ibCOEfFlJ2XWWpNg3RMeBiDcF8r1mgLdsjRORxyjqC2Uv
         amnAE/A7mzvrLgoQm52mV+X9XG1/M4bJDo/2WwLzWwJA3+sqJvWIno52CGc+V4JaWaJ3
         Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151884; x=1778756684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5t0guh4qBPWqIfqEewnhQSul9ffMeJXpGrTuXU3Dlc=;
        b=irGg0MxRyWWLG4npTfRgSdZ7BGf1n01XH8p0KnAJjUYeAUQ2IRYHsJa+f9PHlonHgx
         TLtRwIspdC1SB5/66mY1OK355Bo/mIanXJoRggdYW/31iHsh0EUkmyO9FNklF5zlQiff
         c8jNMRKJ5fIqrWLemfO7EBuaf3D12BodJY5w4B608y/GAwoRdV4Up8PRBmfD84w1TmUf
         ImPPa+pz+WTLoEHOixRxejQP1Ie1W2h8lqtKPOAYTC9wWVnYqDrYq1qcSY5LfDOEsyjj
         Tac4AvoJs7zG+IZtbc4K7JaqTsDBVugnB/KOLvVY3qIQ4qZ60d3sDe7zI+qHOgqw8PcM
         Yu0g==
X-Forwarded-Encrypted: i=1; AFNElJ/Iewr52/+kYcz/jha2g4ME0hKBbMq+IQc/p8XS2k6dQYYGu5zTR1PaBXKXHHfNk43kH9zYbjTTxz97pYTuJiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkePUNf3jJXu9H1JP+qKko8tnaZNRgEHYX9MCn0avU6Nk9HLD
	8ck+U3ju79AFyDDRMLpWwhUuNCVCOk2yMChdo03iJdzgizdZtLD+BqPQ
X-Gm-Gg: AeBDievmjTM8s/wF24HKTnTptkg53bLR5L77N+BgSaLJRa/6u+cW6FgVjmr9IBofv/x
	G58op6IPPnQj6XNU9uYoru2MvjlIBHDxQSuj/JRdtspg/yZLYcoG5FY3jPDaxX8tBsWepklr1YQ
	vsXzs+FB2OR24Zr3rc8ERZYCRM778WQKuyXd3z0WYpJEfTbgCVmltep3Vn9797ywCk8J3Lnp9g2
	vkp1kCbKRGQTaIBwpZ5oK+WD3evxEekgTajo0ijla23L4RpZ+CYNfqyPf3IgQJEU9plv0R4L1ya
	iHLja/UWpm1AT3RwZofgodJ2QIj39y7oiaK/Il/zS1SPebahYN8sGKgzw87dEUysy4ZjQ3d9xwa
	3zry/6eQjJ06fsI16CZg0YBxBip7Xt1yRpJE9cSNOr0+aBcLiLlEgkWl4iK2nbcyec3NFV1nZgG
	1JwLgVWSlTFO3xisYPWkMp6KheHlEQCGL4ELTPLtq1
X-Received: by 2002:a17:90b:5403:b0:35d:9efd:7956 with SMTP id 98e67ed59e1d1-365abce1ff6mr8143531a91.11.1778151883993;
        Thu, 07 May 2026 04:04:43 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c2f5fcsm7360479a91.7.2026.05.07.04.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:04:43 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH v3 2/3] wifi: rtw89: Make use of str_alloc_free helper
Date: Thu,  7 May 2026 19:03:40 +0800
Message-ID: <6101125fbd6f619023e270a7dfca366d2be0cc31.1778051552.git.jqqlijiazi@gmail.com>
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

The helper str_alloc_free is introduced to return "alloc/free"
string literal. We can simplify this format by str_alloc_free.

Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 17704f054727..6cc68494b3a1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2554,7 +2554,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev,
 		 */
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "failed to %s entry tid=%d for h2c ba cam\n",
-			    valid ? "alloc" : "free", params->tid);
+			    str_alloc_free(valid), params->tid);
 		return 0;
 	}
 
@@ -2690,7 +2690,7 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev,
 		 */
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "failed to %s entry tid=%d for h2c ba cam\n",
-			    valid ? "alloc" : "free", params->tid);
+			    str_alloc_free(valid), params->tid);
 		return 0;
 	}
 
-- 
2.49.0

