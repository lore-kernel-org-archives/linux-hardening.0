Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C744496
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:54:43 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8423A8C
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:54:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578b4981526so1820193a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405267; x=1696010067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+EF4vJBkJk+ZVR9CblihV9KVKwpbDqXkhI36zKUO6c=;
        b=kLcYT/LllAUOWPyeCaorT9YFh0fumN7IpfIOstAMpbLCIqfT1UOG+3iaCV8NAoeDWO
         zV5svidS8VKtsGNVgp5rphF2FvKVA+o+vZ2t3/jpBYjQdTgs6W61mhh4v6NzFrh7LI5c
         5C7oCVD6sNJ2k3jzfrL/jVGkcqSacZScVEtws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405267; x=1696010067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+EF4vJBkJk+ZVR9CblihV9KVKwpbDqXkhI36zKUO6c=;
        b=orBWnt++wIWfOax65BKMuVL1AhUanZnIrc+Yq3l41UcBYR+m2TJzraJwXMz2e2aVV2
         bKjifgt4hmMfBRS5VKeeS7TTheFLVWz9wKtnodVs+fksTxOyQ70DLOnIJWPFD6DAZW+R
         J82G5qY8tDRdBqvggghaqE5cel2YEjWH7mpMJgnB2B6RUNO7+4Xw81WA/+Vmx8Tb8jSo
         kyYlwqQDsW8dZt/kgxtn/eJAfGr0Hh2swJXeQvEZI/jlI/QbDBBYaIDtRaDrUREOQTsi
         AuEAXlS5j98yi+5O5z4EvN1qVxeRDNM1oWTI0FaLVOjLEih8KrXs3t2Md//qYKhArjZu
         K+gw==
X-Gm-Message-State: AOJu0YwC2CQ0ueecwN9EEi9awCu7LRfvd+mqPoDviPU5RjkpyGk2tzaq
	PTtLMPNIdUVRQVrPlRl7GJ/YIQ==
X-Google-Smtp-Source: AGHT+IEHTrz6vwmxrsTFOxVvmSb41QWPkh3jvMMRyJ03luJqtTFxKRrwM8037x7mO0uOF1KONBCuJg==
X-Received: by 2002:a17:90a:c7d2:b0:26b:4e40:7be8 with SMTP id gf18-20020a17090ac7d200b0026b4e407be8mr425881pjb.12.1695405267155;
        Fri, 22 Sep 2023 10:54:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a098400b00274a9f8e82asm5621422pjo.51.2023.09.22.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:26 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Wolfram Sang <wsa@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-i2c@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] media: i2c: Annotate struct i2c_atr with __counted_by
Date: Fri, 22 Sep 2023 10:54:25 -0700
Message-Id: <20230922175424.work.863-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=keescook@chromium.org;
 h=from:subject:message-id; bh=xHqAexkdir++JtYVtYwcT7l23jrkf39UFVqFNHYvTUM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTROjZmn9PrBfPmIbpkMcg5sdNYLw8r0dJEE
 dRDF6P38uuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3U0QAKCRCJcvTf3G3A
 JmMlEACyXQMycy4pimGfzQlMXVi/e5YP4/RoKKXxI3rA+mIRz/OEaWUNy187GNrPLMuVRUEl6+m
 7HBRBE5xxKe03wBcUu0kmWdpDuLIN0efMNzsWH2PQY8YPDw1V7Gaeh5FHD+MTY9xp+88FCZq0dw
 O5fNNwnBpaiJ8q+hwyak4O84zmGhnxy/Mo7yPZMWaq4nFn8IbqprfKnjorcedYUuWWHfJQ1wkzN
 HoR3w0l8YapoHDkp1vCqhdfExasn72Qu0UgN/n4xVTJckAJ0+UYYw9s3DpLvqRzSi0PTgN67ypb
 MtWf6E0kk2TN113KyScBCSU9h6D6uo0uRSZvt8PrTi2J50/IftiSoNkwY2w3DuBxqu28vd+lJJz
 sWfGFrp0lfdEIb5YqkIWT1BUxW6nD1VcLLfUWD1zneBljOu5GXct0D3g342AYe0F3g8u2LpXzH0
 uVG/7sBg/wHslmjgTJWx+VpOXkqbGue5ZH4PhIzc7kislQ3tkMj22IuxBpvqiWqVFZL+cvF3SdL
 ur0bGhn7qFjouZrQNO0SP3eQP9E3dxRNyf3zyiuBzMvrejRFAt6V7oeIgKwjGns6fOBtQUonNQg
 sZQ0aauL4gW0OOpE4M5dDcWJo8GNLi1tkdvWc5+p8IzCTba898Lo16aluMogKJDOy6MZDBvb2pN
 7SVgLij pk1wMheg==
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

As found with Coccinelle[1], add __counted_by for struct i2c_atr.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Wolfram Sang <wsa@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: linux-i2c@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/i2c/i2c-atr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index 8ca1daadec93..f21475ae5921 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -94,7 +94,7 @@ struct i2c_atr {
 
 	struct notifier_block i2c_nb;
 
-	struct i2c_adapter *adapter[];
+	struct i2c_adapter *adapter[] __counted_by(max_adapters);
 };
 
 static struct i2c_atr_alias_pair *
-- 
2.34.1

