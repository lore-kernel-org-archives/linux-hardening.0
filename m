Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A0AC7113C
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 00:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356532AbjHRAJN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356668AbjHRAJM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 20:09:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07213C25
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 17:08:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf1935f6c2so2676375ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692317318; x=1692922118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuyJceB72D5Lca1vu7MTV9NQLwwD7ixf1vMFNhBLP24=;
        b=NllG7Zm2docwbcVuC5ST/P0ww7TH//CpiSUDVU53JaO1gWQ9NEgA8pgYr9WIXC5Mwf
         svjywlbmGcJbCtGAx8MRDOkflRFXL7LrQVEneAB0xv0JSNV0TvcnUHpNF/OaWvLr0a1z
         HMlc1kKpaNKd1DCXZGn1a/kH15DYwDc9HTyuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317318; x=1692922118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuyJceB72D5Lca1vu7MTV9NQLwwD7ixf1vMFNhBLP24=;
        b=e0KBvh/wsHe0Y+aLXr8H+OYwoOwt1XMfHGsbhrfZbIWhHDtTbkZ5iu5CHTa1iox0QO
         9CYs/CbUt71+iIRKPTz2Qi08NyPpEk45ZAKJzpmit2YWy3NtTjmUiJ0dIXN9m1ZjQYRR
         oD6iSaXHnDCfIwxhltsanbEH77zxdq6IfikYL8n6GJ0Snfp9XUHTFZ8vd4S0gbqXkJIb
         vNim5E8EquAHEHYaKb8hZSvxsOqIzi1n4AtsgrJmapj7sdcVFU+z5UnCQiRzpq0XGfub
         Ich1Cjt2FKNAmgqx6cOM9UTW8DLECoJWCp3OW8R4QNQ9PxQwAekt+sx4mm0VwcrSrDqQ
         vkvQ==
X-Gm-Message-State: AOJu0YxtF8m1TdLZDN7bJFIsFH3VN0ZJw3faccnh/Qjbmx9WD1PMnr6o
        FHW3FFMnn8OAO6OfjNXwBauuIg==
X-Google-Smtp-Source: AGHT+IFrKbs5SvBObgUstemZiNhKYI6u3Ud7yM88uribSkyKXcJawqqpIR7AWnTVzz57LyyTIZj/pw==
X-Received: by 2002:a17:902:ec90:b0:1b8:6245:1235 with SMTP id x16-20020a170902ec9000b001b862451235mr5275690plg.13.1692317318091;
        Thu, 17 Aug 2023 17:08:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b001a5260a6e6csm338817plr.206.2023.08.17.17.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 17:08:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
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
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 17/21] dmaengine: ti: edma: Annotate struct edma_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:54 -0700
Message-Id: <20230817235859.49846-17-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=keescook@chromium.org;
 h=from:subject; bh=2Nk1bqy6qcs+Z8s3SKRWE/rRh22inu1euNPXBXoqeWg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRB4f1Ho4STxM3jK1PkfWbL2FFMg8yDuRmKL
 toFxjB+pOuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QQAKCRCJcvTf3G3A
 JtE+D/90ilHYwzp4mxGplGcw/99eQt0gOheBCrW8QL9ZFeinoj7YdgAt0123/fC5w91CL6gfiNO
 OT8LNUYgTMDSV+8ovuppBJN8f8YbEhY8hOs40LjJTNDd0qiD875/I4FUoRRplA9Uk39Si5sJix2
 HDn7yOOtYuS2V9vf4dS5YvKOayC5WFvupZnOYnDT30VcnqaDIOYioi5qjTyni6f7ON/mvBvfMVi
 Jxr0xI9QYwe40pwKS3YRrvnO0AQGBexDZlavdQ/vJQB8SVEz6RsdmvlH2H9soIKBA8lKwQfP6Jt
 nP++2RlReQ2B1WxrFsFXQHCAYv5LTBr5gSFCpCejATw0gJgkE9CSPH+t+LOZ5fVFiaAHmxWt1sA
 7KZUQzHl2D2Vz3JSLID341af/ApuW+H0WLV2pLWnJay3vDBy0fSiG1SjxFEVV4pyRaw6DNjsHF2
 Mv9c3B3FYbxZCLar5mlAHuihh7Wzj0ZjPV7NNLdxvlEsOTzEskM6GTH6TjWhiHY+cYEuXkg4vyL
 LtxRjAGs3xc2DL+Yq4iRs5oqvcw3Z9e/tUm1bsn1cUoK1kjSIbt9v+j44UPzNhXE72iFbsnscBi
 Q5mPy+nTPeQqgxp8gNC1rUmMAgWdSpgiklVGizlJAQPPG79c1X0gs1HfZ76kWB3uM5aVIt3WiVL vp4tcTRrfiG5Wfg==
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

As found with Coccinelle[1], add __counted_by for struct edma_desc.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index aa8e2e8ac260..9c2b2c4c3882 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -202,7 +202,7 @@ struct edma_desc {
 	u32				residue;
 	u32				residue_stat;
 
-	struct edma_pset		pset[];
+	struct edma_pset		pset[] __counted_by(pset_nr);
 };
 
 struct edma_cc;
-- 
2.34.1

