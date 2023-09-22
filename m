Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EB43A81
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:50:21 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8376E49
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690bd59322dso2018750b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405013; x=1696009813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHp1ED10bg43WmKmQvz+z20YRsbZCcJDatOaeiR4cRc=;
        b=kYM/pP2NkUCvetwgd+hi6+i1TURFdyU5Oa7s1I43DF2teL/5DdyXDjlW5YDjUpgPGu
         n1astgEiVM8bluAbe2EQCkyG7BrccQXxyR7kGeKqj5FcRbXolUsgUDLDDSYQgC5TI5zn
         3Eyut2HzvPs+ZIjuhvj5pxRchXfhHNw9HATR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405013; x=1696009813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHp1ED10bg43WmKmQvz+z20YRsbZCcJDatOaeiR4cRc=;
        b=bB5D1I9DIVDC4bRSCiCnYCqCRQCP7WrXWqXw6Oa/CGd0z3j1hWDO3Bu4LKsxCG0n+8
         nsOcrWyEwbX7OCDnW1oO2q4W1m4icKwJo5ewbgds/5Jm5tYXjfxB8E4jhguHSjEamq1w
         C35iC/liC22KgL8fIyvBFlGXw0zrQavzt7b0eip3+8RZUcG8SGek4ApmWxX3C2gKO9VC
         tV92upa6sl9ziRzjsWxTp51CG8JeODfPLPWK6QE/3PUdOJ8U9Nx21QfIV1nf3WpoWUt7
         05x2E2K/HS/hVYHWZE1T15+dBO2GtyXqtsWy//ERoUhH82ZZCUhHrg0rsCfXazkV/OEM
         2vQg==
X-Gm-Message-State: AOJu0Ywz+Om2kUfb/rvy5z6wFXeT7nWmsjiZGc2Tvdw6sAfjRcEgPm1F
	PG0s728hFomlhB/jOVdpNyTSUQ==
X-Google-Smtp-Source: AGHT+IFUQBKrktGM7T6XnCIgINsyQ4Uqfg3+fboOe93XpLQmHZ2pILAVIbZVXa2loO83xONkmkZlfA==
X-Received: by 2002:a05:6a20:430b:b0:153:b16e:8db1 with SMTP id h11-20020a056a20430b00b00153b16e8db1mr245441pzk.10.1695405013229;
        Fri, 22 Sep 2023 10:50:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001b9d7c8f44dsm3767571pli.182.2023.09.22.10.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:12 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	linux-i3c@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jack Chen <zenghuchen@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] i3c: dw: Annotate struct dw_i3c_xfer with __counted_by
Date: Fri, 22 Sep 2023 10:50:11 -0700
Message-Id: <20230922175011.work.800-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=keescook@chromium.org;
 h=from:subject:message-id; bh=g1g4deThn2jq2/HmpjUdVckXHtYrg1phRYVjxqpT31c=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPT88H9qzG3LMBy5A38JWSSkUyL3Eg6YJLhU
 eMX5HXSGtKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T0wAKCRCJcvTf3G3A
 JpPwEACXZRomIRPU03APpI2pgvFryCHHAmuDLTXo0N1fOecwRoE4OGPaNSqxHZPbQchIrRD5yF2
 2dtE1vedKPQ36FCNd1BwbsjXBmiJ3TNdl6bYV8cBK15uCpVDhwWgGbYXEOb0ZFC3W+Id4Y4vUBT
 rP7TxnKo2Y/NRYdKNeFRo+0kGxIW3o2B9flG2MIwDroKvUztJPHPJ+w/XDm3fUA7mJlAeQ/Ft1n
 pfiE4aFzxeUBy75Y1n/Kb1+CIFw8hFjmV4PmfTlUbdsYL2HNl9kX5b/+ULhPiEr2yr/namr9ckn
 Bv6v30Wc10cBSr/YO4ueLcr/RYKLZqJqmx8w1numFHJkhRIbk9d2D+A5Qxx3i+/LO+A25t45cIr
 CazDqhoKDhq66/KtUesFjWOpwuIP0maUx/BcoKvTDVziUbNKlM9XVEsUg1RCR25GOTAIPyYqKRK
 tERqOZjC1PEzFwxPvIlX81QQVkxPEnwgux++N4hNgXMqK3uGDPrmP65kpeVLv55kh0QB6lOOloU
 1CihM9VKHEPWBy2KM8zJVbTbyn5PlQQ8D7c7wcTO4ocA5q1cqWTf/R0bH8YIO0lCX6AuhnUcLCT
 5MEnctf90+Y4LvEimrbWP8c+2OJp4TPkHzH/bwt5+YoxFvuJoCQMkQxvnE1mGXVGjWiNwc4gBC8
 c1GN5F1 dRrNbxxQ==
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

As found with Coccinelle[1], add __counted_by for struct dw_i3c_xfer.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-i3c@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9332ae5f6419..ef5751e91cc9 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -233,7 +233,7 @@ struct dw_i3c_xfer {
 	struct completion comp;
 	int ret;
 	unsigned int ncmds;
-	struct dw_i3c_cmd cmds[];
+	struct dw_i3c_cmd cmds[] __counted_by(ncmds);
 };
 
 struct dw_i3c_i2c_dev_data {
-- 
2.34.1

