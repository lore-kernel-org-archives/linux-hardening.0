Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167B28D8D9
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348262; cv=none; b=p4mgyhbmQPpWhjmnVfkszziRq9Uuweu1EqLGT0gsG7SDXSSDTbbOkXn4qvG5dp7eZervxb73J/P3d0LDRgriNxxzJdrqmznKxWxPk2Bn4jaKuqVIE2fEDT32nzDnHWpNN9/9I/1LqgwodDKlFm9U6aOmJlP+M9yqYq2n/QK5EJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348262; c=relaxed/simple;
	bh=nQNhTlb3Wi3AZs74fxwgaCsEeJMqAk+Y4n98Q1DatjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDMyJUtHxK9iLzsm5bGS9uhJhQy/ndV1ZA02n/3OaYdIo0UBB+yzbD7Rx03eANqeyGK4iAwM3/crmuo2KCvBtCFbboPw3PPvb+fHirvoUkszb8ffsOAm3XzMYnnnEwXvhkdt2qy3nTHxsjphFQ5Fv4OBnOCLtWGFF20o92cBut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO2xwM82; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO2xwM82"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so2603368a91.2
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348259; x=1752953059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0w5dNU4zVBgHy7X4J6SeopuOAh3ELx5QZLUnf2Hkb8=;
        b=GO2xwM82EixPoQgjY1HKMf8HhvJWUCMzYM24rrCY4ZvMQmCO1AIB8O+qZqhmvUww4+
         K7cng2tHkarowWN2ZME/aix8/te+pMJKYei+v1tE3HRfen06Xxqu9LAZUaK+l7i6xHDT
         iSx7D1oECMTaElH6hxX3HE4TUQUNw0Ik3CJy+mjeGZEkKo7YXzmubjxsjJvySQEQPYB/
         9AhK9oJF36YlC/x7cxfUarls52bc9SI8Zq35++PpLf3hpCuU84xotUliJHOZeT0ww2gH
         J0wVqTu3zU9E914Jm4TOd616XHlSRf4QIuMxdWg/kBf9U9AViADFyE9yji39HSuyyx5k
         XuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348259; x=1752953059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0w5dNU4zVBgHy7X4J6SeopuOAh3ELx5QZLUnf2Hkb8=;
        b=DT7fYhy8xdxs1q7YrEpW35FVQJ6pyF/RwNKXCHxoQdS++3hfyqN+C5rd97PhovLbqu
         jMZuwWrlOBwKiMCZdoEyOgbY7z6nIcfIEW7Kr3JRUxfCKJ8RDk1HYqVpAtaSTL2bibgA
         /xQ4dXOxjDhIF4TGrxq6j5mSATLvnvE15qYHEkYkDPWL7V6ZaPv0eC0q6sNqZWQKE+gV
         AUK/Lv6E2cX8Gy1iHCvUzn7Nxq+pzNf3vOb17Dt/V+Q7Chm+F6WF/Z8/lvJq3TQc/gjY
         cQpBevWu4OX7BoJOIDCgZyJL39ndD3YgUHedC2FMAj83Gga326p3qC8UvGCy/2gkqnv6
         sCaQ==
X-Gm-Message-State: AOJu0YyEEX0YHbavN4aIaaaxnCU7+ntiR9crzY5v1n2un30cVzy1cK/T
	JLwo+Ve7fKZ9Ho/gNeN02Yu7r1iCLWNY8dY5XXQe/yRdupVuM4v9OD4gSA1jWN8t
X-Gm-Gg: ASbGncvHF7fHJ5HesGxXuGxfW2XVhiw940R77AbV8ECvGGNIA/ZCmt+e+pyPvMcBAkW
	71Vtvuze4+i0Ax7DBUpOZxqJfPbjO4/YhM0zKSCcZUz3em12D1iaiAMkhPoDt9ytqV32H9J2AYE
	swOwGyqKhfU/u9nkFceNKTC7GBBucgAk49Qj8Mpwbbg/iP1FOEB4CPNYohbts4CzelFdMAomRTK
	i7yn1hjo9LDHDqt473eQ89bvM9N97jLRIIkqQxwUu+6CIwuCwFGCzWbMIWHDM/70ZofJjKV852E
	x5saKQydEO2LN8stmMBy0VFV/N4KbOuMMJoFlLiS3FApPTg/2QF+GZwSsgxc3HtglGdK5etnb6D
	B4PLMLwYmn9LMgEuKG8oemStDmgobBTMJbus0U2SnY2C2
X-Google-Smtp-Source: AGHT+IEoW+wtDH87fLAkLGCYbgxGfuSk1CCXkmX8lnpGJ55Kdb9Dt3QgdgGTKzbAgPJmsEhpLuC6bg==
X-Received: by 2002:a17:90b:578e:b0:311:e8cc:4256 with SMTP id 98e67ed59e1d1-31c4cd6303dmr10559759a91.22.1752348259289;
        Sat, 12 Jul 2025 12:24:19 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:18 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 08/17] init: add caching startup and initialization to start_kernel()
Date: Sat, 12 Jul 2025 19:21:53 +0000
Message-Id: <20250712192202.707192-9-gatlin.newhouse@gmail.com>
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
 init/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/init/main.c b/init/main.c
index 225a58279acd..72e55704ce2f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -958,6 +958,10 @@ void start_kernel(void)
 	trap_init();
 	mm_core_init();
 	poking_init();
+#ifdef CONFIG_SAFEFETCH
+	#include <linux/safefetch.h>
+	df_startup();
+#endif
 	ftrace_init();
 
 	/* trace_printk can be enabled here */
@@ -1098,6 +1102,9 @@ void start_kernel(void)
 	arch_post_acpi_subsys_init();
 	kcsan_init();
 
+#if defined(SAFEFETCH_DEBUG) || defined(SAFEFETCH_STATIC_KEYS)
+	df_sysfs_init();
+#endif
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 
-- 
2.25.1

