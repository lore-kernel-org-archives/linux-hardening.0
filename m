Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3433DAAD5
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 04:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299201; cv=none; b=UaqAfVhVhY9LvjJjFO7kiv8Vw2qj/A0rOte0Lsh2IbQEc2yGpNOUI8I9ql02Am3FKPTw36/3jAh0IBb54dUtHfgF8nUj6zDVu6/fsF0KeUJZo8GIgJeaBUToQs1OJJFomIntgISmFSS+CG/PU7A9zQPqaLew3az4cmGRvs8Z3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299201; c=relaxed/simple;
	bh=JdWbu+pWVZBfEQSWUKTn+Y93GeKlHqrybuRdhpHUi2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dGFLydhwrKU7JuNphXf4FI/VZ5TKmpe5AhX25JeNrtXo4XKfpjye5hIUVhIZAlOPgaXiTTdBEgtwo5bAbJ9vdnjAaMaGqQ8IihgfpBtI2u7k0rjUdtTm8KYIRJMJ+aMKF9ew7Fm+zACuPFDsrJvVPfOTYomIn/egoOOnwNTjyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEpoxlw3; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpoxlw3"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2290818eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 17 Oct 2026 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299199; x=1792903999; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vKBZrvo9gd0CUjOza/xA+iBTaDbgfOk+BsxyRzZQseg=;
        b=UEpoxlw3vsAGd5GM/nFYBaa4gXWSSBCPM8Nvv9MYg43BTlx2uJosK3/+0JaPjlyb0M
         Y0jMlAqnsx0TGO5yV5MU3/9kHmVdpyzR9dxkmrXMOyy11imVT/KMc/zVmshz3ncF5hU3
         nFiS2l2mlU9HWwpbi/e15Y8e2+McVFzsZKV6qsPd/Ji2hsLyR0WNxqrGEyrv3+/L5w+d
         7DXSzkrHPEwKy1DNVlAptQyVHWetx7YoRYsCLsW1Q7BYTvwdrBLOJ+F1Dx8owjtuDloF
         LNVVmTpZ77zyCnkBMltsZfk4N5S8hsOiZ+tFU8Yrw6nrdFvX51jyU6brqqGcCnQB1LRn
         xoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299199; x=1792903999;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vKBZrvo9gd0CUjOza/xA+iBTaDbgfOk+BsxyRzZQseg=;
        b=Ked9fs0b6RDTz4iOumqddkgshgJZuIyjaE/lPOhdjJpMN7ch6sPzolPqWxZDSOZtKr
         U5gE3xnHpyOn2pvCtGBRf7petAslMHisTPHSfUJwJBlKuLV28t7khBUnQCfDOP7FLFkx
         4kd84z3dUJOWtRCav7IrhqOpx52QskSND3WBfhaSyX1DYX1eGtVeviDWS6ntuIzx+JFK
         /hhhDjfBBY4ju+VZiBNXpP3e/d+4+jk3kFMJohUWKHUoD0J9UCyEEKdiyEcqQ6lTBRN6
         FWazazZvps0d0P583vW3GSNgyWdulepx54A4eBmhWWNHDjHDO4cgiAhME6sEehOX3uyI
         OyRA==
X-Forwarded-Encrypted: i=1; AKwUvBwGgKjzpH7hsDLvjTrLS6O6rHu+87qJaM15d07n03Xc4dM7exURDahTcdOM0ihdRD3gypZksY+R7uS2uoCeiJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLR05XmRSyvGQUde8FEdnhmgACh0pMZBAgC+kEz6QsmzMNjz7Au
	7ol3dIAP1UKkTP1pfOWW9heTaJC+m1fJEpK6ZlYwysPEZEummfi1gHwa
