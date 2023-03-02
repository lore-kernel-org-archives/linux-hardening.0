Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D8C678D4
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Mar 2023 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCBWtz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCBWty (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Mar 2023 17:49:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFB23337
        for <linux-hardening@vger.kernel.org>; Thu,  2 Mar 2023 14:49:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so4312046pjg.4
        for <linux-hardening@vger.kernel.org>; Thu, 02 Mar 2023 14:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87r3ryuddMp2n2OJgEocLi5hCbxjRwWfqUz8IuAFVl0=;
        b=KJYLa2os+yE0S+tQquXclEo5UjbB3+Ix9L7t+KQV3eWYy49UoX7lkm4pdsI0DCG2xP
         1Zb5VEgb0JZwWKs5XjvOkNJmi2QFtZJxCjvVNdN4NIi6tT4yT1bRDmW6x7vkkY/W0SBp
         grxfEqQ+YXXSh+Uj6LgzHidfiHyt2I/MWu8XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87r3ryuddMp2n2OJgEocLi5hCbxjRwWfqUz8IuAFVl0=;
        b=oczITQ6YPtmdP+E+xWrA7hqRgFvfzhx5TmspLmnOXIs/X8D6N259d57O2TNc9lI0Kk
         aTlOlI3/32+TA46SNmy4McMmnUJi5daVLe3rDdKeX445P+FgkDnTMg20Jj1HBctXx8Ao
         2lWvdEvpmHXY0MsXFF/qB9KVbih2eumOuDZPOXN+7l42arqslWnDBgZiHqrb/sBsMip9
         K5FMYPc/kELuaR+zXjv2HRzHFZGKncC4gaMw4gIybJZcwLdimiZ9HTcxc+T2yiIH4U3Q
         CgozJvtmUTpiH437gDn198iYs8SVFmX8bbAObjxw7IatvG2y97R9eR81OXWk30U0ufZZ
         CNjg==
X-Gm-Message-State: AO0yUKWVIrhJc4FFlQmSHIMiYvKRfqmI9DQ4lCJ3ycqi9IxzWIlHgDHd
        gnNbkDf79StV5NH234e+3LDik2Awt5FafelZ
X-Google-Smtp-Source: AK7set8jKAerELLqXHm7NocBIiVApMHkGJPa8LPJV/dR2Nkty1/Zi+585lESapSslKGeBs+DF51TEQ==
X-Received: by 2002:a05:6a20:160c:b0:cd:1cce:d892 with SMTP id l12-20020a056a20160c00b000cd1cced892mr139958pzj.9.1677797393110;
        Thu, 02 Mar 2023 14:49:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b005b6f63c6cf4sm217194pff.30.2023.03.02.14.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:49:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kheaders: Use array declaration instead of char
Date:   Thu,  2 Mar 2023 14:49:50 -0800
Message-Id: <20230302224946.never.243-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; h=from:subject:message-id; bh=eLj/PflKjatP3hFY0i0HHeuMwWpjFzg2cBxv81U9QkM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkASgOFlZ1ftATS5I9PtciOtLxZpppkpTfsbekhvi0 AiYPKIuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZAEoDgAKCRCJcvTf3G3AJkeqD/ 0UKRxmCYQN06lvmilRYvIyKjBpP1mKZf3n4bjCclIFAOJ/ZLkeIiUPLMpOo34kP1jZOaaJapJsc3th WwaEdtGNaVCu8UyDipj4c1YBMdSYL1xekEJtkPnelZnDwEutxQNxEy38mpAgoCb541wlTw9w0YbPAi yyJa+NJI5l/x2IxhPwKD3F19cxe9JlWTBqC82IpvTUY7l9jxv1XcnM4ZJA0D5mlyDzOovN10GhQdVj aEPKTTjm8ifvUsuiODnrsguQPwwvoadopjqjwgGLlmxM9G6IfAD8F1zIWFo6XFsPfrxhRaQvO/bjcm GLXRBa3GPb0I05K21/lSkajRvk5xOfs+FSpF9S+PztoqgHOnI4wDRrL6zhdp7JzxZQ6IzVsukq1Xqe UUuvWc4OfJN2Q8j3Jkb4aq3NPpQPMnvOip9hlQdEpgRR4foO95+kX2XpQ3nK1uODIiDxCb3y+ScURs iI+/TAUPcYLIV6i59xNWz9yNv2kfisiAXVg5AQdf9jcJbJn6LhGEaW0GlpQc6ocYRRliSxzE91OD9l UKkvUONcTKTMx7q7/bUY+E+2qmFHnoN1HUb//TPtpO1Km4DypVSVz7flMS9OWbF8y6sX/eP2Bk1ceM c8dEuWg6AeUgSV0SwOuqvYletGKA8FxVGpvNRif+xcgiCXHeBQE6QmbVeyjw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Under CONFIG_FORTIFY_SOURCE, memcpy() will check the size of destination
and source buffers. Defining kernel_headers_data as "char" would trip
this check. Since these addresses are treated as byte arrays, define
them as arrays (as done everywhere else).

This was seen with:

  $ cat /sys/kernel/kheaders.tar.xz >> /dev/null

  detected buffer overflow in memcpy
  kernel BUG at lib/string_helpers.c:1027!
  ...
  RIP: 0010:fortify_panic+0xf/0x20
  [...]
  Call Trace:
   <TASK>
   ikheaders_read+0x45/0x50 [kheaders]
   kernfs_fop_read_iter+0x1a4/0x2f0
  ...

Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/bpf/20230302112130.6e402a98@kernel.org/
Tested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 43d8ce9d65a5 ("Provide in-kernel headers to make extending kernel easier")
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/kheaders.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 8f69772af77b..42163c9e94e5 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -26,15 +26,15 @@ asm (
 "	.popsection				\n"
 );
 
-extern char kernel_headers_data;
-extern char kernel_headers_data_end;
+extern char kernel_headers_data[];
+extern char kernel_headers_data_end[];
 
 static ssize_t
 ikheaders_read(struct file *file,  struct kobject *kobj,
 	       struct bin_attribute *bin_attr,
 	       char *buf, loff_t off, size_t len)
 {
-	memcpy(buf, &kernel_headers_data + off, len);
+	memcpy(buf, &kernel_headers_data[off], len);
 	return len;
 }
 
@@ -48,8 +48,8 @@ static struct bin_attribute kheaders_attr __ro_after_init = {
 
 static int __init ikheaders_init(void)
 {
-	kheaders_attr.size = (&kernel_headers_data_end -
-			      &kernel_headers_data);
+	kheaders_attr.size = (kernel_headers_data_end -
+			      kernel_headers_data);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 
-- 
2.34.1

