Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6644495
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:56:48 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA689199C
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:54:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c47309a8ccso28622485ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405275; x=1696010075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yau4BT1EoLV5IJxhaSNLPuA1eve9TNZXYVy+N/HUh40=;
        b=K9qyHnGOKl0cqd40Zt7+2PnbAm56Cq85B16NBf/DE2nkbCT4rG96JZkKoe7Molw3oB
         umFQDru0ttKOWC+QulCRNzBmGiAe82eMpo9ayPT7IE0ONIajhmxMJJb1PXL28K2PvW66
         k16lkNhltyW1ezDsmN8XgLUPlaZYQ2oDz2YSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405275; x=1696010075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yau4BT1EoLV5IJxhaSNLPuA1eve9TNZXYVy+N/HUh40=;
        b=fOsstMCLgqLS7JNulsM5ubXZSFyuHjZWIQXMFITRHfeORNa8kLG8Aedx0FL47VXnth
         R4l+eRDhCtlgXBI91zaa6olFNvKg6uHWUQ1haXqvUITzdIEjcxfVHx4pK6nEcopbwJiZ
         wYNklk2xfv1C93rgGt5Z3vz0HjvTPuRxh4Sa5f8zW3Weoxad0Pxf6GfiEy84RuTWnQVZ
         zqKXBViShlTSmSgrdRLDc6xNo431Sn+Il+QYjaSJLGXCEB48Xuo+PyFiInJgwPxvqpum
         cs2YPf3LMNAVMQahQRaiWGlS44v8eQa/6Y0iBLaBOL1Lx6Mu1diUreYDbBAUcYpFfTjY
         eJUg==
X-Gm-Message-State: AOJu0YyQyP+UJWGvfZYJWjmXm15Y5VSfkRQ1JMtxlpej3i1UGsWeWMdq
	ZKyoCPrgKDfwvAJ9tbxCucnM/Q==
X-Google-Smtp-Source: AGHT+IH0nPqBG/eAcoGO+3MN6u7Nmf8xgA0JckteDfVErs328BgyzY5lHU7ZCU+XDwo2uiaN1b90Dg==
X-Received: by 2002:a17:902:c793:b0:1bf:8916:8d21 with SMTP id w19-20020a170902c79300b001bf89168d21mr3721398pla.13.1695405274889;
        Fri, 22 Sep 2023 10:54:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001bb99ea5d02sm3785718pli.4.2023.09.22.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:34 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: qat: Annotate struct adf_fw_counters with __counted_by
Date: Fri, 22 Sep 2023 10:54:33 -0700
Message-Id: <20230922175432.work.709-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=keescook@chromium.org;
 h=from:subject:message-id; bh=mO0bdOi2nI6QO7rAk/Bt7GstmFLQozYHxthbt8jGiys=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTY1zT9E503RR5pv60ffrhtLU8cjnNXS8B8W
 ChPy1l7puyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3U2AAKCRCJcvTf3G3A
 Jr9PEACUNiXvl8pQbdDtreunyBaXA9OzAXifbarZvcgVP0x6lvUxJiXAf3Do8llYxy0p7tyD6NE
 zYYvVfe9nOKX7RYiMUKB3sXFpA4YQAWnPC0Gkx3RZxhbMLeEPbMIwwL8N/uZnecnx9Twc+v9zt+
 HvvTKe1aSlYnRTIVE+4WB3AeOQTo5t1FSy76B5mMV+auhuVd+StmU2nCELW4ykubkUlptjVJATx
 9ndKYhQ6UAEHZuV3r9Sbg5Iad7FiYyQGqRzDDyKTNJkMfqu2Yth7uTTr62H0NcMkVoPH0T8KuRn
 hvk/cZbfPt60gO/Hls9+kyFYJK0Hk819tcgmKxhigK9c+5zyUfx1zO7BSuJilF3BkZ9ve/DJ4Q5
 a+j2XmWigAb/wputzOlYx38i2Rlck9pwKfZ+e/mpG2INPuaByxjaV6JXVpHL8FkOmsEbKoj44sS
 6wFyyX4ifgN3JFS4RFnz6hygM9kCCk98Y82aUHyTbQ/uoTYQf4Fdg114CCPtRFsNXBR5RAOpEdp
 dQUVncIQ+DlVDuBweW975ffkDa2eAuZRXDOkRcG+uwdCDZ3eQTuZs1jiIuXWsHc2E8r0fCCy1V9
 kJZEMQod7a3N+J5510CfP14zcTB46GDAVSuK0tInO7jCXGVO+N6VsSdmYNXWikKxOvnslgGDLaE
 cOYw7LO p/I/SNxQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct adf_fw_counters.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Adam Guerin <adam.guerin@intel.com>
Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: qat-linux@intel.com
Cc: linux-crypto@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/intel/qat/qat_common/adf_fw_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c b/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
index cb6e09ef5c9f..6abe4736eab8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
@@ -34,7 +34,7 @@ struct adf_ae_counters {
 
 struct adf_fw_counters {
 	u16 ae_count;
-	struct adf_ae_counters ae_counters[];
+	struct adf_ae_counters ae_counters[] __counted_by(ae_count);
 };
 
 static void adf_fw_counters_parse_ae_values(struct adf_ae_counters *ae_counters, u32 ae,
-- 
2.34.1

