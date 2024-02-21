Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAED41232
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507710; cv=none; b=s+fWx+UOPtn+SbROT5rQ1lD5y9cOfcnVEDdWpJO7MkBg0ItPswvRibIJy5P4uWYiC+bY5TKNPRsUlXbEdLqA8UnRxQf8M0WqoJeG82G/idaV1vsWlgKrL3puqLZliHX2+sW/wQLQdfz3qjYDqx332r9BjHf5QkKMJhctNz1QNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507710; c=relaxed/simple;
	bh=Mu+X+yYW4cvmC9NQvhPl5vvHTK1CoiY4aafGL8tDBao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZKU9C8ts17MjiDZgSRJSkgk8sL93qiYNjKwytS314lz5njw5W/+X1qVqlLEcplo8G5fMXRhQzpiL6IugF8TJpkIslRW36r08Znn0CVLggqoVP09zOC3BS/rT79Zld2q7g2kzq6PG2e+kqc4uFG2To8hGHwZEY2beZOiFToVE0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9pFYzKQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9pFYzKQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso89311407b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507708; x=1709112508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+N/x8q0XM6q/oxl++oFE/zLIduvg/H3kbNqGrSm6L0=;
        b=q9pFYzKQA6kltZmFbrzdKjQhTTjCVsENKULtAAj/is4cgaEBuvUDnYYrgrPATdGfB4
         B5Izv6MUwuUJKl8ix+oHSB+9Nw+86DsOuPgccNKWV2pQ1UU1aRfLgtg4E8b90VNoCCKy
         d7XE4OZcNf+5/3lL35N9TygGamSl6fDjeFX2mQYhPl4B8Dletz4oaSgrB9296lEPkcXY
         sJ7UaiDAy8j1lvsSqqD8h84HPlnsMJ6pfpPEq3hrqI0dnrJAzY/ZQgR6bJ8do1phyOXO
         257g9vZ1ZsDgd8wngEQP7Fimbkj58R5r9iMN1WDcE+juk6m2yIy+3qnnYreQC153EZsU
         GEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507708; x=1709112508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+N/x8q0XM6q/oxl++oFE/zLIduvg/H3kbNqGrSm6L0=;
        b=Dq9rMJrPzro4jkIr8RChOA6pO+FM8yD9IAwJciFX41bbyN7k5qn2pyfzaXz/fFyQX9
         rnowKbMJx2MjWDMz7l6821b8GwFReAMg3lzhCMP23l3eE79yEa5GG9W7VEXzG3NyCDIL
         H0BkiFxeNVak2zcc/DupMK3BZfckEb8klRo44/x9juWtRuAFrXfsapSrd/BZaYbYx+jP
         QaeNQa2Cb6HS5wmyYY1cQb9W+wUrl7WaH6UCoEYV+4tOt+3EupXT8C/JFLpYVaiGu5Mi
         rR2HuN2Z+mkOAUL4WC/zQYRoILdR7WIcJDRh2XNzIfdpLp9S2ZMe0WU0N+Xh44g0Jpmu
         eYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5xhBKarkkiYQfSHrU9XMBTwzLXBHgLW2sydFD9YdbWpf4a49en12/nRE683xI4qLszGo+1nOXHaZRxcOncuyv7TMZ60EwtvywAgpSo63z
X-Gm-Message-State: AOJu0YzYmskk/ZHFyZixk3I7wZ/VSTm1oiwALB1CSKtwAmXAamM8bN/J
	Lh/PBBA3kKmP4jKCndnh7+PhzfhOTh/hBSpa0b8x14jSPjvKMj1MIKsYz2bBUvt/2XvcYCbfH8R
	eVQ4ar9Yrag==
X-Google-Smtp-Source: AGHT+IGujiTgGmrs6aB7MYtXNm4zgRA3Zr4vV9toQOw9f+upbD+oRsb+6ooQYjPHHocWRD49vELQV317edlmfg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1081:b0:dc2:2e5c:a21d with SMTP
 id v1-20020a056902108100b00dc22e5ca21dmr5584522ybu.6.1708507707855; Wed, 21
 Feb 2024 01:28:27 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:19 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-7-davidgow@google.com>
Subject: [PATCH 6/9] net: test: Fix printf format specifier in skb_segment
 kunit test
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUNIT_FAIL() accepts a printf-style format string, but previously did
not let gcc validate it with the __printf() attribute. The use of %lld
for the result of PTR_ERR() is not correct.

Instead, use %pe and pass the actual error pointer. printk() will format
it correctly (and give a symbolic name rather than a number if
available, which should make the output more readable, too).

Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
Signed-off-by: David Gow <davidgow@google.com>
---
 net/core/gso_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index 4c2e77bd12f4..358c44680d91 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
 
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
-		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
+		KUNIT_FAIL(test, "segs error %pe", segs);
 		goto free_gso_skb;
 	} else if (!segs) {
 		KUNIT_FAIL(test, "no segments");
-- 
2.44.0.rc0.258.g7320e95886-goog

