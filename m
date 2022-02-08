Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB90C43219
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 22:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiBHWx4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBHWxz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9647C061353
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 14:53:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y9so535789pjf.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohL8lfypuNocY9N3S5xez4sUrNp/rSZ6lRXmJ/oGIec=;
        b=a+KQG1Rc2kD1MkbBccinDb5tC/LMA+IHBJ/AdHYEUGUy+hqYnwOKavdBvCixlgVFs+
         lpYzygVgUqVr+eFBw/19XzjpEVnoti8mL6020TaoDsO7aA2Pt8IYssrSOXVcG8C17mgC
         uRXilp9yNbGAztDJ7mZmVKu9AyO/QmFf7cz5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohL8lfypuNocY9N3S5xez4sUrNp/rSZ6lRXmJ/oGIec=;
        b=sE2OLKR3QFJ40WGJKJFBrVDlZ8HPenpNpwoUTvYTZ74UEdGk91BthzAdsZIq0V2AI1
         kbGuHoj9DFByNQAspkKcFqh2x7XgK8chQ0Oqp9dgLvL1RyQryhon/q5edr0S78sKCaOA
         crtPbNDT8b+oSzwkG5Kge8kP0z/EC7mUnnjwkQ6dGg/SfaZEHjyO+mvHCBVElhqZDxab
         95BSlmAgrzVgb6dRa1LIwE3jO5B/JEdD4N8vw++tb6WrZydPSbV0eZTUC+Xj/Efjg9+u
         bhOTfU7kF7qqD9IpVAT6g+P22wkB9o3w2BrtpF/rqAAZIY9UvYEfmBy30Q9yKUfMKgMf
         DCjg==
X-Gm-Message-State: AOAM531kVtpvu/2cZk2gtz2W2rbOHggN5lrxHwcOo5ti7p+Kv3T95C6W
        X6YnDEqjdvMMlD7UPmqNnT7/jw==
X-Google-Smtp-Source: ABdhPJyBzW5HujTqEYsotAQ7T1nyLaMwVF7t3phNb3c2J9+G9thOWVC2ZpyyU8poAqLA+AeaN2/0OA==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr211451pjb.71.1644360833143;
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm17224199pfv.192.2022.02.08.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v7 4/8] Compiler Attributes: Add __diagnose_as for Clang
Date:   Tue,  8 Feb 2022 14:53:46 -0800
Message-Id: <20220208225350.1331628-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; h=from:subject; bh=4SDaw0EWkM/aZ9UdVR0PvLV5ODFDPttxec88Z3EMAPk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR8XC3tFWBBRxG+54By6AdqIGDcWeT6HebsLJN1 KFjh3N2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fAAKCRCJcvTf3G3AJvxLD/ 9nQbvCbm9F4OKB/+IKlUH5zOUgm4XQQrjsbA/gXEIz2JaWFPEiKLEwYc4GDXx9SbISyZjdwuHdfCRj JkXMK4lRAmn+0pPtL/KWwFnRkBJ2bT8rX1i26Ic9tu8eAA9wMX175dnyN8qMDFt0brcfYtIepO3RvH LcN+nMkNOC5zMDvaDlexQ+L9ruB++xyw9HEQRfHOQi2TdTCIJq6s5cP78+oDV5jjl61gAgLDlA955h Kzeq4OHDuXq2pqAua4m3WIy5Ely5EgFrkVJhcIa2v3zAS2vjsCOLP+icxE073Zq1y4KY2wBoh1l441 L/ndDc23VPXqvzaG//0la5sY90k3EIaepcEoVBBMGQvv63y51Vy2YRwz2D9RG/JhemE9sLqn9uhpiq AbNnKxI3vcj2NnkuqsvOnPxwvpRLAkd4nWZt9e8VgnnC6FyOOrvw3ZlaQlKSpOkX2RuCUv67utgSzK aRPhQJNgwXuZBPXIhpwmvP/neAej+qmqQLjFP4KAc//enP/8FfY+gnl6ZmeIEq8zIEb70c1qz+VcV9 HkA2V85gNsgZlxJ1CgO8uTBqnEDEtLT7hq5YZMAZiloJNZ+7Uxh4lAGisHXah5zOlubVKRoeOAWlLR aMzwxhrRj243m/dYFx639mVQRBNJkuSlPtrP7yQw5ZU5Njjut3tkUOMKy2wA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Clang will perform various compile-time diagnostics on uses of various
functions (e.g. simple bounds-checking on strcpy(), etc). These
diagnostics can be assigned to other functions (for example, new
implementations of the string functions under CONFIG_FORTIFY_SOURCE)
using the "diagnose_as_builtin" attribute. This allows those functions
to retain their compile-time diagnostic warnings.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index dcaf55f5d1ae..445e80517cab 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -100,6 +100,19 @@
 # define __copy(symbol)
 #endif
 
+/*
+ * Optional: not supported by gcc
+ * Optional: only supported since clang >= 14.0
+ * Optional: not supported by icc
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#diagnose_as_builtin
+ */
+#if __has_attribute(__diagnose_as_builtin__)
+# define __diagnose_as(builtin...)	__attribute__((__diagnose_as_builtin__(builtin)))
+#else
+# define __diagnose_as(builtin...)
+#endif
+
 /*
  * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
  * attribute warnings entirely and for good") for more information.
-- 
2.30.2

