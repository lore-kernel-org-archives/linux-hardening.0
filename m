Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D49348C7C
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969241; cv=none; b=JWNEEsq4BYhwjjYLzJ1pcus9ZRwdG70//NKHWa1KGRhnG5WnzYPKhyDQZsxHDYuoSebbuilRWTk8BlejufoP2fi0xQlIHwnOi0JvCwlAJvlzEaws2ixyupHEh6Lubn40T7HQDp0hIKpIHWhpONRvy5z0kNCiyGLAetYeeqWIJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969241; c=relaxed/simple;
	bh=bu+VqBxA6nqZV6JK7oBUZFdnjDL9VBnPUZknJyXfTEA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KjjTVdQJdj9tZEjmutV3O9sJ0r+lJaZZhnp7peppsr4L8HitORNSoQSHceBp5lr3x59jDkdRgcCl+MyxE25Dseovd1MHSVNY0QSvvG9OCf92x0fW8qJowJWOlGyCS7bJajFkQr9jLEVcDOp9VgTbvJaWPfuaeZG7WApZC3JNjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgVve89I; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgVve89I"
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-80621978fddso214536a34.2
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790969238; x=1791574038; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ncPdKQ8yTurzGsf8xW/nALnmFn+Mq36jdGYCCaGLUmk=;
        b=kgVve89IJug1pg1CHulhfqadjs/KnYp9EmujGEpD9jAxCroZtN25/v7sQHir43y+/R
         cdr36fFTY2qmdFFcGclWqNpQ/WicJAgtYBIXSryJ1WiKadB6QT3wK0Hqr/esHttTSeZd
         0GPdobT9+8lrxdYpd/I8ifas/rawR5wazGIS68ons+cDb8Kaf9QFE7+IBudiq8id4edi
         2NzO1taL7KlvteppMZrQ9lGfHVPLOW0mE+/W6J57UMZa0AlCdVt6eLxIEylEIgUsDtWR
         3ROoo/JcSyiv/FHiX5xX3YjCOhDkgbSc4sH83a53DgJch3VT7lkResVmqj3OLmj0BOLZ
         1pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969238; x=1791574038;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncPdKQ8yTurzGsf8xW/nALnmFn+Mq36jdGYCCaGLUmk=;
        b=OxyJHvDlEwp1goT1FNcWNqHXlq3mOtsNEcnW+3opSo0ty5datVuWbvBpQe4/GyBm6y
         mLri5phMWrcM0yQNjp9+3lDLD6ZMAa7mwSPjhakP0sXJrzxdlA8RRn8x+sKUD4PCHfOJ
         vn2RmKgC6klJ9uCQ+m0A1FNaOcUZrmtE00xBjBSihCXdUgs5ko2h24+oFZNGvPKql5Fg
         bdnjV1UysIohgZT9W7Oph69NF8q6O7Po6doXlMZDm3r2gEmhw0AhjfHe7d+JW/gLubEI
         d5eM1XNSdVj3gCgwxlbtzHYssGNNhC86V/lUeay5FOidMyAy+oEef2SN9sgiA5pVEb0L
         0S1Q==
X-Gm-Message-State: AFuF++kq48LUNHKVtRMKtFWc0q72H9h0Y6QgPi2/K/HIbYgxJmaboYql
	77D7CfPtTpLlhudCOZ9747AnUjq3So+SPoko2GFPn4MLnuLt/9fxj5agAQ5Tr1qK3aG9Fuyiv2T
	pMLPaHc5AlL6rSyJEYGz8mgzdpQ==
X-Received: from ilgw6.prod.google.com ([2002:a92:d2c6:0:b0:506:ef1b:4df4])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:e8b:b0:4d6:92b3:5c84 with SMTP id 5614622812f47-4f52b3b318amr2241563b6e.65.1790969237696;
 Fri, 02 Oct 2026 12:27:17 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:27:17 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche6ZJWdSDr0I4rHXQ1VBItxgTw
 rtb5DCH7zD/SoakMLpWKyV81HSKBU1dUXhKfMDpvZjY86Xxnt0oGnMZkjnLEt4aNTtuvQzg9oS zUPnOCYN+/92uP2zL7YWQ9xht2w+AUQhweQAAAA==
