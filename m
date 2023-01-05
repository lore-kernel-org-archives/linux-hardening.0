Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F0C3DA7A
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjAEWGA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjAEWF7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 17:05:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41B767BE0
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 14:05:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c2so13215171plc.5
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0/OIItYBQ/LlamHWRG1HEEnT7hNf+TYeSra86z2Brk=;
        b=n17TPVVS1e2+dMewRwQT9JLjefS/KUc5ZVmrEI1WOq5QkmJ50L1qSqxkhaSsV6MTQ2
         4hevybSckxzqEsyHlbyTi1GSnO0O1zU6GYEE32TLUxf6O0/C90pHetdon1VdWIG2iAmS
         D2fCgtrf4REMUzfaViVtvgb801e8zm2NOH1p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0/OIItYBQ/LlamHWRG1HEEnT7hNf+TYeSra86z2Brk=;
        b=ldTvb1rTs7WgXoCQYCx6KEhC0wxJYKWcIW1zvM1FFP/M0HuLIHiogPKRSHTnKmwcDX
         BhUY7Fs5fwbk6HLQtn6NJMlkWaZpco8mDs+pf/wOcoHErR+fwj8wELDEco6jv7DCKS8E
         G6On5AdIxzboTXLbP/GO2NvD6RkXtY6a1kC8YIuXjXZHt/OkgYwU6qtyqt8xiZYtbObF
         zIoU0DOJI7VSqwAs0rynjH6xicwJoDpe8rUWLYbTvPFpLRCxeJbFBIAJ58QfNs4u8EHp
         cngIcQJhScG+EsZ461lCSOh2uRREgWpCRkX1pKp9eMywI0ubxPxrYW6eMWIdBwwWMtG5
         GbYg==
X-Gm-Message-State: AFqh2krbRFoZ4u1Cwdyu4cI9Mz8M9Uc0cNZ3dIJjgj8RqlVOP8LZywDP
        5znzlfTk8vHEusM1Le7hX5ppqQ==
X-Google-Smtp-Source: AMrXdXvjfpHpqj5DKFofyxd8vmi2zL+Fo1jJ640Tt/Mmr86nfj/AoHwRf0Pb2GAHrOije3I1lyxZVw==
X-Received: by 2002:a17:90b:1982:b0:225:dd16:ac4c with SMTP id mv2-20020a17090b198200b00225dd16ac4cmr41992901pjb.16.1672956358083;
        Thu, 05 Jan 2023 14:05:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nk11-20020a17090b194b00b002260e8357ebsm1783940pjb.30.2023.01.05.14.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:05:57 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] vt: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 14:05:54 -0800
Message-Id: <20230105220549.never.529-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; h=from:subject:message-id; bh=Im+HeJ/SO6Toyppy5KpgHX9hERrzzsgMNzvw49e/BTo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt0nCsbc0ES+bQDV6h54nWAMiR7Gq/Yffsw1Fi4TK jGnACIKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dJwgAKCRCJcvTf3G3AJqP8D/ 9UJlCMIrUP9OoXPNQpu4gIfQFD5U8Q7jpgxyTFazZOIaTy26tsA+lzq7Km9fPuyhTMf6OyL4ckcbXy US7oVq9Yb6Eni7ObGQ6abcFggGecWExjUreo343sDnhuJgHzO0woOAAaJXl9KAmL7vN8/IIVH7TSXx ouywWAndl2uVohwkBVMIR9bZfK9LKkFDT5VS1s3kVPWeS6j6aC3y8mwrboUUNDRGm0Bn19IA02cw8E te9ySMkQ9AclS4jQAexHHsqufU6KD2lf4Cyhhks2OkOuggiuMxfT4TJXa3yLbZMhjJ7B1iaWiKQ8LS Lr0uyF/6x8WcWXt1wP4PZrHWCWbUCPa5LwD6UQTlKRJUMd+WQtSUuVBjNlNjPT+1g4Ia4QK/LRkSJI 0M6waWvvV6jtH6n2WWM31zRydnhgYhiEuHTVoke+Y7T4luJcFyI17qzx2Fc3oEQEltZ+cmIllispVE +r/d7+pUEWImYZNZKGPODiUUMVjTh8euwxrpROsm8bDmoHvuEZwNB3Ql2doo5D7WRYw7YgjUx7Ko+T 0qT3zcpOfmBgIxB8aKhOFWrEMpkRH/6mThA1/NKm+hOLY/HcP/8awJ7RBr/SVl88HnyaNKyby3iSgB DLZyHIvquZHbm4EVMFa5J/JzA/KkVoe9oin/UrhKR5CZaB3GQVA7gHZ8M+FQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct uni_screen's
"lines" 0-length array with a flexible array. Detected with GCC 13,
using -fstrict-flex-arrays=3:

../drivers/tty/vt/vt.c: In function 'vc_uniscr_copy_area':
../drivers/tty/vt/vt.c:488:48: warning: array subscript dst_row is outside array bounds of 'char32_t *[0]' {aka 'unsigned int *[]'} [-Warray-bounds=]
  488 |                 char32_t *dst_line = dst->lines[dst_row];
      |                                      ~~~~~~~~~~^~~~~~~~~
../drivers/tty/vt/vt.c:335:19: note: while referencing 'lines'
  335 |         char32_t *lines[0];
      |                   ^~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 981d2bfcf9a5..b1445f00f616 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -332,7 +332,7 @@ typedef uint32_t char32_t;
  * scrolling only implies some pointer shuffling.
  */
 struct uni_screen {
-	char32_t *lines[0];
+	DECLARE_FLEX_ARRAY(char32_t *, lines);
 };
 
 static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
-- 
2.34.1

