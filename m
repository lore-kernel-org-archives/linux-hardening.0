Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C81C54EAA
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 09:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjA0JAC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 04:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjA0JAB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 04:00:01 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A31227AD
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 01:00:00 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-15085b8a2f7so5655481fac.2
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v2hSS8RRNEiKdXNBkoxjOlqOIzTHsfUutd2F8KxRjVc=;
        b=WVav3P/BvZwERU61cqc+7WHLADxXI6Tj/8iSeHsbhXgEBenzqZfMA2OUsIrJqHgBO3
         tJX0kaY3lVVp69kxaCKuAStXjnE8aa3byUFIWDBAwHZLF502pb5/vjbCRsSgcr1l9lMO
         NMwxf9XmbOJLjgKtXdgeQ5OTcuVfP+R6jBzvHR4x5P92BuF+0e76jDE+O7JLvg1WiVOo
         9nIrRwlBiftTcCDT0J///SDIAoMeyHLDRIoCT4heiUt5NPg1w/OJb31ahWZqzCeynNTS
         ryl2vqbWClwoW2t6RCdEIYJGY7eIyAHE3SIgC4znxi+F8efCPt3wQmzKXfF1xIuXhr70
         61oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2hSS8RRNEiKdXNBkoxjOlqOIzTHsfUutd2F8KxRjVc=;
        b=iE4m0jSu2ezBKX8RhEjcCajO0gtU2UgqGdUmyl+OZ13kcrR4rnY5OEMGctHcvHsNEH
         SLKS/iZSDNyUsFvFOOSySLL7HSLVC0X4bMO1X1doP5jyQVYkx5HsARui8EyE9ET/eUQo
         61dqdwB4FVOX35Koa0qyiDPRyWWPtUk6gM+mSRaIKjyQo5UCbiATG4NfbiHsiVlcXstt
         jiTEUd7G9vNUjHi2l1K5qrmlmGXJD8pZSmQpSdC+0fTOMcIpt4nrkQSRsADFSDeCktqN
         3f9ZHtkBrz89pT6srWjCGQUj7hkFMne3yxz7wIDylJP1whr1p7q8SSk07YLvdRDyM11o
         g4Sg==
X-Gm-Message-State: AO0yUKWKZ2WOHcUaJHQ2V2tjWYweLSeWLbRs8TOLkcn8cZCPWQ5cdh0/
        dmCYCSU2IEQUmzzY0gSY8HA=
X-Google-Smtp-Source: AK7set/Oq/TjWQdc/27dKCTsZKI2wNCpnXcEMh20i3ydhU6PDEL1mXztICP70raZMnAJsFQIeTWfKg==
X-Received: by 2002:a05:6870:c08f:b0:163:6d5d:5125 with SMTP id c15-20020a056870c08f00b001636d5d5125mr773029oad.19.1674810000160;
        Fri, 27 Jan 2023 01:00:00 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id w19-20020a9d77d3000000b00661b46cc26bsm1519319otl.9.2023.01.27.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:59:59 -0800 (PST)
Message-ID: <190942891d616be7fcc3f5c5ed41f035f29c4521.camel@gmail.com>
Subject: Re: [PATCH] powerpc/rtas: Replace one-element arrays with flexible
 arrays
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Date:   Fri, 27 Jan 2023 05:59:56 -0300
In-Reply-To: <20230127085023.271674-1-ajd@linux.ibm.com>
References: <20230127085023.271674-1-ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 2023-01-27 at 19:50 +1100, Andrew Donnellan wrote:
> Using a one-element array as a fake flexible array is deprecated.
>=20
> Replace the one-element flexible arrays in rtas-types.h with C99 standard
> flexible array members instead.
>=20
> This helps us move towards enabling -fstrict-flex-arrays=3D3 in future.
>=20
> Found using scripts/coccinelle/misc/flexible_array.cocci.
>=20
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Leonardo Bras <leobras.c@gmail.com>
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas-types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include=
/asm/rtas-types.h
> index 8df6235d64d1..40ec03a05c0b 100644
> --- a/arch/powerpc/include/asm/rtas-types.h
> +++ b/arch/powerpc/include/asm/rtas-types.h
> @@ -44,7 +44,7 @@ struct rtas_error_log {
>  	 */
>  	u8		byte3;			/* General event or error*/
>  	__be32		extended_log_length;	/* length in bytes */
> -	unsigned char	buffer[1];		/* Start of extended log */
> +	unsigned char	buffer[];		/* Start of extended log */
>  						/* Variable length.      */
>  };
> =20
> @@ -85,7 +85,7 @@ struct rtas_ext_event_log_v6 {
>  					/* that defines the format for	*/
>  					/* the vendor specific log type	*/
>  	/* Byte 16-end of log */
> -	u8 vendor_log[1];		/* Start of vendor specific log	*/
> +	u8 vendor_log[];		/* Start of vendor specific log	*/
>  					/* Variable length.		*/
>  };
> =20

LGTM.

FWIW:
Reviewed-by: Leonardo Bras <leobras.c@gmail.com>
