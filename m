Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8A306B3B
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151870; cv=none; b=JC1XnRoFshxNPVgirPg3aMzszVLTHYvuUR5ytPjr3D6CwqK75ve27YZOBXuaNOW/7KKg6jEr4pS9Llmzl9EfVfSKmKQBmth4oTYNRYLX4EoA9HNx1eBIxSNB9OqpmfaEl+x3cX4MY7gChUfoEht2idRdPV9Y6Xw5s+l+VGjAkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151870; c=relaxed/simple;
	bh=0SGyG17o2tJGzWQ0udzyOUcT09bMtcXqi5lkxseaC4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUFgL56q8m5xKypmWYWrwcafe/E79B/Cfjj8Ol13f1EvOB4FWNQuDO/fwOOxUEuwzJ82AwY9Pv2RuuxMTOFH8nPG9IlylPOcMT3wz02DgW6U/nfg0vH08Evyl9an9dMNby+LlZukAUnulgwxtnYSZDS8YOXz1TGOn8v2TLR75a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnw1Q3hu; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnw1Q3hu"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-364eef1891dso489950a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151868; x=1778756668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbHKY59I43VJu3Inx5ITaB5XIt+9MgBqVQXP8HKYePo=;
        b=Hnw1Q3huyHTUbxbRFlKpSA06o+Q/8ukNrnjtHoaKw4OGE8i9DpLhYUVqcp8TMA3ZVk
         kDerwMPs+wB8JuusqsYijD6wmCB9DJNFfjgFTLiV5dlxxSkbr1bX13D/KwPlo7GA/FwG
         ce/nLHCIrdJ5eMJw491p4S4qSd1vIYzyjxrCFYqco2v9OMHh8oDnruUpwLk9mc93KLvw
         aqw3j8sLQH8l1EwvSzh+erNdjp7s0SY+7TcKoR21JIvWUwlxqN3qMPBsOgr1lwQPgRDA
         DwCqxV9403CBXh8iabP5MsgwgRB8FXb5iVKIWGZBQe5BEWAYhCgXUhcC2Lkv+pYLITCS
         lEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151868; x=1778756668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LbHKY59I43VJu3Inx5ITaB5XIt+9MgBqVQXP8HKYePo=;
        b=M+HL1+6OMpdoJUzfzHHkO7Ep7LcFrrLRfAYVM4IbuwRVGBFO4F/777qiD9eR4SYbVt
         ZbsHhljVcfsJ+Ku1teBMPSJD+5EuR+SR6ndycKQKGgbjdBD+o1lbCg8aCwt9Kz2V8gMc
         SShav6U4cQT4YQUYS5efVvqEuFWLd2kJVx7z5Z0KfrugstPnYp6Wf2VxwbT7yIedV1RC
         rYgID/iPA8oLdtmiYhIwBMAcOe0WlqMTMBqeuzOqjDABmfILIzI93gkSnnHNHqFcEEd0
         d3DvSMl+kIa2f8wsACX4XRrmdY6GHYd3CpvqJYuEQGe8SWw9LXw+5+aP9lFRLntQkpzO
         BQEg==
X-Forwarded-Encrypted: i=1; AFNElJ9RxuxmDXzXV7P5AdVK+kjO3wpGZ5xN7okC5F9nohAWjCLV48jkAEKlGhiudSKCM/okp1/pfpkcsx2fHdyi5y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKlNIWSDKoOLq6CYm9mcDhM2H/V2yS9l8itPwUvOLX+iZEx3j
	Eg0xoS1YfNXVc3DM586H9nM+2Ov/HTSpTyYxkEGH4Z/pM8gwTJOREmrd
X-Gm-Gg: AeBDieulsgbqG52OiwxNw2Di2yHZcL7oMQhyT6Q/FRby8mGFxAb9fpp/nhUBG6L1bXQ
	nBMPjG6J+HGwXDaPnXprJmH4REhwnnLX22XctEuFYfNI75+pif4uDkI6KXwJmntloo1JrLqf5rS
	0EOyOpv8Foz+rX7jSz3sj/o13mk2+04v4k83OzmufBCCZZeK9Cvl9Uc5fqMTxYu0SHc3IEOIxIa
	5z7YIbH6pWr6ri6WlIryIgWRKYDXtxI3546dsNmWADdY13l9oU2+qDJzfvHvHsSlpR+WTNm4uGV
	hEgSRh77XfrH7OWoYjr79U6Rl72onRyRYeDOM9fFcJ2yxCmYSHa1QhvIe6uM7tDydCO03yA8c1t
	4xXn5++ZTJPmgeskBVWpkACG/8CDSpvufLUbTp+zgxk4Grs5KaylbuwYg5PW6FcB1uqBlCuIy87
	u/oDOFNY2/VcjwHhynXF4atNzFHpGpKfHx3dgjl+K4
X-Received: by 2002:a17:90b:2d4b:b0:366:527:3c9a with SMTP id 98e67ed59e1d1-3660527402bmr2738189a91.15.1778151868319;
        Thu, 07 May 2026 04:04:28 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c28b1asm5720264a91.8.2026.05.07.04.04.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:04:28 -0700 (PDT)
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
Subject: [PATCH v3 1/3] lib/string_choices: Add str_alloc_free() helper
Date: Thu,  7 May 2026 19:03:22 +0800
Message-ID: <9663db399276de3ce91a77b8a8be8220132e74a8.1778051552.git.jqqlijiazi@gmail.com>
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

Add str_alloc_free() helper to return "alloc" or "free"
string literal depending on the boolean argument. Also add the
inversed variant str_free_alloc().

Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..65f346db95ba 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -17,6 +17,12 @@
 
 #include <linux/types.h>
 
+static inline const char *str_alloc_free(bool v)
+{
+	return v ? "alloc" : "free";
+}
+#define str_free_alloc(v)		str_alloc_free(!(v))
+
 static inline const char *str_assert_deassert(bool v)
 {
 	return v ? "assert" : "deassert";
-- 
2.49.0

