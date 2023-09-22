Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB143AB8
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:52:11 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8731F29
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690bfd4f3ebso2156324b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405109; x=1696009909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsmMQ6krAwAnzPF3fdWBN7ZYXZOUHbuU3lEOUk2NaIQ=;
        b=LPoy/G9abhkVPsnBKjUCM76Wg13WDHJ6ZkBcV+/SYr/f82jneF77FGufyxxMTMSw3D
         h7vIvC9MKJBIhhfYG1jCdDf5/QCLVQukTfvdstJcb1TlJ6tm5eACP+D+p01uEKZtx8S1
         Vk649DpeUfgwloO2bBzEnLb1wWtlw0IwlDO4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405109; x=1696009909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsmMQ6krAwAnzPF3fdWBN7ZYXZOUHbuU3lEOUk2NaIQ=;
        b=gNgRCWTwkiLJzLj3DtA9wm3c5eKFZnwAD/o5thsFamE/fiEKMP10OKqIyNigvzS50y
         cud9gmLYkVX/tKHOlHQE4SbPiDx69GGEUMEc1fbjavkE3w9YOiHmVmYeTJucOCo040Hm
         fQ/DXV4G2mnPKZrgK/FIZ8fId4zyJqWemoRznBzvubbEZzecJBJm2GDIFUCd3MAsMWGb
         t9XDHhGBmBitiv2ObxnfcKjMYWvOw+38HSIi/Gg83kSAHDVqRP8EqB8ZeC6KtCYNKwp+
         5DGUyCj4wcrmDFc/KZeQr1RBhLRwnHH7uD7QxRR7RgmZ+PCF/fj5n5ZWq6k+UgeEovcy
         z0HQ==
X-Gm-Message-State: AOJu0YxahrFMdD6urgVe892XT97I/SD8/r589DKxgw5Mxx+PhRiXwR+a
	qj+5psUyGF30FK1FmeC3S5PXFw==
X-Google-Smtp-Source: AGHT+IHbhoC9rDpc1qX1ly2mgTN/S/Ww+ZEC1lkxqLq0fJPJPh+dwlksi9VUQd4aEWshzXY00puTcQ==
X-Received: by 2002:a05:6a00:2d94:b0:68e:2478:d6c9 with SMTP id fb20-20020a056a002d9400b0068e2478d6c9mr164234pfb.2.1695405108883;
        Fri, 22 Sep 2023 10:51:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b0068790c41ca2sm3472604pff.27.2023.09.22.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:48 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Benson Leung <bleung@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dawei Li <set_pte_at@outlook.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiang Jian <jiangjian@cdjrlc.com>,
	chrome-platform@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] platform/chrome: wilco_ec: Annotate struct ec_event_queue with __counted_by
Date: Fri, 22 Sep 2023 10:51:47 -0700
Message-Id: <20230922175146.work.219-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=keescook@chromium.org;
 h=from:subject:message-id; bh=e1ZqynN9loVhS8+oR1i/+utvHCkGfpoIEpm/aYvNyDE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQy9C+3oWrxbkRNSsFkLrCWSYDM2/sWuxmwC
 tMv/weV8pCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UMgAKCRCJcvTf3G3A
 JsSVEACFH2wrdHPw7AiB5kOrwR8BTwEXFdchI+hhWo9w6mWLv40k/1F5iqb4aU2VNjMok9NaFLT
 xH0oWaaak/HJFJQX6RNj6ki1evQPTfUSe3r3QKdLJO/66MAsEOwStztGz8gI5QiSXJk5hFha7me
 /HZFiMeQd1UD4i3TuVB9JBbaNzF5Uj5R8QII6Wg1NoC8CSY3joJVel1baQ6YM5mtdKqAONP00Nc
 gggO3cUde1R3eel5kJg7ZwJNNvWkk2yAyF8mx3h9E/iZcxQRM6274ADxvQFOayfLQkAV8TAEK1J
 8Hg6b3XRMOi0Qklntjcr/+lHcomhoohabMbzSGLGSMwdcovjnxk2xJq/pNnE+gK1hDqxgo3vtHL
 LmUOKZZwDV4e9Lt6vgXxURSCyYZBAhA5ERxALUfarPlYNtVSzfTVpvp1xNO+YZHckTsnkS4HOpL
 dA1+s1V5x7zj3ey5aZQBCry/zlGCIoH/OnoLzMt1kNAmYNPQ/e2CPICn9GoaA7qpxK9rLUPrw1A
 S5mWfprdS5o52qYqbXEm5aOR4v+j9XMnJIYGmi5UWCO4BUARVBd9Ai7pSWdQ8j9udJA5OATCN3U
 Q9qg6IzzfdFjmAjFiht+mZaQJ73CJObmFpsCn1VscsldTgpngcGnDm+Ft0y1lH6C/KIZyXRs42B
 Bo26BPB S0FiNjzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ec_event_queue.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Dawei Li <set_pte_at@outlook.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiang Jian <jiangjian@cdjrlc.com>
Cc: chrome-platform@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/chrome/wilco_ec/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index a40f60bcefb6..f80a7c83cfba 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -95,7 +95,7 @@ struct ec_event_queue {
 	int capacity;
 	int head;
 	int tail;
-	struct ec_event *entries[];
+	struct ec_event *entries[] __counted_by(capacity);
 };
 
 /* Maximum number of events to store in ec_event_queue */
-- 
2.34.1

