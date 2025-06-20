Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D452218EA2
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398504; cv=none; b=GjD0YLeWDuhkUFoTM7sS+gWkE2ZJ8fqhDXzsYD2Pfu/dniIF2etiv+CT7pmUQ2uz9AsYw0hX4/88ki5UKMpMfSMSl/fsC7oA6gUOrYlaeKcbgx43S5aJ6gi3GRMtSRj9loPu93RTDUIXnaduENm2cHw/5fff5uJCjPvc1O9cayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398504; c=relaxed/simple;
	bh=S75fM3nM9TnsR7L4uT55yoIs2jbn/4LAz5Rs4K4sh/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvJFIC21hQMvsjbIyvFRjrKFSlISK87+j8v6OsusGBNrUQVUoSdR6fGrNU4U5h5xL5f/GlswF7KA2PZCKLtO0ghA0bzgpGu0uUXjeNJKxWXoIfToK2KyzoPSLKPJ6Yk52f3aEqfPzznqhSjvy45lW2fj5ls2AadI683iq/bNh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e5c9e2va; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5c9e2va"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2363616a1a6so10964945ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750398502; x=1751003302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDhdNRa67SFV3SQYqSsc+ujKA1vPIuWHhvTmauspQso=;
        b=e5c9e2vaRW27In8sJjFRZX4JAI6HG/qpTqecPVPmhdDDh6dBKKkKkB7SKyp1/JL1HJ
         foJX4G9ulj7wOEVhqCnV/M/s7xAYtPf+ycwZ3ZLR5z+Tres4nzpQAR3NWoHE1wjDqgJA
         R2Ggroh+enLgInAeji9CmeyzxLA2XQbF8S/vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750398502; x=1751003302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDhdNRa67SFV3SQYqSsc+ujKA1vPIuWHhvTmauspQso=;
        b=OFZhD21nFjSx32oMrywWZUCLc+FnscRZvnSCk7eT8BaK9fW1pHQkO0DxTtEjab//Wl
         pJhE6aRVo46wycpUFRB9C6V5ScW1A/fDnJ3/fSe/4+OY+RAi/EyzXAUALai/9w2SJG49
         +n237Em7I2VV+2UaxX8SgrVLiUp9w+Jrnm2lnWvtOyy55eKJ+gFOmAW2dUDXVy09Qbrr
         yLSd80qZcZ1eiFS8zhZaLPSQn+SSbOO43Qf7t/ipRg9qQYlClptgj5qyHQ20mlAr1Z/u
         D+OrwpXKFFC/VtNBYCIO+EWWj92rQ5viASmshntSLpS3VfkN/sqkc70ZAcVfXzmSjSvZ
         DQqA==
X-Forwarded-Encrypted: i=1; AJvYcCWA/DgOMuTeEPOQiTKtexzHQlftkOXM+PMcqstL7ocQow/hwUbIUl5Y5VJL9rq1ITLvImWnfJn0vCMZUyKGqrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNJl+sTiTWhcn8JlA+FmmccbGQbmz5zjSAcm2YpkdY9hcv0Ml
	ZTHxhfqdhBebjsxHqjI6PhbxXNIxRUehaMhFYaOz2lbU74IamMm7QnNZhyXMANNbhw==
X-Gm-Gg: ASbGncsH1C+dyoRaaW6L7WMX3kz6bfjA95sdRhtn1YHZBSLLF3VFShk4zJlwbuNF9wa
	UqBdpxhX0QnHvOCSIUDhv3pmXLW7I0Ra14wMtbnUuW1MQ+dlZ1KQhe0l4f2sz4vZdxfnUEgxejl
	UTwABB4QLtKJIFJhcSfYlMAeUy4RYleIUc9El/aA5krPgLkEn7qQiCkw/ao+SotnXRWd0kuwZaW
	PRbLmuDLUg0kkklm1k2fjrPApuDT0JYXoa6twdVi9HLdk5yokTYvSUriY8CoZTFgqmENCZiID5D
	zf0oZgXMPBPiouBlya1aUU/2LfzCznbmiDozUDBpDdkh7eqmPLSy6o8loRfrHkv+L18qOZmdCte
	6cOJcyshQERsrVeAVJ2I=
X-Google-Smtp-Source: AGHT+IFJk0gn2Y3dKhWc3pdhP6/fnoHggpA9+Dt/AssUIqPkRx2PlFX9KNpf7G7AZbo7eFSKogQnog==
X-Received: by 2002:a17:903:1988:b0:234:f182:a734 with SMTP id d9443c01a7336-237d9954d7dmr24314205ad.31.1750398501768;
        Thu, 19 Jun 2025 22:48:21 -0700 (PDT)
Received: from naoyatezuka1.tok.corp.google.com ([2401:fa00:8f:203:8f2b:74f7:bc26:564e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83937bcsm9215265ad.43.2025.06.19.22.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 22:48:21 -0700 (PDT)
From: Naoya Tezuka <naoyatezuka@chromium.org>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naoya Tezuka <naoyatezuka@chromium.org>
Subject: [PATCH] pstore/ram: Validate ECC parameters against Reed-Solomon constraint
Date: Fri, 20 Jun 2025 14:47:57 +0900
Message-ID: <20250620054757.1006729-1-naoyatezuka@chromium.org>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Reed-Solomon library enforces the constraint `n <= 2^m - 1` via a
BUG_ON(), where `n` is `block_size + ecc_size` and `m` is `symsize` for
the pstore RAM backend. A driver providing invalid parameters can trigger
this, leading to a kernel panic. For more details on the theory behind:
https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html

This issue was discovered during develop chromeos_pstore driver:
https://lore.kernel.org/lkml/20250610050458.4014083-1-naoyatezuka@chromium.org/

Add a check to validate this constraint before initializing Reed-Solomon
codec. On failure, return -EINVAL to prevent the panic.

Signed-off-by: Naoya Tezuka <naoyatezuka@chromium.org>
---
 fs/pstore/ram_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..c7a2ff9c5a6c 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -212,6 +212,14 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 		return -EINVAL;
 	}
 
+	if (prz->ecc_info.block_size + prz->ecc_info.ecc_size >
+	    (1 << prz->ecc_info.symsize) - 1) {
+		pr_err("%s: invalid ecc parameters (block_size = %d, ecc_size = %d, symsize = %d\n",
+		       __func__, prz->ecc_info.block_size,
+		       prz->ecc_info.ecc_size, prz->ecc_info.symsize);
+		return -EINVAL;
+	}
+
 	prz->buffer_size -= ecc_total;
 	prz->par_buffer = buffer->data + prz->buffer_size;
 	prz->par_header = prz->par_buffer +
-- 
2.50.0.rc2.701.gf1e915cc24-goog

