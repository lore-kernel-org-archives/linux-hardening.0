Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C243AB3
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:51:33 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844611999
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso20496035ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405077; x=1696009877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FhFEbneXxxaBPpeUpxOqm5me+1wuH+iOEgRRKvJoLs=;
        b=B9ZjAfzVQZaHVrlciIR3H4q/zXJyYPCqaJBM2fVayL9nrchrdpkhrAGndqF08888Jr
         etFm/Le8FHSMmf4iTFfCJOwwljwvGy9977QUvcHKPOLfngnoqS530fLS1gBSHHqODAd7
         gqOm8xmUlS3hLmDY3/NQiLvEoGdP5MCjLFYzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405077; x=1696009877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FhFEbneXxxaBPpeUpxOqm5me+1wuH+iOEgRRKvJoLs=;
        b=mKbpMwuGSfytYUz2DXHdk+7hKqZDTJjBupKtSSrHw37eMVBEktx+sC9gz7mbluDMI7
         EBvshlyztLz7BDFeuA6Wi6pXfgjscqc2q3ftCXY7OyGPczvxtT9Sh8rlUFsaoYQ5sg1Y
         PIKLksfFDnlr9IkcdR/MqBFgko8797AER6yX766bnzL/jzqFqMX8bnD8JQ0SOIuYrtm7
         XvjVAldjZQ99uhEfGRdUkwI1+zwvv252bb6yGIeFe43WxZVh/VGSmCGoOFGAnd3uzWCO
         GYaRbCkUSNEhWlCKSjtxduJ4WFhViMRRWCERXQkK4n2ZzNl+MKK8KNG9O9WWb6k2QcJA
         JzRQ==
X-Gm-Message-State: AOJu0YzNkJOVrceym4fbFgJZawvTN/G8O9adCpb+xtNLa5ZXSGh4VPz9
	XN+aW5PWxwB87G5bt/mB+qEGhQ==
X-Google-Smtp-Source: AGHT+IGbdv9VwbwNAFjuBeDTZqWEmq6Cgd7EZVO0zimsbEWBFdYx8gilTv66w2ACi0U7EPXn8wEnXg==
X-Received: by 2002:a17:903:11c9:b0:1bc:844:5831 with SMTP id q9-20020a17090311c900b001bc08445831mr94508plh.57.1695405077190;
        Fri, 22 Sep 2023 10:51:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf11-20020a170903268b00b001c0a4146961sm3792429plb.19.2023.09.22.10.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Amit Shah <amit@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] virtio_console: Annotate struct port_buffer with __counted_by
Date: Fri, 22 Sep 2023 10:51:15 -0700
Message-Id: <20230922175115.work.059-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hLc6EjIakpzsaX2PmH9KGXcoCU7k7VxuxAddnu5wvP4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQT7dSBQHc/s6zgQ1bG9pZSaUdLcPzEWU5q+
 UW8H+WTeDCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UEwAKCRCJcvTf3G3A
 JvOmEACk0QTdWB4H9s0DTbpqXHzvscY+UZub5Qt5LP0HSsv4VUHS2VqKK302oSkpmjRd6PnScRR
 CgD59KxXDfrn0HXWKbgYGs9RBY9LB/BYhtrPIB+oA4X2l2bejqg//JPkCS5c3YQqgZslnuhfY+K
 2qWoHc1d1Q51y6JIDeheahZwH2BAv/dhFLmVYKUtR2CMk6muErN/cf6KqtBMdaqmPZ3PDtnHnnG
 M4+CHKXrUvsM99Lcvi6rtZ+r4n5q6CcSns7LnRTpajJJesE0zXK5GHp36jbRQ06nZzMWRztHxt8
 bNaRpaV55BWkecXEOURmiGWFxtqwNgaUeY/uBYqsl2ND5izgFB8mnE7jPdvkQNUPaQbbBSsyXc2
 xm0/NYMUo+aUXRSqxSptEQhc1ANGAwMUx8tt+8y9JpsZP/2691w3VuXNzp/pCtK4j8a4sJrJ/on
 XMA/XKEbifZ3ep9LXPAHWWlwjSVSvw0jzJ8ZgeKWjQTvb09AawkDpXmhUr8r1bSCoKQksybOR6S
 sRo2x2Xc4LL44AKxKWTZ9HhOzAn/iScJowWZki3dOZrMvsN5Gved36lKyWWuFQifTANbzNIPFvR
 1K35LT2O+9RZkieJErqb3GdNTuAQLgzFnrq4CtpzXoKu/Tst3IylFRzlkloZnU+cgGX1uqfgtv1
 OWDskmG st82qa8Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct port_buffer.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 680d1ef2a217..431e9e5bf9c1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -106,7 +106,7 @@ struct port_buffer {
 	unsigned int sgpages;
 
 	/* sg is used if spages > 0. sg must be the last in is struct */
-	struct scatterlist sg[];
+	struct scatterlist sg[] __counted_by(sgpages);
 };
 
 /*
-- 
2.34.1

