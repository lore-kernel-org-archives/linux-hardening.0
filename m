Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C763B14A5
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780755970; cv=none; b=UAK6a0BSWJ4Pt1n9+y2RDlm8UM6QozBlOxzlCKf6Kl0arbUfSaV/Ry/G/fteHTPtwaAS2ZH+VFNqrxj6zUuKZ0RrlQ/LmlBGptjKc8cGEGErF6zql+pR9hT7a6gpcjIPV4sH8TrCWeT3GQugPuTnPdXNnLNF2E+aHdT8EE8ktAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780755970; c=relaxed/simple;
	bh=+hyM4gk1hqjvyfZgMjW1YVTkHIHEHreAZGzkhudju4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCUxaAoEosIVelinCPPShdhmxaE3CJ4pHvHtpJE6ZezYFnfG2rw4+uSCE0bFxc7ASly4XCpl2oFIlK4FgwSy2T+59SztktoyhJLKM/J7+mkGVf20AG22ZpTAbUzjSzd+juKiWxy5pqGWoRGa15//4yaqpvoSJQqN/syttVEBW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgujt8eh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgujt8eh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fd45e596cso1366607f8f.1
        for <linux-hardening@vger.kernel.org>; Sat, 06 Jun 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780755966; x=1781360766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi3D5Ovx/vc/M3F2YJZvJdLo/rPpgsVFqrneVPAyiLg=;
        b=Bgujt8eh/e1ASUydDqvSJl5iCcB0vX11xXdNpKXH7ikVYSzxurj5OIHEnrj9TIyE8J
         1Sy/ycHlGOFxILB4MUhYdI/axIWzAQcBLkgW1iZYVW7lqGVP55hpJ9DucLWGwIPTpHM8
         o9cmaKeUBzq/DjdKB9my5e6ca8dsJghNkMyun11VdgVnxFcMn2QIpxNZ5b2q9FMEiX+4
         qelNJRb0JZLYzHGLclBMU8sXuymVAIsimuQE1vXpVuVqGIVrQO/0+L7XhoLgxKw5ZrOi
         N31eMkIDiWfOy8BmctKxAzr+rCTHmtnNsgJpxdTPXqLwsSmSyjAoidnI1pAZORLw+VH1
         RsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780755966; x=1781360766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi3D5Ovx/vc/M3F2YJZvJdLo/rPpgsVFqrneVPAyiLg=;
        b=juQSowkzAy0U1jsuB6T5VCt9DfsYPgrTjMql3iv1dnw1lul2vjI7tfFnWbTXtAZrfd
         YcBCIqyC1koWGu9SdChIQSkPGCzlhc4rDlRggbCNB9UIbAs7430q4J3JJYDrpt4BkD+t
         WojHFniRgvJjGMVB3FuszGHBNkqbf2uQx1Yg8mA6A6HA07wOzZelXC5hio3O1IKRKFdi
         UPqW1hR+fI0gq0WvK6yg041oqp6WKy3cEUjcVitOWuYcfXyQ0Kgb1l7ydfw8o3utXrhk
         86jtFTIuw6T0E8fhwQI+qvUuV7QhhkTqpt/LFu1qu8/hL3eF/AiA0FFdrVBai8yt1Qz1
         S9Sg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ky5opieS/YTIz6KLrxk0t+HZ+tbxQDtIldVCekXLZCWrrUj7f083gcL1rWg9qYcUSNB0FEAYTgmHKS8FhWVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTeZDX8RGCzzNWekTVs+G/fDWm/OdTgf2scB+1UH67sL7591nC
	29m5Txof0ZBUQFClXB3BAKkCmLWuoA28flq0Rp7MEmRQl+IB7HlMp6dyK+m6
X-Gm-Gg: Acq92OEfQvAtGVi7UwnNZHLbpOu0Todqem0iPRktKj5m55k3SIgoy3D571Aew24UA3K
	hbZRvW2Ams5WLmD6s0xhVfEk6wlJMq+7hGVfXyALBRCQB/0TygcLfX6KTHYDghEj6/aIOELoRT+
	M8WeevbVOSFvAwLxHAEyTYzFr/IF/V32w2waa3TkNZQ9mM0ZJUFGSaze3rVO8L+fF+dHKAEH2vk
	dEpP3Ui+BevePyXpH0+e4liT6888mBLHCcWVJnVowW7hmK9lE1Pkkg2BpEsImsnbq2VMp04PJxx
	BclHf8dg9cuYvBd3EzdD1uj1dC/LgjbzP/y4Z32AiDxqZpj4g5YXYblOaY9ekqli04KLcrkp5M2
	0kzUdDvPpO2nfIVDYfzZUVwYBn+ZbMTZn/0OMnohwHQPZKGqOxtAlcLqhgUZpoYAGTb8VEquUMd
	VCQWvVIyo1QecYil4V7sntgQUhN3W6gbExcTlC8HsB4oQ2fvZKv3BOKOJiZH/UxaxToISRra9sg
	tiP9MIW+DEbrc87smH3tPFUXWyXOzHAUt2tMyCjJg==
X-Received: by 2002:a5d:54cc:0:b0:45e:ea9b:edfb with SMTP id ffacd0b85a97d-46030766c2amr9776459f8f.39.1780755966236;
        Sat, 06 Jun 2026 07:26:06 -0700 (PDT)
Received: from hp-ubuntu.. ([196.119.187.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm37699842f8f.23.2026.06.06.07.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:26:05 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] cred: prevent slab cache merging for cred_jar
Date: Sat,  6 Jun 2026 15:25:58 +0100
Message-ID: <20260606142558.13809-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cred_jar slab cache holds struct cred objects, which contain
process credentials: uid, gid, euid, egid, and capability sets.
Overwriting any of these fields is sufficient for privilege escalation.

On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred"
in sysfs) has 2 aliases, meaning 2 unrelated object types share its
slab pages (object_size=184, objs_per_slab=42).

Cross-cache heap exploitation relies on slab cache merging to achieve
type confusion between unrelated kernel objects. CVE-2022-29582
demonstrates this technique: an io_uring use-after-free is leveraged
across cache boundaries through page-level reallocation, ultimately
achieving root. struct cred is a primary target in this class of
attacks due to the direct privilege escalation that results from
corrupting any of its identity or capability fields.

Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
so that freed credential slots can only be reallocated as struct cred
objects. The memory overhead is minimal: one struct cred exists per
task, and with 42 objects per slab page, the cost of dedicated pages
is negligible. There is zero performance impact on the allocation
hot path.

This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for similar
isolation requirements.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
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

