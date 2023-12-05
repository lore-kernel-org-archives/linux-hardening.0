Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU77UWLf"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F21B9
	for <linux-hardening@vger.kernel.org>; Mon,  4 Dec 2023 23:32:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db584b8fb9cso4402145276.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 Dec 2023 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761529; x=1702366329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHfmQmZDYuyXCu0NGdHRUb/90Lva6Q2oB2rwJOjRS8=;
        b=gU77UWLf17NGFwns1NTtH4ufmlGXSuKUVMe0SMM3Z/hkuzpNhnNVs/ZdiK6v8qArF6
         1iPq9ZvY1n1XV3BuyBhS4bmkK8n6w20y/1zUlCfOFepTmp8dM/vEVUVW3ZPiyfbMRP09
         hCwu1fRloMi511BNUmei169Jh4wxlce0fe+rV9OB4IrxNpS6tsjOgXiLaRfHNMwnwex2
         ejrpMQ53Cn32gWbPxEVS1/Yjq8olZc8mk8my+okMtGnUhPA6d6nmXnJXs+6+EWW05mW0
         ifZyaaeAlZ2xHbNk+ndalBpIbTFFUgDECLafYNtE7lWJ7IA0Dp9H6goWe+DyqAqCVbkp
         Y9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761529; x=1702366329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHfmQmZDYuyXCu0NGdHRUb/90Lva6Q2oB2rwJOjRS8=;
        b=CtjFIbOz9hTgVb05Pp1/+Qj48IB23GHugnKb/bOfovVXsO32c5eJsGBOxK/2UtzW+i
         2gmO7Z9sPIQPmRqzAFUJIDzFykROKxjZ7w+3CUIYXwW8O03zKA6DQfLNu+qaIfwAKQaM
         xiD5dgGsxutNumFDATgc9z8xm6vfaPZEi4nT6CgoU9sWfJwCIbdtK8+a+O5QuVHVJnKO
         6nQPvj3GDO6DCmoEj3JNjlDkIkjtItmWd9yybhnyoiwcT7UrIwxe3xYTp9iPF7jLVB9y
         xG763cw22DN8lFWlzNj3LxUwv4imYfLu2G32Ck0fLxJLabKtmnXwY7cuGNbbElb9gtuH
         UGrw==
X-Gm-Message-State: AOJu0YxnNN4QsqWR8sgodUSPiHUl9G8E7+m7yPKk7mhe+Vpcx7GCEe+g
	2sT0dkfmAwjDgPwdZr6b7b7ShbxDPEM4Pg==
X-Google-Smtp-Source: AGHT+IHHF6+HTN+R7wTnVRWLqb4w18tX0Cim+QBivHuTkcMFGQFLnFtpexLAxiytHhXHivrQcbisM6rp+Y02ZQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d6d1:0:b0:db7:dce9:76d3 with SMTP id
 n200-20020a25d6d1000000b00db7dce976d3mr188630ybg.9.1701761529700; Mon, 04 Dec
 2023 23:32:09 -0800 (PST)
Date: Tue, 05 Dec 2023 15:31:36 +0800
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
Subject: [PATCH 4/4] ASoC: topology: Replace fake root_device with
 kunit_device in tests
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
 sound/soc/soc-topology-test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index 2cd3540cec04..1d7696e5bffc 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -10,6 +10,7 @@
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
 #include <kunit/test.h>
+#include <kunit/device.h>
 
 /* ===== HELPER FUNCTIONS =================================================== */
 
@@ -21,26 +22,20 @@
  */
 static struct device *test_dev;
 
-static struct device_driver test_drv = {
-	.name = "sound-soc-topology-test-driver",
-};
-
 static int snd_soc_tplg_test_init(struct kunit *test)
 {
-	test_dev = root_device_register("sound-soc-topology-test");
+	test_dev = kunit_device_register(test, "sound-soc-topology-test");
 	test_dev = get_device(test_dev);
 	if (!test_dev)
 		return -ENODEV;
 
-	test_dev->driver = &test_drv;
-
 	return 0;
 }
 
 static void snd_soc_tplg_test_exit(struct kunit *test)
 {
 	put_device(test_dev);
-	root_device_unregister(test_dev);
+	kunit_device_unregister(test, test_dev);
 }
 
 /*

-- 
2.43.0.rc2.451.g8631bc7472-goog

