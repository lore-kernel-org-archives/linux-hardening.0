Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E557AC43334
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 05:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358050AbiFPFXU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiFPFXT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 01:23:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702D5AECB
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jun 2022 22:23:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso4876169pjb.0
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jun 2022 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLwzCgeGjXvkAY0tAtafYy0s/ZAsW8+7L0BV4I3ZRUg=;
        b=i8Jw1IH6VUEi8KQMpX04rBSHs+I/nRw4wm3Y2NqpACnSuZNIikRM1Va65bIlL0dXu5
         hPGvIKf2gWhtIzEglKPEDUPuCcORIewZlFTs62THn8BbuOVDWvIvOHzHL6UdnJpOpOhX
         lFK8gemR1etOaZjQJqzbACo7h0BEZyxqhDlIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLwzCgeGjXvkAY0tAtafYy0s/ZAsW8+7L0BV4I3ZRUg=;
        b=nUaYL/xmolig4cnVnnpnmkQT5tZnzCIE8xWvz0FXHIWDh2Eo4RhswiHEIroDFnLo1e
         R0652K4t/gLLVlw3KZhPA3/BPtoRMRg6Op37fOWu3jaXWmOtl/0KT3EV1eJMoPGyCPf2
         +4+9eIVujPTmhyfHc/PuZYSMG8tetZJJXSAUhZ/z49lb7JovawDfvIa09i44pFFIClQr
         oYoN7uBSQGFbfs7za2asEUY4K71ncuhUeGwn3poBbw/pegtZQwaQL8Rd3ruEYO2TQiZj
         eMbqPjQgkx20Tyk6Dt+lK5djuewx/+BBMFDycc8yqZyRWbnEDEywYIeZ2+AGyvT4YtYx
         EJgA==
X-Gm-Message-State: AJIora8Ec1QZPuAg9MtcmexCXzsFd/TmyK6Orxt+Uusn7j7qwQ/deuxB
        Mo/0xnekQjqkJs6zMkHNyyQSeQ==
X-Google-Smtp-Source: AGRyM1u00NqA+iuH3p4+18EEEFYx02PJPaeGYhvfU2E7xSaLD60jb9nETXZDYXN1yGmzsG5D6+UHag==
X-Received: by 2002:a17:902:f54b:b0:163:e2fd:10a5 with SMTP id h11-20020a170902f54b00b00163e2fd10a5mr3317916plf.28.1655356998486;
        Wed, 15 Jun 2022 22:23:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14-20020a63770e000000b003fad46ceb85sm613610pgc.7.2022.06.15.22.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 22:23:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@nvidia.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] hinic: Replace memcpy() with direct assignment
Date:   Wed, 15 Jun 2022 22:23:12 -0700
Message-Id: <20220616052312.292861-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; h=from:subject; bh=SFrVIRGfudjdjGzJlB2y9b2KbLEnr4pxj5hyTzo45+4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiqr5Ay+2HIbpwfOaEAdDeSsHsSYKH5Yf2peVuxbq1 ongVj06JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYqq+QAAKCRCJcvTf3G3AJlYcEA CxKwinqR9MKXCNs89GwL0DczM0vxhxtlpxJ91FuWhUzXCCDngALRjsFZmNj4UsT8EVD9KeyU/PRuwW RRn2ZvPm89zA5CRFtMbUR1C6rNEPw/yG4Q7c4+l3CqyBWnIVJIrF1cz5rzSzCwY+skVXETXdMiO58C DPJ8XWhLMmkMQKppoF8Htq42LVOvMCBXfPsA7JhbN7RpvfCzA3ExqGn5ha0eVsSRQV7JXhD4Hq5stU 3lkF3vre65Zqjcr40cQPtnqfSMIequXKQf59NX6njrWQY8Kh0Qs7xHTS1zxgY/1dIjTw662hodqLws okaJq42NFPtYTIbMwtTsNNECZH+nusLJhekyUw2eyJOy3bDl2g3GF4FVABz/3ZuB/jdi+RydACGzk2 IKjVBH2yBqS57w4sSoQTHGsGnCpADXapnlEgzQJWcW67qNc1zQLHVjJxIUYyIwll5sRbBp1qPm6YFL WSVb9islI6pDx6gVRhxohuNuZ1OlEC5b77AYL4hvopvrRlhk/kRt51AXEPfCsBC9LxRL+S6GRs3fJ9 I6cJGAiHZss2fKNH2Imjv65YnVPQIP1wLOBoIW820V6YAyQ7Md+v76lblglrlrwHWfm8SMwrH3yTxe U2f/TK9NDBYAXO/MEXq1VUJF+cyTnD42t0ZE3KHoUwd3jxLCUKC4V/JtiNJQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Under CONFIG_FORTIFY_SOURCE=y and CONFIG_UBSAN_BOUNDS=y, Clang is bugged
here for calculating the size of the destination buffer (0x10 instead of
0x14). This copy is a fixed size (sizeof(struct fw_section_info_st)), with
the source and dest being struct fw_section_info_st, so the memcpy should
be safe, assuming the index is within bounds, which is UBSAN_BOUNDS's
responsibility to figure out.

Avoid the whole thing and just do a direct assignment. This results in
no change to the executable code.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://github.com/ClangBuiltLinux/linux/issues/1592
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_devlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 60ae8bfc5f69..1749d26f4bef 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -43,9 +43,7 @@ static bool check_image_valid(struct hinic_devlink_priv *priv, const u8 *buf,
 
 	for (i = 0; i < fw_image->fw_info.fw_section_cnt; i++) {
 		len += fw_image->fw_section_info[i].fw_section_len;
-		memcpy(&host_image->image_section_info[i],
-		       &fw_image->fw_section_info[i],
-		       sizeof(struct fw_section_info_st));
+		host_image->image_section_info[i] = fw_image->fw_section_info[i];
 	}
 
 	if (len != fw_image->fw_len ||
-- 
2.32.0

