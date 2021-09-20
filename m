Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14985C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 01:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B6A61159
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Sep 2021 01:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhIUBhR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhIUBfA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 20 Sep 2021 21:35:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4685FC0611C6
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id me1so3936530pjb.4
        for <linux-hardening@vger.kernel.org>; Mon, 20 Sep 2021 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWhoWBW+6i3JSlaA/8K89arcAnj7wf0LVk0B/HGuZ4E=;
        b=XMVRtqGDgddJ9vmZtXl+N9v3wZWQz8TsekFurV+IhOoFVVk2LuP86HJ3JUlObyYKm5
         vOoC54qa29lMWiPGJe2N2EUYMSnylo49Z16fOr26DSDVnTIfJDkqpM8wuQd6PNh/Ab5f
         12fZvtZeKCazWZW5L8F3NdOMcFnn/0ObVd/QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWhoWBW+6i3JSlaA/8K89arcAnj7wf0LVk0B/HGuZ4E=;
        b=H8vRRhSQeqtWO06mvNg04nnj7Eo0F7ylKyCf1GwKHjkRkb4L1W/S8Itl0DamoviQmP
         VSVCBomYlr5oDFRbjp0HOz2FgJHiHodsgNbX807BljhXOvEqfvhpYDb97s5lvn3EQ5hB
         d1ftjNBuOAvVABaiS2Sk2C9VyTA02nomfoZMRhXGH3cw/fhd3uIhSpIgsqeyhdgplvNZ
         5dRlkUYJItmEXwbg88+XXftFAbZvU58p9TxiCLNWXrL9X7SmYJqmdjsQtetxteWBUHqX
         sgeJEH5TtZA852J85ko8IGLPr7S4Vve+UT8Hxdsq4qqL7qCVz9oiXL2n5ODIR8lNGpWW
         8bWA==
X-Gm-Message-State: AOAM532CF/kpZGCZ9jJl7nrYE0OxGh89HZ+wUyxvUt1JRK0i8NOfXYq+
        JlHMbYCou6fjQiASnVZp6sndTA==
X-Google-Smtp-Source: ABdhPJxJkyvaK3tKy4vV8SofFI4zOawknZJhuHckMeHtbZcxA64+Z/AEQVh4NOO0f0h2sSGL+DDMxQ==
X-Received: by 2002:a17:90b:3a8a:: with SMTP id om10mr301445pjb.223.1632161336832;
        Mon, 20 Sep 2021 11:08:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g3sm133895pjm.22.2021.09.20.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:08:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] overflow: Implement size_t saturating arithmetic helpers
Date:   Mon, 20 Sep 2021 11:08:51 -0700
Message-Id: <20210920180853.1825195-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=685; h=from:subject; bh=FeG5PlfVQOLm7yYHENWE55wzEyBQPrLEryzPdosJgs4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhSM402j4bi/2udxuIImKCgmvR1/RMVmE5NfB0uQe9 ov29NnCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYUjONAAKCRCJcvTf3G3AJkCqD/ 9wne1Eptj0PIivZbRY8lVn4JyDC7UhAQr4gHCOyvPKbQ8YuHJZwKGwTftmmeOU9iR4vmLtg729JALP OGU249kFWYyRLcDTQYhN8IDTZAFOuWr49twoJAkugw0Oh1T+OQX64DMHeLxaqhNQVhEpmDVtfSuLIp Z6350Ufx3WfpKutOlwTN/snYSetedt/sXo7ebW3IEQQ3KjgraTlhQF2IlUvYnMpxx7NJLMdG66wSwD Od2hMQw/XKGRmRh3fJpRptzhA/oUGkKiGKFrFxyReQ9BdUacnYOLO8MLncsQ4DTRO7lVeFt42hgwQ5 PUtsstbbVYlGZ3RKmUj973T8/9+WDXs2je27S3nut+/uu/vY2d+Ehww1WhMUnmj0qoOQlGOTCKIWHI WxMQ0oMaKpBWIDjiHg4snsjgLxIC0RSwvNfnTmt8Blr/krbwZcRyoP3k/RWUI1JqEnuAmWI+cJ7NBq dFu7S4MC0718Q+hS2WQMaKFACmrH3HQT2mbvh1H5t6q518HbWEsFf4vbEUb7EbH1D31KG/DifLRjh9 KJLFUFHnumgao8bYjXwynF9v8tdUXDfXXNY2QIDWKhWYRVfqO2cMZOoxfpVsstai+aMRERT/7kzkMq KayOgWm9jy+bO7UvQv5WXgR17VZZT6XNxvVCZ++hQYmwJ7S+w25PbZBhywAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

While doing more array_size() scans on the kernel, and reviewing recent
struct_size() work[1], it became clear we needed helpers to perform
composed saturating add and multiplies. This creates those helpers and
updates the self tests to check them.

Thanks,

-Kees

[1] https://lore.kernel.org/lkml/?q=%22open-coded+arithmetic%22

Kees Cook (2):
  overflow: Implement size_t saturating arithmetic helpers
  test_overflow: Regularize test reporting output

 include/linux/overflow.h | 140 ++++++++++++++++++++++++---------------
 lib/test_overflow.c      | 111 ++++++++++++++++++++++++-------
 2 files changed, 175 insertions(+), 76 deletions(-)

-- 
2.30.2

