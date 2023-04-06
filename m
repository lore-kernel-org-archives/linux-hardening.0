Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC3C7619A
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjDFACS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Apr 2023 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDFACR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E859E3
        for <linux-hardening@vger.kernel.org>; Wed,  5 Apr 2023 17:02:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso41190626pjb.3
        for <linux-hardening@vger.kernel.org>; Wed, 05 Apr 2023 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICBa1DtI6i1NF0+JonXqQyqUlpz7dmxfeFViA4mHGno=;
        b=YwjTtcaHeXgmNQCy+UZfNoSOdXZjRkV1nS2FVwslb/8WY3CT6punFfDFo1A6SEXcEN
         qgBvZR+YGmwakCTv/2s10NaRAHXxmobJgDox8sh2B8NnrDVlMF7kykKRvSfJHrnDfnaU
         CrwurUlZu5Q5vMrJKVxFEIoCEymN3rFYQ3lAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICBa1DtI6i1NF0+JonXqQyqUlpz7dmxfeFViA4mHGno=;
        b=S/SP+Dkklo9+TBiuAknZrjVBEEVtBO331P0m308b75T77vtyQlLSb3vUG50h89hOh6
         ADLqBrzPx6tw95Ki69fhia9PH6BT/3S09UqBYjom2G2bqh8LnOsrVBlfp9qcbW2Hp4I3
         Aj4Jojhrf771OVsjjXo7CrIe6MNPwXKZt905kxeN9ef3D/CHE2fwXI+s5OZmnMTz866W
         qPmrcTFAMtRUVbzZuMU6DCGK4sbsvghRlD6NyCIPnG5++a9CSkBvKAQgVANC+a1Y3P1X
         Cso2hMoBWx4kYrOnMQuGkWO1MTiZl8GsDpl8adwLlK0KdBZ+JSdjHHG2js4BGrpXPnzD
         hdfA==
X-Gm-Message-State: AAQBX9d1kxpCcNC1MKHzya5+UVPfSgNaC6GE62BUGqctmt0cfyHlZ0pg
        DVOcDTAD2KIvO8Z2toMRI77B8A==
X-Google-Smtp-Source: AKy350Z+Cz1lIx0yILCxOSuk2mkykSQoFslODV+JxiUeF7G2r//dE2JEl6b2FjPX2FxSt53YJBCWjA==
X-Received: by 2002:a05:6a20:835d:b0:d6:c9e2:1795 with SMTP id z29-20020a056a20835d00b000d6c9e21795mr788533pzc.27.1680739335996;
        Wed, 05 Apr 2023 17:02:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b005e099d7c30bsm11029461pfi.205.2023.04.05.17.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:02:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 4/9] fortify: Add protection for strlcat()
Date:   Wed,  5 Apr 2023 17:02:03 -0700
Message-Id: <20230406000212.3442647-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405235832.never.487-kees@kernel.org>
References: <20230405235832.never.487-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3250; i=keescook@chromium.org; h=from:subject; bh=rj52x4JBej+qEjIHIHz74SGX8jVWOZs51u/oWt76v9o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv//oEVXTENJ5N/QlhC1PcMOKe+fLOu/OWZjhUq cGEUJoqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJtbXD/ 0cKX83TNsTe99BigymaFdb/hrWnqygWzdMcLVPDMj6bXddgFVN05PUZvBqP0Jwk0Mq8PN+cVw1xnQK hhPe185jF6FVowhCd83A8Awzl37jFuXW3oIZnifmwtWfbrkV2NSpxlbyqqO1vdo0ZYVaCYCfiiyUql MMJn5QehjOT1vS6A+jJOPBaN9hyxiXjyUYtFvcwjbLXvSyU6plrXedx7Yw4T6Mc0rlBvcr19NfjVtx SBDX5WCJVrmYXhUQKAexomoOvuTHz7TW7gOBFNdtiVvHKOsM2QFnrcQ44xww1H1yZIeF21pWNK0Ure I2WsKEN9IDFqFN5sXbkRlKB5xgU3P3cO5wUw836+tvzaYwdYgrXCuMDD90mJ3kmNhj0NCdd8ugRoR9 xwidD22KGNV1BJA9dXt3yvPXn/p/zb5rgA2ltA+c+A2G17GmupmfOiRu+b/8PmYwyclrcAMVdMu7hr l5OyX3aP9Wy7l8plUlzY9SACEyxMyGShBhxL2VPBQRdQ3aOUdJ4Lx87cgMNGiP8UUNdUwd1PPuqGDF fVOmKgvKW7q4/GZZAwzD1UJJ9ByTmUdCbacrmlat93+NwU6D3/vpuhW5PYQVF6ZshQ7LFJvVU76sth fyZ5LHa4lq99coCOec13GLmFrtPJnP8d6IguezioiOVkUvn42/KNyEaccZiw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <kees@outflux.net>

