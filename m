Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0438BCB
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E20MYgOe"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992CBA6
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 09:44:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c87e55a6baso28379505ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696869881; x=1697474681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb99YdmqVEejiWEnH1GHxc9UcT+WJQ1JMF8Pc+Hi6Js=;
        b=E20MYgOek9g9xhgi4wHtGoIiIRBNBWfCYXQ/ey5brOcogn6Zr0x7V5pjSxsZzbYKjE
         OwzxkRTMTRrTW5bgmPM8ZDyaauQp/iAwUicBHHYNnqdExjnOi50dWFU4Io1otjrGwTxW
         b0VjFyIhUwpIBcq8JTUKbDW4pIFd80heRsz9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869881; x=1697474681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb99YdmqVEejiWEnH1GHxc9UcT+WJQ1JMF8Pc+Hi6Js=;
        b=e9nKZDJXfzDIKp2rWSXK4OiyqXOyw9HELsHXyBVZnNl6I4WsH+V+sACMy5dLepNH20
         eMJI9z0PfGsVqPHx5LVl7CXECg9YLCsv3HBesKprMZhzq7C6s5LOC/XZBnG3tsCxAfWP
         698OglSXrAlJSK5r5ucjr1FeWkjjV62HD7JZYFExXk1xpWf1g3QdeTSuqzRFsE+tCDR1
         FP4FvrA9cINhGSEnbjNvntBz746qt8HPUwwTklXgJc3uHpC4nOvu3pyVOrwWXk8P5ZZA
         MiABA3mQy7xfpfToirdja2dn2veRzYLtsm9ExRgzqwTty1cKc6kNswnT6dDhRczJ3oWS
         mCtA==
X-Gm-Message-State: AOJu0YzalBHFnrbFlScT4vOn0yFpglkReqDHPszoh9eVQB2Nig4gV6sK
	cyAkqFeqYnfblaghXat8DDTbjt++Nw21U+Ys894=
X-Google-Smtp-Source: AGHT+IESRB1yZvdNdle/MtYTsam7bcaBJCQTdJrYdZYcCONWabwrZ22XhIQ+ta6XPuY/8T37ZMfQ+A==
X-Received: by 2002:a17:902:bd94:b0:1c5:bc83:557b with SMTP id q20-20020a170902bd9400b001c5bc83557bmr12137947pls.51.1696869881094;
        Mon, 09 Oct 2023 09:44:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001c6092d35b9sm9870376plg.85.2023.10.09.09.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:44:40 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:44:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc: manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	justinstitt@google.com, linux-hardening@vger.kernel.org,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: qlge: Replace strncpy with strscpy
Message-ID: <202310090921.622A22FF8@keescook>
References: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 05:12:24PM +0100, Ricardo Lopes wrote:
> Reported by checkpatch:
> 
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy

Thanks for working on this! Doing these replacements needs analysis of
several issues that should be described in the commit log:

- is the destination an %NUL-terminated string? (strncpy can produce
  non-%NUL-terminated strings and sometimes this is intentional.)

- is the source %NUL-terminated? (Sometimes strncpy is used when memcpy,
  kmemdup_nul, or other things should be used.)

- does the destination need to be %NUL padded? (strncpy does this
  padding, but it isn't always obvious if it's needed.) When padding is
  needed, strscpy_pad() should be used.

> 
> Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>
> ---
> v2: Redo changelog text
> 
>  drivers/staging/qlge/qlge_dbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> index c7e865f51..5f08a8492 100644
> --- a/drivers/staging/qlge/qlge_dbg.c
> +++ b/drivers/staging/qlge/qlge_dbg.c
> @@ -696,7 +696,7 @@ static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *s
>  	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
>  	seg_hdr->seg_num = seg_number;
>  	seg_hdr->seg_size = seg_size;
> -	strncpy(seg_hdr->description, desc, (sizeof(seg_hdr->description)) - 1);
> +	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
>  }

This function uses memset() for seq_hdr, so this is clearly trying
to construct a %NUL terminated destination (due to the old "- 1"
on the size). Also, padding should be redundant. All the callers of
qlge_build_coredump_seg_header() pass a const string as the last argument,
so they're all terminated. This looks like a correct replacement.

>  
>  /*
> @@ -737,7 +737,7 @@ int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_core
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_mpi_coredump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>  
>  	/* Get generic NIC reg dump */
> @@ -1225,7 +1225,7 @@ static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_reg_dump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>  
>  	/* segment 16 */

These are both trying to copy a const string, so we know the src is
terminated. Checking the related sizes:

struct mpi_coredump_global_header {
	...
        u8      id_string[16];

The const strings are 13 bytes with the %NUL, so they'll always fit in
the destination.

Just before these copies, the mpi_global_header is wiped:

        memset(&mpi_coredump->mpi_global_header, 0,
               sizeof(struct mpi_coredump_global_header));

so padding isn't a concern. This looks like a correct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
