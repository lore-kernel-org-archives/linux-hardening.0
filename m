Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072128A3F2
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348262; cv=none; b=ZZgCRkblKqFBsBaaTcqlbxIoBI8Y66IVMAH+x5PO536TcVojDr+pRltRe6M3F59qgtXvf3Lkp4iFPUKBKk18CVBwkmSzJQxL8ZQJ4ZHif6iXSlzHVhWqekI87xqwrTpTqXA9TLCnb9pR2oJCzK1G+GZjhk+bCf2AduhMaIpcAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348262; c=relaxed/simple;
	bh=P5vcDzmN5k7Z8cEFhhpbVJGvHa/5zkkk4oHxR6TG3No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Agq3KRN03zOiBzl6vl/rP5TN1Nong0PnotZBQjFKCcxvHDrDNs80cqW6FJFXSyhyJSSIKUlk85dLyulhYW5jUFeP3yVZWMK6YlL5Vlj5EUXHXwsg4DinltwFkxLfcrSyzaUCCP25TaYhvhwupWAn1TLOkMo//70e++8QNI9Przs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrC9lQjw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrC9lQjw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-236470b2dceso28213505ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348260; x=1752953060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KToix6PVwfLq8hzFA3dDe/05limfkdjWg/p12B+a8Vw=;
        b=UrC9lQjwg0NC6eJC68Rj5fKalAjfQsmumEjBF9n+28jyzoQbn3hHHS7eGNuMCmovPh
         lzsShRBBxUkCQ+DMlcPlO/COcYpJSN33fS0V8ezFnElGrrX65X+dw8iBA8jAxWOewlwr
         HfqHK8nH6kxIyCudZNT7ZPEDI7Ww2DxTykzes9NcX5CmGH36vS52XsbWkbA676FAW7oc
         ms7XFxcVjV+i124lNyf0hRP1kyB/yu+DBHtspA0aJOdak15l8lntFDQBsEHl8Efa7wWP
         txfm9B/bYbPkYBrUnEtkqySVPqeNO9y9St/Y3sjeKHtw5GIcXmIdNsaSwoaQTiDcAnbt
         SIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348260; x=1752953060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KToix6PVwfLq8hzFA3dDe/05limfkdjWg/p12B+a8Vw=;
        b=dN9l8h3LLHvjEq/PQNaj5M3aa0jpa9hn5xOm+El3zHsmHfhUEs49ZoC/uG7ESm5A04
         fR1PkRus/3qNLcncCn2a7JeMbFxBb/WwRF6CK8szkZ15cWdfJBAmqVoqMLoMdSkiU8L2
         ZU2zF43/vpAfIsdtrdOdqpBjR5NHULCrVkYZMbTIAgsEidFO3B7wDgCkvvYS7cgggmmm
         vQPcTu1sxnzf2C1aAn+uuUNxjKR6jZvCcA8D+EIOaFRWmuEvWoODzeYquU6ZlRxdicw3
         iA5Vv8LLyaR3RD4+0yCXOFa+Xd+Ph8Xuogu24YvLz97jU6l8cQTYqIRWOFfDHeYUqJ0q
         hXiQ==
X-Gm-Message-State: AOJu0YxugBpkbJ72O+sSybqJFIeJCxC2Keh0rDQfPYaIlj4/7RQlTp/k
	UD7sNjhE4ZzyKrIET51adx3cw8El81hi0hb9I5Uh9w7QZeIdDHrrhwG8/waDQIaS
X-Gm-Gg: ASbGncsMEc33XLDqEz6kCImHK8K9X7Tw43K4GvzT07ej77IpiLeM+MX3eCvKynzix0j
	wMzGUQHp2clMhGTsOi89b6wef5h+bqGIEACEnvIxhf8mG1J6k0tykYFVnAEHRmNIHlm04oOPmzc
	2Igyzb2hWjTHsTkumSfvsq2DTrP1JkL0VJdQAPsN4tXIsY5B1RG0tKmbRZC8pXkGAv9PxADILrP
	CfOHR4QMQLm9Cs6ACfILYffT8CYeuPG1/kQF40f+7YnXlqs/JW+xHps9Vi6Gi2uIwGm0MB0m5Pz
	QeOmm2j3xJVmIG5AfaT9wCm670GXqTkatSjjuatQHhvmgid+Cy2fpdZ4q0CdZpvTBIEtytkvAE8
	cPVGq6RJqiGLxEZA0iDpsZ3u+xLbyulBwzp26bi2SJTQq0pHGxm1aTxk=
X-Google-Smtp-Source: AGHT+IF1/SBi/0hgioPrA9SGKFH7ELADLRT36qEzqF+7hldOG2JXPGSxCbfybdpA+qgj6sGLDnb+4g==
X-Received: by 2002:a17:902:db08:b0:234:8e78:ce8a with SMTP id d9443c01a7336-23dee3a62f4mr102900265ad.48.1752348260256;
        Sat, 12 Jul 2025 12:24:20 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:19 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 09/17] exit: add destruction of SafeFetch caches and debug info to do_exit()
Date: Sat, 12 Jul 2025 19:21:54 +0000
Message-Id: <20250712192202.707192-10-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

---
 kernel/exit.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index bb184a67ac73..c712cd11a2c7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -951,6 +951,22 @@ void __noreturn do_exit(long code)
 
 	exit_mm();
 
+#ifdef CONFIG_SAFEFETCH
+	#include <linux/safefetch.h>
+	#include <linux/region_allocator.h>
+	#include <linux/safefetch_static_keys.h>
+//        if (!(tsk->flags & PF_KTHREAD))
+//        df_task_destroy(tsk);
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_hooks_key) {
+		if (!(tsk->flags & PF_KTHREAD)) {
+			destroy_regions();
+#ifdef SAFEFETCH_DEBUG
+			df_debug_task_destroy(tsk);
+#endif
+		}
+	}
+#endif
+
 	if (group_dead)
 		acct_process();
 
-- 
2.25.1

