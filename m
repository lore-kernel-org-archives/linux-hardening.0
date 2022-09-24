Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97833C07E9D
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 04:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiIXEEI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Sep 2022 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiIXEEH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Sep 2022 00:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9413A953;
        Fri, 23 Sep 2022 21:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D8760A52;
        Sat, 24 Sep 2022 04:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05415C433D6;
        Sat, 24 Sep 2022 04:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663992245;
        bh=EN/xHz26wvCyfr+ycL35toumyEeShppuKtIek9Wh97g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sO/9eSK+OnQSJLog+b3/n4HuBOverxs5/4ryCOCLCF22pEHOPasrkIN7/tBgYTOkD
         P/6Vj9T5M2sPUbwFKt/ZCBrmMMD4L/d0XANAN4z6y/HLXhXWZyotWsYFIBPYt/N0nz
         E7sIGBjRR69t6ANd0ACbEwTtDNW/suByxYyLFOtuVkQ+DyCWRosxQggqh+GCBZrgpt
         CJlVm+AvydgImR3ln+gv3dUJHFJgKfTKtBt3gTt7zm09r3ioIl6yPUKrlfyfRiqBZf
         vkvfXddsB8gOeigqQFdwtL36k06sCtFq0/KbjSYxhRufYmuqxArV8XFkF0E5y7cb/s
         PBqH0EPal/ZFQ==
Date:   Fri, 23 Sep 2022 23:03:59 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dlm: Split memcpy() of struct dlm_message flexible array
Message-ID: <Yy6Br5dUir4pfcvv@work>
References: <20220924035226.3359297-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924035226.3359297-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 23, 2022 at 08:52:26PM -0700, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/
> 
> Cc: Christine Caulfield <ccaulfie@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Cc: cluster-devel@redhat.com
> Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  fs/dlm/requestqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
> index 036a9a0078f6..63f45c3c53a2 100644
> --- a/fs/dlm/requestqueue.c
> +++ b/fs/dlm/requestqueue.c
> @@ -44,7 +44,8 @@ void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_message *ms)
>  
>  	e->recover_seq = ls->ls_recover_seq & 0xFFFFFFFF;
>  	e->nodeid = nodeid;
> -	memcpy(&e->request, ms, le16_to_cpu(ms->m_header.h_length));
> +	e->request = *ms;
> +	memcpy(&e->request.m_extra, ms->m_extra, length);
>  
>  	atomic_inc(&ls->ls_requestqueue_cnt);
>  	mutex_lock(&ls->ls_requestqueue_mutex);
> -- 
> 2.34.1
> 
