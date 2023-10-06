Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3A443689
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVL+eVa3"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039B12A
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:17:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so2218582b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623471; x=1697228271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6YwZjvr1n2rReATmOsCl4/nRWCKGZ1ZgYFpaWNXvg0=;
        b=EVL+eVa3KsRKrxwxM9roulDeXC4NboWlhS04/2Tzj/Xu477y+FZ3o2jYAmXlapjP8D
         LXKxej68NE4SHG3PRa8xD1dffV3N/dHrWrAXhzqWl5rsLR7r3f28dUYvz3XW5SYWxhTn
         hpl4ubqwUHdiD11Pb6jNEa+AKlaAmhzUgk9UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623471; x=1697228271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6YwZjvr1n2rReATmOsCl4/nRWCKGZ1ZgYFpaWNXvg0=;
        b=EmZaHHb1dgnAi7KIyi3dkJaEOhjnpjvImFvmYlVIkxZDBaRjYdhE5H1dAsfOMbepqq
         ymJkNXgcNhD5WQSkpuPw5PC87JaEGV8WSrY7Rfk4U3lsjHCd/RcY4Mknp2co24+/UuAD
         es8qK9+E+LkBNO1SE+E2ro2JUWzqxUdU22DfJrP3/FNdLSlsu7RfwHb6hC7IcQXE9D5d
         PSVoQ7qK8AG3FGxICjsHOV4gNRw8nsyVBXTWr/Twb9mC1r+nzT2I8VDEsnVHzvi7CDIH
         EPHtLaHjmVhhSwJAh7yTy4eKQ9QbtNquGzoEt0VzRgq92Ayz9LcSwsGrQUY3EiM9WbhM
         Woww==
X-Gm-Message-State: AOJu0Yxk8uIlRuF79QP9l6C5ddLu5CPsc4gkDCigf2nxShCJJsi2Ef8Z
	wSsRRNuOBQ2k+4Cb5TskYAMIRQ==
X-Google-Smtp-Source: AGHT+IGCGO/cXTptgEcWlTMcxY5y14yHjew/epDhANqohnxpsz/a2MTS0rt9OpO+iHMmFQASendtCw==
X-Received: by 2002:a05:6a00:814:b0:686:24e1:d12e with SMTP id m20-20020a056a00081400b0068624e1d12emr10202159pfk.30.1696623471603;
        Fri, 06 Oct 2023 13:17:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bu3-20020a632943000000b005657495b03bsm3711505pgb.38.2023.10.06.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:51 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] driver core: platform: Annotate struct irq_affinity_devres with __counted_by
Date: Fri,  6 Oct 2023 13:17:49 -0700
Message-Id: <20231006201749.work.432-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=keescook@chromium.org;
 h=from:subject:message-id; bh=KxdzKJ0tyfEaDG8yDFbaDj7zdUPNncMi/SrMW85pCgE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGttEdKoPsgisFKN+sc/je+mRE7+YQ67EeQ2R
 TIPo+ZI1O2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrbQAKCRCJcvTf3G3A
 JiUiD/0RVB9iHYUQ/FQYj8q8DSYzDgIYFkSRrwjxH5iPpaHW8oj2mmim8HgBEz1VIDqO+p0VM5p
 aiL/CdQrHlZC3x2FSA+BsLAF1k+HCwHIM9TdtsoWpn2tvVRWJHM1u0zMwJmAG2pd0h0j0AEba9L
 x/WGtSFmIMIexH2aaSQLfCas3GTZZt6aR7r5OXBDqmDYUaA79fEZOvEsO38Iwl//7xNSjvJrlgp
 d45d5jsSjBKXL88ijkWOmgJ9/bubUOTSTn7IFMEFYmUdBu6KInG0yGi+H5wvdK090l5eGWxY4H9
 XFwOqMrCkiD0iaCYnqc8Yb9UjYr8+mICYLthH+179hts4zSS120ZSNTYY9juYfK18m6eUl+w2Se
 Mr6ALao0wMI8wOhuRLlmjkzA+yLwtnOHXeNINLUCy7kgXwoXzHEgyHyCFfcKfZTqlWwxmoZB9f/
 Qq05MfgERPqFCEuigvSMdiEklLYBVAD8pOy1MyoO6VH1/6lYhMF/WMT9WERicUOIIR67Qac8XBW
 9iHani7cPxpsLYljbnSgwyxKjz6j++nbA5wk7hw3IXHLTb1gf8W7p2VuJrU9dTshhYHn2yKe3OS
 yHCcvlP6Gq1KtD9ZjtMeUmjCCqs/bc4JuC8t/Wtd60aScKhqn9mFtdzx3rVSrgckTShD4+q8/LS
 tCdD8QJ jzU4PZLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
irq_affinity_devres.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..07216889d3ba 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -291,7 +291,7 @@ EXPORT_SYMBOL_GPL(platform_irq_count);
 
 struct irq_affinity_devres {
 	unsigned int count;
-	unsigned int irq[];
+	unsigned int irq[] __counted_by(count);
 };
 
 static void platform_disable_acpi_irq(struct platform_device *pdev, int index)
-- 
2.34.1

