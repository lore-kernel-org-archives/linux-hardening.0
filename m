Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74ED17D2;
	Sun, 13 Apr 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744529232; cv=none; b=pxhkdVBELLQToVPcrfbJVPNjB+p++AuYF/4BZiwG/2fJ/EvA4N78vplPXKiaK1S3jEx+5qHvpy9nq7MuveCUI0uOFUFZSjZ1Uuh/htR7NvQi8T1EPQGAnfSN3u5eGT4NqxKQIR8+AoPyRgSjtwnXI2vzMZhlPL0E/Z7sFMJjGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744529232; c=relaxed/simple;
	bh=NQU8rRlS9AgCe/UrflwbmWHGkEj8xOois/IFQOaeoHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URO38KG8oIGKBbv7UWxB2F265hTlj7N9rm5Mn/E3o/3Ojf/5CiM4329e8ahEfL9mNn8b/SVt/xSxzc8ZlzPAU82OJGtAblPxIK14kezahxY09LbkK9JeaZnbWkJUvxEHvR5AidfGgzz4XcrNLBTmVXsjXvm5vCFMAhuG9dSJk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMsYVc8W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMsYVc8W"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403cbb47fso34710315ad.0;
        Sun, 13 Apr 2025 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744529230; x=1745134030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWYostWBKe0tIkuaeH+vuD5czF+yp5g20BCw9eDtc9s=;
        b=IMsYVc8W5UJAKjXTEJlpJnLaQHq17NgLCSzFpMSMSHrIvi4YxDmhI4MbkB4ov/y1AO
         f4GjWLR0tBpT+Tjp8SeUmInED+Auh6/apXn3A/7q9yGy3Hf9FUO4R6f+ZEutqIFhiB2D
         5NT70MDp3EqDW9+bjiyRdPCkR3qPgr6lw6bv0N1iH3gfolLr8hBd26JH5XJd3rvZ6uJ7
         YdFsp15Nr60Md4tvzsywxy+pnCuXQHA3MFFciyEKajsXdfzFwQR6rXKMdwCbxb/3ybIv
         e2XEYj2A3TIVKK9bMkxD8yUKn104abvnY0tNx/r4BhKYzzPfZVzvTkjxG9/8/uAoVBgl
         nVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744529230; x=1745134030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWYostWBKe0tIkuaeH+vuD5czF+yp5g20BCw9eDtc9s=;
        b=LNDJGU/7V6Z0g/UXml/qSgL5L6KKfUSur6dMOqpJb3jaN/HktbTh7fUOss2dq59dwP
         DQT2rxy0BDbgQcwi4lWhfQXSSQd4HohIDOIngmbgRhFwA5Tk1O88l4C6YuE5DcPlCH39
         SmO/5kFJD5NJn7G+G03qPKF1qs8D9/Jvlo9WU4blvWs2afHpJjp0bEN0BvIKI+sD/eoF
         0NBAXugVTZvyBZ6sHvslJeB9OCU32PYU8uOKv5S2/d2lTF2YLw6q1gFmLcddByfTyNjr
         7TT7ShT0R8A0GDssXAUbzAbOIWufpSFXPsbHMDYLxdsb0Z8Hnnnh5HlhGebeUSUr/fgm
         v1pA==
X-Forwarded-Encrypted: i=1; AJvYcCVIuSESVorsb2gj/0NHJxtedo9X/BR8B2q9ElV5ruXo2mSaUCcjhCZJD1OFjtI7AY2d7H3YtfZ7FhFm9LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKIHc+R2BlwPNAVDWH4VPBkAuKrqn7FTycOYEcXZcJ5KhbliU
	HzGmufdu8Y8K/XuJ4xrxSK/JERjtBiCsLalNI5Pka/vvB0TNp0Cu
X-Gm-Gg: ASbGncv8A0XuLiNn8uhA49oOHRP/cRgDyFdxU8ukAdzlgxG/lt8nE9guqI9p79y+jum
	jA0m75fnfLgZ+fmJ4WqbT4gE1NOKJDsYxKRL2fSBrdlhpqJnSqh7EJX3Mxyjfs0wHTYNWm5g4m4
	T2nUxaG7mLyiVSbDBuDo0sGdFddMfggUYI9S/yRnp2tMmU9jrxgRFEoBcQHm9ql22sD3iinuBsH
	I0l0ObdtJObOpXXR5NvmpAzIsjoEEC2KIQUUS3jegM8f6GIKpMRWtZUk6EJpJGX1c4DU1hWbrmd
	4E8kY7+PzLStVF5TXkf/XEbVWHMPnHvTN66cvIDocg==
X-Google-Smtp-Source: AGHT+IHm4WyCl30UTp+3sbvLd2G6aPuc4J3GTHBl8Er+Ytjg/SmBLcemafqlDWMCAbTyKFbTabd1uw==
X-Received: by 2002:a17:902:e883:b0:224:1005:7280 with SMTP id d9443c01a7336-22bea500191mr125827835ad.38.1744529229958;
        Sun, 13 Apr 2025 00:27:09 -0700 (PDT)
Received: from hh.localdomain ([222.247.199.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628a3sm77946835ad.45.2025.04.13.00.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 00:27:09 -0700 (PDT)
From: hhtracer@gmail.com
X-Google-Original-From: huhai@kylinos.cn
To: kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	liaoweixiong@allwinnertech.com
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huhai <huhai@kylinos.cn>
Subject: [PATCH] pstore/zone: Fix return value in psz_init_zone() and psz_init_zones()
Date: Sun, 13 Apr 2025 15:27:45 +0800
Message-Id: <20250413072745.3949-1-huhai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: huhai <huhai@kylinos.cn>

The psz_init_zone() and psz_init_zones() functions return NULL on error,
but psz_alloc_zones() only checks the return value using IS_ERR(). Since
NULL is not an error pointer, this causes psz_alloc_zones() to mistakenly
treat a failure as success and return 0, which may lead to a NULL pointer
dereference.

Update both psz_init_zone() and psz_init_zones() to return proper error
pointers using ERR_PTR() instead of NULL.

Fixes: d26c3321fe18 ("pstore/zone: Introduce common layer to manage storage zones")
Signed-off-by: huhai <huhai@kylinos.cn>
---
 fs/pstore/zone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index ceb5639a0629..57ffcf76f254 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1157,7 +1157,7 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 	const char *name = pstore_type_to_name(type);
 
 	if (!size)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (*off + size > info->total_size) {
 		pr_err("no room for %s (0x%zx@0x%llx over 0x%lx)\n",
@@ -1203,7 +1203,7 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 
 	*cnt = 0;
 	if (!total_size || !record_size)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (*off + total_size > info->total_size) {
 		pr_err("no room for zones %s (0x%zx@0x%llx over 0x%lx)\n",
@@ -1225,7 +1225,7 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 
 	for (i = 0; i < c; i++) {
 		zone = psz_init_zone(type, off, record_size);
-		if (!zone || IS_ERR(zone)) {
+		if (IS_ERR(zone)) {
 			pr_err("initialize zones %s failed\n", name);
 			psz_free_zones(&zones, &i);
 			return (void *)zone;
-- 
2.25.1

