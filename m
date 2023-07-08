Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E9FEB64DA
	for <linux-hardening@archiver.kernel.org>; Sat,  8 Jul 2023 02:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGHCrN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGHCrN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 22:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E4C9
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 19:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841E061A94
        for <linux-hardening@vger.kernel.org>; Sat,  8 Jul 2023 02:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE46C433C7;
        Sat,  8 Jul 2023 02:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688784430;
        bh=0arfoHoQe9kngWQ5BInR7qnXyopf7dxUCosuf53ZJ+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mK0eyUX/rsfTzt5kBhdZL8asCFRdgqLSeEIew84zdpFfo2vwcWwKG6QA9bP+2wJ6V
         SPbQRoFOcszHzTp4qIm8Xk1hOw/xkMMuKvTylT3U7lFPTr01aWncZO8+faf6Qw/OM6
         EM6k/GE5kLDXdk0m75AD5fNtzcQGLqO/Fs5/Edyr4/uUNqEI3UgjwiAnwAiIcs4SSV
         3dlkkamZdbbx0SfdIET23DIaJjkDev8p/V5ma2orXv/oJERN76bgpz9NNTzMx0iGGf
         2kKuSmDdVTh8IKUagnNmyAm390/dfYZ2jjTKkSmlQAETR1mW7j66ai5dYZDm9FumyC
         PYH4Tas7lB4Sg==
Date:   Fri, 7 Jul 2023 19:47:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v2 2/2] pstore: Replace crypto API compression with
 zlib_deflate library calls
Message-ID: <20230708024709.GC1731@sol.localdomain>
References: <20230707083456.2501913-1-ardb@kernel.org>
 <20230707083456.2501913-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707083456.2501913-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jul 07, 2023 at 10:34:56AM +0200, Ard Biesheuvel wrote:
> +/*
> + * pstore no longer implements compression via the crypto API, and only
> + * supports zlib deflate compression implemented using the zlib library
> + * interface. This removes additional complexity which is hard to justify for a
> + * diagnostic facility that has to operate in conditions where the system may
> + * have become unstable. Zlib deflate is comparatively small in terms of code
> + * size, and compresses ASCII text as well as any other compression algorithm
> + * available in the kernel. In terms of compression speed, deflate is not the
> + * best performer but for recording the log output on a kernel panic, this is
> + * not considered critical.
> + *
> + * The only remaining arguments supported by the compress= module parameter are
> + * 'deflate' and 'none'. To retain compatibility with existing installations,
> + * all other values are logged and replaced with 'deflate'.
> + */
> +static char *compress = "deflate";

I would soften the claim "compresses ASCII text as well as any other compression
algorithm available in the kernel" to something like "compresses ASCII text
comparatively well".  This is because zstd can indeed compress ASCII text
slightly more than deflate.

> static void free_buf_for_compression(void)
> {
> -       if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
> -               crypto_free_comp(tfm);
> -               tfm = NULL;
> -       }
> +       vfree(compress_workspace);
>         kfree(big_oops_buf);
>         big_oops_buf = NULL;
>  }

Maybe set compress_workspace to NULL after it is freed.

> @@ -592,10 +623,17 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  {
>  	int failed = 0;
>  	unsigned int stop_loop = 65536;
> +	struct z_stream_s zstream;
>  
>  	if (!psi || !root)
>  		return;
>  
> +	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress) {
> +		zstream.workspace = kvmalloc(zlib_inflate_workspacesize(),
> +					     GFP_KERNEL);
> +		zlib_inflateInit2(&zstream, -DEF_WBITS);
> +	}
> +

zstream.workspace is never checked for NULL.  Maybe do:

	struct z_stream_s zstream = {};

and have decompress_record() check it.  Also I think it should replace the check
for big_oops_buf, as big_oops_buf is really for compression, not decompression.


>  	mutex_lock(&psi->read_mutex);
>  	if (psi->open && psi->open(psi))
>  		goto out;
> @@ -624,7 +662,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  			break;
>  		}
>  
> -		decompress_record(record);
> +		decompress_record(record, &zstream);
>  		rc = pstore_mkfile(root, record);
>  		if (rc) {
>  			/* pstore_mkfile() did not take record, so free it. */
> @@ -639,6 +677,10 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  		psi->close(psi);
>  out:
>  	mutex_unlock(&psi->read_mutex);
> +	kvfree(zstream.workspace);
> +
> +	if (zlib_inflateEnd(&zstream) != Z_OK)
> +		pr_warn("zlib_inflateEnd() failed\n");

The destruction code above needs to be guarded by the same condition as the
initialization code ('IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress').

- Eric
