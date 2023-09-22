Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D64446B
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:53:09 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6521BEC
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c572c9c852so21149405ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405171; x=1696009971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKO7HZA7note+xxP86iPyjMQTezIOPPmqe4sHJnTuiU=;
        b=chHLRQ3imy6l+WvL3/9yPEvGEVvSJJW0yxJbVMVuXHzWOVShRXSo0P/rJ2VT6ODRUR
         eCshQqm3zy8L7phIxMpNSJMdWW7ZVRR/AEdfWovJRYUiDzwr/BeEVd0e0o1EwUhRzWMk
         1tjAI4gMNE56/5fW+W3U5Q0y2L6ImFUnoj5mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405171; x=1696009971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKO7HZA7note+xxP86iPyjMQTezIOPPmqe4sHJnTuiU=;
        b=UN5wS2pbu60KjE6+x4OJYJq4Skklco8S4/shGi8Oi9T4lj+x/AfwQC/AnJIAEV5zT0
         npsKtmUf2rKXhopLzfOBZEdxSsdP6IiDRYCLFEDQu/RHZ+WgWIg/kwMsRI9BTHjz9oxG
         bwkrJxV9S1268pn8rIUyYKqi/UdYNzwKUIrURfhXd6kXXJroanDV+tg5gPi0VTLvxqx7
         XWoL9d8K2ajgoEJRNA1nBje3s8f0zUOw6f4QttaQT2xMFjxdVcod9HclsRem4hMYzlbI
         XXDFjwqzDli6HOWDFMlzvyqpphkdbXt4G9WhJesOVwt57MXTBG5XLcY0pu6/yCbrDmS3
         YvGw==
X-Gm-Message-State: AOJu0YxkEF0gbQooohfuPoia6oq/tAe3yODPf/9evnzUYcT7ifsXU/Pm
	HfNWC59fO2gQ1ZPo4mMg5Bekyg==
X-Google-Smtp-Source: AGHT+IFaViTplprBwLRsyLm+3YZWtewV01aqBFowvprcsZQclymf5ubRmD+3j2W/qAbz4TplZJUwAg==
X-Received: by 2002:a17:90b:b05:b0:268:352c:9d13 with SMTP id bf5-20020a17090b0b0500b00268352c9d13mr496040pjb.0.1695405171425;
        Fri, 22 Sep 2023 10:52:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a1fc200b00263b9e75aecsm3834838pjz.41.2023.09.22.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:51 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Tom Rix <trix@redhat.com>,
	Len Baker <len.baker@gmx.com>,
	Dan Carpenter <error27@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-mmc@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] memstick: jmb38x_ms: Annotate struct jmb38x_ms with __counted_by
Date: Fri, 22 Sep 2023 10:52:50 -0700
Message-Id: <20230922175249.work.593-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=keescook@chromium.org;
 h=from:subject:message-id; bh=IYB/5z7VQPpaTtnk20ryAqWUCT0rzInyLePi0vxIKHI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRx1X2xU9/fAJc4ZPAebmwE5hH3qrgWsM1dw
 vLMDlH/bXeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UcQAKCRCJcvTf3G3A
 JmkPEACRHShf/0k3dIPbAkc3C7PfZIdI1FQTAFGzE/GaNVBsm8T3tTI5WyNX3UFKuEjxENQnu1i
 cIYrj0Y3gqh34Y9l8ITYPOB/LSIlCaUWFZnvaTXa45XGrQbSO56fQGjzVUrUCTh/8CVTrNd7Tos
 hNTn7XpmKZh9ZnJhKI88D5dF7sBRTLSe2ONhHcLmuBtsJ0EYUARWlMX7NprBWotDGgYR3p7JrzZ
 81CmSQ3dCxRW+Yf3wKwwsIKcFsH/7LnYoC3GflvxAh7ux8B7/1GWu7yiZC9tMdwIYeTpQE7jFKZ
 dTcqeNNIH6RqJvX2Sn5Fy3/iHIZgETt5fYlYXbn0hLbBJV5JMu+sKBGjm8LaGIdtlq9W+CAOVEz
 TVy0Z9o7xicwh/FMfEouStlbJBn+2kyVUy0ahd7OWlXKaS7ARVyD36XPJ2XYQaCSbhHhZC4kA8I
 m5cI+RxKRK3fvFjkS3RoWpKXCH8gTrrp9Vl7LwUjXs0YouI3xIdbmi4JF2pg61MK6onmsXLIyKl
 vQuZCZ8SADPi3mumw+zC78p62HxeGpgHUhyUC54yRGesI4P+D8b2jZd4yFmUxY0RU5hC/DDPE9B
 EkMVoryyGfhne1hZmeF0BWN2XMnP6xpRHxsSOLzQCsLowor7oQ0hoqaj1Lasy4pG7CSZQyHwyGw
 0S0YD41 /KOE3bOA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct jmb38x_ms.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tom Rix <trix@redhat.com>
Cc: Len Baker <len.baker@gmx.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 21cb2a786058..e77eb8b0eb12 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -66,7 +66,7 @@ struct jmb38x_ms_host {
 struct jmb38x_ms {
 	struct pci_dev        *pdev;
 	int                   host_cnt;
-	struct memstick_host  *hosts[];
+	struct memstick_host  *hosts[] __counted_by(host_cnt);
 };
 
 #define BLOCK_COUNT_MASK       0xffff0000
-- 
2.34.1

