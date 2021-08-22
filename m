Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB2C4320A
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78456126A
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhHVHwX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhHVHwM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E8C061764
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k19so12611589pfc.11
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NkVqVqmacCPFQLHisTBuXWwR3jW59S7tqh7b68YAP0=;
        b=VOieh+oz3krAsmemd8JAxE1OW70YdjtHtradb87zdngOEGdc3ijk6rT2jnRonEvnZq
         YI5OkUM9gPL+0QTQlckQuUpFmIgAfJzHphLhykalozxUpyFg+gY685TB4rtiQGYDN36L
         LtGLlufECPHj3O/t5xK2UrJl27thlTi7+jc+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NkVqVqmacCPFQLHisTBuXWwR3jW59S7tqh7b68YAP0=;
        b=LvR4P+ZSU85nMi6pnd+0xYZ38BIaGZ3jpQyq/daBD+59HpTqcYDV333uwN1qLDX0W6
         XDrPbtvECVQhw6a1tVhrNzRAbDKocYWNw/WGlAIx3PqvEXFlL9Kf1DMTNbMUS1rncwuT
         9UWvcpwN4dJLKEyj2s/Auc6VcTLnwFvOepwEW0ys5zEzKdelLiyCq+m2OIpxMZoYoloo
         u82i2M15OanbqE/0IGMacBKHoafIbRM5gRgk0lG8uFFs17X4wbKsoHvviUGEh+kAf8yQ
         GcQ1Woh1FVv21jossYHw189i/e+gzyNXZSfGD/fPtYRjJMGaf/PKCbTVcYbFwE4tKshl
         grzg==
X-Gm-Message-State: AOAM532VW0w5ozocl6Tc3b19/ch1v7dZar59/NKrK3DfwNWnT/4MX0J0
        5oCdcE8P+XxglS4fXGQll3xHfA==
X-Google-Smtp-Source: ABdhPJwWP8jaiAQuxTM/c9lobxClDZOjQaaNTOFC8XZ6RjfrKIPxhZmwpqTJeuKg9E5tfh2wRFTbaQ==
X-Received: by 2002:aa7:8683:0:b029:3e0:9a61:b505 with SMTP id d3-20020aa786830000b02903e09a61b505mr28699813pfo.10.1629618691176;
        Sun, 22 Aug 2021 00:51:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ds6sm15863866pjb.32.2021.08.22.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Joerg Roedel <jroedel@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 07/25] iommu/amd: Use struct_group() for memcpy() region
Date:   Sun, 22 Aug 2021 00:51:04 -0700
Message-Id: <20210822075122.864511-8-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; h=from:subject; bh=UVbvWOW7x4MKaEbPfdgMN6YucCopn2OgnRsLaMXPm6Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH2VqtN1ff5F4pCfQC8LCAMeT8BUlql/ZYuegnS qqE020KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9gAKCRCJcvTf3G3AJt9hEA CPyxXUooiUxHazGTqO7twmxywSUXadYscq6cu7BwlM2up+ktHuyDjJooZ0wPB6MlYD0IMvKRihjXN8 88gxtASTkKCxkAXAhKwAXE2cR055izczBy9XbCIhg/0ewbMZVc2NbZt6egkIQesda6Jk+qIrgbFvJT MCxtR/C5ywqKO9RWKE/YI9djbRJYOUdEnYLIz6TRUs3MAttcW/kwX/p54qvRmAGv5mk2sPSfGSXdTW +ylLQ55kBYE2W2U8vaGTYWd45RSuk1ckm7OBTHXeOPSw0YIRfec5RAsrlUiin5DRCoR0FhTs3LiHZ5 LtsPogWji78cnOISRH3il4zZFqyTJ4s39/cEqRCRvTmhaCEeec2gg7JnXpEcPKJ2RXWpvPtk3BCuaW rNYlu9VHVa/tD6dT0vMxiRd0jho1/hn/PXD5JFx+eSgJYogLZz13Pk2avyQyVHLptwIq/eHMDI6nr4 X3viZBB3ToUbqPEv5XPItaLZW4s78+g3N3xqZP2bGEEwfoZgYQI4yri0GlLVgONhK2KW6lzsPHclaY IdIfPtSEuMheY52Ku6RfAAKd0uu2ROYg37+iUZKXMpEOsoiiKr3DklFKYeqr1VStjduXfJwki+102q uiwLIFstLYM73b6NC3iogqIcMnWPJLLgqAszJ/70pj5D6as6xqOooQXgOxIQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct ivhd_entry around members ext and hidh, so
they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of ext.

"pahole" shows no size nor member offset changes to struct ivhd_entry.
"objdump -d" shows no object code changes.

Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/amd/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..2df84737417b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -121,8 +121,10 @@ struct ivhd_entry {
 	u8 type;
 	u16 devid;
 	u8 flags;
-	u32 ext;
-	u32 hidh;
+	struct_group(ext_hid,
+		u32 ext;
+		u32 hidh;
+	);
 	u64 cid;
 	u8 uidf;
 	u8 uidl;
@@ -1378,7 +1380,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			memcpy(hid, (u8 *)(&e->ext), ACPIHID_HID_LEN - 1);
+			BUILD_BUG_ON(sizeof(e->ext_hid) != ACPIHID_HID_LEN - 1);
+			memcpy(hid, &e->ext_hid, ACPIHID_HID_LEN - 1);
 			hid[ACPIHID_HID_LEN - 1] = '\0';
 
 			if (!(*hid)) {
-- 
2.30.2

