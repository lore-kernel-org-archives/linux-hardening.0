Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA493F4D9
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:18:26 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DFAF
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:18:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso1163365b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375103; x=1696979903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XM09kEc8Kp8BRYEzLwAFk6cBdvMXUL/+IkaIgbusPU=;
        b=DgV33KWRjRyaG4hdlHqFwxcF+xsTY7MMOrQ8lp+fjpgkLw6S7tyTwNeXvDKeTuXC+q
         dDKHZN530ZZrgOxJ1IzrxdaZNyPgHY39l9hYVEpz14lyZ8O22vHvntA3g1TiC89UlV7l
         Mtzpm9+vXgIyrQpHe5yzxDmIzJ+ftDUXc857o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375103; x=1696979903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XM09kEc8Kp8BRYEzLwAFk6cBdvMXUL/+IkaIgbusPU=;
        b=SurNJdbQn0EW9tjPMpj5JnudYivkYdCVLQtSwRRQ8iwMShD17TpJ9yyULK34Qz9Myd
         1D7xcSRjdloHs6sdcTr8mVGs/BvN5WOnXja8O2omEmiVrpYbUJ5HQeCw4yIPk2oaWSSG
         Ai8IVL6H0rnzrVMjrivrTChSpehktm/jQNk6UY5NPisO1US1jnbi+MbDRkcW5ajnrFG3
         m4V3wH3mip8bSUxLuQPn+oLdtIYwbbNkOXvzZFnnh/UOIjVeuk2QRespx/Jy0R8Jomj+
         e2ibIMFFK6pQQrRO8emZxzqnCep6ZvB0SgdV2/MG63kw2KoXaTmQIyJ20JgwYMzdumC0
         2syg==
X-Gm-Message-State: AOJu0Yx2T4prt+AV0IY5sxemxk8I8vEHUeTFwMIq8kKsDNuZbEq5ALNV
	flr24V/qVCfTQ4L06lMd6cdccA==
X-Google-Smtp-Source: AGHT+IEwKOi2g91/6+3PVOksMMOBXjtZ6RUc8kcIOjZ3+jcu3YOHO3VrVuRhXQygmft0K82aoguc4g==
X-Received: by 2002:a05:6300:8001:b0:153:5832:b31b with SMTP id an1-20020a056300800100b001535832b31bmr692118pzc.53.1696375102984;
        Tue, 03 Oct 2023 16:18:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a62e817000000b006933c582ed8sm1897059pfi.20.2023.10.03.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:22 -0700 (PDT)
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
Subject: [PATCH] nexthop: Annotate struct nh_notifier_res_table_info with __counted_by
Date: Tue,  3 Oct 2023 16:18:18 -0700
Message-Id: <20231003231818.work.883-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AjwLE9p8WGopinEsMtaz3ddOS1mI0qnJXpq5C0mCIUo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKE6FRvS+TBAwxc+K9caUt8f5xq1QuruutNKl
 6rvdNKdQguJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhOgAKCRCJcvTf3G3A
 Jo+FEACDuxBwqD2j1hWN5SQMxl3AwTJawunug8XKcPvJfIFp/RTGo5A8ClW1vELUc4+BpLeROLv
 H119H972/sNz7cDkp2Nlo60Yk9V4jEhyU5mUpqiXjhUR8nnTZPJijFiH/wkyilrzoR+laOjaIX+
 y5iEpgcZYGU04GWtAJDfObUCyEqkPhKfXtQQNri4Lm5pwvaKoAxprAufBtOY+xfselLRdr3M9K2
 8rJ+IBolsSlAXKH1DftdiFSBjG9EmwKydkha47kSrOeMG4EMTWOfNlOj+YdBWoOvgg6r6B6hobI
 II7hEMTRvU5zBkb9jMAiE1MUR41bJFcMSSWInv3uIPQGQImd+PM2F+16cpUGdVWqMi/zY4MWl4d
 ZkNf3hGG2jsfcjW260crWJ3B3c/f7ik61m2RqIvv9gTXKwwzriycjijPvJ56VWzAkBjzHYz1Equ
 4BzfYYzNpowHL2EVmsFWkwOLFOkg6f0OvU671kIkH7nJollSOeArKap+mtlpo2ZtSiR6nKgq2MM
 KCXt4zv+CZYnTmDaL6RXHJwY6D+HQRHjxXm/4W7pJviek1bH2cFpF90D3HVYkkFbds1nHi0mTyX
 8f4hhCx3uO86L40eqe8XCihbEkXxUIKOk4u136dDDUmMByv6kH2SP/Ns/K9u/bhM7VW0tdp5jvj
 UIdLPZZ 1WOpGYgQ==
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

As found with Coccinelle[1], add __counted_by for struct
nh_notifier_res_table_info.

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
index 09f9a732e640..8f5a2ab45920 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -200,7 +200,7 @@ struct nh_notifier_res_bucket_info {
 
 struct nh_notifier_res_table_info {
 	u16 num_nh_buckets;
-	struct nh_notifier_single_info nhs[];
+	struct nh_notifier_single_info nhs[] __counted_by(num_nh_buckets);
 };
 
 struct nh_notifier_info {
-- 
2.34.1

