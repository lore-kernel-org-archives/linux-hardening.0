Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F817BDA
	for <linux-hardening@vger.kernel.org>; Sat, 30 Mar 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807928; cv=none; b=O3frllTzYaNh7u+QEICKM82Z2BAgvQCDDgMrRuUvEjd4kx8zWXoC/iJpOg2keJWMmsyeBxm2TKGZz56nM6hO0lTmjNhmfP7qqWLZOs9WfZLpEBP7k1usfM6jhiyN08us2hQ06VpOBOT7USjadWOrE61tXcsPXNnNESn1khhRjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807928; c=relaxed/simple;
	bh=72NlypCU3m1Ai+nlWdQqXQ/FhzgDGtzVMmXe9FDsnK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQptehjxX5asY9ojeLX3Se1Fth3vWGQmD07/Etv2bRymvzkyq0AzgN3t/cnAvq+AXlqGcvQBxoRVO5y7VHBd/OtaRFwihLt795j/3LEsYy6dDn42DTXz5bHdDKl6Sm2hb4P2TjkOcE+YhnaGJPw5kTlaM4snutSvgBFAcTVmK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kO9j1Rt6; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kO9j1Rt6"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4f7a648dbso1657831eaf.3
        for <linux-hardening@vger.kernel.org>; Sat, 30 Mar 2024 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711807926; x=1712412726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R0+AkTWI8QZwkAahS3FDyHG9j7KXHmvm4QW/s+hHfA=;
        b=kO9j1Rt6JU6GRsyHJFWfGh0Ervom6Srh6hwFvU4JfhBQClsJBOrd8tO8ue6zwWQ/pF
         3rVqaX29VpwarDNSFYkWF6UdlE3x7zMgxq4/TDeC3b7ZJV1hotttADvXMgIfOxPrYsNG
         WU9xjZrf/rn6pR4bErxbf5kWBl/Tjhy8gK4L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711807926; x=1712412726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R0+AkTWI8QZwkAahS3FDyHG9j7KXHmvm4QW/s+hHfA=;
        b=RniA7t51JO+9Y2yq9KiYZxXK2TbnyDimLHNeH4sN2e6W4HyJU/RFvJO4T8xtPTQKCu
         HiLCJ1ITRBD72Dgptp9RUPzQlkG4UQ+nM/wU2uuce31BSUX2KttDqV/v3boOrg67eMbh
         eu0fFb5EzFEhbA13xC6rb0Zh3EjYKq8hEOAV8sPGhduwaqLq+Gqg7xIesSm9AfVI16yw
         8ZsbykW0utasV+pYpjH8RRUmyy/8f7i191GOpQxmy7+T01IkSfcMUaE+T3JFgHIyS84j
         X3BzhVJMK0I7n/Ty0JF9f/KgJelX9Im144x7o41MZZ+mH4acaGAIgejQsU4nzHF6mq49
         x4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IuKjIclsrAkLYCVrTL5iRhLsvnClNlXkrJLG4djd6QHZ3yWYlyRpZUwA0h92G1xG8S4whDPQKMlsRfUsAcOdG/5jG0QVUkVHdwjGf+F9
X-Gm-Message-State: AOJu0YzGxXeNhqQbhQMwGlfz/uYJH4wXxtAQmwSWG1npU18FT+IjGoG0
	0MI2ACZexj7TENpvUBwjNsA2bztVFq+sb8gHXXjzh7nZ+q4LvJvOKl+wbOCfqA==
X-Google-Smtp-Source: AGHT+IEJtzUzuRZgSZPHVHwVuvYRyBRpL8kDmcK5MecWGpcsJm7ruAhRPpLIlgMAXixtWQGCSKy74g==
X-Received: by 2002:a05:6359:4121:b0:178:6c79:6ccf with SMTP id kh33-20020a056359412100b001786c796ccfmr5950622rwc.17.1711807926336;
        Sat, 30 Mar 2024 07:12:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w22-20020a63fb56000000b005dc4b562f6csm4607931pgj.3.2024.03.30.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 07:12:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Karol Herbst <kherbst@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Timur Tabi <ttabi@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nouveau/gsp: Avoid addressing beyond end of rpc->entries
Date: Sat, 30 Mar 2024 07:12:03 -0700
Message-Id: <20240330141159.work.063-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=keescook@chromium.org;
 h=from:subject:message-id; bh=72NlypCU3m1Ai+nlWdQqXQ/FhzgDGtzVMmXe9FDsnK0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmCB2zFC4lHA+jf2TBWjM1ztczWQiNIUhah6PlJ
 NpV613q9s6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZggdswAKCRCJcvTf3G3A
 Ju46D/41X6YPEmbiOsUB+J4DpwOnPKKcWsCj004G4gCAGXDcM6V+h7frx+gzNYT4Rf8x4XsR+Jr
 rQie9X4uNZp2UqZjv6FoMoJ/4Fns8PwbjLF+l0gB/Fb9vnxXhMacWym6B8w+PswdMS16W9pSaen
 F5Zs8+sTbvHAaRXn3iZCPYx6ui3LhmHpqy/e7+pHVKnrj4FCMPmAuZYvV4anVze9FSq+nPmoFVe
 4z1zpNbj5Nty9xbyRYWwhQNfAB8YuZpgDUGoG1p2AdiphqV77NP//zHYPcHsfgP+y0JIz/5BUxR
 Lp65/01z/jPpJyAivKhVM2pvS3aEM7N8bTOuAaM+rtB1V3deWraWkypkkJSwRAtdxUTiXrnbr3Q
 zK1KtBGo7BRK6DVc03milid8NDHuHnIwNJM3w+/h3ePn0NlvlmBD9bJLoAajAl/hlrYTzTAak2Z
 VHzHA0SQ2Vhn9Etuq2ipHNQhNVT3u8txxcSJCBr6Q6RBWkaeHS+IXH4DIwvKkwbcmc2SZ7BehHC
 gecHXXvfcvmvsbcNQnJHTKr0dZmjQsZkf7YPzVfhrYvzU33RIoADtfHAmcVTQXZsVqXFZq5PRjO
 3LC4+FeijavF4l/RRJPr3Btg3mW8DmycJkmfTy3BiYHrt1lxWF488MN0zrq3NdSq2+JfZ8KkBrh
 pVR23AZ tcRpXu8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using the end of rpc->entries[] for addressing runs into both compile-time
and run-time detection of accessing beyond the end of the array. Use the
base pointer instead, since was allocated with the additional bytes for
storing the strings. Avoids the following warning in future GCC releases
with support for __counted_by:

In function 'fortify_memcpy_chk',
    inlined from 'r535_gsp_rpc_set_registry' at ../drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1123:3:
../include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  553 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

for this code:

	strings = (char *)&rpc->entries[NV_GSP_REG_NUM_ENTRIES];
	...
                memcpy(strings, r535_registry_entries[i].name, name_len);

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 9994cbd6f1c4..9858c1438aa7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -1112,7 +1112,7 @@ r535_gsp_rpc_set_registry(struct nvkm_gsp *gsp)
 	rpc->numEntries = NV_GSP_REG_NUM_ENTRIES;
 
 	str_offset = offsetof(typeof(*rpc), entries[NV_GSP_REG_NUM_ENTRIES]);
-	strings = (char *)&rpc->entries[NV_GSP_REG_NUM_ENTRIES];
+	strings = (char *)rpc + str_offset;
 	for (i = 0; i < NV_GSP_REG_NUM_ENTRIES; i++) {
 		int name_len = strlen(r535_registry_entries[i].name) + 1;
 
-- 
2.34.1

