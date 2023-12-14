Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgvWjpRn"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9842DA0
	for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 00:49:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so8648768276.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 00:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543789; x=1703148589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkRyaEIclzm+ShIMyVUbqREgKKajNjynsQ0mobEpXzk=;
        b=cgvWjpRn1Wu1bWJ1qeTxF/WH65bRi37aahZVCQy3rXjzx32KJiErk89YQefh5ZEf+C
         +dGWH7vRN8IOpRl07fQ+FSVoJEvUMfTLUWQVSgPkds49fzXfpZBNia34Scyg53Mu0lyz
         Xg83Vle2jySQXw9ahzxjC7oPbrnv/qdWmfNPqfLe0ebqBcPYLqjql5AaIqa2aEwRDxly
         rCIFfdsRrZtI80HrjIfaxg+kv+9g5CNd85HNocXkNODhjwPQQX6AoVNW92xwMHn9ICn5
         2LPsuDlBJ2dQXuga3zKT2uOxAdfAJz7/6h6NQqXOnIXZfVL4ZdaYOnT3InSBTTjIFF+Q
         +DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543789; x=1703148589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkRyaEIclzm+ShIMyVUbqREgKKajNjynsQ0mobEpXzk=;
        b=uUl8MY4/mk26YUk7Auc+VwcnP/J4xjqFnXgYYAjWldx3SgKiRYAl7EWj/6iBeHHzFp
         0R90vazMpx9p2LZcvanh2CrhT2SNCNyYfqIa3Xd52JI9du6AfvuLjZEST/0mXY5iX/Dh
         dWmZ/ZDJq9uPgF6LvO+Dg40OeLhjTOlQNJoRkwM21ZtWqaVKlUUXTGm8yebwmQVSB65q
         SgABWuufJSDej8hK3lyYqMAtzz+YS1G/BKLFCa/46K9giElRUL5Evdm0POf/q3wVEcPz
         REzActqjG+yTXXD1RyaKQsgnhsoyYGZGXoa93M1F0yeiwLq99kcc2xeSNHgWJFoQI3mq
         yzqg==
X-Gm-Message-State: AOJu0YwBl1lj6C+PzYKxn7+vpkmINxytTCtZJ9Nm0DfnAah8tHx2YhNH
	BzNUvvXNYt2SVZS3zGDg4+e996IliuIBAw==
X-Google-Smtp-Source: AGHT+IGDg0Fyhjpq76SSgGU1J4glcAEVxaBtoVs6Vf2R1J8FGM0E4F/WJ9Arlixnod9ZTdm1m5VCvxm1fX2tEQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:6b0b:0:b0:dbc:d896:9795 with SMTP id
 g11-20020a256b0b000000b00dbcd8969795mr39417ybc.12.1702543788881; Thu, 14 Dec
 2023 00:49:48 -0800 (PST)
Date: Thu, 14 Dec 2023 16:49:17 +0800
In-Reply-To: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231214-kunit_bus-v3-3-7e9a287d3048@google.com>
Subject: [PATCH v3 3/5] overflow: Replace fake root_device with kunit_device
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/overflow_kunit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 34db0b3aa502..c527f6b75789 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -618,7 +619,7 @@ static void overflow_allocation_test(struct kunit *test)
 } while (0)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
-	dev = root_device_register(device_name);
+	dev = kunit_device_register(test, device_name);
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
 			       "Cannot register test device\n");
 
@@ -634,8 +635,6 @@ static void overflow_allocation_test(struct kunit *test)
 	check_allocation_overflow(devm_kmalloc);
 	check_allocation_overflow(devm_kzalloc);
 
-	device_unregister(dev);
-
 	kunit_info(test, "%d allocation overflow tests finished\n", count);
 #undef check_allocation_overflow
 }

-- 
2.43.0.472.g3155946c3a-goog

