Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1646DEB64DA
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 18:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGDSbe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDSbd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 14:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E96E72
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 11:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 972DC6132F
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 18:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AD9C433C7;
        Tue,  4 Jul 2023 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688495491;
        bh=+63LsQiQSe9u1SOemu9SyzoI0INUNhd/lRwFZR+MCqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljSAEZ1bIs0K9mJ/WL4/PWiLq4Kb+PYwpEF7HvAOHOLR5gKkkfjI9lHz3NyrVQ+en
         q245LBlECwt1REGvmqwp6rovtWowznOZMA7t6yGGojDAFVjCRxfHSZmrn+ftFIPibN
         puehUgv1cL1dvlSGj3QbDeZyg/a9YCNIjK2/MmEL9+1943CZicGEuMvgkg2lQ0zrtS
         mlkwfsrxoqX8sBMD6J13aDOcE74RGcP7iC2MbMWPE+o5e5qbp7BXRC9MI0X/VOwQKz
         FPa8GqwFOxDaguRh/rRgIfs28xRCTHRAchPJ3XG/omkE3hI+YVc9d5LUDYdrgz9YF3
         Cl/YISYj59fNw==
Date:   Tue, 4 Jul 2023 11:31:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 2/2] pstore: Replace crypto API compression with
 zlib_deflate library calls
Message-ID: <20230704183128.GD1851@sol.localdomain>
References: <20230704135211.2471371-1-ardb@kernel.org>
 <20230704135211.2471371-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704135211.2471371-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 04, 2023 at 03:52:11PM +0200, Ard Biesheuvel wrote:
> Pstore supports compression using a variety of algorithms exposed by the
> crypto API. This uses the deprecated comp (as opposed to scomp/acomp)
> API, and so we should stop using that, and either move to the new API,
> or switch to a different approach entirely.
> 
> Given that we only compress ASCII text in pstore, and considering that
> this happens when the system is likely to be in a highly fragile state,
> the flexibility that the complex crypto API provides does not outweigh
> its impact on the risk that we might encounter additional problems when
> trying to commit the kernel log contents to the pstore backend.
> 
> So let's switch [back] to the zlib deflate library API, and remove all
> the complexity that really has no place in a low-level diagnostic
> facility. Note that, while more modern compression algorithms have been
> added to the kernel in recent years, the code size of zlib deflate is
> substantially smaller, while its performance in terms of compression
> ratio is perfectly acceptable, and speed is irrelevant in this context
> (unless panic() is a performance bottleneck in your workload).
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Actually, LZ4 and LZO both have slightly smaller code size than zlib.

Though, they are really intended for use cases that need high performance, which
as you mention is not important for the pstore use case.

So I think zlib is still fine here.  Just the above argument is a bit
misleading.

In any case, can the rationale for the choice of compression algorithm and API
be documented in the source code itself?  Otherwise I worry that someone will
want to "improve" this code again.

> @@ -157,37 +152,46 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
>  static int pstore_compress(const void *in, void *out,
>  			   unsigned int inlen, unsigned int outlen)
>  {
> +	struct z_stream_s zstream = {
> +		.next_in	= in,
> +		.avail_in	= inlen,
> +		.next_out	= out,
> +		.avail_out	= outlen,
> +		.workspace	= compress_workspace,
> +	};
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
>  		return -EINVAL;
>  
> -	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
> -	if (ret) {
> -		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
> -		return ret;
> -	}
> +	ret = zlib_deflateInit2(&zstream, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
> +				-MAX_WBITS, DEF_MEM_LEVEL, Z_DEFAULT_STRATEGY);
> +	if (ret != Z_OK)
> +		return -EINVAL;
>  
> -	return outlen;
> +	ret = zlib_deflate(&zstream, Z_FINISH);
> +	if (ret != Z_STREAM_END)
> +		return -EINVAL;
> +
> +	return zstream.total_out;
>  }

The above code looks weird to anyone familiar with the zlib API, since it is
missing the call to zlib_deflateEnd().  It looks like the in-kernel zlib doesn't
really need it, since the in-kernel zlib has been customized to manage memory
differently from the real zlib.  But I recommend including it.

> @@ -629,10 +640,17 @@ void pstore_get_backend_records(struct pstore_info *psi,
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
>  	mutex_lock(&psi->read_mutex);
>  	if (psi->open && psi->open(psi))
>  		goto out;
> @@ -661,7 +679,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  			break;
>  		}
>  
> -		decompress_record(record);
> +		decompress_record(record, &zstream);
>  		rc = pstore_mkfile(root, record);
>  		if (rc) {
>  			/* pstore_mkfile() did not take record, so free it. */
> @@ -676,6 +694,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  		psi->close(psi);
>  out:
>  	mutex_unlock(&psi->read_mutex);
> +	kvfree(zstream.workspace);

Similarly above: zlib_inflateEnd() isn't being called.  It should happen
alongside freeing 'zstream.workspace'.

- Eric
