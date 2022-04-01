Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551AEC433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  1 Apr 2022 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbiDAJai (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344560AbiDAJah (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Apr 2022 05:30:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3705B1CD7E5
        for <linux-hardening@vger.kernel.org>; Fri,  1 Apr 2022 02:28:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F0D15DB
        for <linux-hardening@vger.kernel.org>; Fri,  1 Apr 2022 02:28:47 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4D323F66F
        for <linux-hardening@vger.kernel.org>; Fri,  1 Apr 2022 02:28:47 -0700 (PDT)
Date:   Fri, 1 Apr 2022 10:28:29 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: vexpress/spc: Avoid negative array index when !SMP
Message-ID: <YkbFvYRkcXgo3mpK@e110455-lin.cambridge.arm.com>
References: <20220331190443.851661-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331190443.851661-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 31, 2022 at 12:04:43PM -0700, Kees Cook wrote:
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
> Skip this logic when built !SMP.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Sudeep, can you please take this through your tree for sending it to arm-soc?

Best regards,
Liviu

> ---
>  arch/arm/mach-vexpress/spc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index 1da11bdb1dfb..1c6500c4e6a1 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -580,7 +580,7 @@ static int __init ve_spc_clk_init(void)
>  		}
> 
>  		cluster = topology_physical_package_id(cpu_dev->id);
> -		if (init_opp_table[cluster])
> +		if (cluster < 0 || init_opp_table[cluster])
>  			continue;
> 
>  		if (ve_init_opp_table(cpu_dev))
> --
> 2.32.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
