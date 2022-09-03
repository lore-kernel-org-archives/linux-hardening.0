Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E2FECAAD4
	for <linux-hardening@archiver.kernel.org>; Sat,  3 Sep 2022 11:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiICLs7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Sep 2022 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiICLs4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Sep 2022 07:48:56 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A18754AD;
        Sat,  3 Sep 2022 04:48:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VOBAkhS_1662205727;
Received: from 30.32.109.203(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VOBAkhS_1662205727)
          by smtp.aliyun-inc.com;
          Sat, 03 Sep 2022 19:48:48 +0800
Message-ID: <a3b32e71-a345-40d3-feee-fa4c5aab42af@linux.alibaba.com>
Date:   Sat, 3 Sep 2022 19:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH][next] ocfs2: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <YxKY6O2hmdwNh8r8@work>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <YxKY6O2hmdwNh8r8@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 9/3/22 7:59 AM, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declarations in a couple of structures and unions with the new
> DECLARE_FLEX_ARRAY() helper macro.
> 
> This helper allows for a flexible-array member in a union and as
> only member in a structure.
> 
> Also, this addresses multiple warnings reported when building with
> Clang-15 and -Wzero-length-array.
> 
> Lastly, this will also help memcpy (in a coming hardening update)
> execute proper bounds-checking on variable length object i_symlink
> at fs/ocfs2/namei.c:1973:
> 
> fs/ocfs2/namei.c:
> 1973                 memcpy((char *) fe->id2.i_symlink, symname, l);
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/197
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
