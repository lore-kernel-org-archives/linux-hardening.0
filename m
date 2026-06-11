Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F07341068
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161371; cv=none; b=cOXHTgL5QjhdChJV7vx9bAcDlXRcNJF95pYiKpxyiI8DX8aoK8C5aabNJDUJyw2k56lXUlBJtvWyNogA6ujWVstKCM7L5PnnAWsWGeHxodpvSCXTWgWxP+QeTT96B9qf42JHC+duMj93ykXaxKwcD9XI9QGV1MFwDZwto44JSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161371; c=relaxed/simple;
	bh=yiDYo3uXjyQYEP8qg92do+PKxEnqD4etbAOSczuXrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEjuYWDV5pOy8WIY19ZlcRMgaDq9uqTE4uqUS4Jovro8Hg0np7QYgPe7WhB+lwI6RyJw6m0HzhiQOQmbKntWjHlvVo+M1YJQzhBST7sBy7oUGZCLMEy0Cb/fBOuf4rs6jNTud7xuhmGGJMlxArhDOuyTPXNaR5WF6LmSLzFoYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GccVdRT+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GccVdRT+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef29c5561so4056676f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161369; x=1781766169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktJHYJQkk8yoVHrYe038VfAc/S/hFzjEvTGu3j4TfPs=;
        b=GccVdRT+kCgaCnYjV/i/sQPp+svexE3XaAS7FYOA+n0Tgn73UnvEPY9wqGxyy19Hkt
         Mc6ITjeHBvXV4f5k034xzaNyuN/JMycnQmRtLNqVhUBsabMi0stma0BYkChK9RsfHFfj
         C209z5u3/BNhyV6JBQo/rQhc9SglenhM9HIldtjtR196E7pp9Ip0jJ89JW2H7CA+YvHf
         04ktPE3D0acu5YGIUf1C3cnrplirpQBH0w/ehcyvj2If0VS5X492N9j82hKZwDWP9cdM
         Zg0roPbvmduY0UygJcJkiO1Yhrs7/vMZET2io0O8dbQvGy9lSD0nHGd6Hag+qkQzVz1M
         d+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161369; x=1781766169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktJHYJQkk8yoVHrYe038VfAc/S/hFzjEvTGu3j4TfPs=;
        b=fKVpwTc4v/jB+eChZwzwCKEzTLzh7y1kbS1r9urR1iKNnKCwBVsuGXh/3GfOaDouP0
         WLFUu+FeEg6vsNfhNCua5SzCfcRZoO/cfLtzP0oB/l0ysG/jnBTrQPNrkEiRvzX0S2AD
         w0igpQu5TzKLQx8io7cE8pjvfCcT6dHu0UDho6XIsU5RrprhgdDaRI8YBt1iqzZAHuDO
         qUq3ijPofZLVVkggnsoMgPgSGKIDuGR1QWfQZoyUYiaGCmY3QwbCESssF5ruqqlQdB5X
         qlhXXtEpYaVhSdJVd/mkPbJTnoGkVcDceie28IFQF35sXIRLmDlkt6kUqgnDGtQno1W9
         p8qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rwafLIXxYkd5JidnRxyMTC3dSy4adBgb5UZkwL87bKin9JG5jDB1ep08P7yn0THv17W7GMu7+IQ/5i9xrVLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyEYPz5Q/yyeAShciV2BKsRbV+sUdKTzmT/TuVeFp1lrkjvnZ
	GFtUwPCtwhR0htCY8Gm2RaUFoGqZH/lPpqDa9ebfc1ZlW7Zwfmbs+L8=
X-Gm-Gg: Acq92OGtrbDIJVBooUuIPRlLSslelQPfPI6v/wiuKXZeQ83RW+GIHBka7PM1VilE1I0
	s3hNW6KCHyvFTtNRKzfy4hVREc7w56ZKoylCYSwfrQ4N8AzPosnpuPvP+Cjt0wy91v2RcymOEka
	Tdpy5GMxx2X72JaXBS8XiYpeR22m7qLIilDmyoDUP+Fksm+DAk0FO0sJwEFsn4xJhdHgazI2D04
	VK0Ezw3XlZdvzb/rwCvaGEwI3DcPxdy+ZAtfnKaBxjGk9i2/GddFaYgbdlTdO5y0pafzPsMQf3c
	H9U5pe5EXy7+WQN+DX5pChitkeNfJrmtPx0M/mHoGSEJI8MZIwL6ucMDsL1s7j9cvLDOAOPbnLW
	sP5t8Ga0yzxNAbg68JNE4sUdQ1B4qxP++CJaSfcbYXB9400yCjrWBscqDF7tmttbVPczKEPMHJR
	Kn6HXAaqe19skMN4e2JpSnzUaLJY9u3V5BxuGwwwSl5NVPhdICctzsOglEq5/fJtllw8WmGVzaM
	R4wmwACFBILXKOKidkwIFV8UyoNohEWSCj3gHNE
X-Received: by 2002:a05:6000:1842:b0:45e:f3b1:52d1 with SMTP id ffacd0b85a97d-46067576bfemr1862316f8f.9.1781161261836;
        Thu, 11 Jun 2026 00:01:01 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.138.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm76550344f8f.15.2026.06.11.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:01:01 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] cred: prevent slab cache merging for cred_jar
Date: Thu, 11 Jun 2026 08:00:54 +0100
Message-ID: <20260611070054.6550-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SLAB_NO_MERGE to cred_jar to ensure struct cred objects get
dedicated slab pages, preventing the allocator from merging this
cache with other similarly-sized caches. This is a hardening measure
to provide type isolation for credential objects.

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---

Changes in v2:
  - Collected Reviewed-by tag from Kees Cook.
  - No code changes from v1.

 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..0e4ee60a5acd 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -557,7 +557,7 @@ void __init cred_init(void)
 {
 	/* allocate a slab in which we can store credentials */
 	cred_jar = KMEM_CACHE(cred,
-			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT | SLAB_NO_MERGE);
 }
 
 /**
-- 
2.43.0

