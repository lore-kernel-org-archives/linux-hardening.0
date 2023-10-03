Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CA3F4CF
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:21:52 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE3B0
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:21:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso11349925ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375309; x=1696980109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l821elQAUH489dU69En7IQT6h8j9FiBoZuXMgRZSCxE=;
        b=Fdeb4adbtdqz/24mWufniLj32ERNRutwl+yzYVmAdpMarLlfudwUva4UlFTUsEOBBA
         2BRoqrfkmOqzRk9SXuWr4EbwhlsOWJadUfl4PZ12BjlmXGHANlc70oQcb8paDixsJotW
         2/xva/gFta5E6/bcWmL3b5p9aVuABCvPUkTnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375309; x=1696980109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l821elQAUH489dU69En7IQT6h8j9FiBoZuXMgRZSCxE=;
        b=Wf14+6ldkISYUcFg2nLOPt+V+1PY/yefDSvRQ6tI/oi1KkjCP9kB38bJi6r7XDBaH/
         4tlj1lwjeLQr9NdpViWEOQ5sMBEI4Yszhbob8vuPaRUG2MPGrI3BFTnwtReCAL6o7LEG
         0WFjju3Lsc3MzVqFD55by8JdgtpLiYMqVtghdEoT4ZeUEkmhhZPwT16oGqsfapWsbBe3
         2b7J7wSMmfaTn6Ui0TI6cFkbjj4fJKxCssgKaZNZcqa1/0YjpiuEB1OOxTQtlv0o6c80
         kBE/AO+tItSGTW+qj7T0U3X3yVj6gUahwRy7KeuoJcyAmi/bKbq3KXgNg0OqGACEzFF3
         Up0Q==
X-Gm-Message-State: AOJu0YxIGbp/tcQdv8JmIGK2WR1mkM6uOzhpJwQXg7RU1PvFhZTl1jYu
	Sqcw7rErd+VkH/FqBxPr+2cJpA==
X-Google-Smtp-Source: AGHT+IGaEniPXHFRb7z5ff9Cq3HhY2bLKc/jWHQPtMoMKRK/fjd3yxeIZoXmuPydpHGtfi4+KyU8kQ==
X-Received: by 2002:a17:902:a504:b0:1c3:308b:ecb9 with SMTP id s4-20020a170902a50400b001c3308becb9mr849979plq.11.1696375309168;
        Tue, 03 Oct 2023 16:21:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001bb1f0605b2sm2169114plg.214.2023.10.03.16.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:21:48 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: David Ahern <dsahern@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nexthop: Annotate struct nh_notifier_grp_info with __counted_by
Date: Tue,  3 Oct 2023 16:21:47 -0700
Message-Id: <20231003232146.work.248-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=keescook@chromium.org;
 h=from:subject:message-id; bh=JVLfI2oulF09wCbNbUhJ4YM8+UHf0mCkNjgh/7VPPgs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKIKGEdBVKlol3rm9nZ9aXAU4vP8gZt56RsYV
 djO/OWGvI2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyiCgAKCRCJcvTf3G3A
 Jg8AEACzM35r9K8GvdD23G76rSA5TZ9Q9H5scIvzrAcMMmEtWuziZzhyidCD4bWAsC9Fa5mE5+q
 8/0u35x12yMOrXdAHymBrDf3oXavSsaN+Imj21NjXBHagA/g6+KKf+W/efejbX3zEX50AkoJQ3v
 cAaWB7WsKljtJixfZXiRTcE5eQdxwslhQg2WZ4k8Lq2N+Ky9ZeS6p3BGlSjzKeeALIkslSAYJCq
 FRGCLQ4Gb0hiwPFOlNow7KeCkxblsr5oCg9j04rhzP7oqDuK1w7pq4AjaT53BlgW9OoMbZDqQr3
 7rlwBM0zFtHvj3z43+yas9peHlkX9KJ3DUSzYwDUwXDpyoeO6ORk6S1eIqw7jqwDY8d8x3h+xpK
 97kOoG5tCO6jw47CHr2Z9P+relUQvnQU6HLnTxB1MQfs0MXZZ6C/i7TJQfwNO9lAUQ/5NOLWwsX
 /jnYLaLmcgFD4a/ZTxEByUrX2PGHsB/B41vBvYLzrIGFUxk5zQ3h3zMAvSdIyf3qPXhgMmlAsAH
 JbiI58uWOj5xbpYifQRGSKFLbLiZr8IS6Z9lKy57DPgbDiRXSZSLsY75Gtvp4lEWQHnyqlmw+jM
 72fWourBpD/QcbvjZ27w3BbMrGwnH05xnzOc/16reg0vwnMsqoAMAuaGc881nvkdeGBDGffjA0e
 0vnSOeS H76Y5MMA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nh_notifier_grp_info.

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: netdev@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/nexthop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 2b12725de9c0..5dc4b4bba8a5 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -187,7 +187,7 @@ struct nh_notifier_grp_entry_info {
 struct nh_notifier_grp_info {
 	u16 num_nh;
 	bool is_fdb;
-	struct nh_notifier_grp_entry_info nh_entries[];
+	struct nh_notifier_grp_entry_info nh_entries[] __counted_by(num_nh);
 };
 
 struct nh_notifier_res_bucket_info {
-- 
2.34.1

