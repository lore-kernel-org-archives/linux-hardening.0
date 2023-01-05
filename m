Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9FC4708E
	for <linux-hardening@archiver.kernel.org>; Thu,  5 Jan 2023 23:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjAEXqG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 5 Jan 2023 18:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbjAEXqF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 5 Jan 2023 18:46:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A50E0E6
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 15:46:04 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jn22so40968861plb.13
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 15:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixmy6mGcgoBkvJjym9GQ9iC/bNIzdQTH6bspDgeDvy4=;
        b=GQGTpbZ8i0H+pQVuEFS/65Vxh3N38d3B8Qxa0GhO13fYdDKPLvvcDpThsjFzLgM3iN
         HqqSkAojzTJ1ZyfI/h4Zf+xjZKbxsjbwWQnvxDePVyJWrCGpv9CFrDDTQBEsvMy/HxmT
         X6Xrpxmz7XzHy8xBw1arDnEJJ7/R1G+IWVPzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ixmy6mGcgoBkvJjym9GQ9iC/bNIzdQTH6bspDgeDvy4=;
        b=kmWlZAUuztMCmZfxKYJqz1u57a+Sk8LVhUejS3SWQ4gCugJ4rm1wA02+OmJH75AHWE
         oppX9pR/ixqF0omorTyNZfbJpX5m4aRYUGz+VsA2oilw83jNqn+WbGYLVVnczGrfSuEr
         PhLQk+kPi2wzca96xaTlkTsbGpQknGms01YPvHh3gN+meWb3i5IBAL8Z/vRmEK//5hkC
         NYsGvxufwStq4/OYvkWjFzAeNM6DmPuMc9pEtSKJvHVCD2nbVj3ryVLozX/w0QeCZCwt
         mmJqr3rNGrLeV8FmyqB8xNWMwNyaBMN14PqmM4jyh4EeZ1IeHjJLjvZ5Ykac2Hcm11KE
         iLuw==
X-Gm-Message-State: AFqh2kreoeVj2IqX+SQroWM460Dl62RUOuCadn6TrSpEm4UIE+wbXI5J
        V+Zv8domtip2h4XHQlRQu7eewcMg394DoyTx
X-Google-Smtp-Source: AMrXdXsQ29gxsjUu8TwAEiufSQwno9s8pvZUaHEdBElLVjiWT9haDQNYooObacLrznyAr376FCbTXg==
X-Received: by 2002:a17:902:8698:b0:193:a5b:ccf6 with SMTP id g24-20020a170902869800b001930a5bccf6mr1196588plo.0.1672962364271;
        Thu, 05 Jan 2023 15:46:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b0019258bcf3ffsm26402243plg.56.2023.01.05.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:46:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] net/i40e: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 15:46:01 -0800
Message-Id: <20230105234557.never.799-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; h=from:subject:message-id; bh=7oqp1H8bnjca8UKRWJizcoup+xvwTPIAvLIjStmgIhg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt2E5B/QBFZKrXqubEBxJWkonAnCaVOq5GJ3FscS0 OD9vd36JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dhOQAKCRCJcvTf3G3AJlTVD/ 4hn023GoXsD0/jMdOjvZG3DjtedIRTLFclHpsVnAfKSEwTg9hkk/Z6AHKcCC/WsDyxnUfMCXmW5jZz 8ziYYoZzJHtBy0M7wBUgzgxwdH9sOgg94Qj9AEj/ovDnfjJNMSSrorxm/PJre/U+RT3Hb9X3/W09I1 Y1xRSvrO5TTjHUAOP90f7bnvp5A0BQ6uQ3RL6C0eOxSTcrVxhrv4pJiGYpRqW+xAa6dPkuYnw+zzwl 0ItMswnDOsTQytcjgtcPqRqw7pmH5vzyGRzwkVo5V2TnNt3skeKNBMTfxnXrF6yOE1AMbun+X6rNzY R2XlShoDgfUIYEb7VF96k2Vwg9mF8fM+g0jC2iZjqmERyDj1Mnqu6s145AMUOv+z2LNUS3LvvF5xZr 4+zoKrc14NELHWb1CZ6lCgBz/uyc9K6vGWTGTvLV080sqUd54uqJ00veOOAZRLij6afsCdGiiIzkZD H3Q860ipa63ykgKuAmxBGCuEyaWmzWO8NAyLN42H/gqOsV8Ydo7hpyWDOlDr8rvzmsq7XsZuMyLVib CXLtVIl18PrWLD4XpRayzh2gnMiIVnii32h496olyVC6QmZ9KKmM3zEhhoWojrFNclPf/HdZr4V+5x gtdYTagMrjmZ0n/yK08TAFqvMorhfXCKn5GqRMGQ90A5mg4MbO3wFzI/L8VA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct i40e_lump_tracking's
"list" 0-length array with a flexible array. Detected with GCC 13,
using -fstrict-flex-arrays=3:

In function 'i40e_put_lump',
    inlined from 'i40e_clear_interrupt_scheme' at drivers/net/ethernet/intel/i40e/i40e_main.c:5145:2:
drivers/net/ethernet/intel/i40e/i40e_main.c:278:27: warning: array subscript <unknown> is outside array bounds of 'u16[0]' {aka 'short unsigned int[]'} [-Warray-bounds=]
  278 |                 pile->list[i] = 0;
      |                 ~~~~~~~~~~^~~
drivers/net/ethernet/intel/i40e/i40e.h: In function 'i40e_clear_interrupt_scheme':
drivers/net/ethernet/intel/i40e/i40e.h:179:13: note: while referencing 'list'
  179 |         u16 list[0];
      |             ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 60e351665c70..3a1c28ca5bb4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -176,7 +176,7 @@ enum i40e_interrupt_policy {
 
 struct i40e_lump_tracking {
 	u16 num_entries;
-	u16 list[0];
+	u16 list[];
 #define I40E_PILE_VALID_BIT  0x8000
 #define I40E_IWARP_IRQ_PILE_ID  (I40E_PILE_VALID_BIT - 2)
 };
-- 
2.34.1

