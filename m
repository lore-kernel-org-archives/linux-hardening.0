Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E851C7EE24
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbjEKSlk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjEKSlj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 14:41:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C8335A5
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 11:41:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6436e075166so6749511b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683830497; x=1686422497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmEGgp7UzpXMr2679NqQSGP6auA4dsHBdILkXW5CU88=;
        b=Ga18LKy+wVLmNBgAsJnHQBQmbaIW3ZXpFNwNiPSuL924YiRuId6/2ChaM28aHd4LZ9
         z36uQ22MTtAk00fUQV/ADMTtrfQy5l48QymYbshXxe35qpcIf+IywZ/HvIqRP834jjV1
         LRLb7Fkr92lrc0N2fvfNIqHa/CkZf6aJ5WQxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830497; x=1686422497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmEGgp7UzpXMr2679NqQSGP6auA4dsHBdILkXW5CU88=;
        b=gWtSw0ayOVOtMISAit5RqfffD3/feZ1s+A66W8KJGjsCuVCovo1Jh+gHFEb2SvrEgP
         eIV1m/VDmpI4DBDgl3sBkpOMXxXBAxEKIggffk7Yi6auPa9kbSN2Irlv3YRla/Qy91wb
         +ubCz+nLBcBKQVfh/VHS27wsGOcsUd4q9c3eRPHmBD0D0hEehot4bPADUj9uGVQR1F+s
         9gPMovxg3iodusp2CgD1eAQoMArv8WLRHbpoq2WvKpPOJuWkEF07Jk+3EUvXSXqhQZXy
         Sy67+/k5t6TMAei6Ck4otXHRIbL00+uR5fsWZuPgVs4bFiiyNfKVWV+poDJgYMX7nd4y
         03DQ==
X-Gm-Message-State: AC+VfDzkE3t8lHnGe7Qh26pKhTampK5e3bV0v9I8SGHgslyUJzIyO1nC
        x9aBr7nb4a68yI2+ktnL6blaUA==
X-Google-Smtp-Source: ACHHUZ4i3qsxM8xVhotIeDGKDK99S6ZaRm/hQHEh81twOzxm+2aqZl1ou0u8Dfjur0zXBZXzU0yQ+A==
X-Received: by 2002:a05:6a00:807:b0:647:b071:20c4 with SMTP id m7-20020a056a00080700b00647b07120c4mr12442043pfk.1.1683830497330;
        Thu, 11 May 2023 11:41:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f13-20020aa782cd000000b0062e63cdfcb6sm5799803pfn.94.2023.05.11.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:41:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <code@tyhicks.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Xujun Leng <lengxujun2007@126.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: submitting-patches: Discuss interleaved replies
Date:   Thu, 11 May 2023 11:41:35 -0700
Message-Id: <20230511184131.gonna.399-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3652; h=from:subject:message-id; bh=PB0GhYpiwYZnktCoOIXqcoPuWPTcB11jj/ColM7AkfA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkXTbfOKSD8Mkt6WOrLgPP8U2XyIjWuBlPoC53nkdZ JoYapPuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZF023wAKCRCJcvTf3G3AJkyGD/ 4xsRRBgBFeg93nw6za1bBQvkzpEOXIDmR9fXXcbVFAyyQea2tqyZZXkLOhE1y6wnrqHP+CmJ2FKKCA NR+FZgGxUvEGtpTw9ogLg06B2OcOkElLCLPLVrmCh/terDQAQ95sDzhEEbRGOnEBYdMPZgVJEFZcev +vsVhdIOCtfeJJ/yxQFClgpkDHqfZeBegX/Z56N1AnU505vA/Pi8twrjXYGQUCPR9EbUHcLpjTdu8H QykughHGh9xi853+adxoC69QKemRzFo1SlBoPdU/WQT0XMNl/stgWNCPnsyggx7EzeXuD5y7qlsWAn N9MaLhFZq/3hShokHAgDHAG1U4uADmJDaLvbKl/8GRCLND7DaBgL9Ksaw549wTkK0frsMwXcUjZx5E LI2/3tVTpTwngXH2Qt6V3Hk+Wl+LWx8irEyWIAinlKogoITpp0pU0BM+eXrTxGQWvcKv6yEAbt+rGj M6OflLqV67uZdw1Rx9Lh7/dfk6HDYqC9Vx34shn0i3ooJe2dpVsei/vspuMFBFF+wCbEAZ/KthBZ6S Xgjd664cYYlF9IZU7TWWbEdWM+iXnzc6PeSMOpPU7PU5rtOj/yy0uWf3qp/N3Ehsa4ZJxdYOwjgXo2 tjqzrlcbLPhnYNiQ7RSt8siHCuuQKtkPx8u20K15MGLz19hyqldPOpxE0pdw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Top-posting has been strongly discouraged in Linux development, but this
was actually not written anywhere in the common documentation about
sending patches and replying to reviews. Add a section about trimming
and interleaved replies.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Rong Tao <rtoax@foxmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@foxmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - rewrite 2.Process.rst to be postive and link to new section.
 - fix typos and phrasing (Thorsten)
 - add missing "::" for block quotes
 - add Greg's Ack
v1: https://lore.kernel.org/lkml/20230510183423.never.877-kees@kernel.org
---
 Documentation/process/2.Process.rst          |  7 +++---
 Documentation/process/submitting-patches.rst | 25 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index 6a919cffcbfd..9ab58a0d4fac 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -434,9 +434,10 @@ There are a few hints which can help with linux-kernel survival:
   questions.  Some developers can get impatient with people who clearly
   have not done their homework.
 
-- Avoid top-posting (the practice of putting your answer above the quoted
-  text you are responding to).  It makes your response harder to read and
-  makes a poor impression.
+- Use interleaved ("inline") replies, which makes your response easier to
+  read. (i.e. avoid top-posting -- the practice of putting your answer above
+  the quoted text you are responding to.) For more details, see
+  :ref:`Documentation/process/submittingpatches.rst <interleaved_replies>`.
 
 - Ask on the correct mailing list.  Linux-kernel may be the general meeting
   point, but it is not the best place to find developers from all
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 486875fd73c0..efac910e2659 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -331,6 +331,31 @@ explaining difference against previous submission (see
 See Documentation/process/email-clients.rst for recommendations on email
 clients and mailing list etiquette.
 
+.. _interleaved_replies:
+
+Use trimmed interleaved replies in email discussions
+----------------------------------------------------
+Top-posting is strongly discouraged in Linux kernel development
+discussions. Interleaved (or "inline") replies make conversations much
+easier to follow. For more details see:
+https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
+
+As is frequently quoted on the mailing list::
+
+  A: http://en.wikipedia.org/wiki/Top_post
+  Q: Were do I find info about this thing called top-posting?
+  A: Because it messes up the order in which people normally read text.
+  Q: Why is top-posting such a bad thing?
+  A: Top-posting.
+  Q: What is the most annoying thing in e-mail?
+
+Similarly, please trim all unneeded quotations that aren't relevant
+to your reply. This makes responses easier to find, and saves time and
+space. For more details see: http://daringfireball.net/2007/07/on_top ::
+
+  A: No.
+  Q: Should I include quotations after my reply?
+
 .. _resend_reminders:
 
 Don't get discouraged - or impatient
-- 
2.34.1

