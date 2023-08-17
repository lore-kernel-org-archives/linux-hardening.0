Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB20C5479A
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbjHQUGY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354190AbjHQUGJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 16:06:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF07359B
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 13:06:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bcad794ad4so1600915ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692302766; x=1692907566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbsxO4EunJBczn5K/qVWQc9X0kVNu3YHxV88CwvQfAo=;
        b=bb7QBUe3bTaz2B2jMyMl56SJDnlsnftgVjMEogpwFzd7cb/Ocv2M7yWlKTUK//A+XT
         sl3doHdTYBEIeGe8ER5o9AjcQaLtk/dkoP5fZXCQZB6w9bmo9UXfASSzdguyOiCal+Ja
         +uGlklc5Pobah5m6SxwT6rNxF4+m41uvS0oFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302766; x=1692907566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbsxO4EunJBczn5K/qVWQc9X0kVNu3YHxV88CwvQfAo=;
        b=UYLSPx43NAHv05FLxCZ0BhqE6Tfu5Wz4GBAFGe4NYvvjM/TR5GTmJBMxYs0kV8xTVh
         fq+XtaF7mL4Pcri6p8khNFmpfAqBByg9OIn6tHlvAUbNyH+7i5+d4C4LJ3TzODBC4YCu
         /fLSE6LCBYHbWIzYuT8EJnPC7zDl6deD2jfkjDE6mAtOy4ZnA0nf1GbIR957pWO5i3Z7
         l7t/fmO22XeS6XwbwDyn700OSadCWUEDPMNC/daThwUUrqdSFSKk/IENMkWSk51boVp7
         TPsr/QrfBJLbZTiZO5oZpbnmjXGzc9AG60U5djwfb3JYMywNiziSx5bAhvnaMJPZqPAj
         8cVQ==
X-Gm-Message-State: AOJu0Yw5CsPjn8a0DXAxOOvmdOT2Be6Nnab7BbxtBmOYtCz576KQ1+6M
        G/zxwmLes9o7tAsuLyN65WbZuA==
X-Google-Smtp-Source: AGHT+IFvOpj41A5JYl6PjF6P3Rg1fHwaar9j0sl1Dy+YcFnDkvyGkeNGyVRne93EWm8OkeJhGUQqUQ==
X-Received: by 2002:a17:903:2287:b0:1bc:18e5:2c82 with SMTP id b7-20020a170903228700b001bc18e52c82mr535587plh.36.1692302766095;
        Thu, 17 Aug 2023 13:06:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001b6a27dff99sm154872plb.159.2023.08.17.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:06:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] Compiler Attributes: counted_by: Adjust name and identifier expansion
Date:   Thu, 17 Aug 2023 13:06:03 -0700
Message-Id: <20230817200558.never.077-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=keescook@chromium.org;
 h=from:subject:message-id; bh=yMkCTHZHP/BRFycnWTEzZlu5l2QK06etjGosbVrVIT4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3n2r1CgP3Mc6pKxyHkZYiaBqAOVNY4uUihf1S
 xpexulDGQCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN59qwAKCRCJcvTf3G3A
 Juk5D/0fRxpeHUoylQN5bw44Q4bDNoPclBzKqlpYMfYTeS/vBf3t02TO2Oh4sBmPxyMa/pdcRMD
 n6Z4w4GOgxAitAfrDNMuqyFEyvp4insRTwwoTKl1kNhaYJu22bIw0CWngvRv4upSqODjUrB+ale
 7oSuCuUohlqq62sibdTRlYqhtpYymI7/hEx4W/hrGg5Xr+i9DCeK0o+Wn48uzyrYuWRJ2cZIb5o
 lFR7wItH03McdWGnQq6cowK0bX3UJTnH9BQ+WeoKeJNGq489fi/IaZtAaDiLR2dIkr9TP+B93El
 bi+vAqYsZXxpmmYd6rUqiLAordhRuaL70ZH7gNN1BxQ3GFQdAiR2VEffxF1RA3vucM1LgQVY91P
 YCyAKovCM02kXBx9l1KQxzL6hyrhTgXHbQ+GehYjTMnDzcL7KKoSPaphXnczGgPet+FZ0Zt87uq
 DJbJ3RmRxIVA0GG4G0Ll24+wpbJhMYVRYIJIiB1KgQy5zhshHOJOtlmG0GuzimTTnxUAibE6uF/
 tlMOVVHDy66Z1Ag3mB8UwMFf7Y3qhJUtpHDPQhhZuKXvXwZviXFJ/q+VsavNT7xl6BqXwu9a4X7
 fqyZPju0U/35nmQBgq9imr7gRVDLLenkPpbmprm8iPz0ZrQ1u9PXcaRpiLrS9C6m54f3RiFG2vp
 77E2RG1 raQeW3CQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

GCC and Clang's current RFCs name this attribute "counted_by", and have
moved away from using a string for the member name. Update the kernel's
macros to match. Additionally provide a UAPI no-op macro for UAPI structs
that will gain annotations.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 26 +++++++++++++-------------
 include/uapi/linux/stddef.h         |  4 ++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 00efa35c350f..74716a407aac 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -94,6 +94,19 @@
 # define __copy(symbol)
 #endif
 
+/*
+ * Optional: only supported since gcc >= 14
+ * Optional: only supported since clang >= 17
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://reviews.llvm.org/D148381
+ */
+#if __has_attribute(__counted_by__)
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 /*
  * Optional: not supported by gcc
  * Optional: only supported since clang >= 14.0
@@ -129,19 +142,6 @@
 # define __designated_init
 #endif
 
-/*
- * Optional: only supported since gcc >= 14
- * Optional: only supported since clang >= 17
- *
- *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://reviews.llvm.org/D148381
- */
-#if __has_attribute(__element_count__)
-# define __counted_by(member)		__attribute__((__element_count__(#member)))
-#else
-# define __counted_by(member)
-#endif
-
 /*
  * Optional: only supported since clang >= 14.0
  *
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 7837ba4fe728..7c3fc3980881 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -45,3 +45,7 @@
 		TYPE NAME[]; \
 	}
 #endif
+
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
-- 
2.34.1

