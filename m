Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF77C71134
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 00:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356458AbjHQX7e (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 19:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356305AbjHQX7D (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 19:59:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5752713
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 16:59:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-564cd28d48dso321752a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316740; x=1692921540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnDKyGKtXCldI9QXtpCv/6I5lmu0QC4pcInlXQTO858=;
        b=DAWnaYSCcJsZ2VJyNMzhkr9UoSPe49NdfERuR/9MtkDayZn4oxbL0bdBJw+2iMhj4p
         Lfnut52cWciE2RYd6WqwqMkE73qCE3FMBqJtuUplIPAdNFGT2sciOaegXwD5JeA9wmBC
         wH+Nd56QJZy0nXGsWO1k9ZmYPEY10CEJMGfAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316740; x=1692921540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnDKyGKtXCldI9QXtpCv/6I5lmu0QC4pcInlXQTO858=;
        b=jF1PT46+2qJeazsDa/oZDLr54HLS+ihXsDa5LucsPxk/QrLtV9ZtOe0HJ8Pht8AkSZ
         sucwZ4+YLqAijVVsQeJHjXQh+k5RdJ4NJcVSmFOIOgp/UEuEzx24CEFfgEQ+h1cVYjVw
         NvcUUxpxe0rnGK4/800GS+yEw2qspNlHl/eTZNjeIsrZFsnHx0H+RExXesYcVe6oJPZ3
         lHLK0kTEwHT2KgO5WQovi9wld6E0tNz7JG/E7dv0jOVUCnIKyOhem54J2Kf5vWzi1iDS
         zTAD7r9Yya0BwOVO7DC+irA3xvWm10jQ8QTawJiDu4eQmsUh/Q8NXD5jNksepIKXaZpi
         2Ygw==
X-Gm-Message-State: AOJu0YwtzOBxyS8JGJFD3Hna4R/O8rUciG/7Rz4HcvlM5+yoPOti42fO
        9KkvhdURg5f//roa5B7KplDZgQ==
X-Google-Smtp-Source: AGHT+IEKQeHBko22jcPNb2f0023mzEzUj0EzLavg9CKweO8UgR8weVOyzF9lXaJff3D81Nl8HJWsDg==
X-Received: by 2002:a17:902:d386:b0:1b6:bced:1dc2 with SMTP id e6-20020a170902d38600b001b6bced1dc2mr897825pld.0.1692316740592;
        Thu, 17 Aug 2023 16:59:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001ab2b4105ddsm343739plh.60.2023.08.17.16.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:58:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 01/21] dmaengine: apple-admac: Annotate struct admac_data with __counted_by
Date:   Thu, 17 Aug 2023 16:58:38 -0700
Message-Id: <20230817235859.49846-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=keescook@chromium.org;
 h=from:subject; bh=+yUzAqwh85bIB2bobXU6XticjxS12rqU/iamdolC6VQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rQ/2TY8D9mRgdw2CyM3qyEw53h74QZCcomFf
 /5CQW+uVY+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60PwAKCRCJcvTf3G3A
 JuA5EACo65ZRVDO2T369DZ8mHVU3mjAd/qj4wNjNG75A+15aqgtGCNtC6y1ULsuPGJRjpu+YGZP
 SfVM5TtRf0xD87KOcvyvFhAhPiCX72b/bgH9K0QC/ZaG1pKs6GWhko/TzVqRHfrpQsCvGik2Yzy
 /Ap7x9pHLr4VpCDYMvdQ14aFHpyOdx8aYtHDA1mIwxQ4TDTYiVQswfNl0mxvkRtEdJ0aF0c6FGj
 c9Wi2wkrXJHPrMQNxrQim9W2JlTKVKqRl6IyIWbLVtIEMGlyxG8ugMc6VyaVucZndxlIJN4xQ2U
 4sKFedJC4XevUTeDtgLJljcdkZQYpR5uvtS3BwAjRtNvH8giuUMrCs4zKPb2YCLieX8/hx/nZsw
 LwLJVqdCPZkQpFt/V09vvrOi9GyNaOqsByUl/+H3p8MLDp7nfIh16KZMxacwYBLfAtNXeXxTA5o
 nHyQushjVS9VAp60zhFlRDfTvOWDHIwRoopc1a8UxDwov6pxVzEyIwLE4cIGB7XObcyon7BHN1p
 g7p84kopAehxM0BeoZMMZ9Y1NLeaTbLIf/zC46QyF5KBHtNgFBrK7VksizS80pxLQD4vfPM+FwY
 lETjtxkrjbwEOfezCh0YL2gfzl8DLG5uX9D15KXxo5RYGhkzXhDubRLrlu2qf5J+KDBnU3umWrb OEEXY2wqf3bd9Rg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct admac_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/apple-admac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 3af795635c5c..ff46260b6ebc 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -128,7 +128,7 @@ struct admac_data {
 	int irq;
 	int irq_index;
 	int nchannels;
-	struct admac_chan channels[];
+	struct admac_chan channels[] __counted_by(nchannels);
 };
 
 struct admac_tx {
-- 
2.34.1

