Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6607CD379F
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjIOT6c (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjIOT6Z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:58:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA8211E
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:58:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so2440788b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807899; x=1695412699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmHM4psXavgvDfuezLrO35so+CBMe74SVmqgDqqj+X4=;
        b=XeTzfUDcCXCFkZBfDf1AQF1x3mA8sIj7CHRxo04V9HYErUCdABgWjOXgMTIJq8NWoY
         7wFuMr9NS1ajAdoiegiAhtKqDxNzhZuOk+Gzbhm6eNS6sVhiQ0NVGQSAMQtOaxDyseNS
         C0t2IrM0pFi6lb3yQ8JB4dE73FqdW8j7RUNkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807899; x=1695412699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmHM4psXavgvDfuezLrO35so+CBMe74SVmqgDqqj+X4=;
        b=HYF7Hj7mSJ1+8kJMO6nunwi24oW0eMGIFYdHtQlVlrKOB/gsmEKvXQOv15O0MlOBTm
         Ol/QQl7stBsMQuh3xmBJgf3qdHWlzmwOaGBftsGdHh9LExbIk182ktuRuxzYu/xgEaM3
         +h5/GnR8sLrE8J0MyBBh6K0Ql35NUn4c0HyrO72ljEsNUiyOdYx2WnP1PgyX5oezJVDp
         ssB+rHNe64zlUGqaVDtXvBZD0VPEFxknWtgLVi6fTZvyddC5Yke/81pXWcm6mAq4eWRi
         /cXbVAYUzkjaSLSqkGZVl7T7R5ftX/Odgf///htCa0qdv2bnNSq1nfQfD/3nFaq0ZW97
         TY0Q==
X-Gm-Message-State: AOJu0Yxf16jvMRML+Uh0Ecr1Ruz6JXUK2nkksDwbQsoLetg87VM8Dh42
        f1dvR0mI8AxqwVXOQUqy3ysdZQ==
X-Google-Smtp-Source: AGHT+IHxg8lMUhQbD1ACheTV/Mn8ZmyK6E+Zn7O25oxU88CnFr5Q2FqS0QAIFWE5fO7vBsi6A8ggvA==
X-Received: by 2002:a05:6a21:819e:b0:156:dc22:96a6 with SMTP id pd30-20020a056a21819e00b00156dc2296a6mr2747617pzb.55.1694807899302;
        Fri, 15 Sep 2023 12:58:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s12-20020a62e70c000000b0068e4c5a4f3esm3314766pfh.71.2023.09.15.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:58:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] usb: Annotate struct urb_priv with __counted_by
Date:   Fri, 15 Sep 2023 12:58:16 -0700
Message-Id: <20230915195812.never.371-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/nlnwk1swWCmCy2+Sv6muF6tU55a2t3bsLZzpmMZ7jA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLdYB58rdkB52xPa44fGOBHqVRz7lxkY6R3VI
 m+mHExbT+qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS3WAAKCRCJcvTf3G3A
 JmBcEACKNUOge0/I+8iiOTctI4cFdZB/+rB9Ls9SMAQ3HTYKIXbFV6eJFbPrC5AAdAGdsGyVCJH
 8DDCbKRazcLtk/2vGPm6G5nR2FlXm/Rc/JndCygWsLpIsgWs9NMtm1QZlN2rag2TywAY5O66Pdn
 e6RWMDqHtBpjC8irzQ0bHTjkCF4IFlDefPhNEJFeuB9xZVfCsjs45uuDLMM2DL9DmxDIR9TztgP
 aEEPH9ULbxtxiUGrldBOLZpYAS6RnlApwMLXomqII99vwWZEXdECUAWH/AMjYlGDmeuuZdeCGM2
 zfYbE44jcYqSKf2LHciFpDQOTXbr9CLIIUlc7UbO+S45hQONplJEJIPy8E/l2vq+7tCcVJTcslf
 vI7T7sGBuhZljTfaxI4E5EuKBMRLeO9Rna/e/MMp7lHnVerLm8cGrFa5+l+bcvTBsjFSozCuqsU
 Xqan6V+WOLZxOz96eqfXe/e7Il1H1AgAhJy+btd3mtJMRKNEm1TzihpBWwcJ7SESPCQYwGFkeIg
 iAws1DwbSOAIMRq0+yQ3wKSzcD+s2STzCWxnT71yFB1hSthlwFilQIvNlAkhUoEU5HNoO7arF5q
 mB6ZLScLXIEtDto8BDzvd/u7lfKIBnlFXEvMEkB46kXMRcjHBaNclSDin1SO3xY9Mo0CchESmZP
 15qunaB jCdEo3fQ==
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

As found with Coccinelle[1], add __counted_by for struct urb_priv.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/host/ohci.h | 2 +-
 drivers/usb/host/xhci.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index aac6285b37f8..1aba22784e05 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -337,7 +337,7 @@ typedef struct urb_priv {
 	u16			length;		// # tds in this request
 	u16			td_cnt;		// tds already serviced
 	struct list_head	pending;
-	struct td		*td[];		// all TDs in this request
+	struct td		*td[] __counted_by(length); // all TDs in this request
 
 } urb_priv_t;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..2f21c3a8565c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1666,7 +1666,7 @@ struct xhci_scratchpad {
 struct urb_priv {
 	int	num_tds;
 	int	num_tds_done;
-	struct	xhci_td	td[];
+	struct	xhci_td	td[] __counted_by(num_tds);
 };
 
 /*
-- 
2.34.1

