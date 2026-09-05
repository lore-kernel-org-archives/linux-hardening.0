Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C4377567
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636584; cv=none; b=S+ZZePGqFfiHwjzKW8R1IiIPPL+oyLYOsRJtJEYvNU6RWfcQ4nMEXK7GX4/jb2ljw2OsbmsLWEu0bal4hQE4ECRwzYliW06WJuZz54DhbKmjWbhxkphcd9cLXNK/aYkwQDn7SSJcOUaC5IceNn+XGj3llDKN3AQWCZAFzKDrNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636584; c=relaxed/simple;
	bh=ofbcNdKdX8uKfubBk8IcA8XBshBPL7jLcyqQ7jTP1nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfCSih2bcn4h4jDgV2Tu6L1VfpyCwhvgPk/JCn8J/v6JZSv7KDesylPL4z6k6XzmKT9aFMs13F1vDqJOl6hP1EcWSoi5LOLL0kMEoiZt4hTdjILd8uGO+Z1NjFt3uB0zubI9LCsY5db2TeqfpdCqSy2T6vYnfNtsnG104toRUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afSu4coJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afSu4coJ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-86b03b75fecso35131157b3.0
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636575; x=1789241375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7w+lmyyiQCKlIYYGhcG8AgW8vI6XCeGVdU/tQ/rIM9k=;
        b=afSu4coJWttPg+LU2Rwv28BsRwtgM99tIL16m5Qhc7YkMtY4Z9Tx4+9qlEETiIlHX0
         V12wZBAr3KV8PbFjGJgMGODfHtrIM4qbUycqH27XuTruyE3IMTd0sMWQqfeha0Qw/mkz
         we4r2qqlIsXkPuv2GCHopBTt8MdeX17c9G3lAZZ8/l3JdJkxwzln1gVy7F5oUIVchs2U
         m9cY82VsILQvaCvfjuB0qJ6FizArxicyMj8mMyELl4fIAZxNWHoWVeqXa6GO7xKGypNL
         qdcMXgMowr+oO01GO0P7TeAvoLmjNzZNV4DI1VJcaZa8loBAIj9X5DozudfhHgm2B+u1
         oHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636575; x=1789241375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7w+lmyyiQCKlIYYGhcG8AgW8vI6XCeGVdU/tQ/rIM9k=;
        b=ex3+MPLvfWkVZXc5WhLeVpWrnrC2+0bAmCAUyOtRfYHG5/MD0ozP4EAt8DcCBASXeb
         TALafDnVhGvYWDd8MjAM5PhI2YovYbM8GsCXi2uAZNBOVwfGXoLflExoPgOPilvQi6HI
         iCez5SdFPmYz1atwC7eguJCLhYanJl92+dF4u48JwrqfMTw2mqXM3d+OriKvQ3MDqvZU
         TxYNWwwgua5AoucC1AzngzQJwQDDwkN9W2uvhljWiOxoQgBd1s2/nDgxIAPuvj+IgS7e
         6Fd/q8J1CmDBZNFgB9qYtEnTNJiZ4PH0CBJ2AxB1RAlYzLHDlnqYluFgK4RCtHa7fwBE
         LEVg==
X-Forwarded-Encrypted: i=1; AKwUvBz8pV9Jfir4BaJlD+5WmysRSKoriexY3r3BtZM6xvEMjLOpWwXm530BMKznlvmV9kpD9YLTcqz0OfANC6Wfa7A=@vger.kernel.org
X-Gm-Message-State: AFuF++md93cUCFIfYYAcC5tX2ADC9gpKONh/SOHZHEhyMlaIph4EiC1g
	8PH19yTuQLVlzwzu2TluDOZrx9/tn2st0EZl7G+RwtODw49SCouO5sj4
X-Gm-Gg: AYBFou3r/EGwWzlR0dhcU3RPqfxGtjDdSbxIrwVJs+b4LolxtMXiAhgvhFHxylLfJ19
	/AmmiDryqqYFTRum69mcskJ8ua2O5aQwfZIpNeiQeIhXYG4jvpn6BiAvRogUPGF5vCAoehdEbLz
	C1LNaWAtavn1H2QdnZKvU1fHoRXaReDwPPontgVcxMhNIEO1q9UOExYbVKyLsZpF2MUFtZk/7wj
	+m8l0F5E+c8unl1nyHIlkbPKuBDXjUtvhJRIKuwZLtJWh46j/BipMy/ActUJvd/qxYS+mSeOhIe
	8cwRRr3yYamcjXkqmtvxBCoTA4n8zMOouFT9a397bgHidCMW6OO2k813svprt2jXmxKOHxXN+tT
	RWdkDJzjsi0zGQFRhWlsAvAHEfZepBgzcXAjxuRUGvq3mrVAg9m66aCwAwXFMz6ANCZ+ewx5eCw
	JABqamPtw/4c/tOIvYOiM3PDKKTrSsy3c/oMiXrKmg9903kYsuv1XGoWoqrgq3
X-Received: by 2002:a05:690c:6e90:b0:869:718b:ea10 with SMTP id 00721157ae682-87125efa162mr62967287b3.16.1788636574996;
        Sat, 05 Sep 2026 12:29:34 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bef8930sm43411967b3.46.2026.09.05.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:29:33 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:25 -0400
Subject: [PATCH v2 04/22] alpha: select HAVE_DEBUG_KMEMLEAK
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-4-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=ofbcNdKdX8uKfubBk8IcA8XBshBPL7jLcyqQ7jTP1nk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E5e4uq8wMo/6H7fqrxf38yFeP6f/5oop3CrYfUMw
 VnTy+9d6vjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrnL4wMnzuC/ul8l
 ZceveOdI6XnQGbdDN/TGF6Xv3szLMTzQUckz0ZGV4KuzFdkj/SM6uJ1zu2+M+0pm1vbBZ7V+n06
 nGvVgt+ygMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Kmemleak needs no architecture support beyond the standard linker script
symbols for the data and bss sections, which Alpha already provides, and
a scan of the kernel stacks, which is done generically.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Matt Turner <mattst88@gmail.com>

Also mark Alpha as "ok" in the kmemleak feature matrix.
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 Documentation/features/debug/kmemleak/arch-support.txt | 2 +-
 arch/alpha/Kconfig                                     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
index f45149cfa313..b65b3f8c0e89 100644
--- a/Documentation/features/debug/kmemleak/arch-support.txt
+++ b/Documentation/features/debug/kmemleak/arch-support.txt
@@ -6,7 +6,7 @@
     -----------------------
     |         arch |status|
     -----------------------
-    |       alpha: | TODO |
+    |       alpha: |  ok  |
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index c4da16971652..f6d1d2469677 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -19,6 +19,7 @@ config ALPHA
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS

-- 
2.54.0

