Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C153D38E
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaI8cg10"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC780185
	for <linux-hardening@vger.kernel.org>; Fri,  6 Oct 2023 13:19:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c62d61dc96so19042455ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Oct 2023 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623544; x=1697228344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5f6ytO4v8vRnOLZhCY/GWjs+tAFnZkSFkkdvYDNCuiM=;
        b=TaI8cg108Z+FMYXbLmtGXzt85khSvCQ8ZqpzT3S5C0ne8ixhqMJ7RNhBEtYJHOeydC
         YJcsNxvGlw2FmWA+n5cB6Qm+GrbrNTNCxBCD7TICWsP7rViIvVK03P/rb40VesaRN+RC
         IcKZYsz7m2dcT5K6DXy5FgJ7Zr8XXln/ZZNOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623544; x=1697228344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5f6ytO4v8vRnOLZhCY/GWjs+tAFnZkSFkkdvYDNCuiM=;
        b=d/Z6OZxJKMJef2S0xioDeVsgVfOoL9djxklgTcwe4YjiBqSewH4A/ZE98O8KM6UdwV
         7lWXeJzhPCnUndRXv8HCXLIpcnxYddQB4/768uBys++cbPYnc/9ZXPSBJZGGFryznb9a
         BH9g1Qn72aptPJ+P7lP/bM9rWpgyTBP4ZOC3VJBej5IJN/6PG2Ri2lUsgY5EMIztvE6j
         3rOkHLq/RdVh0zcle8pCzQZUQ3EEYzq6x3fErgIpo9ePe8Gg3iuKaueBWMjVOmOhXXm1
         +lDakkIRjQouBHQc+vaoZDduhigMx0Oc7lWPG5Zm2+lo6pziz/CBLHFVCZyJ40gKRxde
         86Ag==
X-Gm-Message-State: AOJu0Yy72/GXc9Yett4eoprNcRrAUdXWu/cWiOXJpJ3t8vUQy7HxDQpV
	7eXWsWmP23DfPALtXXmNB+kFiA==
X-Google-Smtp-Source: AGHT+IHoIlMhgrt/e6wSDVo6U3GrZoPZTlLlZDAUuVIjDuJVhWRmiaJrCWW+kz/LaH09wQ+DUjWSpg==
X-Received: by 2002:a17:903:1245:b0:1c4:4dbc:92bc with SMTP id u5-20020a170903124500b001c44dbc92bcmr10579883plh.16.1696623543892;
        Fri, 06 Oct 2023 13:19:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902ee8c00b001acae9734c0sm4331895pld.266.2023.10.06.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:19:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] wifi: intersil: hostap: Annotate struct prism2_download_data with __counted_by
Date: Fri,  6 Oct 2023 13:19:02 -0700
Message-Id: <20231006201901.work.278-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=keescook@chromium.org;
 h=from:subject:message-id; bh=TKH2rwBEryE3wL9UTdezXy/1pyU6gGSThNovHiWR+yA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGu2xaMzE8hOMdtfFrRZu2+Af9UD+Je6xgVdx
 MTm5JiaiHGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrtgAKCRCJcvTf3G3A
 Ju49EACitXCernnFJ9biGqz8FuXcSt+CYk4lCp82ncDmztIE7w8s7PrVYr3qyIXD5St+yemEvIY
 8+TFJqHuSJ+paWaoNHAhsxTg1r09JWvOimJUZ3ElMl6n/Bd8/pxwY1ZHbmnlgOkLvs8+kXiYhfN
 /6++V7c10DTQExTdfUBlANEEoIZ8mQdJEHPv6sbSbxYOFYQeKo4XW3BxYi9WU4g1JcCmoRSNQB3
 /k0E9TD8cAbbKU8FvNLEMCG9ME9FlhoA9yskpT6t7sTt4eBqzc1XNpXHTEnqwn9kHsRmi2WaUui
 vCgEF5gre80jNXK/sNllBjTiVbWYgBw3dyX1ghrHZMJmec97kDFi+IDdwdp9X68JKFcIqwEdM0i
 eJROy9QnWw9Rqo9gH+mfkop6wvtjTIlAfOTHlRzMvS+rIXhZAdMu/q88krRTEI4Q39mFJnxOuCE
 gOHoMiSxFoo+Lk8jQ4psIWfiq616RjfdOkBeWatRJ1SXz5clGVKm/GIjrmAUNUfQQ03Tnnj08W3
 YQzgJWjH7EcBu0Yi0xiAELx8XW4MBy1Dn+rlcWlyOXyMd0J0W3M0iPxQD0ttRrhHVa/pILy9THj
 ACXphBwkKUpFySPa87ZUKJkkZETjbhD+ROuipwdrpc9vCOeiP22iA6esHKK6LteyO+UPePjIBJE
 ouK1x0v ulZR6wig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
prism2_download_data.

Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intersil/hostap/hostap_wlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
index c25cd21d18bd..f71c0545c0be 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
+++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
@@ -617,7 +617,7 @@ struct prism2_download_data {
 		u32 addr; /* wlan card address */
 		u32 len;
 		u8 *data; /* allocated data */
-	} data[];
+	} data[] __counted_by(num_areas);
 };
 
 
-- 
2.34.1

