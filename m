Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B6C83F3E
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Sep 2023 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbjIETPW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Sep 2023 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIETPV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Sep 2023 15:15:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8ACCC3
        for <linux-hardening@vger.kernel.org>; Tue,  5 Sep 2023 12:14:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-56b2e689968so1506727a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Sep 2023 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693941221; x=1694546021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TXgvmJLu+K+I9kZcFR3KfNae3WSDNL4+bYanlcn9kg=;
        b=EHnvBvBc+85KhToee5+QdAwZlObPsALVVB1emcmJfw6BLjwKbxMGDupm5kWtR48XHc
         4m50b0JYmtEMqAk1Pe90ppixnQjGn0LEoMPICt0QagNsLA8mr3aNRYC5Yit/Q6Mt3nnN
         PYQO55kIR5bsfJCCkMm7QXu1CNyzzTQlqi6TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693941221; x=1694546021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TXgvmJLu+K+I9kZcFR3KfNae3WSDNL4+bYanlcn9kg=;
        b=E3A04z31rV1RNJ0qgu+mEEWGuZelaDgcM+wu8AWrZoeUte0OlNMYomP88T3OKWy9Rn
         ZMhXGYOZ58o8N+GqTnXnMRnpv2Gt0RsjDTgiNh3VRaBzxCVCVlJYPNWndhZZKzensYYw
         kHzBRRyVcz+b3/r+Vy7tiGDXXAkR7nhEVKKXqLOpEAtAcAuAZlWG02n1NsbNu5AOQ0sv
         RHlPD28N3bSbwcW+91szmScMdBquGk6fSeY9egd3c4VyIdEnOntNoLd/2vp3g4E2JsAl
         dqAl2T98cEu6waTKTiHuQbKSpbjADg4ISDKx7g6HnOiKgVfbyt5CcbKzeoUCQsnaI0Tr
         hryA==
X-Gm-Message-State: AOJu0YzpriAgiV8mrQsTNAbhaM3zkIbqs6ZwwKF7swyPbkeyAxFjk3yo
        eSDqGdEEl3T4AL5e5gOJMxqvgA==
X-Google-Smtp-Source: AGHT+IEUIHzj4gKawoDNkJH8MjO1eQQeCwXX59tDRQILYoHaf4f+zWYoobJ4Rh/dDipZrN1hXry2fQ==
X-Received: by 2002:a05:6a21:3b46:b0:140:4563:2243 with SMTP id zy6-20020a056a213b4600b0014045632243mr11481977pzb.50.1693941220744;
        Tue, 05 Sep 2023 12:13:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78097000000b0063f0068cf6csm9385016pff.198.2023.09.05.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 12:13:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Johan Hovold <johan@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] module: Clarify documentation of module_param_call()
Date:   Tue,  5 Sep 2023 12:13:37 -0700
Message-Id: <20230905191333.never.707-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2525; i=keescook@chromium.org;
 h=from:subject:message-id; bh=2gl+o4SRoHaQVcttgjZhYq0Is37kI1hlnwzbQN5zDGg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk933hZ3IhiyCBUuiGWz5YX9hla+CnKgiWgcUhX
 QCafDdP062JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZPd94QAKCRCJcvTf3G3A
 JoQpEACXWjlYTg6OiUiUpym5wEwvwnUewYnpahiHOhonlgfgSaPT8XpFDWuExVJs40vbV7V5R7Q
 RcXJBxgn/8VTQXvwk02VLL/RYODT0LWwCxJMlQGCmtoQIHzFoedX748TciV2ThFfW4+nSfg26HL
 1vCjvpHtVYotnDFevFoC3H4WUa7BSVI7TPobreLBJ+Lx6CdNqUvjDmKf9fQlaA1TEI6oHYNEojj
 BCjhzwceuYX67/ulaePn7AaH11onT1C/B5exrHK+RaK21uYxQrf4lvadp+l7rOzfryGGSiZQJ/d
 NhafNovhIRVs3zfKSW3KJH9cKHg2qH5atIzIcnL1L2BwTcleupVO2kIFqO8Tu3xbDrXFPLc02dp
 kxUaNSajibzTD5jhRgoicMsUOnfJWgYG/EsHyAP0XtEpCkYa7gizT3WAgryhp/vio6S4u0FD0wg
 7e8A0IRcsHUdyjawKOG0lgDZk6Mx0G7zCjYlfsr0NAhbMGL6PvA+/WXdwQhHN020W2SCpbYSqud
 uPt+95gGr7kgNAB4Xsxbw17ZWrcoplrhc/Eh5TqMNAFrox0zrGzwZgatT+nEyo8jQoFfahC7uiL
 6q3XJQuPPl8qLfwo4ediBtsk6aloab94SotaUkjmvsb0tBgWrMQmGZd/ivfkYIxO2zDUtxOr6F3
 rVzJura wS6eE5Eg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Commit 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than
get and set fns directly") added the comment that module_param_call()
was deprecated, during a large scale refactoring to bring sanity to type
casting back then. In 2017 following more cleanups, it became useful
against as it wraps a common pattern of creating an ops struct for a
given get/set pair:

  b2f270e87473 ("module: Prepare to convert all module_param_call() prototypes")
  ece1996a21ee ("module: Do not paper over type mismatches in module_param_call()")

        static const struct kernel_param_ops __param_ops_##name = \
                { .flags = 0, .set = _set, .get = _get }; \
        __module_param_call(MODULE_PARAM_PREFIX, \
                            name, &__param_ops_##name, arg, perm, -1, 0)

        __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)

Many users of module_param_cb() appear to be almost universally
open-coding the same thing that module_param_call() does now. Don't
discourage[1] people from using module_param_call() but clarifying the
comment: module_param_cb() is useful if you repeatedly use the same pair
of get/set functions.

[1] https://lore.kernel.org/lkml/202308301546.5C789E5EC@keescook/

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Nick Desaulniers <ndesaulniers@gooogle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Luis, I note that include/linux/moduleparam.h isn't in the MAINTAINERS
file pattern. Perhaps you want to use include/linux/module*.h?
---
 include/linux/moduleparam.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 962cd41a2cb5..d32450583182 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -293,7 +293,7 @@ struct kparam_array
 	= { __param_str_##name, THIS_MODULE, ops,			\
 	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
 
-/* Obsolete - use module_param_cb() */
+/* For repeated _set & _get usage use module_param_cb() */
 #define module_param_call(name, _set, _get, arg, perm)			\
 	static const struct kernel_param_ops __param_ops_##name =	\
 		{ .flags = 0, .set = _set, .get = _get };		\
-- 
2.34.1

