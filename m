Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830771BBBE4;
	Fri, 15 Nov 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682022; cv=none; b=WE1sKad8tE+uNznWcaRLfn1/qZMNKqupUwTn4q7KtC2pGcWJGrgEMl0upn5LpaA8pFAQS1T8Pkn4FyyRFXsomCAnR32z97I6TsE0IJgmypoxt6ytwdUDsh/C2JGe0blC/dHXB3Pe7Ofc92vBEchx8dmzL/qJdoz/kuo7JdpJ1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682022; c=relaxed/simple;
	bh=qb4j9++Wn3pdMTMVafXv2RjMOn0flrFFma6bhaJd+fk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YkH9iZwctwJ6I4zkVzDzSW0E/he0Jcf+660Na6pbNaHnHY6sTutK+ez7TcPnbnkLfmM26V9gkUQwQB0h60iqWFOBcxyF3qNnr85ROWxNUSKnhO26Z/nPVdVIS6pfdGV03xXuc8R4Wzlis0iuLTcIobivth7KaGfi8HZhX9WCh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrT7EN0k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrT7EN0k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c78a10eb3so1718355ad.0;
        Fri, 15 Nov 2024 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731682021; x=1732286821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D85tEXw3ghRcF5NOG0pxapc7stLsNP1lARjnSuc1Ehw=;
        b=JrT7EN0kBHZgnqW7SZSgLYfO4hr6jS0IOopC/R48ciSxzQgToTctrWzmGFLZ8kJ4ud
         XawCtQbufJ0t6O/rBtPgDugef863WMSFTEO9AUxWXoGFN9oNXm4Ef1Wc4d+O22qwmm1W
         uzVSDQtayuI+dUP3YwF1nyF4MhpZ659V0MfMU2Rzn6ClZqV2yd7pJzShDNM0kDY2m0N2
         Z3ZuHIX0Ln8ezDL6OSYwBJELRYY+mVHVSgU224CeGMkRZqvfhVaUnURytbAlVWpm+QDD
         gPaLBioP/PhqYJ5k5owXMVzjePdqVuAVXPClv2YI0WczmquEo/6J+4+qJrVTx4VxXr1Q
         Fi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682021; x=1732286821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D85tEXw3ghRcF5NOG0pxapc7stLsNP1lARjnSuc1Ehw=;
        b=gVT2Jg3EmCM3I5esD+/kL+7is6Yw+tRHfHdp2V+mgo6IidELqMI+itPwlDR6/dB1rU
         qEIzmziWA7HD1l5Kund6z84FgwZfKZ12Wbh6RdC1YEf5gGi1US+VqyEm3r9npGb5cQR8
         gbQRJPcAO4mehXd417dwByU1MwJKqJFJoUJH/37FtXgrOte5/RjJVkGrivZFyrhP3OOz
         1Icj7ipxw/49q3BJcls7hLe3+QCItxyu+F9m10Gapu6dPSKg6AKTtZ1qRBi7YfHMda1a
         4udfrloDCmr7ZluVE0j6UPvTOn4A48+y5EMIHz3x4m4nYp83Jw1+0XiLeQNNkNt7BZLl
         ZRHw==
X-Forwarded-Encrypted: i=1; AJvYcCXZY50QaSSVdOV19nIeDr9H32PVkyJFkeab7rQ8LIPt/HNqddpgaOhLDCdIGlB+yfmnFZgrhHxLhDTMLv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8UpEPrFMZWW46YrSSs6GP67GQFNmFvr7bagyRS0sBityeXrm
	HIk8CHi/jJYQkLKmpjO/0Cm/raiKCCDYrdjBBJ6vpzLvso+Z0cXQ0OQZFg==
X-Gm-Gg: ASbGnculNiQlyfmW9X3fJfapy0oC1j/pXnWwLRBowxvhWRvqqNPVeGLeIsu2gRChORg
	LVlEjhnfOxvnNh9c0VRltntYEKwvqWUiWrPKcQgsBwNyJCNviCQakIb/c89vOS9WK9bKz9cmtqd
	zPiHb2lscaH/AZnTNfsxx49eTK3dxwAVH1SHJABpc/Jcr7V24bzCOa1VqoF/HWG31k1xmFjnRpW
	RJqdJPBuQZEisY0QNB3ynlh8daPJUuj93l5ZEsUT5lCSfMXvQ==
X-Google-Smtp-Source: AGHT+IECTcGn0sQf5zoyLHcOihDrUxKUsdIryYLh986GKIo7YKNiN/dVsu6iEh2i41XaTD1AWufGtA==
X-Received: by 2002:a17:902:da88:b0:20c:60d6:2dd5 with SMTP id d9443c01a7336-211d0dc5196mr18555095ad.12.1731682020836;
        Fri, 15 Nov 2024 06:47:00 -0800 (PST)
Received: from dev.. ([2402:e280:214c:86:37ce:58f9:f47b:37e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f467b6sm13115235ad.171.2024.11.15.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:47:00 -0800 (PST)
From: R Sundar <prosunofficial@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH linux-next] lib/string_choices: Add str_locked_unlocked()/str_unlocked_locked() helper
Date: Fri, 15 Nov 2024 20:16:16 +0530
Message-Id: <20241115144616.7453-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add str_locked_unlocked()/str_unlocked_locked() helper to return
"locked" or "unlocked" string literal

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

https://lore.kernel.org/all/ca4f7990-16c4-42ef-b0ae-12e64a100f5e@intel.com/

https://lore.kernel.org/all/498a3d58-55e0-4349-bd92-8ce16c6016@inria.fr/

There are about 9 occurence for locked and unlocked string combination.

 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 120ca0f28e95..c3ad47e1051b 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -82,4 +82,10 @@ static inline const char *str_plural(size_t num)
 	return num == 1 ? "" : "s";
 }
 
+static inline const char *str_locked_unlocked(bool v)
+{
+	return v ? "locked" : "unlocked";
+}
+#define str_unlocked_locked(v)		str_locked_unlocked(!(v))
+
 #endif
-- 
2.34.1

