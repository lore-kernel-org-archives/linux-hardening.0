Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3CBC71133
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 03:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbjHRDlb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357741AbjHRDlU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 23:41:20 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA6358A
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 20:41:18 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id WmuKqb7rVWU1cWqMPqV2CA; Fri, 18 Aug 2023 03:41:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id WqMOqhPfMDHerWqMPquR9y; Fri, 18 Aug 2023 03:41:17 +0000
X-Authority-Analysis: v=2.4 cv=MN5zJeVl c=1 sm=1 tr=0 ts=64dee85d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=mDV3o1hIAAAA:8 a=Twlkf-z8AAAA:8
 a=hEGvEmT7ark0PdWysM4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22 a=_FVE-zBwftR9WsbkzFJk:22 a=-74SuR6ZdpOK_LpdRCUo:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XS6ddzMrecuPuYAqVJpaZu6ilnoyG2mS0jCrgvsgBTQ=; b=SrRkOhaP3QKiVP6PPRxlkhwJsc
        cZTdPs+iOlfJ9w8SKFgQ7nl5pPbKFCAVgNMj0bvhrVFtrgbcA+mhjkRZ6VsFs4Ifh/PS++eMgVkY1
        70Ci9WmNxrMRFgcecjYFQNRapbVf34l3Qr6uJucThJY4do+LdjxdcPB16dXUXfOsI12jGqT09wRqi
        4vMMkZ8MtBkM4GWS5j9/8dhgLcIXoLKt+aBEha+MkL7w+tkxPRg2whqC5STS9gCw1ZefbVXbbCmaN
        Iuy9VjIQTedCmcJ5dKWCVb+oFxsf1Ua1k2ei7wCZFHuqwLmEsxJ6SNQNZWz0wfwj1p3aWk3mhyZ5z
        Wa7hSFTA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56796 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWqMN-002Jn6-1p;
        Thu, 17 Aug 2023 22:41:16 -0500
Message-ID: <338a56b6-1e07-4089-d762-25440c0f9d81@embeddedor.com>
Date:   Thu, 17 Aug 2023 21:42:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Compiler Attributes: counted_by: Adjust name and
 identifier expansion
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230817200558.never.077-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817200558.never.077-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWqMN-002Jn6-1p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:56796
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG+1e4DNkG6N0HUeV4uDtq1/k6S6u3UCz+sW3d258dj8LGu7BKh3A2AQdjL4Xtzq+mIQTsxasS6XCSIQDy+8uPz1fwF1EaYt3WhN1VIzo1ggVfNJGZNc
 6fZfzSHZvbwwBu0z5TozEtCNt6+haIe9kqxwGycAw8A2dE9jhjaygtG25p0Uy1JAQXQIJ/sEBBSdi70mbCb1VFDXaUF8PHJ6FasGsG6zoOQ7l7ZaRRs2tXj1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 8/17/23 14:06, Kees Cook wrote:
> GCC and Clang's current RFCs name this attribute "counted_by", and have
> moved away from using a string for the member name. Update the kernel's
> macros to match. Additionally provide a UAPI no-op macro for UAPI structs
> that will gain annotations.
> 
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/compiler_attributes.h | 26 +++++++++++++-------------
>   include/uapi/linux/stddef.h         |  4 ++++
>   2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 00efa35c350f..74716a407aac 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -94,6 +94,19 @@
>   # define __copy(symbol)
>   #endif
>   
> +/*
> + * Optional: only supported since gcc >= 14
> + * Optional: only supported since clang >= 17
> + *
> + *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> + * clang: https://reviews.llvm.org/D148381
> + */
> +#if __has_attribute(__counted_by__)
> +# define __counted_by(member)		__attribute__((__counted_by__(member)))
> +#else
> +# define __counted_by(member)
> +#endif
> +
>   /*
>    * Optional: not supported by gcc
>    * Optional: only supported since clang >= 14.0
> @@ -129,19 +142,6 @@
>   # define __designated_init
>   #endif
>   
> -/*
> - * Optional: only supported since gcc >= 14
> - * Optional: only supported since clang >= 17
> - *
> - *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> - * clang: https://reviews.llvm.org/D148381
> - */
> -#if __has_attribute(__element_count__)
> -# define __counted_by(member)		__attribute__((__element_count__(#member)))
> -#else
> -# define __counted_by(member)
> -#endif
> -
>   /*
>    * Optional: only supported since clang >= 14.0
>    *
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 7837ba4fe728..7c3fc3980881 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -45,3 +45,7 @@
>   		TYPE NAME[]; \
>   	}
>   #endif
> +
> +#ifndef __counted_by
> +#define __counted_by(m)
> +#endif
