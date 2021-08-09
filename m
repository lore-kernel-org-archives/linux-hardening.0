Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED8C4320A
	for <linux-hardening@archiver.kernel.org>; Mon,  9 Aug 2021 09:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251196101D
	for <linux-hardening@archiver.kernel.org>; Mon,  9 Aug 2021 09:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhHIJwU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 9 Aug 2021 05:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232944AbhHIJwT (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 9 Aug 2021 05:52:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC75660EC0;
        Mon,  9 Aug 2021 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628502719;
        bh=J8CUNEQlMchF5+n7xZbUyoke5OF5A74gsFwrK7af7y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3RMWC0+7MgMSfZj6xCZn+lUbkU9ibVvYHQ6tgUukCmO3/1yrgmitXvG4noCskVzW
         n7VuOhJZMycvg09Ym9IQzlMgkISWZjXOGlCeSz7y0pvb+f5ShDI3pD9GSAIoIemneN
         z8pAALIuXCn9ywONxPxkBNeHq27P48oD5okxPe+SpAOr9Z3k0iRVe+nJxEPCGjkjhl
         w0JD1t7qx7jZy/xhGKyKuTkvCa257y5BvPwp1gPsn5UfEuL2iaCxqLpMVcG64DFKQm
         Lq3GIBv1Gtgb6m3xENFnVtciRY2j95pHfsQ24iech0XbiGZuKN2gnBfdFh4XVEV7jS
         YiGfQDomvWkGQ==
Date:   Mon, 9 Aug 2021 11:51:54 +0200
From:   Robert Richter <rric@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YRD6uoVYwCSFN0U0@rric.localdomain>
References: <20210807155957.10069-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807155957.10069-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 07.08.21 17:59:57, Len Baker wrote:

> @@ -1113,11 +1115,11 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			p = e->label;
>  			*p = '\0';
>  		} else {
> -			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> -			}
> -			strcpy(p, dimm->label);
> +			const char *text = (p != e->label) ? OTHER_LABEL :
> +				dimm->label;
> +
> +			strscpy(p, text, len);
> +			len -= strlen(p);

The logic looks broken and dimm labels are not properly copied (the
code should add an " or " separator between labels).

-Robert

>  			p += strlen(p);
>  		}
> 
