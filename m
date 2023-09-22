Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59343A9E
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:50:35 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8FCED
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bf04263dc8so1465602a34.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405030; x=1696009830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrtz1QFozDlH3/nit7ZF/0eGtthYpeLrLWIW05kvAAU=;
        b=IMXDEBxnsaoQverSML88+YIa9U0dITWZMpQV6p926fsOeKkYDacRG2xvvE8WznPdtf
         T07tmv4/5XQQWMy27COlE73HHXenLBz3kw9/effXmqybZC20Y3dlPHyzGJ6aPo2sj/oX
         XeqT0Sy2jQe1p534FTUKFiXzzRnQUk9xfum4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405030; x=1696009830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrtz1QFozDlH3/nit7ZF/0eGtthYpeLrLWIW05kvAAU=;
        b=KPgTIUJeP6uDS50fWSneqtnJezcZQ0T82+Inju12iZ/ACAbXjtKq73ThSMt+RmVm5E
         haJZX7kIFXaWAs+5y9RCavLzfZ0dgYNKKrQIHX1xqOx/swIRvn4+Yl3b27IkxQYPowqX
         JIyv31/esQrHlC7ecFJCfJnKiMMdOW6QOpZv40wDIwmoUHE/InI1GzlWa8vOpcjsHbD8
         Z66dsQwrGLm9hoJAqgcKpkseuTLYLqbEPaF4SSEk9vAM6rrNn3HOO7U13xdFZPWDHHa0
         Fg1eod663wPSr8rxXcDJH2LNEk6/iarHTDz8hdAZxW1jU0hb62zkPJxO329ZkN0u/5Yc
         0UIw==
X-Gm-Message-State: AOJu0YwiLDaK9z0IdW41bkq8RTWvQi5T+TzxTnosEG47f41Fvx+k1+Qd
	4YKcngm3ls2QDM+1CLYrlXGvSQ==
X-Google-Smtp-Source: AGHT+IFJh95YQOZBveM2XcPw/CDPZ/6OICivEFtPWMcL1XwnDyu10HsC/gAgnWiCOFnG1qMx0vCAUw==
X-Received: by 2002:a05:6358:27aa:b0:143:8f7f:9150 with SMTP id l42-20020a05635827aa00b001438f7f9150mr360342rwb.13.1695405029982;
        Fri, 22 Sep 2023 10:50:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020a637f08000000b0057d86bb613esm1259916pgd.45.2023.09.22.10.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:29 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-input@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] input: Annotate struct evdev_client with __counted_by
Date: Fri, 22 Sep 2023 10:50:28 -0700
Message-Id: <20230922175027.work.563-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=keescook@chromium.org;
 h=from:subject:message-id; bh=F0Z7qk8WbE9IhwsU20RzqLTm540D9AV3CzIu9FIos2Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPjfCweOYJ24fK5QO6nd0/ZcLHSx0EiqUyvr
 m1XcXMHLxKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T4wAKCRCJcvTf3G3A
 JuesEACmgZ7LJ7hzGTmPk4sjXyOwzvRHjPW7AZ5lnEZqS5CAf9LyiS/rXgpw4uGU0ZlR9/CYbEC
 CoG8fsG7pB7gqgEu+NyGT9wlhpWFp6gEr6LfIQoq5h5QG/BygRUsRAPA/SWjJD3/Ph7SOLMAthq
 YzsNXZCD0QXwzCICFZ3BnDqiEzau7j3WjNxIARgkVUr2kY0JPd8lBQIvE6GqVClHP01tLiqgbj2
 5ZnsuWA2Yb1kkZwfTi3En34dulyGlkwl3NtYmcmSdo8iAbUpkdXL8QnJGhQHlGXh88gYummzjLi
 ebj7or4i8/Fwsq95c43QxcBdyguuKr/+HubKfvjT8V07aVfNhZdeuodMDCGre8CW2Qpb8r3UjH8
 zHemjDdNd16/u6fth2UHJlUt9kF8FoEeiJl+1J11VoqdmPPsfuuuwRCbwB8hK5djmvGay2y5AYi
 unBmV/C0AKdGP6XZgGhB6mXao3Y6KX6DtdXL0PG0VH1Ukl3iNSBzwRz1IpRmxf0q2ACOq0ZWGO6
 BSgRbAWiyvuc+ZG+Sw3zFqBiGE4bc+HoxW5XYUQe+GLkuiTipuB7Xwj8RVc2O45B+6KS4qKgWgg
 wt1WodmF7XKHVB615egh8bmJrV/8mlbZ16PU0UmnL2BmHymc/BqC7MEHjM9RTvqdMwnmkTFn2/G
 bT1zU6M 23OjgTHg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct evdev_client.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/input/evdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 95f90699d2b1..51e0c4954600 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -50,7 +50,7 @@ struct evdev_client {
 	bool revoked;
 	unsigned long *evmasks[EV_CNT];
 	unsigned int bufsize;
-	struct input_event buffer[];
+	struct input_event buffer[] __counted_by(bufsize);
 };
 
 static size_t evdev_get_mask_cnt(unsigned int type)
-- 
2.34.1

