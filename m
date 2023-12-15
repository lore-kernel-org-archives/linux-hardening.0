Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C48DDDD
	for <linux-hardening@vger.kernel.org>; Fri, 15 Dec 2023 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4M406bEs"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e302b65cc7so2306287b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Dec 2023 23:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702625963; x=1703230763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=4M406bEsdMF6O3NRYBNV0wD3FBpWItAMUWZdgyj29cY5Bsaecy5YDs0h2B8ApR8Uz9
         8XuPdszBhfvNpgEEWWDE6df7Z7zMRWgPOAZNjcd0xZeQkoxRczhnXOT5lxkSqXkP1uhY
         FC3n6HG6YnzcuiSyL6rxUiouLm7ywgAkZRroHB7aggZ4RdM76a/vy8tEGPn5cLToLoi2
         pz6c4hcAJq6Y0soTQS5Y72IRGWW/PNlHlfhGByc5xfjrydePSep2ecgVVrMiJnI1hAbl
         Iq4Mi3JwVzP56tcPtYd6B+M8PPKiTsJW8EkyTUZ28Q2yE3WYsZc4S3oJXiRl7+HQZB/g
         CKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625963; x=1703230763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=ddcVzG+snF7Mzx9CA/gOHjZiV9NvQFcw+1znRkV92Svo56oIOfZmmCa9ftwOYddAHO
         jDmqDhSYDbUdqp2/IICN7bu0dPxZWs+5j5Te9K3zz3jzwxMX1qUzpyVPPw4NyACCuVQv
         FbullEHgG5ml6hj6iaCavIBSQtzZzBDMQ89xE2/hwn03SJNSBGBIc7+/M3jFs6tbu3HM
         0ejbSQV9vQBycqCzq7/alc8As9cqniAbEn2YatPO6hlUKF1QZKlK9W5GRTT/MHiKVZGC
         OXlYC2NBwRRr2bJWOXEuTREMo0oqAiAMUrXR8QCboXNJ0zVHCLenzLQ2MiH+C1mpvCTm
         loKA==
X-Gm-Message-State: AOJu0YxFgWkay/aWQKD03YaSrpyRndzg9GLVz7VrUplaTCqnHRNDEJPe
	fChKnaQ0vhIeswhoKlcp0ItxlZ+zua60JA==
X-Google-Smtp-Source: AGHT+IESolPUWUjcu8ehVBMVbwsHg0hbt8xH+da+fFZstOFajYilu1HiXZJcR+VkbSIMMfIUvRBPM/Nns0DS4A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:3604:b0:5e3:d2af:8b78 with SMTP
 id ft4-20020a05690c360400b005e3d2af8b78mr27176ywb.3.1702625962892; Thu, 14
 Dec 2023 23:39:22 -0800 (PST)
Date: Fri, 15 Dec 2023 15:39:09 +0800
In-Reply-To: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231215-kunit_bus-v4-2-4f5160e2f95e@google.com>
Subject: [PATCH v4 2/5] fortify: test: Use kunit_device
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
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/fortify_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..2e4fedc81621 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,6 +15,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	size_t len;							\
 									\
 	/* Create dummy device for devm_kmalloc()-family tests. */	\
-	dev = root_device_register(dev_name);				\
+	dev = kunit_device_register(test, dev_name);			\
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
 			       "Cannot register test device\n");	\
 									\
@@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
 		devm_kfree(dev, p));					\
 									\
-	device_unregister(dev);						\
+	kunit_device_unregister(test, dev);				\
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 

-- 
2.43.0.472.g3155946c3a-goog

