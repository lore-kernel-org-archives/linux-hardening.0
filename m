Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238AEEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 18:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGDSHW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjGDSHR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 14:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEE10E3
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 11:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3219161343
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 18:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726C6C433C7;
        Tue,  4 Jul 2023 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688494033;
        bh=Ee51Qdqp0cFGfMo8JSxAHISfd6AjKPeiRo20PMye68E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDcnDWAzrfl/797AjQ69sdHVncDUyAmW1BAZpHS3q5CEUipq2hRHf0KOUdlnT7Oep
         48XYLe0t+iJlO+W6hohoFrOF8e5JGRydCIf41hfwRHmzy7uR7WGd21Fx4gkx/His3z
         voM/YLJIUvnMfizOAFC6PVjz51bmijEVCCebB2VRG7rKPkcHlmItiS28PUssm97FYq
         K8+aoqYepninhjBRiQ0qmmDRYH3QMf4e6BKdO/N2ovqTuWL22vza1KSDBqhksVRBhP
         mWEAzs7+VJxpAAQwIHluqqoQ4fh+dFJ82ckf3wgvTYb54+lss7lTDZUx5d1w9F7cT4
         Wpepx+3uE2mIA==
Date:   Tue, 4 Jul 2023 11:07:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 1/2] pstore: Remove worst-case compression size logic
Message-ID: <20230704180711.GC1851@sol.localdomain>
References: <20230704135211.2471371-1-ardb@kernel.org>
 <20230704135211.2471371-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704135211.2471371-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 04, 2023 at 03:52:10PM +0200, Ard Biesheuvel wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> The worst case compression size gives an upper bound for how much the
> data might inadvertently *grow* due to encapsulation overhead if the
> input is not compressible at all.
> 
> The kernel log is ASCII text so it should generally compress rather
> well. This means that the probability that the kernel log grows beyond
> the uncompressed size after compression is astronomically low, and in
> such cases (i.e., dmesg filled with perfect entropy) we won't be able to
> make sense of it anyway.
> 
> So let's just drop this logic, and use the uncompressed size as the
> worst case instead.
> 
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I think the reasoning about the kernel log being low-entropy, which is a bit
hand-wavy, is entirely unnecessary.  pstore records include a flag that
indicates whether they are compressed or not.  Therefore, any record that would
compress to more than its original size can and should be stored uncompressed.
There's nothing more to it than that.

>  static int pstore_compress(const void *in, void *out,
>  			   unsigned int inlen, unsigned int outlen)
>  {
> @@ -291,36 +178,31 @@ static void allocate_buf_for_compression(void)
>  	char *buf;
>  
>  	/* Skip if not built-in or compression backend not selected yet. */
> -	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
> +	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress)
>  		return;
>  
>  	/* Skip if no pstore backend yet or compression init already done. */
>  	if (!psinfo || tfm)
>  		return;
>  
> -	if (!crypto_has_comp(zbackend->name, 0, 0)) {
> -		pr_err("Unknown compression: %s\n", zbackend->name);
> -		return;
> -	}
> -
> -	size = zbackend->zbufsize(psinfo->bufsize);
> -	if (size <= 0) {
> -		pr_err("Invalid compression size for %s: %d\n",
> -		       zbackend->name, size);
> +	if (!crypto_has_comp(compress, 0, 0)) {
> +		pr_err("Unknown compression: %s\n", compress);
>  		return;
>  	}
>  
> +	/* Worst-case compression should never be more than uncompressed. */
> +	size = psinfo->bufsize;
>  	buf = kmalloc(size, GFP_KERNEL);
>  	if (!buf) {
>  		pr_err("Failed %d byte compression buffer allocation for: %s\n",
> -		       size, zbackend->name);
> +		       size, compress);
>  		return;
>  	}

The local variable 'size' should be removed, and psinfo->bufsize used directly.

> @@ -330,7 +212,7 @@ static void allocate_buf_for_compression(void)
>  	big_oops_buf_sz = size;

The static variable 'big_oops_buf_sz' should be removed, as it is redundant with
psinfo->bufsize.

>		if (big_oops_buf) {
>			dst = big_oops_buf;
>			dst_size = big_oops_buf_sz;
>		} else {
>			dst = psinfo->buf;
>			dst_size = psinfo->bufsize;
>		}

This can be simplified to:

		if (big_oops_buf)
			dst = big_oops_buf;
		else
			dst = psinfo->buf;
		dst_size = psinfo->bufsize;

>	unzipped_len = big_oops_buf_sz;
>	workspace = kmalloc(unzipped_len + record->ecc_notice_size,
>			    GFP_KERNEL);
>	if (!workspace)
>		return;

This can be simplified to:

	workspace = kmalloc(psinfo->bufsize + record->ecc_notice_size,
			    GFP_KERNEL);
	if (!workspace)
		return;

> /*
>  * Called when compression fails, since the printk buffer
>  * would be fetched for compression calling it again when
>  * compression fails would have moved the iterator of
>  * printk buffer which results in fetching old contents.
>  * Copy the recent messages from big_oops_buf to psinfo->buf
>  */
> static size_t copy_kmsg_to_buffer(int hsize, size_t len)
> {
> 	size_t total_len;
> 	size_t diff;
> 
> 	total_len = hsize + len;
> 
> 	if (total_len > psinfo->bufsize) {
> 		diff = total_len - psinfo->bufsize + hsize;
> 		memcpy(psinfo->buf, big_oops_buf, hsize);
> 		memcpy(psinfo->buf + hsize, big_oops_buf + diff,
> 					psinfo->bufsize - hsize);
> 		total_len = psinfo->bufsize;
> 	} else
> 		memcpy(psinfo->buf, big_oops_buf, total_len);
> 
> 	return total_len;
> }

This patch makes the 'total_len > psinfo->bufsize' case in the above function
unreachable.  That function should be removed, and its caller should just do:

			zipped_len = pstore_compress(dst, psinfo->buf,
						header_size + dump_size,
						psinfo->bufsize);

			if (zipped_len > 0) {
				record.compressed = true;
				record.size = zipped_len;
			} else {
				memcpy(psinfo->buf, dst,
				       header_size + dump_size);
				record.size = header_size + dump_size;
			}


- Eric
