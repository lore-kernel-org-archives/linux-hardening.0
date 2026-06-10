Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA73769F2
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074260; cv=none; b=GSvGTJaNDqGPlN77BND1ewaKzYOaqdFVIkNoKLMlq95DyipgExpL326V79cvgmtx+wqs2UtzM0AXSHAdi36vPCMm8rizlEdv69McISFVfboiLT0i2SqjFKKJBFmKBGwanA+l+G9lVCtMJZeM8yrlBMPQ+Y1l8rUUhsfUBETBuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074260; c=relaxed/simple;
	bh=79DnwxJFzJS6ztuiCswAItKY/iEYoA/hB5xT9+mHBVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFoETW+q4K+a4z3U1YWPoKF9cOU91u7bXpeCS0INcDXvPkeGExGznn9M9ues7o+MZeuA9XvR6Q1+5C/8TzWKMFlLIIsCzSxYpuw93g3YPRFH3WoQMFXy5Oqz6Tz0zqyebtJqz9CKKG8x8s+0aLGCO4U5Eq7C9EFQmP5Xj7ykn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frYluLQZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frYluLQZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4602e2a0372so4604940f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781074257; x=1781679057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/bLIEy6KRuoctCkoU9/pMoqja9vj+0u1Pq617vGiJU=;
        b=frYluLQZzpCw9Qj/omMLQTkeKDWA4SMnJEtf5l215JOPpOQV2iTX0ieWjG5q/47url
         ZJu3UffCYf9M6rrmyvf8EYF2eQSCoWQbRZu2Y0AxZ7a8Lcc99Klty7BLxu87G2OgoewP
         huH8o+9oxy7HsDwtce46voYMOSpQOfqxcIt5XF0uBU4CXHKgvGe7B+NO9HvWhwcusbhx
         6mh/pyblwobPdgzpv4VuMWwTNQjMsRWTZT/1J8xeZbFq/+Bo1SSNFflXfKxk6GKgoEtW
         fC1CKednRHA3GaittscWbT37SY9hzqADCcDgNNmF1SqQu5+DiuNZuf6Hl9O0rX6xsR9H
         qs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074257; x=1781679057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/bLIEy6KRuoctCkoU9/pMoqja9vj+0u1Pq617vGiJU=;
        b=Lh5afKv3Hb0ZdZsyAtBNXATMth8Ze3BMrhZ4bH6Ylpvvtwd5QxjNCLfj+hFp1RcOO1
         1B23/ljV8++JQJLJhEeERKTVJO312fnjLGPVJ7mzCL3361V7F6TIJh27FHmFelt3zf26
         +5LdDPzuFkgVIKgiRzZxpLA8FrnvRS3vah2ljg9w+S18DL+QHDlmVdUmJ1va8Ur+xtEk
         D3/iOlOEJyaL4bByS1NBL6YP2BtKXL/Oxb2HX6O9q+hbjHUd38jeRRhZBcgt/K6lK3q/
         VDYmGQaniksooJwB9RCFq/3VBeWXpwRlolCSRnGxYMmxmGtiaBUsHUoaI5ga4r7XXXV7
         RFTw==
X-Forwarded-Encrypted: i=1; AFNElJ8YZa6AdqIQ2gL9Br7lIOAKyQLyZgChaYmciukDX910SNpkrBgiuMm5jAgKWwDyWuK+TLmA1CdAEtKvxjhLA08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoKSqeGTEytSphUkhsitXJKkVChPS6c6SoFXPpY0mT5XXwXSl
	2sLe+xlyL6o6tD4Zqk4Gl1sKszpFn1sKQKhX5vXPT4YpnK0fU4pvyQg=
X-Gm-Gg: Acq92OHmGdYsXuJ5awz+Goz/NXdiwetFyqtkm1j5/pePury/a6CSKq66VZNrHCqrjvd
	+81h1DmpYp4omsyNyiunodZp9rWGOPXtueGeluI2w0cbkz/9/wg0paW2PBWhVujaPOOGqJddUPB
	A1hAvvn9/iadsM3AySkmppFDqQ4PecL0QApMl5KEXEHsFlNntykL9ikoKZIzFomvOZ2jffeOPAr
	eRRjq8fG+uFSTnL5Cmt9YjbufwdlKVJF7un8OK1fjMumDqqMiHQp4P/dMDD7UOap2aSTeJecrJ7
	LLm0t1445q8T91hsmxJw48z91etv4Wibm1bR78ucnwp+C91eX7xpJXfzMMb2Vr/mWE6bssGyj9K
	vTf0SZ3Q4CYhtnwk/b4z0UUJdSAx5bUipUwK6BN5RIbmN3CAo350GfJRHCLoKfcjRvEWmJ0vzMO
	Q30VRaOOjNr5evUeRhp9AXhDaW/H93qTdzocbRMMPHHjarAdi2D6rIFQCnU/bqaOm5XVP0n/Oo9
	0cnS9XtZBFz7w0H7E3E0Eg6K0VuHu2xBzNzbmKyFdU=
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id ffacd0b85a97d-46030652fcemr28960085f8f.26.1781074256955;
        Tue, 09 Jun 2026 23:50:56 -0700 (PDT)
Received: from hp-ubuntu.. ([105.158.214.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm69539946f8f.9.2026.06.09.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:50:56 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	vbabka@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] keys: prevent slab cache merging for key_jar
Date: Wed, 10 Jun 2026 07:50:52 +0100
Message-ID: <20260610065052.9120-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SLAB_NO_MERGE to key_jar to prevent the allocator from merging it
with other similarly-sized caches. This hardens struct key isolation by
ensuring dedicated slab pages.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3bbdde778631..592b65cf8539 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1275,7 +1275,7 @@ void __init key_init(void)
 {
 	/* allocate a slab in which we can store keys */
 	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_MERGE, NULL);
 
 	/* add the special key types */
 	list_add_tail(&key_type_keyring.link, &key_types_list);
-- 
2.43.0

