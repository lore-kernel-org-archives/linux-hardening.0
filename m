Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16BC38A02
	for <linux-hardening@archiver.kernel.org>; Fri, 28 Oct 2022 21:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ1VFm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ1VFj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 Oct 2022 17:05:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC1F1CC3EC
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 14:05:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j12so5875251plj.5
        for <linux-hardening@vger.kernel.org>; Fri, 28 Oct 2022 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbG+joJhW13ICEQATRvk2jVajs+23JH7WSAE9Sl6s74=;
        b=An9U+PdiR2RPLoTfUHeskFLBzEunyHkeMy43OFSc8/zKO4YzdaCJ6EpoSOw9a7K5vm
         c6Mpya39uJYv3kierrZx7ih26bloGcP3bVynfJFEJcGw98KxwSVqP2IC7jl7E4sYwsvJ
         xDmK+uYi8Im2qO7uL08zlQcuU32tt9JJu8qbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbG+joJhW13ICEQATRvk2jVajs+23JH7WSAE9Sl6s74=;
        b=MiPPFZ8EP8Sjk1kpwsZqLMDHXDN0ExO9APvBtivMXTKm4ZwxiyJqvEsjKJ3qlZozMz
         8defuFszT47fbeFiCyTPCvQqUMuKtlZlsEFxjMIpjQm1DJX1BSIAl0/FNAd8Dwtqi3Ap
         e/Xc51MqUJxC5hSsVXJBfU014uvSIujPdusfkNRYuAhirnL69XrPegc+KmiL9F7Vww7t
         z+PabZLMKvuLko5bJr0nRpWMVIJWT5M5/aunYs8rHn9qxRb9qePXmrcq9GVoJ4vDgmHj
         iYDlcZc3F+YYasH1ZxzQ7YNLkmYWYNOJ+rVzVG647lwIgF0HD3OH2lSmA7T+sJGQ8cW9
         PAWQ==
X-Gm-Message-State: ACrzQf34IMaELfSlj987Ja/dM/C/3i+5Gu2jXL0Txj9FKiF8aTMkoWEI
        TV82N6rpfL/3/qgZkCggqkiFcw==
X-Google-Smtp-Source: AMsMyM7Gpq7hs7SM9H9SpAZ9uzOnXai7J2oZsECngNraVo9RrbOMMC8ZpBg/apSzpNtcfAoXotQ9Uw==
X-Received: by 2002:a17:903:22cb:b0:186:a8ae:d107 with SMTP id y11-20020a17090322cb00b00186a8aed107mr906420plg.119.1666991135725;
        Fri, 28 Oct 2022 14:05:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z67-20020a626546000000b0056b9d9e2521sm3357311pfb.177.2022.10.28.14.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:05:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Date:   Fri, 28 Oct 2022 14:05:31 -0700
Message-Id: <20221028210527.never.934-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; h=from:subject:message-id; bh=ILza0IrVcn+5fiTi08w+F9FLzCzRxX9WFGawgrZ8WGE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXEQbEtaPeJagj8L8AkGXVIb8P9iDWp7xNpOmvORX jcng6L2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1xEGwAKCRCJcvTf3G3AJrMhEA Cab2XKmn6dUMgLbSg374bZ0FkcXtmDKg27YT/1oy/mWOqIhmyL11BWkg1dvgenL7FT8Mo50wP/vHmL rOR6Qo5AjNEgDDoHuC+EvUjjpAwLyAUc6Ez/JmH7LLnHaapNIJaq8U91Y2McMc8BwK5/pOeC9U3iOh WRSCDT9vpNGwFmgRl5HlWRo3fk523gbTeoZe71AFCeWzMRfNf6/F+l8nEbsPFDaXyL4gJNiZbU484T gM8N3oA//+Bz2HJsx1LTGUYkT2vcncbMBjYq/tq+jUagVsAN+uqU8gL3g0UcBBrilpJavJjswlV9kD LeyFI1t8yD/CDnSG1bD9oRdls/iuIcVZzRTAWd0AHKsKTRHQhYPk6q9DyKcEZUgNbapDH7LQqos4f8 7gNxFvpWHuqFgqkhlCapmStVki7T2gELa/IXmL82+tO4v20hneYGmo5zryxy2vT6uYw8Vy/Tiot5NA jruIoyAKl0z2WL7V8ybdPuMLd2+bkCy+0u/2+InQOC+GbNgPADwjMVWM7gaFDUdee+t/yhVauVCOcS ooLbxyHvMjUQIY6iwT7fM6VMPFXs31In/8nyG6q814Q1kNP7BTQXdz6JG8xHup2n9uY/A2qwJglEKV IyOzcBiE+zpkAkMuxA4sFmPVKksItqXdE0LbGoeIV1Ep4OwhJb5SkwE2y+eQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

GCC 12 appears to perform constant propagation incompletely(?) and can
no longer notice that "len" is always 0 when "data" is NULL. Expand the
check to avoid warnings about memcpy() having a NULL argument:

   ...
                    from drivers/crypto/caam/key_gen.c:8:
   drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
   include/linux/fortify-string.h:48:33: warning: argument 2 null where non-null expected [-Wnonnull]
      48 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
     438 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~

The NULL was being propagated from:

        append_fifo_load_as_imm(desc, NULL, 0, LDST_CLASS_2_CCB |
                                FIFOLD_TYPE_MSG | FIFOLD_TYPE_LAST2);
...
static inline void append_##cmd##_as_imm(u32 * const desc, const void *data, \
                                         unsigned int len, u32 options) \
{ \
        PRINT_POS; \
        append_cmd_data(desc, data, len, CMD_##op | options); \
}
...
APPEND_CMD_PTR_TO_IMM(fifo_load, FIFO_LOAD);
...
static inline void append_cmd_data(u32 * const desc, const void *data, int len,
                                   u32 command)
{
        append_cmd(desc, command | IMMEDIATE | len);
        append_data(desc, data, len);
}

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202210290446.qBayTfzl-lkp@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/caam/desc_constr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 62ce6421bb3f..ddbba8b00ab7 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -163,7 +163,7 @@ static inline void append_data(u32 * const desc, const void *data, int len)
 {
 	u32 *offset = desc_end(desc);
 
-	if (len) /* avoid sparse warning: memcpy with byte count of 0 */
+	if (data && len) /* avoid sparse warning: memcpy with byte count of 0 */
 		memcpy(offset, data, len);
 
 	(*desc) = cpu_to_caam32(caam32_to_cpu(*desc) +
-- 
2.34.1

