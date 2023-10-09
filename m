Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52C37CAA
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QhQEe/CT"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A3FC
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 09:10:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c60f1a2652so34582035ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696867844; x=1697472644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlqtVYWDwFjsVmMJ3ynK5zOk4WfBZOLfWnDThZr9WAg=;
        b=QhQEe/CTuqCxJIOfPoZ8fgkBgmbjjUyK0QmInLlIZqMsaWy/32ToAP+gcFQQ0j2Ps1
         UGKW2dIFDkDpvTsduwxaQBUHgd4/2TXYXSycHbdy3CBciPhHOpdLgvp2kubCfyxR08VW
         /wYOTcJUI686YQRESn6Wk4T2aFuTKQcVYsISw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867844; x=1697472644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlqtVYWDwFjsVmMJ3ynK5zOk4WfBZOLfWnDThZr9WAg=;
        b=JSS+b3Gyaf7aoRdp2MkfNok36waXNo07eIVGaAbNI4iDhECOpGPF76YLQ4y/j0hoxr
         U1gRsbNBTRbKeA08I8MWF4sAt/hCN4e8RCzOtCVPfROc4tGZ1wdFI0Soiygo1d9EDOow
         ZPXFn2KpE8+rrzIVg7tzP2cJ79dDAhDHDJqw+E5DB//ruNRmTqywQslG/vsF+p+Sahjr
         E8ZL4KodwIVBJt7hP4ZOBvly/Jpqtp4vBs6C7b3hyoS+CuzA0JgADrehepF3yN0s+gb7
         /4WEia289m5T3zdY64JePXKSO7yXbSnpuv8v0vFzwcZqdXs+vmSDpysY7d9QXlT7UAoW
         mpiQ==
X-Gm-Message-State: AOJu0YxOeENNw35WASsE842sjriS1KzSuoneF74lcC5N5st+V39YJOu9
	yzNAVr4qYngL6ZNIoNzRCWsy/w==
X-Google-Smtp-Source: AGHT+IHaNSM/F/12DdBX+Ma4QCHh9fYvjPMd3UIX2uPTMcfa9A3UPB2KEI6+rdRMpT5sMW4arXdLgg==
X-Received: by 2002:a17:902:e54a:b0:1b5:674d:2aa5 with SMTP id n10-20020a170902e54a00b001b5674d2aa5mr19275942plf.13.1696867844107;
        Mon, 09 Oct 2023 09:10:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709028c9300b001c5eb2c4d8csm9765942plo.160.2023.10.09.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:10:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jason Andryuk <jandryuk@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] wifi: p54: Annotate struct p54_cal_database with __counted_by
Date: Mon,  9 Oct 2023 09:10:35 -0700
Message-Id: <20231009161028.it.544-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=keescook@chromium.org;
 h=from:subject:message-id; bh=YzjePAWoD+DSEw/PjSkFzQTncEdbJTF0SrU+nTfsVaM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlJCX7vlAstYYRr8Z0mnQUxiZDkskkZO9CJ+b9t
 NQY4DZg256JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSQl+wAKCRCJcvTf3G3A
 JipyD/4sIWmxi4BQzwpXVms+RWPCLNRlL9RbPY9/6KGp/spGVvhfdxb7V5cwLlX3GDeUD4zWExn
 GL7Yshbfo9iR3OiRxGmXof9oOVdJ6rhNsdi/HaGLCJxqZp6UdcoXN1F5bAybLPkF0R9JykkW9Ea
 M/jd8F1k/G6thhfd19vPkqDHxueFyxdiOPlOS6NuaICkM6neQU6M09h4xn+Vv7RFvMjZDe9x/Qe
 sDOrFQa2QZZ1mU1Q+XVnTxdDpnw958GqUGOHUOHpx/qnaGINbJVa4zghSsD69C4T22b+izuJHyV
 cX9u+G3yKOZwwU4k4t1eOFqX3lpuhpSXWcnDgLbGgp/Srxgqvcav8uXHmR8W3clzEJdtMHn0tnF
 MMsim49cLaji7VkQ6bMHWQa/JKA3bbsCSplAtYKKJ9kzjzmogKelO/hGnJZCp5owdHvB5/FPlVR
 ftsmoa9PUhBYum9S5Bzn32x4oSqUgbJSzcV/PTBGJJvZuhgX11pq/CpboblX430xR9cwLXIcCb9
 zwBrkfxpegvYmUWwoVXb9czxB1ud+1nKRAJnNE6urfE4ZwNMoZeRSJUMGzbIIL5V9qAQ9dZlEVZ
 lbvq8Dhe0C5f/7rQZ19uHWcvxM5w1hyFShmp9LmlkNMc3PUdvSmJ59onewKaqMANKH0HSMow/fm
 sGR2+E1 nI8wezkg==
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

Add __counted_by for struct p54_cal_database.

Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Suggested-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1 - https://lore.kernel.org/all/20231006201719.work.356-kees@kernel.org/
v2 - use the correct member (jandryuk)
---
 drivers/net/wireless/intersil/p54/p54.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
index 3356ea708d81..522656de4159 100644
--- a/drivers/net/wireless/intersil/p54/p54.h
+++ b/drivers/net/wireless/intersil/p54/p54.h
@@ -126,7 +126,7 @@ struct p54_cal_database {
 	size_t entry_size;
 	size_t offset;
 	size_t len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 #define EEPROM_READBACK_LEN 0x3fc
-- 
2.34.1

