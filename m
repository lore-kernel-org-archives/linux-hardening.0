Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DE436B1
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:49:37 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8811AC
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:49:33 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1510323a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695404973; x=1696009773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6o8rcy2kYsMziijJ+HwTfBhFIINOkXf/UXn4gSYDrRE=;
        b=KaQNd8Agv/4jMQXtjZ4pQnH2MrXTVAzRfMQo10FGKVbfeLvr9AgriENYzM0PEuokhv
         GlZzQFPtEs0VoKfAGzH493i/UjSzKFJFeZPYpOvhdf35Nn7bpAAkKwm++hpLIAEwfFQF
         r5SyT/oJEOLPA3IRP38C40SsV8aJxZRXkZSMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404973; x=1696009773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o8rcy2kYsMziijJ+HwTfBhFIINOkXf/UXn4gSYDrRE=;
        b=IkO1ycl6cz7Q8JFs/CwU8KN/YLqGwW1f4HDX+nbCPKm8Ewn+yKzlXg3C2C3kuVX7gT
         QSYgToGhuYeSaw9wCcU9PmvleMv8V53jk+UqwgRJi/dPOV3twxnSxY/j2LlOpK9VoRlN
         a2SjHnmImTC32H2VvsHGq3RuUUReomOPYHTGxwbvjpKr2yBniRzbhlczO6hGJaxv785I
         58u3obenZi9zX0rYSAGFQs604ula30hw6L0UYzliNyTrS9XJI5iEfFv6eJSLhDPONJla
         oxqucKayaY0m0/I+SumPfoFoIP6Ke7GBl03Gs2bqRex+28QFsUxkhcaN1sugZFAHfUFc
         Jsaw==
X-Gm-Message-State: AOJu0YyA/N+mCq4/pPteoLbf8ZxVnvA7AmR9BKXPoAdsBlwSyxzh0OuS
	AKc9SDVqljg2lhsOPPuoLYLWrA==
X-Google-Smtp-Source: AGHT+IGBbYRZZj6iJdxISWqR0rCjwyvcEffe3apxgZbJGOfRTRyOM9w1AParWKjksC8mYeC8yyxppQ==
X-Received: by 2002:a05:6a20:12cf:b0:15d:c40e:5cb3 with SMTP id v15-20020a056a2012cf00b0015dc40e5cb3mr241613pzg.56.1695404973361;
        Fri, 22 Sep 2023 10:49:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t24-20020a62ea18000000b0068a0922b1f0sm3451624pfh.137.2023.09.22.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:49:32 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Fasheh <mark@fasheh.com>
Cc: Kees Cook <keescook@chromium.org>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	ocfs2-devel@lists.linux.dev,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ocfs2: Annotate struct ocfs2_replay_map with __counted_by
Date: Fri, 22 Sep 2023 10:49:30 -0700
Message-Id: <20230922174925.work.293-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=keescook@chromium.org;
 h=from:subject:message-id; bh=EI/V/Mukp/n4kMrskYWItkkDhXixF2aSgcv9kFKrUtA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdOp4GqjAOXqDf2PKH6lUrCfLTSmb8x0bIiGt
 qKfvxpE3mmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3TqQAKCRCJcvTf3G3A
 Jsg0D/9sEXbcZd5+u7yKxlCfUg5etMGyF3yjv1d7pHxhN/kLC0sHVcgzTmfkviwXpI4gZPgOLLK
 kh8dMVV6/OBBlVK2lBf9Z3nNlVj1chGDYuoREQRDbDJWyQjVbAhpOeVDZpB0M8JZHFmlkHxRlr3
 GATMiBdaIp/xl7jC27Qug/Gy0fVqWf95G5/ZR9Xx9Hc5Sd/Q+E4tD6SKN7zGXx3GMuVflLhJ3ZA
 CAIY1VDHpLcDWNwdTt4srhnMe5paJjbCgQVbhYlrF1ZL0QjdXvXRts537gqeBZzCxr1Rlrsnx5e
 3ZYNCsrZkaWEJxr3N+WoOsdtD7LFW8e/Htc6FXhCHKDwucfrgI8UJqTGe+LnpK5uOJpqkZWQapy
 N8Is6s+kthMpzwHCUWDwvEwugrQhV1J4lKfQu2eEfSNh/WQZelpyZZZreyEw4Y7duL40VHw4jHk
 u9vZ5VhGVi600kCOwoGgNC1pvLE4yj/o2Tfh89HkJtmfTFqApZEatrd0pjroRWFHXaiSWH1GKwk
 IkD9aaI69iQeRx8t+fS/aCQ/hpnlCDSRVgrWsINZN2QGrVAkuyQZvYOAj9G2JEiZotO7g1R8BX+
 zXAJmZK5/0wHIsrD1hOFOEROBmWxhasTkAPF8Qvb0WFRakdRTPWkUsNDgeCJiBOh75L4Xjlw3+Y
 gHdgVH1 ISyxNZfA==
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

As found with Coccinelle[1], add __counted_by for struct ocfs2_replay_map.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: ocfs2-devel@lists.linux.dev
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ocfs2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index ce215565d061..604fea3a26ff 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -90,7 +90,7 @@ enum ocfs2_replay_state {
 struct ocfs2_replay_map {
 	unsigned int rm_slots;
 	enum ocfs2_replay_state rm_state;
-	unsigned char rm_replay_slots[];
+	unsigned char rm_replay_slots[] __counted_by(rm_slots);
 };
 
 static void ocfs2_replay_map_set_state(struct ocfs2_super *osb, int state)
-- 
2.34.1

