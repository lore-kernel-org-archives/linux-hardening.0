Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD79C77B7A
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Jun 2023 22:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjFFWYx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Jun 2023 18:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjFFWYv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Jun 2023 18:24:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BCE1723
        for <linux-hardening@vger.kernel.org>; Tue,  6 Jun 2023 15:24:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso5491414a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 06 Jun 2023 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686090289; x=1688682289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmYAsitdtMiuxTmfa+3Zf9OT+yKEDPZiNHHq5YozUWI=;
        b=ROVGk+6F+Jqwoek6VhTyqEeBcpsOecTn6Zn92661yUpP1HszcaLVvP3nhcHLfyDZE/
         jtnAbjb2WSwGOUjNCZaNLx5EuhcMuYKFv7BXoD9kY7qguYSaS4fJpbLUU9ybovI8LKAh
         msStxmrKPdoBhGmM4yB1blT9H8kphUHuNtHH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090289; x=1688682289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmYAsitdtMiuxTmfa+3Zf9OT+yKEDPZiNHHq5YozUWI=;
        b=WiEdWXDfhMF9YJcE0SYWqUEcQ+BBPnMx6tCBPYFtmFLDHeowWDM93777oB2Ams0v9k
         cNorQplZggXL10MnC6q4zxuz7XL3tYVMMGz0oHxqY4CbMMnwztSruq8sqnwUty9vM2m1
         j2AsI54NRL2V8yyT+OrEZZTxt4esNm/EHsVO6M7/MHcCrq9Ce6NZq4q6YWFYNWIFc6rY
         JeiUrGD+YAsUQg5mCKRztF5GBsWd72CMayHB0H6FI/ZYZSiTbC5RGPk8qMgfOtjBi/TY
         7J0gCmd+gJLsjXygKUexS9EI8zpX9Gnl+Kto77T+uSGGJmEq/0CfPHBvfLIAs5XcJNG2
         Tykg==
X-Gm-Message-State: AC+VfDyl83DGL4QIwd2ZVgC9xc5jqh5t6O1ZFhuD/Y28KElh66enVr6c
        YBgO9Sqvfyq4LNdCPZeRaccuJQ==
X-Google-Smtp-Source: ACHHUZ4zPusBCkS+Jt6n18avQIJZKgOsH8rs4RswtrWTkv8F/W9fguJ2MfX39FjUb8AgvAw6Q2QiHA==
X-Received: by 2002:a17:90a:3e09:b0:252:75ed:eff5 with SMTP id j9-20020a17090a3e0900b0025275edeff5mr2928439pjc.30.1686090289275;
        Tue, 06 Jun 2023 15:24:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a19db00b0024c1ac09394sm46493pjj.19.2023.06.06.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-um@lists.infradead.org, stable@vger.kernel.org,
        Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] um: Use HOST_DIR for mrproper
Date:   Tue,  6 Jun 2023 15:24:45 -0700
Message-Id: <20230606222442.never.807-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject:message-id; bh=ogdQalFf0y8pKF+gFHpZjTpG30jr8bbKm5s3B8PiBPc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkf7ItfCmLvYSeW8Q0gwGur9gz7W1IjcA39mfgRnT3 Y2VehlGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZH+yLQAKCRCJcvTf3G3AJpg0EA CojcAOCPQ4kzRxyVY2zE9OQL7dtTvYou3N2RGCBrrY6XKQMNwVof1zv1P2XR9bBnJSIIqotgDPPX9a aZ8XklK5ixysMuMgS45QPl32SnitUOCrARbo0/4DCDFd27VE3mlJvTAhXoRNKftEjdyXhpsDS3I9/H cmD37lTsNrro9oVy5xIO7DoOujmzYspW1oNtNGk/gDgjIiW0po7I8PO/n7Mqj3mKAfV2ljoWW0uvK/ pNQ+Zw4to8OaupHJaowdB3UtJ4zU7MgSG8xaZiWI/EY0QxcgIn6FmEeCJ0Md7ka8TviLNU4IXCk8Yx ReSSRAaVMHAg0hy+WEVNwpAQ2iWYf7gJk+EXMKZVgR9GYXiIbK8fMTzCdmtwg7xMCZpch0YItprXg5 aN875T/ca4liv+bOWM7IDM5ewm82F6RSLstr5xi2nLAHOKAo02TZ/0XH2LeJKEv5kWcXM8dmYILIQM X5PsdWPO9MHzP5MRwn+3fYyjRJPLzSCf6rFDlY2PbB3xYAq8QNXeGGSKJsqUKYtH3KY3WcgpitgeFq 8m7TPtzspglG6NewHGgkpx0PkMNe+eKOvZfArtuI7lWMTglwyBHgvnSqufzPWHsidotD7knjuTgFea vIrkaOavqki2VfIW/X986U8J3Ws6mrSVudV9sXnLm3j+CZ3aIJKxk4hIr3yw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
list wasn't adjusted, leaving SUBARCH as part of the path argument.
This resulted in the "mrproper" target not cleaning up arch/x86/... when
SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
instead to get the correct path.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-um@lists.infradead.org
Fixes: 7bbe7204e937 ("um: merge Makefile-{i386,x86_64}")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 8186d4761bda..da4d5256af2f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -149,7 +149,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
-- 
2.34.1