X-Gm-Gg: AYBFou2/Nz8aBRNN7QbIc3ssXzXpCzbZjIsqxacCQRBbwp5zNyrWSewneLqPvNIRbs8
	VeSx2oMwV1b7vk79jqSoEhBVgw1tz6LQwZbzKLzFfjp4Gkil+Ifbq/KxuiVb+Ip9Pp3wAuKDd+u
	k098hCRSLkFtZZRwUESqTbjOAtreoN3xbnHK2KKJJwPgDPsRYWMoxyiGxTQ1KXg/ZfFBTlLS1sN
	lxeP6OG7epxNceaEcifGGhNGszWr38k+SRzNmSxVKFtiSRFKgwYeLs58Pjnd0J5dVqB6gmB1KQX
	6+t0Dfi5nY/iAU036AXWy7wpkHNsw6ALpgy8Yl0+KPMiX/utjEf3YiZtE4sBAwnm4ym/RI54I01
	77y7Y/r+T6vtXo/cwWRhS8081NOFCEdkft2GIUl7h5RwvQn4MgA1/u0DzJTVbe4Ag0KS7s1AmIo
	+R2nNREZ9nlptFdHp/hjzUDv5NA9zNjR1+4bbqTMrGZrlys+9nnM3cAC754apHjZnDhw==
X-Received: by 2002:a05:7300:ec97:b0:361:6dc4:d0b2 with SMTP id 5a478bee46e88-3619e54358cmr6638408eec.2.1792299198975;
        Sat, 17 Oct 2026 21:53:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm34983352eec.28.2026.10.17.21.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:53:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Sun, 18 Oct 2026 12:53:14 +0800
Subject: [PATCH] string: instrument the word loads in sized_strscpy()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-bug-string-strscpy-kasan-first-byte-v1-1-375a2c46d88f@gmail.com>
X-B4-Tracking: v=1; b=H4sIALlQ1GoC/x2NywqDMBAAf0X27EIeREp/RTzEuOpSSGU3lor47
 wZPw1xmTlASJoV3c4LQj5W/uYptG0hrzAshT9XBGddZYzsc9wW1COcHmrYDP1FjxplFC45HIfQ
 +hFdI5IyfoJY2oZn/z6UfrusGph0wUnUAAAA=
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Peter Collingbourne <peter@pcc.me.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 kasan-dev@googlegroups.com, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

sized_strscpy() copies a word at a time. The loads go through
read_word_at_a_time(), which checks the first byte of each word with
KASAN and KCSAN, or through load_unaligned_zeropad() on architectures
with CONFIG_DCACHE_WORD_ACCESS.

load_unaligned_zeropad() is inline assembly that the compiler does not
instrument, and it has no such check. Since sized_strscpy() switched to
it, generic and software tag-based KASAN no longer report strscpy()
reading from a freed or out-of-bounds source on x86_64, arm64 and the
other architectures that select CONFIG_DCACHE_WORD_ACCESS. On x86_64
the kasan_strings KUnit case, which expects a report when the first
source byte is out of bounds, fails as a result:

  KASAN and string KUnit suites      failures
  on x86_64, generic KASAN        before    after
  CONFIG_FORTIFY_SOURCE=n              1        0
  CONFIG_FORTIFY_SOURCE=y              1        0

Check the first byte with instrument_read() before each
load_unaligned_zeropad(), as read_word_at_a_time() does. Hardware
tag-based KASAN does not use this check, so it does not bring back the
tag check faults that load_unaligned_zeropad() avoids.

Fixes: d94c12bd97d5 ("string: Add load_unaligned_zeropad() code path to sized_strscpy()")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 lib/string.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index a3778d5aab4af..91de344956fee 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -19,6 +19,7 @@
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
+#include <linux/instrumented.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
 #include <linux/minmax.h>
@@ -132,6 +133,12 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 		unsigned long c, data;
 
 #ifdef CONFIG_DCACHE_WORD_ACCESS
+		/*
+		 * Unlike read_word_at_a_time(), load_unaligned_zeropad() is
+		 * not instrumented. Check the first byte, which must be
+		 * readable, as read_word_at_a_time() does.
+		 */
+		instrument_read(src + res, 1);
 		c = load_unaligned_zeropad(src+res);
 #else
 		c = read_word_at_a_time(src+res);

---
base-commit: 90201351a862182bdabfc1ad1c97b1e1b6ed5931
change-id: 20261016-bug-string-strscpy-kasan-first-byte-335585ce203d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

