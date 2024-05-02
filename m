Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7A1BC4E
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690421; cv=none; b=RYYqfeHHXLz1ikvzsZgYfT/JIu3iKsr25zO5pmrnTUkhkGp1AgPqrfXpABRhoCJQ716uCzjlggNwMVqqY8cGy6l/dKosovaB6VfWY4fsAyGELm6fVPslG+Jdh4FYGMX4+7Dtf0lt49dYzH7xbVYhZAOOEYMmm/sBuRJVmGS17R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690421; c=relaxed/simple;
	bh=9EIDvlKn8H06U3Ns7X4JkY7FQixrkq70JScwUwcT+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWBZrlyn+fBqXH3DeBsx98IDiIm5qE/M+A2h85IwAvqAlF3PNArziE139FGuRmWnQTwY3KNBYH2C3t33oxEFrqp/MekfCoHPM6Ze4XwYaFrDodNOvwAvQmplxajgAQcc4HYzqMk7xLJCbYRHWXkU6b5z5WNv6/wiZ+19RTEnYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GXlHVmV3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXlHVmV3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ecd3867556so15469275ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690419; x=1715295219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+CbTYcuXhAHq3pBgBZF2uLGBq5IUxFnRXQZTgCCuoI=;
        b=GXlHVmV32OySEyfV2tzM7/Zcoi9qf2XbShd3IE5te99M4XGjmb8J3ysGDFySvO7HIv
         vrNel25xbPgx7HNUQiV2speMTI9EWLue/TrCaIBTqLOi+XZfgihfJIeWAAVy08HbJfqL
         YprL+VAkMM6uFaXU5wbt/9fBVGbkGwuZE2tLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690419; x=1715295219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+CbTYcuXhAHq3pBgBZF2uLGBq5IUxFnRXQZTgCCuoI=;
        b=SPDh3xtZZ0Tf4U8eT3kWgZqIDAA/B/8YW9MlFKEg41o9S4U/Hm1hKr2frd+Kgo4qFj
         AclC8XLyj1hOooIa4YyVoc1YOmGKQYMAozk/RebWw7iuORl3jtibnaVJDrZYWfj6XIW+
         NBGlT+reC7TylpQAKGTlLkNe/os2UMCduiXoWgE2L31f7Iu9/UWhG3vA/L96/ELWWK44
         fevn1DDGxxzsIxn95tC+DqCbILM4bp/oCzCyaHir+T9XdkmXMO94DVFaWQp1EUbcnGRg
         4kOsln8myh/DX9wzsTDAZAdFnTIcDyadHsVUL3Z84jjsrpff2mA7XmEqFQxKW0L5iIiY
         u5OA==
X-Forwarded-Encrypted: i=1; AJvYcCW79NED38WMU+B2B0dsp7CvjUmaj7oWsfBwnvu08DL/rAAqm7qhpgWOJDH4RDJDE212Kp7ri6/pYVtkRPzDL+sSWnAMMlBOfkNptlsCpgLB
X-Gm-Message-State: AOJu0Yxk3iGN/AfT4cTzWwHcfygRT2Jbwd1/7S+vMcJsG3crlKWxXZgF
	nLGCWffEfTR7btQAd0aEq2WplbQ38+4DpL/bJE95HxrrbdRTssdb++iW6/YaRA==
X-Google-Smtp-Source: AGHT+IE828cNgqxiTXs3gOeTLsF+43jhO+3qFfjtUspZftTwhCEXBNu2gvO6RoHEZi05oN6gZOpuIA==
X-Received: by 2002:a17:903:264f:b0:1eb:bc78:1ef5 with SMTP id je15-20020a170903264f00b001ebbc781ef5mr950791plb.17.1714690419185;
        Thu, 02 May 2024 15:53:39 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id q8-20020a170902dac800b001eb3f705ddasm1861884plx.255.2024.05.02.15.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:53:38 -0700 (PDT)
From: jeffxu@chromium.org
To: ryan.roberts@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	dave.hansen@intel.com,
	deraadt@openbsd.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	jannh@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	merimus@google.com,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	sroettger@google.com,
	surenb@google.com,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	willy@infradead.org
Subject: [PATCH v1 1/1] selftest mm/mseal: fix arm build
Date: Thu,  2 May 2024 22:53:31 +0000
Message-ID: <20240502225331.3806279-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240502225331.3806279-1-jeffxu@chromium.org>
References: <20240502225331.3806279-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

add include linux/mman.h to fix arm build
fix a typo

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/mseal_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ca8dbee0c612..41998cf1dcf5 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <stdint.h>
 #include <unistd.h>
@@ -29,7 +30,7 @@
 # define PKEY_DISABLE_WRITE     0x2
 #endif
 
-#ifndef PKEY_BITS_PER_KEY
+#ifndef PKEY_BITS_PER_PKEY
 #define PKEY_BITS_PER_PKEY      2
 #endif
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

