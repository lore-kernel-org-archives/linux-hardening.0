Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5057C001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 01:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjG0BSU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjG0BST (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jul 2023 21:18:19 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C3270D;
        Wed, 26 Jul 2023 18:18:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VoIPE.._1690420691;
Received: from 30.221.136.121(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VoIPE.._1690420691)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 09:18:13 +0800
Message-ID: <efb2192c-9cd6-62f9-d1ce-a0a536027021@linux.alibaba.com>
Date:   Thu, 27 Jul 2023 09:18:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ocfs2: Use regular seq_show_option for osb_cluster_stack
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mark Fasheh <mark@fasheh.com>,
        akpm <akpm@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230726215919.never.127-kees@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230726215919.never.127-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 7/27/23 5:59 AM, Kees Cook wrote:
> While cleaning up seq_show_option_n()'s use of strncpy, it was noticed
> that the osb_cluster_stack member is always NUL-terminated, so there is
> no need to use the special seq_show_option_n() routine. Replace it with
> the standard seq_show_option() routine.
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: ocfs2-devel@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good.

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> ---
>  fs/ocfs2/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 988d1c076861..6b906424902b 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -1517,8 +1517,7 @@ static int ocfs2_show_options(struct seq_file *s, struct dentry *root)
>  		seq_printf(s, ",localflocks,");
>  
>  	if (osb->osb_cluster_stack[0])
> -		seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
> -				  OCFS2_STACK_LABEL_LEN);
> +		seq_show_option(s, "cluster_stack", osb->osb_cluster_stack);
>  	if (opts & OCFS2_MOUNT_USRQUOTA)
>  		seq_printf(s, ",usrquota");
>  	if (opts & OCFS2_MOUNT_GRPQUOTA)
