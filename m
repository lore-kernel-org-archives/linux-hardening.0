Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4Tx8j3c"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8A189
	for <linux-hardening@vger.kernel.org>; Mon,  4 Dec 2023 23:32:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db7d201be93so3242381276.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 Dec 2023 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761525; x=1702366325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DV9smLZQ3RX5iGHV5Mh5U08N7CP5uXEtJIVwqfx/P5o=;
        b=l4Tx8j3cLfBVHAArTgqSGR3ub0EuGRlDa298yBD+23HvoLHHgTUAkH/8iQu8LHH+E4
         Q18aw3clzqr4uyhDrj8B2/nIsZglA+Ft3E3QJ4sufn8JI10O1K/FRTIe0GDtCjYg5RzX
         ZoIgsQ56jAswAG36a9sJ3Fm9IAFW2lbI2/7JkOtUoL7CzD//iclCFV27gHDnaixWcSa5
         WjAOesrX80WgM2JBeiY1pHvJn6UMJW9cxdCcOeCePxiHik05s6kYSjWOauBe3jrRUpah
         vsVxCEPpNaBTvPIIzlUoTA1lE8eE5ct0QjLKrCu38NfDqk7coOLxwKgPhWMzm0cv6nB1
         gh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761525; x=1702366325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV9smLZQ3RX5iGHV5Mh5U08N7CP5uXEtJIVwqfx/P5o=;
        b=F/08v+OYzYJylz8PgG3XAa9zWWzS+C1yHQxBrd2s/m2DygeXoAalcWousigfdavgu2
         mvFbkLWnuLdzUD2Jqf7j5GKkRJIWHY/uHztzEvE/6uGaa78waV7EJcfxQwL9YG3fQlQO
         fM4GSg4ZNk/iqmdrU3ZZqGdnNaZkduaQX7NC+ah9FmDMt5exOD/uz/ertUYZwAPC9owX
         0cN3kAt4J1X/aqSdpMux/K3kBzF8zep7zKkiIgG5YjZClcsMFQ6ECaaiBV9uvrFpeaw7
         JT4tMXisL8ZLoTkooDr25pTbwuuNjAQgpCeVbeo1fPwJz99DvByhWMEuoR+bc6JxCtM0
         z2+w==
X-Gm-Message-State: AOJu0YzG3zsppbhHmT+wRHNv//sTuAAm1oCJs4AMhPACJOPUx6Ssmtdy
	G+/ZIukJr1W40uqI8Y6CtVI+UpfYrFmiNw==
X-Google-Smtp-Source: AGHT+IHd6HO2jMP5HD9ZeIpo6hwIyN/w0eC95NNxakjiXl3f5OV+SEA9oRHhQ+nDPt3tJrzszUO4EACeVBNHug==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3d05:0:b0:d9a:ec95:9687 with SMTP id
 k5-20020a253d05000000b00d9aec959687mr967759yba.11.1701761525047; Mon, 04 Dec
 2023 23:32:05 -0800 (PST)
Date: Tue, 05 Dec 2023 15:31:35 +0800
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-3-635036d3bc13@google.com>
Subject: [PATCH 3/4] overflow: Replace fake root_device with kunit_device
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

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/overflow_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 34db0b3aa502..91b03217c462 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+#include <kunit/device.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -618,7 +619,7 @@ static void overflow_allocation_test(struct kunit *test)
 } while (0)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
-	dev = root_device_register(device_name);
+	dev = kunit_device_register(test, device_name);
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
 			       "Cannot register test device\n");
 
@@ -634,7 +635,7 @@ static void overflow_allocation_test(struct kunit *test)
 	check_allocation_overflow(devm_kmalloc);
 	check_allocation_overflow(devm_kzalloc);
 
-	device_unregister(dev);
+	kunit_device_unregister(test, dev);
 
 	kunit_info(test, "%d allocation overflow tests finished\n", count);
 #undef check_allocation_overflow

-- 
2.43.0.rc2.451.g8631bc7472-goog

