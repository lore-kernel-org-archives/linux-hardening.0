Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA1218AD2
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787480; cv=none; b=Q6dv8Eqs6wsktrYRuJSeDYAIdQIkNfXNF0wWs3we2nkP1m2LRDgImCA7C3fBgCSalz09fuCwZc4eIYWO+CGAfBxdssJMkqHaJK3oTQcXta0TbPgd1v0UpKQbyFMNIqmBfWHHKyFTXrLOdlMqb6NZDvNsKzOq96rkH8JGLt3bKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787480; c=relaxed/simple;
	bh=61J2pu5l3ndGn9woBnkjvneIE/RD9R+0X2yrx5ajIWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPTEsYOs1hWLSjWznf6D9Wdiu3/uC8R18/uOQOpV9L+BLLHdMvNKjdzcZEui39+cGODHyPwFnNZSPDOXNG6g6Q1dUb1kTwHuV7316Ism28V6gtq1Y+z2SJhEKWuBtd6kdP1sr9ffZ6kNAFekRNNckSgzQaqZ7CFGkzyUOIponU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsEMpFNt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsEMpFNt"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb75200275so249018666b.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787477; x=1740392277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldGwrx2cT3RoWK8xQPpncYSf7C74wmzaVDctYgnNzT8=;
        b=ZsEMpFNtgC8tqQQhhiNG9KGHmENdgB4rAu9TzSfsY1MSvj3kXgq+zR+OVmeyE23lfY
         hIOT3cC2fIbGcc3Hzbf1dVsmey8oQxNt9XMXlNncyUSDe1Rvj2UouxOZ4iGlTzGRBfoC
         pZksizHBgwUvweaz535oIlBw/CTWRn9nfeek0P3NytAJ/ck1PqSOG75pFOD7fYRIh3gG
         O6nwqs5eEGWqJfIuGCDSIw9uRuAMXV92lTqoOVNC9s8i3VuzuxUFB+lS3gs5+9o1ecq/
         Leib4/k/6UMbNc6yq9iTHWf3RDatAVe5pYDPb+fGwOIwr77wjdmuRPqiVrJlBvBC5gUk
         uP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787477; x=1740392277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldGwrx2cT3RoWK8xQPpncYSf7C74wmzaVDctYgnNzT8=;
        b=kkwq1YPyyDpmDV4i3krN/kJLjwiSbV9OiG/WcVz5mT7HRg9EycNxY/HfWhdeQKdQp6
         xLB7v+qJyg8L7mbtpWTAUdba0NJKvh0wPzekMZ5EcWbdKETStHJh7kUpACvOWk+EhBr6
         RFm77lllMpNLTCuNUDvPSXvjpqpFVF4WD/HwupDdDc1oS+D9AexN+NMNQpO+MW7NQ1a8
         ns2gOQO47FSk8PN7lJrcZE6CNUhn2VsOOXY4tXt9KztB/ev0GyDdZRrbu6eNlWtqF6n8
         fCMVG8w1bFmoj41qdGbg8mexocxCkSV9ExSbdzvEFLcxFEU5Wmsuhzh0+cT1zBk4n2AN
         ZWEg==
X-Forwarded-Encrypted: i=1; AJvYcCVK/TcmdJPN7T+qb8/+FPb8eGK7vhvhsLAsrbrTyz66QYvGFMntvj7ZL6yRYHYoBSkNNnuCcFte3OYezAxJBt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmaaYUZaAWH/BYWFEFOcE758nwFMKTMg2LYnKRGyVFn2w+7qH
	a8E/gOSS4Dfz5ZeF+fvYI2LLzx1OpsxeQ3mn0StFcZK4oeg/dpjkTIjqchqt5/E=
X-Gm-Gg: ASbGnct7977+dDIgpVoLGUr2VzT9UZgotU/w4o6iGDLJ3z/gy58A2WANUOt0hqnFMHA
	7R1hyN2YLbTxKVL4BVYkIT16Z8ikKifXi547R61kJBkCwaKA+qwU9I03Zzr1tNwAsOdXQnE3SBA
	sjkNeY/grG6af4rxobvRaIuHHtobkXEPYcT6H3GIAwdI//EReaNVOnsDJ87JcmJxKS8M5r8Kzkq
	CWAEbSsVUJsLaWRSv6jADWmrB8oausDYTZg/eksnn2ca9eOX/QHgx6yrKLwBpWzxjyO5R1oq4wf
	wT2SPPndr6G9qOOgXdAFhmQ6
X-Google-Smtp-Source: AGHT+IGLJ6wBq1Q2Otx2cXUsLqwI686ZT/K4uXqflhPHhYRM3ByDKMZpdTFQUXVBYhqRHLkwN7a7fQ==
X-Received: by 2002:a17:907:78b:b0:ab7:c115:68fd with SMTP id a640c23a62f3a-abb70e61a23mr916824766b.53.1739787476706;
        Mon, 17 Feb 2025 02:17:56 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:56 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 07/10] printk: export symbols for buffer address and length functions
Date: Mon, 17 Feb 2025 12:17:03 +0200
Message-ID: <20250217101706.2104498-8-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

log_buf_addr_get() and log_buf_len_get() can be reused in another module,
export the symbols.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b..022947f9b61d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -588,12 +588,14 @@ char *log_buf_addr_get(void)
 {
 	return log_buf;
 }
+EXPORT_SYMBOL_GPL(log_buf_addr_get);
 
 /* Return log buffer size */
 u32 log_buf_len_get(void)
 {
 	return log_buf_len;
 }
+EXPORT_SYMBOL_GPL(log_buf_len_get);
 
 /*
  * Define how much of the log buffer we could take at maximum. The value
-- 
2.43.0

