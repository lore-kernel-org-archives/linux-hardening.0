Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6DC636CC
	for <linux-hardening@archiver.kernel.org>; Sat,  4 Feb 2023 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBDSg4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 4 Feb 2023 13:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBDSgz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 4 Feb 2023 13:36:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578392CC67
        for <linux-hardening@vger.kernel.org>; Sat,  4 Feb 2023 10:36:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so7168021pjp.0
        for <linux-hardening@vger.kernel.org>; Sat, 04 Feb 2023 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAB5zqOtRTM+RDMC22uUzCOEEgfCAs845CvOYJgQgV0=;
        b=FeFDrN8Py086U3MLR3GQUp8azy5G80k6MBLOWqnqbORgiStdrmb2cadC9VWVfS9Y26
         JbTzRfVR2cX8GH04erVBRYoTbmoJC4d/R2Uf9WWepZk3PVVJEQIK1/T01kXCCyDJC2Py
         Y04bJqIqC5fEPxMTpLAxPhbpK9MdZshquBGjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAB5zqOtRTM+RDMC22uUzCOEEgfCAs845CvOYJgQgV0=;
        b=fnjy9vGOENL5aowKuqUZbFsbTLIjrl2loscQQHol5yd7RD0c+Us9TD7rHj4jDxfnue
         sEi2H3thJhZNwJ8nGZkb+lIz/w/GCEzP5RY0jW728y8gkB4Kg/9V5i/6C8V4DPLyJc1f
         z8T/qXZ80CuUTwjzVoC2g/ZzFOAXIdx2x7kCKtK9p4v/8srQQNEeYO5La69OBhNQ1ucR
         ra1Gu0m9ooPC/pYsvfKfuFTcwpDsOxmuJwqj/FDm8ITcM6aBpy8OutW0XIaCAKGXkLJe
         oh/zZGFNLq/80XrdAiNPfMWqG6KbB/+nd4I4cW03oeqPdPUlwWrFt/9/rhSmbI21jwd/
         SVPA==
X-Gm-Message-State: AO0yUKUur+AYQJ+nhVG9853/8CqT1+whd9lYfgKVLckd9Qhabbh5ovCX
        5xfUACLKgmADQLzPo0LAIAnaKQ==
X-Google-Smtp-Source: AK7set/Jdyv9v1tL9sEVP2h/N/bCE/kEsK56lgf6VlRbCueUiUSF7m9xxcrg8KBma4WbX7eAnHKOCg==
X-Received: by 2002:a17:902:cf49:b0:196:6dac:342a with SMTP id e9-20020a170902cf4900b001966dac342amr10041665plg.43.1675535813839;
        Sat, 04 Feb 2023 10:36:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ab8800b00198f6e1f9f7sm1449214plr.232.2023.02.04.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:36:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] usb: host: xhci: mvebu: Iterate over array indexes instead of using pointer math
Date:   Sat,  4 Feb 2023 10:36:52 -0800
Message-Id: <20230204183651.never.663-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; h=from:subject:message-id; bh=NtJiRbwcsW7ZWf5I6FqJ4hipZQPi6PPGusc1SeXAULM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qXE/UW+TVIDUwDCEqmVm/lw7Sn89BPMT3/Atri0 hPUZxROJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96lxAAKCRCJcvTf3G3AJuPUEA CPmBvKgSC6R1t88Ly8gbjfTQdrdliNPipHb+q/s0o/ZprR6xuI1Ol8X2bhSsKhmEleH9TzSTxD9TIS 7OPuBfzf32OaDFFj8fRK4X6pkRY98BdC0T+LYtCXvzDYbbbxl6o0SsMPXs8BycCtAIDt4MXXogztO5 S/LbKJVogpzMnJwyv3veqVxr+df21FXO0GykgHk5u8WXyqaE2k8tbCa00dofeyG7MapJ+cdCYhVnFA LPjT11uLRtzihR8A3dPmkMO3xPNST1DzEdlklOL1En7LPX5KhVe40U/3gyjF+NUGuN7I94CiC84oZn noZnKSqj95KH8+Pc+yCML8bBmruBLQXNSc8wM5zbTVmE2AEHj6KVvXPO/pdJ5xV/XuIqOGvbQY93nA PKOSLvCcMREP5wH4CNPoTp4TWxy7ESQ9uKiISS7fzjG/qWHt8IrB34IaEKxkJHrGXwMsW37y6XSW9c CKThePjs3Y9mZp0qg3AvB4Bw4kZT0SciY57z/fmJo/2RVBpqtr9KOq1sAkodOm6EWytQgT46bDIkXh Bt1XFDpIT45LanLMsEKefdezUwhkBwAx3Oyvm6PifyeAHc1GmYtDSho2lyhSzy4GsWCmS/lE33Wvey EebYib1XQFWitJlrP9WJyFZtmpj7PbSPSyqcZwJkSgnAVxcKt/ryhRwUu2+A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Walking the dram->cs array was seen as accesses beyond the first array
item by the compiler. Instead, use the array index directly. This allows
for run-time bounds checking under CONFIG_UBSAN_BOUNDS as well. Seen
with GCC 13 with -fstrict-flex-arrays:

In function 'xhci_mvebu_mbus_config',
    inlined from 'xhci_mvebu_mbus_init_quirk' at ../drivers/usb/host/xhci-mvebu.c:66:2:
../drivers/usb/host/xhci-mvebu.c:37:28: warning: array subscript 0 is outside array bounds of 'const struct mbus_dram_window[0]' [-Warray-bounds=]
   37 |                 writel(((cs->size - 1) & 0xffff0000) | (cs->mbus_attr << 8) |
      |                          ~~^~~~~~

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/host/xhci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 60651a50770f..87f1597a0e5a 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -32,7 +32,7 @@ static void xhci_mvebu_mbus_config(void __iomem *base,
 
 	/* Program each DRAM CS in a seperate window */
 	for (win = 0; win < dram->num_cs; win++) {
-		const struct mbus_dram_window *cs = dram->cs + win;
+		const struct mbus_dram_window *cs = &dram->cs[win];
 
 		writel(((cs->size - 1) & 0xffff0000) | (cs->mbus_attr << 8) |
 		       (dram->mbus_dram_target_id << 4) | 1,
-- 
2.34.1

