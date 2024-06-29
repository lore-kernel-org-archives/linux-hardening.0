Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A6224CE
	for <linux-hardening@vger.kernel.org>; Sat, 29 Jun 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719704248; cv=none; b=FDpRhcFSLxxbFtYGbuCYli8ypoY+cO8aIhb5Az1AbFEF1T/6wMW+/KD4qIkkZMyylSdL1oYEoYmO3tMT+QIG8bLOsKL3OMD+XMZrzRdVkzK8ATq4G1/5ry9BptXbLSR7TteEzfaWofpxCKzbENsEbUdcTblytoIzFiAuZRAVNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719704248; c=relaxed/simple;
	bh=IBEoI0bvSqitYJRqzPDoW8or7zGkJuOYQ/JpQeLhubU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vl87rWStZuANf5GE3ODde/n7it7qBWbokBgaQuvc6xsu/OtMcy0XNbs4z0XPBPKGivVbKXfZuar1hIvGoCpVSNLK2rY7AFVjNaYwfOCBhO7NUIZ7djDN2NIt1ZQ3fboH0bCs7oFfYE0uVNC8dzi/1pQr8M616mEX+0pERHO/zgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=3HrvFnjb; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="3HrvFnjb"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c2284616f7so1195884eaf.1
        for <linux-hardening@vger.kernel.org>; Sat, 29 Jun 2024 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719704245; x=1720309045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3puRN6mg4Kad0heP72+x0UdDRAPxRVJ0rwKkzRspK0=;
        b=3HrvFnjbv8R42DQH8RBAMyz+cUhlrHdxoFIuKcmVTUIV4TFIvGSUUPCsO1XrlN3Man
         Hek+sQOp0wUfhZBdrJp4AbfS+2tP4yACs7vF4CcXKjVPHrEiZKoyCpS4jyS+ypoPJaLw
         76BjNHfVtBazwh2cq4eolmPW2kZ9QunW070n8yL90vmY/skXDIaluZnBaDs6vPqP7NI5
         RMKVeRoVG8uxXy78ikuKBSfzeMN6gxrfODfIyRvXj6Galsausj10b0i2DPRnRFMVWLpY
         TJCGj0+8SCyAP6/qp94rs4tCKv78q9tuytzg82nNYr//bNra92DTvXNBI6O2HrVnjeFJ
         cLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719704245; x=1720309045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3puRN6mg4Kad0heP72+x0UdDRAPxRVJ0rwKkzRspK0=;
        b=X4lhBYuosN3GgeIOLmnRq0JZfDd2vHlqtZQ/ufOu8v2vhH+vNiVCpt7okTAYMitm2R
         sZ/rPLRcjYsEoIZRMT3nw0OW72JzTbJ1q4yhZXMktx6D32nPKV0gehdjMMz3NeLGEw5K
         OEQw4CVrniKiD0y/olnWLinU3Ao6DGg22cDbYvPNwxFHxJTrkvX93uWDclw/QG/9kjqA
         99e2L2cO+vj+MjcKv1DjksN9815AGJvSZ+EBS/kXufwXlpxBtKW0KjdJyzw+nMVdB8w6
         UcF92R6g25N0fccKs0c8n3JWdiQ8ohjcRa6te9Ad/bsJuxQyaQoNZiA4zp3v0ut4vHyx
         nQYA==
X-Gm-Message-State: AOJu0YwEPhoiSinWaYZqq7TgTnt+OBL1Mae9b7U3MfSPnN3AMGiqjL7Z
	bRM2muaxiq53jOh204W+DXhG3KFhVLyJV1A07aUyuiOo5YfxGlgLG6mvNkwrb5eUl5FvzFFxZUU
	t
X-Google-Smtp-Source: AGHT+IG8P+5igDk4ExwABkE2XwoDTVpTr+1Rh0xMCSl5Q2BnEcJHHpU8Ukw7tYI1CUy+tLNvveX6pg==
X-Received: by 2002:a05:6808:199c:b0:3d6:2d6d:e0e3 with SMTP id 5614622812f47-3d6b55908demr2183569b6e.52.1719704244748;
        Sat, 29 Jun 2024 16:37:24 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246ee80sm3791646b3a.69.2024.06.29.16.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 16:37:24 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] gcc-plugins: Remove duplicate included header file stringpool.h
Date: Sun, 30 Jun 2024 01:36:09 +0200
Message-ID: <20240629233608.278028-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file stringpool.h is included for GCC version >= 8 and then
again for all versions.

Since the header file stringpool.h was added in GCC 4.9 and the kernel
currently requires GCC 5.1 as a minimum, remove the conditional include.

Including the header file only once removes the following warning
reported by make includecheck:

  stringpool.h is included more than once

However, it's important to include stringpool.h before attribs.h
because attribs.h uses some of its functions.

Compile-tested with GCC 14.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 scripts/gcc-plugins/gcc-common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 1ae39b9f4a95..3222c1070444 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -62,11 +62,7 @@
 #include "pass_manager.h"
 #include "predict.h"
 #include "ipa-utils.h"
-
-#if BUILDING_GCC_VERSION >= 8000
 #include "stringpool.h"
-#endif
-
 #include "attribs.h"
 #include "varasm.h"
 #include "stor-layout.h"
@@ -78,7 +74,6 @@
 #include "context.h"
 #include "tree-ssa-alias.h"
 #include "tree-ssa.h"
-#include "stringpool.h"
 #if BUILDING_GCC_VERSION >= 7000
 #include "tree-vrp.h"
 #endif
-- 
2.45.2

