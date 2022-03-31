Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AD8C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Mar 2022 19:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiCaTGf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiCaTGe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Mar 2022 15:06:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB3215464
        for <linux-hardening@vger.kernel.org>; Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso324960pjb.5
        for <linux-hardening@vger.kernel.org>; Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K4qat18oyS/ON0Tc2wg3IJl/20RhGtMMHJnn7j74hI=;
        b=fu9LzFVAlRADxGRQVppAXuCP8QEOUuMJxhDaoGIzZSn5yF2pGIuxmwhJTWp5woQn4H
         EHzaLrxIYiJVgpunyLYPv3S9IfZSVNpubgMt/4tO/0lijzJbE1/2ZK2lcEqWyuEedN3T
         2+pKK2PG5hJ9rQ1KKpCLZBGkXKvVi+SILZFbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8K4qat18oyS/ON0Tc2wg3IJl/20RhGtMMHJnn7j74hI=;
        b=B+H6gZmGAQPPD1ftY2OiJHIBkZ2JgLbtuYagrdqgtgUOyB3qA81ZhpY97RLZkQ6UJW
         T3aDXdTKcI0yVscsUhY3MhSii7fFiKYfKKaiEtkwOBTpXBqLrsog16l1SovPM7zSG4m6
         xFmYSNqN577D2MC7oFvDnalykhxCt2aId10nO4PnvsnHHG6pjYMx7jWjzmK4Imb3Eygm
         V7TaiWlESmYGVqSaZbTIruTKF1SywH4AQV+z4f7+7W6U03H/MDnLnbVnSy0amIgj8pQI
         OCtlyNBrv35S4vLPzmAg9l16Y38TBcT1tKeZR+jy3yyX2dMBCfRkc3NVSuzacK+JVevM
         +hzA==
X-Gm-Message-State: AOAM532lF8tRddRwH+F3jUOI0GkDUnYCfAE663+vlem8Ve7BTytqNlXW
        f2lFwhBophHiBUKvSdyNQ5W0oQ==
X-Google-Smtp-Source: ABdhPJzmGmj8aYdwRSZROHgiAtffDN6in63gKRVnyEHWKadCoiriCaM3lZSBHfVtkIHAxWU6vFCsrg==
X-Received: by 2002:a17:902:d2c6:b0:156:2b2c:ab54 with SMTP id n6-20020a170902d2c600b001562b2cab54mr16131133plc.52.1648753486453;
        Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22-20020a056a00149600b004fb34a7b500sm196147pfu.203.2022.03.31.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:04:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Date:   Thu, 31 Mar 2022 12:04:43 -0700
Message-Id: <20220331190443.851661-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; h=from:subject; bh=/2a5CSsipys253M5vGRsqHVDoYM5WGy53UpPjsagOIc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiRftKixEnPaz5DYx3KcOYhAntbvuUAggDZhiZY7iw bo/iWgyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYkX7SgAKCRCJcvTf3G3AJn1+D/ 9JmnMmf4cTjvYcKaiTm+ZsZZnuFtJXdv4Sj5cEH11WQawVe+UAqmL0m1glp2GYK85YUhuNPWdd/2An 2zH3JiJlWtqNuCF8jHcxmtuSgvUfnipd2s/l5v12j/RyWt7yUJBB/f+RA68i2rAnPTLL+MerHlWtyb PhxoFZjC7hcnw/3gdFHtOQlTC5Z4Lw57BivrJXu7OBCGCFwK2R0ArvLd2alzA8/cOpesKeB1d2y7Ft N7SQIMtttTn1UaqFUxP5fAJbwQVgdvSbig44DEep6jFro3jykxmBiK44bGqIy/SGK3w2gDnRfDJk0S IaqlI3aixjk7Vh1lnsPLB42Bp6enuHtDlrLJejwBs11oBOh3J5fJKEZ0HnXDWQ1/iZsgb7aOpcQWh3 5/R4Di8zHLA4ywpxPYhsNey5F8A4Pf2U/RCo1uIUehCc/cjO6CaoddINTyJJ+Sz7fhjDrbVLLHzg1O AFtV6Wwp2HJv1Dpry96HDj6aDhK74xNllVO22PzFa46p0o4gi7flIyfOK6Mdxz/8UthhjoRXKIcJk1 ewXb0ZYaFh38NvdBpaC0xA193NKbxRb+hlwz21p1+6FreJdjhYMhaR+cYFkUhCVh6dRqUpiw37fYs9 CMKyba1yS3vRZqEXSCU7fAq2QtFHELV0CqQ+URjZHEklvJABZrjanhwsn6fw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building multi_v7_defconfig+CONFIG_SMP=n, -Warray-bounds exposes
a couple negative array index accesses:

arch/arm/mach-vexpress/spc.c: In function 've_spc_clk_init':
arch/arm/mach-vexpress/spc.c:583:21: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
  583 |   if (init_opp_table[cluster])
      |       ~~~~~~~~~~~~~~^~~~~~~~~
arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
  556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
      |       ^~~~~~~~~~~~~~
arch/arm/mach-vexpress/spc.c:592:18: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
  592 |    init_opp_table[cluster] = true;
      |    ~~~~~~~~~~~~~~^~~~~~~~~
arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
  556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
      |       ^~~~~~~~~~~~~~

Skip this logic when built !SMP.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mach-vexpress/spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 1da11bdb1dfb..1c6500c4e6a1 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -580,7 +580,7 @@ static int __init ve_spc_clk_init(void)
 		}

 		cluster = topology_physical_package_id(cpu_dev->id);
-		if (init_opp_table[cluster])
+		if (cluster < 0 || init_opp_table[cluster])
 			continue;

 		if (ve_init_opp_table(cpu_dev))
--
2.32.0

