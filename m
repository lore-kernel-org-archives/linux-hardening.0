Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybUHB77D"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4363111
	for <linux-hardening@vger.kernel.org>; Mon,  4 Dec 2023 23:31:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cf4696e202so78958227b3.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 Dec 2023 23:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761511; x=1702366311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JsOh9q6q0UN+mDlMzNPs5NaqcMHr7XGfa8SwR90H0Tc=;
        b=ybUHB77Dcjb1Q7v66f7G76bNTOfGSEIfi3nS76NmTw/pJZaVJaK2XB1D1hmSyIjyYG
         2AUgVvVN5+g9OhJu8svJwY5w++BqPLWYyxc7mlCyUNeGejwLKuv1dfyc4g0D0HFtYfFS
         rs1PrFBNUCe5qHPeK62708nZnfVt8xg2s3yqRp2Yv5ugMTaMn4pQsJ0N8GGc5F3n5KZl
         U4dqTf1J6gQrlPKXkQr828pazFMs8ZA+XYCres8b/QUEaem+PTAbwV7PFHizeLJxln/r
         P+8B0EuyiF037gxdtk3GTf5E3rZHqMBkPYvWdcoN7DgP2sQlykBLz77w6z4dcdT4N8ce
         0xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761511; x=1702366311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsOh9q6q0UN+mDlMzNPs5NaqcMHr7XGfa8SwR90H0Tc=;
        b=m/oltIVy/eevXPFgIjG/P2Bh5JDvSOUmD5lV0cW+el6XMCcgU3cQS0T3nL+pDzqvC7
         zEnRdOZnOGvyO0yqhnxqybDOZ2lqU5La6S8PcerO/tu7BOrjGijlBeLxzc3humx69xAO
         cXbD+aW9gWbOCfWSxi+zbD9zpRnXRPaeDcdsiYrs0PhyqtBTdCRTF+LtPbUmZQ4PTX6a
         EyB7Axfo09XeD73Tm1dHXUuaS49M3xNin6HLz9OLHB8A2s1q7/nqBR0BQtsIh9O84Hlp
         g3JyCuzP7HqVtg4Lw7kMWjJDU99u7iGJk2fHBfRygcy83RcsqZniQBaR49mK2JAVGRVn
         +wqg==
X-Gm-Message-State: AOJu0YyQUZx+GKXomQZJ9GDeHkAHFAFCkh4cV1QWcwHEpHBhLvgG6egq
	IyKtCoKCPr2WdOroPr2fepAUCuAR1tjbbw==
X-Google-Smtp-Source: AGHT+IHsltJ9odLW8UCy0fZ0hGHznDsQzvjXGXw2JM/DWaq2q9fJW8AFLy6sfA63g4Lz9Smrf0AkVUjmwmRGWA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3044:0:b0:d9a:4e29:6353 with SMTP id
 w65-20020a253044000000b00d9a4e296353mr1082696ybw.0.1701761510878; Mon, 04 Dec
 2023 23:31:50 -0800 (PST)
Date: Tue, 05 Dec 2023 15:31:32 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANXRbmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0ML3ezSvMyS+KTSYt3EJEPLZJPUNBOLlGQloPqCotS0zAqwWdGxtbU A3vcpelsAAAA=
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Subject: [PATCH 0/4] kunit: Add helpers for creating test-managed devices
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

KUnit tests often need to provide a struct device, and thus far have
mostly been using root_device_register() or platform devices to create
a 'fake device' for use with, e.g., code which uses device-managed
resources. This has several disadvantages, including not being designed
for test use, scattering files in sysfs, and requiring manual teardown
on test exit, which may not always be possible in case of failure.

Instead, introduce a set of helper functions which allow devices
(internally a struct kunit_device) to be created and managed by KUnit --
i.e., they will be automatically unregistered on test exit. These
helpers can either use a user-provided struct device_driver, or have one
automatically created and managed by KUnit. In both cases, the device
lives on a new kunit_bus.

This is a follow-up to a previous proposal here:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/

(The kunit_defer() function in the first patch there has since been
merged as the 'deferred actions' feature.)

My intention is to take this whole series in via the kselftest/kunit
branch, but I'm equally okay with splitting up the later patches which
use this to go via the various subsystem trees in case there are merge
conflicts.

Cheers,
-- David

Signed-off-by: David Gow <davidgow@google.com>
---
David Gow (4):
      kunit: Add APIs for managing devices
      fortify: test: Use kunit_device
      overflow: Replace fake root_device with kunit_device
      ASoC: topology: Replace fake root_device with kunit_device in tests

 Documentation/dev-tools/kunit/usage.rst |  49 +++++++++
 include/kunit/device.h                  |  76 ++++++++++++++
 lib/fortify_kunit.c                     |   5 +-
 lib/kunit/Makefile                      |   3 +-
 lib/kunit/device.c                      | 176 ++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c                  |  68 +++++++++++-
 lib/kunit/test.c                        |   3 +
 lib/overflow_kunit.c                    |   5 +-
 sound/soc/soc-topology-test.c           |  11 +-
 9 files changed, 382 insertions(+), 14 deletions(-)
---
base-commit: c8613be119892ccceffbc550b9b9d7d68b995c9e
change-id: 20230718-kunit_bus-ab19c4ef48dc

Best regards,
-- 
David Gow <davidgow@google.com>

