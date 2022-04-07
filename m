Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C2C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Apr 2022 10:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiDGKRG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiDGKRE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 7 Apr 2022 06:17:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8BE4403D5;
        Thu,  7 Apr 2022 03:15:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274A623A;
        Thu,  7 Apr 2022 03:15:04 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0248A3F5A1;
        Thu,  7 Apr 2022 03:15:02 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Date:   Thu,  7 Apr 2022 11:14:52 +0100
Message-Id: <164932629049.1424947.13640596774017926989.b4-ty@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331190443.851661-1-keescook@chromium.org>
References: <20220331190443.851661-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 31 Mar 2022 12:04:43 -0700, Kees Cook wrote:
> When building multi_v7_defconfig+CONFIG_SMP=n, -Warray-bounds exposes
> a couple negative array index accesses:
> 
> arch/arm/mach-vexpress/spc.c: In function 've_spc_clk_init':
> arch/arm/mach-vexpress/spc.c:583:21: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
>   583 |   if (init_opp_table[cluster])
>       |       ~~~~~~~~~~~~~~^~~~~~~~~
> arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
>   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
>       |       ^~~~~~~~~~~~~~
> arch/arm/mach-vexpress/spc.c:592:18: warning: array subscript -1 is below array bounds of 'bool[2]' {aka '_Bool[2]'} [-Warray-bounds]
>   592 |    init_opp_table[cluster] = true;
>       |    ~~~~~~~~~~~~~~^~~~~~~~~
> arch/arm/mach-vexpress/spc.c:556:7: note: while referencing 'init_opp_table'
>   556 |  bool init_opp_table[MAX_CLUSTERS] = { false };
>       |       ^~~~~~~~~~~~~~
> 
> [...]


Applied to sudeep.holla/linux (fixes/vexpress), thanks!

[1/1] ARM: vexpress/spc: Avoid negative array index when !SMP
      https://git.kernel.org/sudeep.holla/c/b3f1dd52c9

--
Regards,
Sudeep