X-Change-Id: 20261002-maintainers-stackinit-230afe234e5a
X-Developer-Key: i=justinstitt@google.com; a=openpgp; fpr=E8700888482CBCD3779E67F32D8CB922E382C412
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=justinstitt@google.com;
 h=from:subject:message-id; bh=em/u6WKwpECTiM0kW20l7ZVcgcWotbdCG2m2BRLAdig=;
 b=owEBbQKS/ZANAwAKAS2MuSLjgsQSAcsmYgBqwATpg6HcQDcbs0Sc7kv6X/jG0rp0jhy5uUBYB
 YN0AKFI7JyJAjMEAAEKAB0WIQTocAiISCy803eeZ/MtjLki44LEEgUCasAE6QAKCRAtjLki44LE
 Epf+D/9H9Mr7Tz4O3pj/Zf3dGy7MvN27BQBqAPaocE4hE/wz8EkCbN8zr4lnLNJL+nhskzaEN2l
 v+VFL0djqVbIJrqHG3i1iElOnCcTDUBJ+dEK5aqtGfm1BojJknO906b7f5LSBz3SsvQb3QKRrf7
 0DccU4AjmlxSb4XNJotp9AjC+Tu+KRC1eq85qZQxpzCVwDYZ9HPamgsV8XtzjvKXsBDHMk1ifNR
 ejua2rrLlN9gtiOu2RDBVHAkp6k4aYBKxLUA8eX8/spSGXuVX1QCYns1hJknnDg+xNw9uTE/4k+
 JudGy3edRZPXZ03I50Yt0sbRnnBzwXJYKpj6GCPN0JpqogrniDMK0Wagaib+j3xODlt0iKJVqyo
 U2vxO3fGFL5/nVOXg4YOirZOkTqibVhobA57wTpE/cLMeNt+J4y4qrAQ79jEinCl48sD6pwYZ9k
 fWfa4WAFEnk014Oyqifvj3ggKsxjaxOYDExrji7yMOYhyBPDYz1NqHJvgz/g5y3uc7w6JXs+BrB
 1zvEPEOlzHjpweQQox/UillbAujy1KhSagD81rR475PjjwxD4nXvNk+APhQgyZqr5q3M5m5Q2pc
 EZNeQK7jjwbNPSo0x4sVK+a99PDrMSMU1BGA+Cy7o16TlQ+hD+Qd4tLOxhYROHqxiev7KvSYp9E ipSsmSPRvJLKBoA==
X-Mailer: b4 0.15.2
Message-ID: <20261002-maintainers-stackinit-v1-1-27112a221527@google.com>
Subject: [PATCH] MAINTAINERS: Add stackinit KUnit test to HARDENING
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="us-ascii"

From: Justin Stitt <justinstitt@google.com>

Noticed while preparing a patch to lib/tests/stackinit_kunit.c: the file
is not listed in MAINTAINERS, so get_maintainer.pl does not suggest Kees
or linux-hardening for changes to it, only the catch-all list.

before:
  $ ./scripts/get_maintainer.pl -f lib/tests/stackinit_kunit.c
  linux-kernel@vger.kernel.org (open list)

after:
  $ ./scripts/get_maintainer.pl -f lib/tests/stackinit_kunit.c
  Kees Cook <kees@kernel.org> (maintainer:KERNEL HARDENING
  "Gustavo A. R. Silva" <gustavoars@kernel.org> (reviewer:KERNEL HARDENING
  linux-hardening@vger.kernel.org (open list:KERNEL HARDENING
  linux-kernel@vger.kernel.org (open list)

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f72b4ac27ee..019f443af051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14164,6 +14164,7 @@ F:	include/linux/ucopysize.h
 F:	kernel/configs/hardening.config
 F:	kernel/kstack_erase.c
 F:	lib/tests/randstruct_kunit.c
+F:	lib/tests/stackinit_kunit.c
 F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
 F:	scripts/Makefile.kstack_erase

---
base-commit: 5e0f8396d4805a3e7f753fa58c8c55f1f3cc2160
change-id: 20261002-maintainers-stackinit-230afe234e5a

Best regards,
--  
Justin Stitt <justinstitt@google.com>

