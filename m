Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E6C4320E
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDBE61242
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhHVHwK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhHVHwJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280DC061760
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j2so3954257pll.1
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8xtan08Su1aPHkuXwbXQb4qxZDxvf0Qz0X3flwzJxU=;
        b=KNehxyZsX5RaJK5y2Pm9Hy+GMM4ouGgu1mtFCNGf5Q4+XuYzcpek8mmjIelGU5Zh/K
         SGkkAqqI6ZtkljguX0dRdZq8VyLLpX++4gkynq16kQAfwn/sMu2R1vnWUVqCmuKBnTmr
         vHvxL4HNIkK65E56/fAQ7HpRp1zSvwPTX7iiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8xtan08Su1aPHkuXwbXQb4qxZDxvf0Qz0X3flwzJxU=;
        b=erWf2hvx61pnaF55D9bYaWLcMuDUZ1u5a0HXCpL6AVDFPXdY1BFBIJ3Xtl9+txquxu
         RtUGl+vDpyFMpbv68XetYZbNJrtQoIHj09Ty7muf6VOqxkw5prFew9xwaI6Kx+eNWiNl
         +8H10Uh+2gRK1sEGjILGSL8eFjJ1TTnnQNq0izQo73Y1HO5ZX+QPGGBCBgK1xXwJVlWm
         9ABV4w/3gD8ViToDA5Kmsew8ExAK5MWh3LX/baFqlWlvPrUBzJpBQXIlDPoMl8lqSHzg
         JoP0v1z5CzZRizQ8F//5K78KNMyhkoqXQeQDPpfs/qErGxjSrfp9+6v5/qS4cjobc40H
         xN9w==
X-Gm-Message-State: AOAM533QIchup0XduJAV7Hz9Xcq95mccwanaGEy8oA4vvFrHQaOlOH6X
        c4xDCmPkqy25j47h6gLXzH7g0Q==
X-Google-Smtp-Source: ABdhPJynYb3pa8ejO4B+aEHLyl8/2mMaKNSH2/9APepsItN8LomW9d8AfJf7FjCm4rK6LixtzjSB6w==
X-Received: by 2002:a17:902:e744:b029:12d:6479:83a3 with SMTP id p4-20020a170902e744b029012d647983a3mr23356458plf.30.1629618688348;
        Sun, 22 Aug 2021 00:51:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z3sm12422917pff.47.2021.08.22.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 03/25] stddef: Fix kerndoc for sizeof_field() and offsetofend()
Date:   Sun, 22 Aug 2021 00:51:00 -0700
Message-Id: <20210822075122.864511-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; h=from:subject; bh=LSI9Ve3iPXm24/e6+dJ/Whm/+Dq6iMvpCYAHC2kT7As=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH1w21LSBQACqZKJobE9QLuzQzYC1C0zIz8fHlJ j7xmpjuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9QAKCRCJcvTf3G3AJrdkD/ wKmF69TzlROZwIafqz2MLoItMJiWF/65+N6fmS2XO9e48KkVpSl2fKtlLamzp4HmXqzSDnzqrZdPk0 itFI4TMiLP++478UHgC0wuWMMe4Ducifntz4TDVW0g5+G/cwTzzgJwGz9AMHNgjY7TdhfBw4EE3c0D Jeug5F7twQ9FjEDaMzmLLynDQY/yeNO5HDDqHVdZRS6Qp2l0RhfF878rFc3Jp0ufEWS3VE/bCVlZ7x eQY2TrsxGok6P//wlSnfvOPbDermCWJr0reeYZcxyWC2YqbW++crZK5dk9aK0237tPWEG2O1QO3ofD Ac3IBz2jVy1oGQ8VmJIoxLQ9Lh85+lvUqiLs6S1VTNTlVAGB6NHYhTgWC2xVBdtVCuwsvs/Qt1xm3j LT/xKjTkZkRyGB+QGDb5XPiXh351iZH6rNoDnL+iR58vjO0MItRJqo9ydXevQg+Ul5b1XHrCiI3rzA 6c9Wk6pWdD0gJ1ch+rNk9dMJqfelisvVjpAsPQE8V4NYMfmaYgVUBqghH3LW8+LqCpidDMrXk1RM8c InBmG9X4jSf5m2HaoIoQudmq8ipqnFpqMY1T2r/AbgbTovYcSWFMXMwKGZ1+tgY8JfOJs69rtkN9pW nrxhwXPO6Od0J3Im7hVxdDvu4WFS68ohxHONWzmNrusiExiSogibF5+dCOvw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Adjust the comment styles so these are correctly identified as valid
kern-doc.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/stddef.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 998a4ba28eba..8553b33143d1 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -20,7 +20,7 @@ enum {
 #endif
 
 /**
- * sizeof_field(TYPE, MEMBER)
+ * sizeof_field() - Report the size of a struct field in bytes
  *
  * @TYPE: The structure containing the field of interest
  * @MEMBER: The field to return the size of
@@ -28,7 +28,7 @@ enum {
 #define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
 
 /**
- * offsetofend(TYPE, MEMBER)
+ * offsetofend() - Report the offset of a struct field within the struct
  *
  * @TYPE: The type of the structure
  * @MEMBER: The member within the structure to get the end offset of
-- 
2.30.2