The definition of strcat() was was defined in terms of unfortified
strlcat(), but that meant there was no bounds checking done on the
internal strlen() calls, and the (bounded) copy would be performed before
reporting a failure. Additionally, pathological cases (i.e. unterminated
destination buffer) did not make calls to fortify_panic(), which will
make future unit testing more difficult. Instead, explicitly define a
fortified strlcat() wrapper for strcat() to use.

Signed-off-by: Kees Cook <kees@outflux.net>
---
 include/linux/fortify-string.h | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index c9de1f59ee80..875689aa83c3 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -371,6 +371,70 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
 	return __real_strscpy(p, q, len);
 }
 
+/* Defined after fortified strlen() to reuse it. */
+extern size_t __real_strlcat(char *p, const char *q, size_t avail) __RENAME(strlcat);
+/**
+ * strlcat - Append a string to an existing string
+ *
+ * @p: pointer to %NUL-terminated string to append to
+ * @q: pointer to %NUL-terminated string to append from
+ * @avail: Maximum bytes available in @p
+ *
+ * Appends %NUL-terminated string @q after the %NUL-terminated
+ * string at @p, but will not write beyond @avail bytes total,
+ * potentially truncating the copy from @q. @p will stay
+ * %NUL-terminated only if a %NUL already existed within
+ * the @avail bytes of @p. If so, the resulting number of
+ * bytes copied from @q will be at most "@avail - strlen(@p) - 1".
+ *
+ * Do not use this function. While FORTIFY_SOURCE tries to avoid
+ * read and write overflows, this is only possible when the sizes
+ * of @p and @q are known to the compiler. Prefer building the
+ * string with formatting, via scnprintf(), seq_buf, or similar.
+ *
+ * Returns total bytes that _would_ have been contained by @p
+ * regardless of truncation, similar to snprintf(). If return
+ * value is >= @avail, the string has been truncated.
+ *
+ */
+__FORTIFY_INLINE
+size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
+{
+	size_t p_len, copy_len;
+	size_t p_size = __member_size(p);
+	size_t q_size = __member_size(q);
+	size_t actual, wanted;
+
+	/* Give up immediately if both buffer sizes are unknown. */
+	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
+		return __real_strlcat(p, q, avail);
+
+	p_len = strnlen(p, avail);
+	copy_len = strlen(q);
+	wanted = actual = p_len + copy_len;
+
+	/* Cannot append any more: report truncation. */
+	if (avail <= p_len)
+		return wanted;
+
+	/* Give up if string is already overflowed. */
+	if (p_size <= p_len)
+		fortify_panic(__func__);
+
+	if (actual >= avail) {
+		copy_len = avail - p_len - 1;
+		actual = p_len + copy_len;
+	}
+
+	/* Give up if copy will overflow. */
+	if (p_size <= actual)
+		fortify_panic(__func__);
+	__underlying_memcpy(p + p_len, q, copy_len);
+	p[actual] = '\0';
+
+	return wanted;
+}
+
 /**
  * strncat - Append a string to an existing string
  *
-- 
2.34.1

