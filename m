Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9957C54EBD
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 20:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjAFUGK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbjAFUGI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 15:06:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E941678
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 12:06:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z4-20020a17090a170400b00226d331390cso2864458pjd.5
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 12:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRynXyqPSXTn4rCoxoHLyvDBt750D/GgS94gTx+vdEA=;
        b=cLduJRhC6MWyAlSPlrHt/96BIN6acHNahHOAfVFD/3gWpZGuHPRievwrVmS/p8g+7t
         aVYrwNV3lYRBghHO5MmNDkouFdQhAqSkzXUy0Hz7Dijs+yqmSfbET21PQgNMUY6kQS39
         Znkc6oXs+18uWOSthQsqyU5KHw7GX61bAzNtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRynXyqPSXTn4rCoxoHLyvDBt750D/GgS94gTx+vdEA=;
        b=s8CXSg0imkdGnyMJJbfFP9G0MmVnBCzNLDj5CQ2Ry8gdGFnXQzx1hqdYe97LZbwGk7
         yGeGHZ6v6Dza34zSb7FxtxT/LGkArIpq95M7YrCC0i2FH0v3ywOeB1AuIy/ENlMUfrrc
         PRkVvezmLmIZ/ADKYA4OHlt2v2vXbTTD30qLRsGLkgi6EfcLNdeK75GtMarXBqagQ4fj
         51w574NE+frC8janLp1sf9dnuU80IKz9PXWClBrNx8wt5r6l1LZXtnUGIevuJVsE0MaY
         iClzm7dhjplhczEmE1VmKUScIYKqnzRfb/Chkay4CZqmCG0IntR5gzx8AzIhpbx7jdks
         BSJQ==
X-Gm-Message-State: AFqh2kqeoBRpQzyCQvYJyUnH7powpzAMArZzqtXh70MvFvnzCGIr8FY0
        ClTVUCSczLOFqrgdUSQ7kvfMKilPiCEwDEhs
X-Google-Smtp-Source: AMrXdXvG96Irf8pAn872krsUZ3eJehgkT0Bu9WsLRxGE92OxjgK3MlzCl0E7H4TVgFBUfEC4pHi9XQ==
X-Received: by 2002:a05:6a21:1518:b0:ac:f68:33c9 with SMTP id nq24-20020a056a21151800b000ac0f6833c9mr68838378pzb.33.1673035567367;
        Fri, 06 Jan 2023 12:06:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a474700b00219463262desm1260669pjg.39.2023.01.06.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:06:06 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] docs: deprecated.rst: Add note about DECLARE_FLEX_ARRAY() usage
Date:   Fri,  6 Jan 2023 12:06:04 -0800
Message-Id: <20230106200600.never.735-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; h=from:subject:message-id; bh=W2pNqJKTD43JaSpEWHJSnavL8GLLOvSWonV1g4X9lIc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjuH8srP2S6yInxOMPLcWkTR0LZU9mSxxMjjQUblOq ktFNXW6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7h/LAAKCRCJcvTf3G3AJj4YD/ 9sUyfRQkLEqbQ9W3a9TRqEZpxbRuFpmJ/sUtAqaWxuUfiE9Et2MFXoOUvuly1JvN10Pt8eMO0Vj0LX RWriz62or9mGNZlpABetKNJRy21+GxioJ6xbY4T1yxoCJ5Yx2iwSCfINzYIqTRrqQWjgl36L8onyRi NLOokGHLnSe+IZE44utQZaEIIdXSpyt7NkOj357oXJzGtCDp9BQ8PcR6cU7wQxpPY4FDNkvCanVgc+ n50lU4TF30meeXv7VqbNctWXr4Aw90Vptd+e86Yy7tZNi1/m/2Iohe56S0cCeom+5u0KDkGhGRoDxb y2CsAJM3Odff6dd8d6+HvFGaOIwH9txtBRzaIzRAbz+N39AMvwnTI7R4inKEOdXKMK8LgCbx72uY4z mDgu0qK53IRZw/krLy0WOiE3nyub/mXyx4Rm0sjjq5CxV2+BQgeEjPNAXF9kMA1G48ORd8mo+bJdKE w06pTRg1MOnmifwPdx3jnMfENgzR6lYMrXfPK7ZoMDkasBNl/dJICc5ha2nDWbctsf7qKMR9LSuxA8 o2dOf97FvLReAhyuY2XymowXJ0xumC9//y8EpsfYEuAhKBEf2CMP8j8MZPPY+9CUVvZ0vZkt9ATcQ7 f4q7iDXw3xB8M4c52tWcOIlp5nB9nbVEz4kPhTwWDmIkk5U6oM4oo951CpzA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There wasn't any mention of when/where DECLARE_FLEX_ARRAY() should be
used, so add the rationale and an example to the deprecation docs.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index c8fd53a11a20..fcac0a929efa 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -346,3 +346,29 @@ struct_size() and flex_array_size() helpers::
         instance->count = count;
 
         memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
+
+There are two special cases of replacement where the DECLARE_FLEX_ARRAY()
+helper needs to be used. (Note that it is named __DECLARE_FLEX_ARRAY() for
+use in UAPI headers.) When the flexible array is either alone in a struct,
+or is part of a union. These are disallowed by the C99 specification,
+but for no technical reason (as can be seen by both the existing use of
+such arrays in those places and the work-around that DECLARE_FLEX_ARRAY()
+uses). For example, to convert this::
+
+	struct something {
+		...
+		union {
+			struct type1 one[0];
+			struct type2 two[0];
+		};
+	};
+
+The helper must be used::
+
+	struct something {
+		...
+		union {
+			DECLARE_FLEX_ARRAY(struct type1, one);
+			DECLARE_FLEX_ARRAY(struct type2, two);
+		};
+	};
-- 
2.34.1

