Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA3C433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 22:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiBHWxz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiBHWxx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92538C0613C9
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 14:53:52 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a39so165690pfx.7
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQMwXqlDPSXD5WcTL3esNOpDqscVXLIQFDsHDlsLA6s=;
        b=I7DYO0+aevF5VNc7lv6kik71OWvQgcQNZ8zVQtSbj5ylPTl774t0T5TzMtC8W+xc5a
         G4V4PntNj6Wx//xFTtpnlKptTcgc6sVfB8LfdDkC0cNxX3M4aW4wQMC9A4bNoYOEYM2P
         1lHHM0tCCK7nqJYtjXvIGjtcKV/o6fC9kvJcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQMwXqlDPSXD5WcTL3esNOpDqscVXLIQFDsHDlsLA6s=;
        b=lEDXU1GSR/9um30AOZjEupMeFQZADVsjEmEEiQercfpZBhWdJUlgmyxfXOwS1oIQlN
         qP5Yh0dcMeJnUx1G67TSgR9LsYJTc3Xi+0mooPwuRgjwTTv9RAYicrl2j8KQI9WdfNz4
         4mKIyM4mM1yYdGOjPwlQLqVI+VFRlWnDF2qmmUi8MUq6z2/w2dEYkPop+vXNT+uurJmC
         a2pxPsidpV9o5JPiTpaYOjL3qZY3SZ5UrsLNAIHBNzwNIkvS16nIFb+kBeD5D3Cv05e1
         cFbukLIghVUUTpDe4qZL90fVn5xl3gqo4wtMX9QsWIEV4h5IEKICvMO8ZM6yTGZVENl9
         K32w==
X-Gm-Message-State: AOAM5300AXYmvcracMeFvpUT/VD/qYKZnEZz2rccgmUey4SswUhUD1AN
        0Vrmd5jh5mEcXePh/oLDvt2tIw==
X-Google-Smtp-Source: ABdhPJyYhpQYVGMNJXYXnSxOERPvWyclLewnhUUMAxAOZuJ7tLHin//i/EiDuxPbUhpcU0GU9RuCSA==
X-Received: by 2002:a63:2322:: with SMTP id j34mr3073107pgj.583.1644360832076;
        Tue, 08 Feb 2022 14:53:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mj21sm3798910pjb.20.2022.02.08.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v7 2/8] Compiler Attributes: Add __pass_object_size for Clang
Date:   Tue,  8 Feb 2022 14:53:44 -0800
Message-Id: <20220208225350.1331628-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; h=from:subject; bh=i0Oi+LXolg+eM3YPVR/El2E4tGz736zn+2NHNZGvzdI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR8bIQyeNI+NWaNQZqa8J2M9TzhXpEub4iVXEfv UzC3tZiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fAAKCRCJcvTf3G3AJrm5D/ 9EGjvGZsuSNeXlB/ANO8IFgIGTwIXHRLmmfagMWJtTn5f0+hz4BgaRbPeS4QtNZkzoLAPwaQLFqPDc waWxLmtqXpmnn2xxTuscc3+DVmcKeNX9jPGCBmln0sVZkfIMdp5M5Mr//rsJVByTGQZuU/Eo+i27JV nK0CKkl/tQ6TWmER+YJM+f8IjiozsiN6ndeJxch4neSrzjBDqXKeKh0jIsflO8unil9uTNFCa6O674 8lEuyws8iqyFFAPaardjsC/ccYDTNKjvLBEmym9St62Dsg0VwlAz48NVgiZletgVD08a0y76U7vwIW 2eJzMJLV6cz4T/0RwGbtONrbLRXla3EFHGLYDCNClPIB1LXDUS5Qk9L5lGf7Z3rP4PbpCCSoKe8TeT wBp4ONPatn0kMdEzAP6aIgAv7VZ2P45TVzwTx5ThYWW5oG+qenakqfSGKE2udjlkk1wR8GqJBvm7j+ M4o9TTsjguid/+ArNUi5l8WC8wCnt0mXBu4dzJ9JUoTq7ymMKxd5U6fNrmyIp9hlQpGk+kJkDjXk2x YsZ/gC/FzYgLUEpK5QFoK1rbs1mN4jWTcB2uZ2FvHRQNCFKZNsCiFzBH24YPxREDZujwmpu65fnaOH M3DNpnvZOh5sWF0O4YrRZxuHCyONucVcFUVeCShow/6tZFwm9rOa2Nfy8Q9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to gain greater visibility to type information when using
__builtin_object_size(), Clang has a function attribute "pass_object_size"
that will make size information available for marked arguments in
a function by way of implicit additional function arguments that are
then wired up the __builtin_object_size().

This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
to Clang's __builtin_object_size() having limited visibility[1] into types
across function calls (even inlines).

This attribute has an additional benefit that it can be used even on
non-inline functions to gain argument size information.

[1] https://github.com/llvm/llvm-project/issues/53516

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 37e260020221..d0c503772061 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -263,6 +263,20 @@
  */
 #define __packed                        __attribute__((__packed__))
 
+/*
+ * Note: the "type" argument should match any __builtin_object_size(p, type) usage.
+ *
+ * Optional: not supported by gcc.
+ * Optional: not supported by icc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
+ */
+#if __has_attribute(__pass_object_size__)
+# define __pass_object_size(type)	__attribute__((__pass_object_size__(type)))
+#else
+# define __pass_object_size(type)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
  */
-- 
2.30.2

