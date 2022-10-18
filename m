Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06134C43219
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 02:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJRCJO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJRCIn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 22:08:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4AF8E7A4
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:08:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g28so12755573pfk.8
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMGLJhsH5Znj23nG3H7PM8Z7rLjzyLqci0sjskq69co=;
        b=jIR8Rx7Xdu0BB/CQVKV+iKXCUQm0ZoDJ06X+DKrmakASyAN7SOLbpajdRFE+kj3elS
         Y7UflznwLWeF6yg32V5J9I2DQ60k8PUSiN0JcqSA/YVzKm7ZrYoJ2i0f5stmJjKoBG/P
         gLfBbCewyXppSPJwOnBQU973OkO/oKJsrIe88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMGLJhsH5Znj23nG3H7PM8Z7rLjzyLqci0sjskq69co=;
        b=0ClD3f/YrZk1B5K3BNSFDn3k7FTNUdWyUjOdydKaQeIwNdKKUe+8GvfgxBjdK+5lkT
         xx0jhOrUS6CL7FBMQWe6LJE2vPLp/n1y1rIcGmaFUvlpaRK6fTAT13YLdMlaIWQD58MK
         O9QmG4kQfGIRJLmeW9vmBKwihFsMAh9w1zkWebPMqfSQM6Q/1UVtuff3Ck5NVwV/fy3I
         paKQcPYNBoGeGG9NZ2aE9QfI00HAdXUuRhoX+vVrdJKZsTVU7WQUVFWWYANS8PlsUUAo
         Jh6ZuY6ooL2dhq/WLjX/6m1hB7+GAiMFywWtqKYM3o3qL4d9b/6bExigug6dW8tEC7WC
         3lPA==
X-Gm-Message-State: ACrzQf1Jrm1qmn6nFgguRQhfiSQyIe/Ff5M1E8ErolqLBbhViqNDU0Mi
        gX8LlV7jnAwnKWjYS4ftggebAw==
X-Google-Smtp-Source: AMsMyM7rsVycibE2Y1Puw9+3OWBJeR+8w6E1/dH2F+K6EyLfmNnM39y/VD31FleP9j3QcO1khmUksA==
X-Received: by 2002:a63:5d4e:0:b0:41d:dcc3:aa85 with SMTP id o14-20020a635d4e000000b0041ddcc3aa85mr666329pgm.324.1666058898927;
        Mon, 17 Oct 2022 19:08:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 5-20020a630205000000b00442c70b659esm6756041pgc.91.2022.10.17.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:08:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] pstore: Use zstd directly by default for compression
Date:   Mon, 17 Oct 2022 19:08:08 -0700
Message-Id: <20221018020519.never.337-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; h=from:subject:message-id; bh=Pon2y+0FdKP13fO9/56Jz7YH/A3wnJVWtLmrRXXJ4qA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTgqM20Cw4i60mqZOM8N+yMRC05rSUMUamOJrPgMM n+AqTqiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY04KjAAKCRCJcvTf3G3AJn+1D/ 4tC5SgPiHimrKXK3Xn/1iDGsylDDtUAhPxWiwEmg0px4dNtSIWVBGhyh1GyLnJ3+R9DRqyhTrGTek5 ShB5qgCPv9tXpEE5k8xYDK4mWExYrcS+5KVHVog43CLeJylg2SmXvxpudJAMdCYDTmXGsunJmSSkr7 vjhdo6f4YUIY45vf0/ijrvcsjQ6pnQXpldTNgByBF6HReveguP9+ZjZBItZpq3hBVA1hdBjLlVIp58 vLJWsvPgpi9lDCJ3PvOKP9o5rCyaSZTY9EMAER2Nb1oh5Jv08+/uEOeLR0IaTKBhvBGVux56vY0J5Y i2VELQXAiALW2k6U6wx6f+rO/URUkP8Z53sT67tX3sdfg0aKNTyBNM2M0y8RAdU6PeWsvKKZhxADVA pudi6G530iTASmQJJekS0N+yP7ML4qCgbEGpvLNtmkq1wkhzKuKuKSXdjFD029jLEzlzt67zlsB9xD kHQErcy58aP1Pi447WCzhWRhG9C//3VqN+V7NF8oc/qIWaKphMqkll5Pxc+VwWC2xu/+NlzO1td0Sk TH2JcDUipo/LERQcRuU6FQ6UuZ9ZZj36goPVFOE3kOgNY5HssXtxd8VZGqYcS3NSyPvLAV3vPnmvV9 PCcB7EOaFUUbcdeFJKcEVkv8EwsAxOl3sIR2ekoDYi3cnIwAyK+HBGYSFBmA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

Okay, here is a very lightly tested version of using zstd directly, which
should save 128KB per CPU compare to using crypto API. This leaves the
crypto API available, though, if someone wants to use it instead. Even
supporting both, this is a net reduction in code, due to dropping all
the zbufsize logic.

How does this look?

-Kees

Kees Cook (5):
  pstore: Remove worse-case compression size logic
  pstore: Allow for arbitrary compression algorithm
  pstore: Use size_t for compress/decompression type widths
  pstore: Refactor compression initialization
  pstore: Use zstd directly by default for compression

 fs/pstore/Kconfig    | 131 +++++-----------
 fs/pstore/platform.c | 358 ++++++++++++++++++++-----------------------
 2 files changed, 209 insertions(+), 280 deletions(-)

-- 
2.34.1

