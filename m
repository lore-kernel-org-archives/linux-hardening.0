Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7E436B8
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:51:10 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B92DCF7
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578d0dcd4e1so1794176a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405055; x=1696009855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neGeeh8A661t1sOpf2W7EBJ7owRCneTME8YtnPzahAs=;
        b=n4t7iYX+J4tTaE3NIPWQETvgZzIcBJbv0hPp2KvJGboBypGMx0/TqharJvdhC5EEsA
         9c1Nibkpzj5Uh5UgbzGLc52RLWMshkM4QvCJMr/+FLpq+ck4nXtOqpVdhd9BbVTpQBCs
         kzuKVp5ZpP/DuYztUZcEThU4CbmoZ/hcONgFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405055; x=1696009855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neGeeh8A661t1sOpf2W7EBJ7owRCneTME8YtnPzahAs=;
        b=dovF6d7FjVVjpnRYtUBJEk3r4pm2uPIGpMLAVYSv+mWY9YcLttAs/O7RGGrHrQDTGZ
         h+n61ZFbnEvzctA/JP/zVgfT12EJEEv+xb5tzP2HqgUnHlhvhpD/jU/6UR4TEowSh6pT
         wEWD6I+O8RMQSp2TdRBlJs3QTUjYXd5AJ+UltNzOKfRvR7UBaIHZsTAeUsYaLAz9nhPS
         NK+kYArdjmD3V+A0/E1+mtPeD/WnRPb86RfSxemsY0Mg/KI2xr/dOteWJ/T03Rgrd4cX
         GoAp9Yrmr3WUj9pQ473FsBq05FpxA36BHlBSAVA2FoN+IlFTJzpFT7GuIMq4NExMfDwI
         i3gA==
X-Gm-Message-State: AOJu0YweVRpYsNkVsfHpRe7MgMfFfi0HEfSOgfW2DGsl9atDJz0MEviZ
	cXuzM7xDj79FnpEg9Lpljyu9lA==
X-Google-Smtp-Source: AGHT+IGwaaXLcZnNVxl828i151muOXjRKyMmVrmfGcQERXbMnE0K0TpFrqo7yFb1xzAJmhf2nPBTEg==
X-Received: by 2002:a17:90b:1a8a:b0:26b:17ef:7365 with SMTP id ng10-20020a17090b1a8a00b0026b17ef7365mr329564pjb.48.1695405055384;
        Fri, 22 Sep 2023 10:50:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a031b00b00276cb0757acsm5517150pje.9.2023.09.22.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:54 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hwmon: Annotate struct gsc_hwmon_platform_data with __counted_by
Date: Fri, 22 Sep 2023 10:50:53 -0700
Message-Id: <20230922175053.work.564-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=keescook@chromium.org;
 h=from:subject:message-id; bh=G/sQxhthzDNR478m1f95ahGHMSWbJk7rtQteBk8HET4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdP99vYndLA1caErqy08IrpneOVTAPCIniCNg
 BvHKfdj/5OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T/QAKCRCJcvTf3G3A
 JuITD/4gvcnPy1qfs5STWxhVJ+FtPRDmPzReDK28rjD27nbQYabkIqPz8oHGhp4Uq+Em/8Uaga2
 6QdV0pGz09BFM+dBMRfVY2GDjltT8BFvt1ei5ZYlA2CSgAyylqI83+lh/olv1i+rM2c1kfiXd5x
 FcrR50fp8UkdwXh0nh45LymHAuYpENyHpmp5LS47fPdvwqq9JY572yadSOY4c2c/3QwcQfXZ0Yj
 0pag31BotHRSZiqjK+RXthuNUHwpWJIHHQYfCHI0NPB+i5e34fWN/qjhSRunm4d9RhDOZEmi92m
 0bqmvv9JJyo0eAxP5qSQSxybH15zvBM0usFgbPE86XTqUvZD/afK1opfMlR7B3kMJi0FsGXc43W
 i8Ao0zdZqG9CZf95+DJmCGFk5dBV/GQLZaLYVskmDkOnGkPoF5iagST4CKnD/EXcTwHp+pQ6qBw
 dHLgnGElgl4GxhFNb6c3DvKKYT1T/x9HNYSUH3HGTlcibFmEqlQdRzQCFQu40W0+JxXAKG/JdfR
 qkZXrz16Hqj5DKqAo/275AXLMir65QX+EvECu+z+wVP9lSdKSm+LfR/g0f66ayABl6Vj70Q2rxp
 RjAYE8WmixBqqFTgeEBXDx1S6b7UFYmkT2DxX8jJKY714DKb08H2ZtuEoNB4/XgRB1Tr5tvkkLX
 RzpO2/z 00+UBXBA==
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

As found with Coccinelle[1], add __counted_by for struct gsc_hwmon_platform_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/platform_data/gsc_hwmon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/gsc_hwmon.h b/include/linux/platform_data/gsc_hwmon.h
index f2781aa7eff8..70e8a6bec0f6 100644
--- a/include/linux/platform_data/gsc_hwmon.h
+++ b/include/linux/platform_data/gsc_hwmon.h
@@ -40,6 +40,6 @@ struct gsc_hwmon_platform_data {
 	unsigned int resolution;
 	unsigned int vreference;
 	unsigned int fan_base;
-	struct gsc_hwmon_channel channels[];
+	struct gsc_hwmon_channel channels[] __counted_by(nchannels);
 };
 #endif
-- 
2.34.1

