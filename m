Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF9C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJKU1K (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJKU1J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 16:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB197AC17;
        Tue, 11 Oct 2022 13:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36855612B1;
        Tue, 11 Oct 2022 20:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95CAC433D6;
        Tue, 11 Oct 2022 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665520027;
        bh=4mjeGZWjzdltaknQh2xEAk5S7/0E0scidfMTONRIA+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aE22t2xlXwPF01/LBFR23LFlHwFonaxKAI6BaGe7TGNrMLq2g2vOPLsaHVZtO0qEm
         hCibw3ac+chbdV9UCFpQTt+kf7O9Dkr9Akb+rmCRETw6XIYkRqqpu71M16E0Z+qU+0
         XbnkbzQsK3okMPuZ1LZGImou+ytsqBc36FOjpd/4GqFACT4UsUtxgJ6yTZH5zyb+Zr
         v5L9ZykZFVETjP3cPXXpMaHXV8gXJrqoUiI8dFgXAk2NVR6Hg1qWkjqhr6XUcutSkd
         04fZSbByF+MNJm6YceKxucaT0CjIAYLYnPJL8o7KxEuqWcMZxI3eNlXDa4DMkLuc5T
         4PkpaqTDGcjhA==
Date:   Tue, 11 Oct 2022 15:26:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XRkWvc2uey+IJh@work>
References: <202210111305.743F591@keescook>
 <Y0XQsqdRzlrSpgOh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XQsqdRzlrSpgOh@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 12, 2022 at 09:23:14AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated. So, replace one-element array with
> fixed size array member in struct dlm_ls, and refactor the rest of the
> code, accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/228
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> Changelog:
> 
> v5: use preferred sizeof style. Req: Gustavo Silva
> v4: resend patch using the right version number. Req: Gustavo Silva
> v3: replace one-element array with a fixed size array. Req: Kees Cook
> v2: patch resent as I had an issue with a <CRLF> char in my mail client
> v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
> ---
> 
>  fs/dlm/dlm_internal.h | 2 +-
>  fs/dlm/lockspace.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index e34c3d2639a5..94fadb619ba0 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -670,7 +670,7 @@ struct dlm_ls {
>  	void			*ls_ops_arg;
>  
>  	int			ls_namelen;
> -	char			ls_name[1];
> +	char			ls_name[DLM_LOCKSPACE_LEN + 1];
>  };
>  
>  /*
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index bae050df7abf..9479c8110979 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
>  
>  	error = -ENOMEM;
>  
> -	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> +	ls = kzalloc(sizeof(*ls), GFP_NOFS);
>  	if (!ls)
>  		goto out;
>  	memcpy(ls->ls_name, name, namelen);
> -- 
> 2.37.3
> 
