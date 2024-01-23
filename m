Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDED3C2D
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 01:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972362; cv=none; b=iD1PJJFnMH4AqIhod6vWlHh23TTFnM2GmXmdm9V5U5TS5qCXHUlPUR3EG2NIxN+T9zwyV44nwQbzWJ7dEAOCgRy1qAWBFftiKRFA3+aOgueFwuCVxH2qw1Sp36MyBeeiPyrzfGLbC8RqaQoQasxmXgMo0us8eHgLErLrjWkPSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972362; c=relaxed/simple;
	bh=JA+WiZ5whi3MvySX6MkJgvqaUceqzu/DBmYXunBrTeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MiZbj7DtJzO+O8fTmtHTztFehyfAwPxzwy13eEUKbeHuw9e8Pab277B6Ixa/cqMTwM7nwhhU6Z3Xhg6YpL3RCELIbHs6Sy/U/kcbb35tVkPLjEh1QFVp0CXNkqVgToXUrtJjNcMCuBrO4LFcQFXT1CiyToqOLA0DQXmbqgLxjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UW/j71wi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UW/j71wi"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7610c5f4aso7625095ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705972361; x=1706577161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n14FGfYa3N4uzTdzNZsVaNNrsg5rUFPNmizA1oZLo14=;
        b=UW/j71wigMdpvhBXqA3DZvGGuCrmEFUgvytoPqKQQA79nFHfP5dUwROSdUbQPAtsWl
         ekSmzdiFimLsVL5YiLCFSuZURuAVE3aWmtj506cdG8AnkeeWs3RJBRu+6/Nu+9olKhfA
         jbFRJz2EGi4j8IDy2SG3UV4oU6xa07Qi2vLQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972361; x=1706577161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n14FGfYa3N4uzTdzNZsVaNNrsg5rUFPNmizA1oZLo14=;
        b=eHb7MBH7eH/PxvsM6K3k45/ilTnVz1GwoIX/U148+k9HvpMXAQbm+00NdEDg2dHNor
         AUFC1BITtm3pAm9TDa0TUQDhvxo/6gJkbmFt4vIQRdWVUimKHS7SDJNdiCIi1b2pq6iP
         04Y6z97PnmZnm62acq9M9sjtErdm0t4X2kkLyCLvfxkbAiXmRDDimw4H4G8bYx/S6Od+
         w39EY8yUTNOp/UOX9EymDj5cbsbE/5cl/vbHxjKmmRM3PeHckc7W734vCbmqmUkKByiu
         tDUID5O3XMWkqPLuofkP2UR/xJDkS5YZc85B20/fxRkGw8ka3HzJ6YcL0onpjp2Eui1k
         9TaQ==
X-Gm-Message-State: AOJu0Yxdsy3yoeHCjZsIDCNYpD0MTT+K+wW9qfS9amOiH283b2JZO6aL
	USHQh+rDl385MJHitRCwcoa33+Z4y9lcho53qC7IX+4r/XkpaTIYzatkubHVaBT1GNnD+bkygDM
	6Ww==
X-Google-Smtp-Source: AGHT+IHH3PujdMDfftn0ifK4xpPLi9pSA5OLmvNKNg1j+9Qyo1XlR3axM7A6jl9cXl68oYyNAu2Kdw==
X-Received: by 2002:a17:902:e888:b0:1d7:52b5:9c50 with SMTP id w8-20020a170902e88800b001d752b59c50mr2638187plg.19.1705972360860;
        Mon, 22 Jan 2024 17:12:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm6628583plz.176.2024.01.22.17.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:12:40 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Hugh Dickins <hughd@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: fault: Implement copy_from_kernel_nofault_allowed()
Date: Mon, 22 Jan 2024 17:12:38 -0800
Message-Id: <20240123011238.work.301-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=keescook@chromium.org;
 h=from:subject:message-id; bh=JA+WiZ5whi3MvySX6MkJgvqaUceqzu/DBmYXunBrTeM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrxKG6tfWL5xIYFOGIds5Ts6wuSg01/DNuLeZT
 /o7VpD4uOiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ShgAKCRCJcvTf3G3A
 JqFMD/4gN73mQX7mlPdaa2zdsvP6xq2yWc61Unnw6gRee5hi4n3KdF0VTHrC8u6k/Ojil81Faop
 CycsyD3ymi/oVbJbAN8oA1wX16KvFVSjif6WYxUTkAqDotaXT1X0Oo4qYrGHbmAGX1KsXCC4l3/
 b4iewmTT2eykQn8Nwn/wGsGL/gz2InD3oulj/Uiphv4kWPU8JWMycGeVd/j8LMsEHeSzhlNzEK2
 lcMLvN0UFl7LeIIwjfJ4fx6lS5k475b9MelfqCneOEOIWZt5OO8wBCPyFoOHrnbQWtVgg3MqfMS
 TgvdVKBpb+9UKdvp63vpHvr1nEoOFh7VvIevfFgIu7E5wQ5y7LdMw0Tu7oBG5I1J89ds5umUE8D
 xEOHPot/UYDCpt3RwJq5Kc7OkK7WzJU+Ox/lC0cyJwzJda/kDmWoykk059C2ttsuF8J805nAWHK
 2CXdOVvNRApGTU4Y49k/dPvNX8LAQkCUNUEYIFQdl2Sj8Y/Ky41W9FCh/K6Vw/NIXRrisU6lwLB
 HnqAAkL9cUJsNRqHAk44p4Gmt6hBD8uD9ag3Y6pGYEs76kE50YOnZkmZENzJyIVz5Bt+L5QjZSA
 mlW5Ku2TXKPToAGEKdO7YRa9frphpW+u4qRUNagx9DbbLO70ghNmfr+Qu/c+32TtrN7Wev1UXPC
 jgHeNF1 3TOXn3dw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Under PAN emulation when dumping backtraces from things like the
LKDTM EXEC_USERSPACE test[1], a double fault (which would hang a CPU)
would happen because of dump_instr() attempting to read a userspace
address. Make sure copy_from_kernel_nofault() does not attempt this
any more.

Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/202401181125.D48DCB4C@keescook/ [1]
Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/fault.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e804432e905e..bc5b959b6f90 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -25,6 +25,13 @@
 
 #include "fault.h"
 
+bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+{
+	unsigned long addr = (unsigned long)unsafe_src;
+
+	return addr >= TASK_SIZE && ULONG_MAX - addr >= size;
+}
+
 #ifdef CONFIG_MMU
 
 /*
-- 
2.34.1

