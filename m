Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B58C64E96
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 20:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354886AbjHQUfV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354950AbjHQUfG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 16:35:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC22698
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 13:35:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbff6b2679so1833355ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692304504; x=1692909304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPpoBFJxQV1FmnNA1ExO85wT7EFUumxKCY6/YfojRcg=;
        b=bn/SNk5ZryeOs6MsIqm2lPBXN41cDb3/QGC5P55X004CdeqSVSCRdatZAzBcEcjYdb
         stwp4R+ewfJ7JTwLIqwkCV3tJiLzizVt84HuBYcgnJFtcFj0GJQTBLyc7oWoybuMwO8x
         2fywOflA9vdtzdBg5fkUjF++hib8hmkvldui8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692304504; x=1692909304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPpoBFJxQV1FmnNA1ExO85wT7EFUumxKCY6/YfojRcg=;
        b=jlnkEk/16h624nHbTGnFHOWvSUO2n50yTKXeIO/G0N35eW0JHIa58VK3yVHP52iJRz
         WKeliIY7gr2wM4ukUjOGjxY4goy6AqkgErpXF03Qknt9QrbS0mrREtRR7Kig6g1G7K5H
         gVQLnDQAPVsqQfQWlo0VxVk3Cxo7MYhoL1EaGaRKa0q+Z/0JiMF7EBOxIR+Sedmh0omu
         chQW037XF+loCTeYfA0b22uhlOlZ+pn2HGJWpJlVO9yy8H4AxFCwO61HoTA0MuUvy/qB
         az8KDqBXYABqdUUpFiRWDCz28REO0qcYixqywBLETz6LkZbPsEhPVeiKisQTBWq6ptBh
         b3JQ==
X-Gm-Message-State: AOJu0YyIntBIfh5fK1t2kt50ZbKsG3YNBHHkM2BvXarPMSpr0M+pHjAe
        Ie9EoetTC2b/lp0WcWIpjkw7qg==
X-Google-Smtp-Source: AGHT+IH/wjlRQwIcUDu6P8dS8WNcBHV9BkAXgGNUoicxFSF2suKwOUVA1FxwnyK44BV7mv7sOy9Glg==
X-Received: by 2002:a17:902:ab49:b0:1bc:50f9:8f20 with SMTP id ij9-20020a170902ab4900b001bc50f98f20mr526235plb.23.1692304504393;
        Thu, 17 Aug 2023 13:35:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001bbfa86ca3bsm190173plz.78.2023.08.17.13.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:35:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>, Eric Paris <eparis@redhat.com>,
        audit@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] audit: Annotate struct audit_chunk with __counted_by
Date:   Thu, 17 Aug 2023 13:35:02 -0700
Message-Id: <20230817203501.never.279-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=keescook@chromium.org;
 h=from:subject:message-id; bh=iQE6kV9vlsKmBgzVzqmUF6+idqkcwdK1Cb4L82t48W0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3oR1DKnpFvGMUs179JIA9Rss1/2X8NIbWK6tU
 Cp06TDi2MmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6EdQAKCRCJcvTf3G3A
 JpthEACZY6Pe31vgMRPz5j3xTaeQcZBYjzW4t81pvnkFt09XCmUhXE52Luo096CAIoh/RSN2HBC
 M99jsYStbgG9+65HFqlLEud091NVpH+BcyJhnPQEhjBu5wgClO93nLn/iHrD7DMUKK96p+Oozt/
 d01G4YPZ0WyQH4xuCKfdg5Tpp0AsusCwJcKrBTKkbE4+4nPH1jLfiNGA2hBk41cZtMXtobQUqik
 DnaL7akmF/2Ao3Hun+2GJ/K5eOkJcuuUuqSg2xgsrujou0sDpk5WaeCw9JeyHVQ3io9B5uE37Ub
 lxfsfQHAnQhfBdN116TutiuE8lyHg8x4D5+g2aUQKEBLWmwSRCS0UgtDh11vXC5A6mW/SEyXw5j
 G1fdPaxWys+MGFDr8rbC+yXMK5dlQ4lB4lUwULDhyhfnRgCMdsHHuoY6Qc4mLUN4627S9KxJV0g
 t7V2HNe93Ki9UBhN+WiuJQ+vM4ODPpyXhOVNhnhkrQDP5we6MvSa6f8PAhT0yVELMLk2ZgXT1YU
 1TWfa8AwbwPqP/kbMgsfXI4mLjArAv/pVoMMN31Fd/W91MBoJXB0fY4UM0pPj2TARRKBmD9WSdp
 JyfjvHrUk54mJO6M3ygE84qZElWrMvHvbMBxM4XqFzAkpOj3QgdaFVXw3kCW8ermdyVINeTD8yu
 pcmHcWm L6nweQag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct audit_chunk.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/audit_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e867c17d3f84..85a5b306733b 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -34,7 +34,7 @@ struct audit_chunk {
 		struct list_head list;
 		struct audit_tree *owner;
 		unsigned index;		/* index; upper bit indicates 'will prune' */
-	} owners[];
+	} owners[] __counted_by(count);
 };
 
 struct audit_tree_mark {
-- 
2.34.1

