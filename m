Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728CC32793
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Jan 2023 20:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjARUYH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjARUYF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Jan 2023 15:24:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9805D91E
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:24:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso3345639pjo.3
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7nQ+g2J8OLWVvtfKxW9hliY4Yc3cv4OwnKnX3U91hE=;
        b=MhP7CFPKMusVUiw6o4PRowhujO/e8aU5sJEsYfnFGzwkO0eKdjfTpPALqtQqB5Zy6j
         4HhX1moUWoFgSiTgqdNnBCZ6fwdpJ4C8Af74LEg3m+WUiFaqrMImOxuHx3uDzpXXalR4
         tushRG6S03QNI9iVt8BOoggY9UMF8Cxi+zYGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7nQ+g2J8OLWVvtfKxW9hliY4Yc3cv4OwnKnX3U91hE=;
        b=WK59+Kmo4z5vhrmFT3FfuGRltv5DDCTDPPrspTTltfmWCITkeW+72iuIrjf4dpYGUR
         uQGsEtySBOcTdr6L/oioBzCQkwAVhYSuOS65Ue4Ik00ORB9+C+9I1aNBFdQ4zlH8614V
         WRLpS6bZX4sEVUK1Cf7y75wCSvcSbuygu0Mk+VZlXOVkB8+JPObYplSHfwh9xmBWpx8F
         pd/9BzZnAOUdzp8mt4uLt4E2Y7UnW057rnQ4GAYHOjSh2a/UHDFlKmZHKM/sBdfPRu/U
         Emn6Rkdo2UyNWqsqxDXibaMLSue21sO5LXfySu8dM4qRfH5ZL1Qkln0csjS6DNxDLX8Q
         XVIw==
X-Gm-Message-State: AFqh2koIRG0KN0+M+RkoTgHYnfAnSOSwsRXIjvMBe3pg2OC/MDvzi0N9
        oM9k1GQE2bbmj6Ym6NfZaW1PuQ==
X-Google-Smtp-Source: AMrXdXuvhtr6QYHTUipL1E7izXxzP6eU9ELvbbiqPHuu407BTk2+78EO8VAixW82hWCQezgP9BpVtw==
X-Received: by 2002:a17:903:32d1:b0:188:fc0c:b736 with SMTP id i17-20020a17090332d100b00188fc0cb736mr34331887plr.67.1674073444029;
        Wed, 18 Jan 2023 12:24:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001891a17bd93sm23667416plh.43.2023.01.18.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:24:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: Reorganize gimple includes for GCC 13
Date:   Wed, 18 Jan 2023 12:24:02 -0800
Message-Id: <20230118202355.never.520-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; h=from:subject:message-id; bh=vukSS8cdZdqqtgn6apidKMhxtj1t0IFOu1S+KhQ8h60=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjyFVhjOBNRZYH+UzANpQMnfOjTUf8wrb94vsB2GjK IDs1+4mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY8hVYQAKCRCJcvTf3G3AJmyREA CcSyhCMz+CA+i5K0m3iYOM2pKAQebVxf9SOeiSsHQ9qtRdv7a5z6CkN/4dhLFAdsSWkvEpnms+0XUp h7G4EIyluvBiJiLLXDusha33r5D26q/YU4jyPKPLBpRAnSG9NjYaQzhgZ/D5rdJZHfnFFMsRbNtUM2 fNoIlLb8dPW61nIg5aa3q+OytDBECibjwTGhfTRfKMCXTxSHQACjBshgbDZiFJjq3KQskjX0oaoueB rbnd4ZVAiK7cFr+Tl7mAqFIj0mfZ/GYFGvI7DTuFjSPlvrSCtNARfYN5JWT6jkdQNjkRChzbN7Wk4e t1oo8yy1+5Z4TatJUjAQ+MHPLTkG29N7QDn+tq3EN+PGbPgQxV9n+EgPv1S6oAw4/mNWVSqaautpSu aQTzy443t5hxKSBar1lgdimhQ0ftdCqgY2054yImNbbpTXWNDsJMIvgIlsXHpYUt/IBSqhudau5ey8 vnb073zDoc8LgAQSkN0a3SCjYfPNc7vqt+xoJuZVr5DZs/mpyTIA6STUfj9QJkiVfflaPqdAIaWC3f S2VjdKhhaFXnp24XgMKV43Cz53EiTQ1/EDN91PauJOI5LmHJb7AfX9vrtnmnTC3uFxJKwybVBVMEi8 0wjQFuS1iUmK4YrLAuqcXE/aA2kCRBRASAN/wkM2oNrPucr9pt8HJ4fSszkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The gimple-iterator.h header must be included before gimple-fold.h
starting with GCC 13. Reorganize gimple headers to work for all GCC
versions.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/gcc-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9a1895747b15..84c730da36dd 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -71,7 +71,9 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#include "gimple.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -85,10 +87,8 @@
 #include "tree-eh.h"
 #include "stmt.h"
 #include "gimplify.h"
-#include "gimple.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 
-- 
2.34.1

