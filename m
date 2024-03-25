Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7697F7E9
	for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406832; cv=none; b=aRRPT9SHLky7YQwqICG5Jn+UqmUjpDEPVqgtiyed+yC6gfw6m7TpDajkykrfB7A9viB8Bc/Hp5jbD552kyX/Bb5olt9m+Mbgr2gg94I1QcvO+uAxxG7c8lxl0Fdt0VvlT4j477qtij2Rp6xwF8UrZ44kQ4Qx5uf0+KdGnYhwS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406832; c=relaxed/simple;
	bh=GKS0Tf6qp+BZ9KFCahLUmOaP97KsUUjEX2vETGsJmws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMP2QxPdcbT1Q1QkYbjMkrMQ6EWEGWtAiZ8TiN1pq+BFU2BJmdtl7AreD/Gx8HsamguzBFiC6g6Km8CZ2Jk+HVbYedmYMVwxif9T30wPvMGRok2TZzwjFRnDPuJLSrU2Aemxz9oERKOynphSQ3Axms2R+Nrefp7rZGkkcl+ETiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TLMprQLF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TLMprQLF"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42f4b66dc9eso27600011cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711406828; x=1712011628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlPMTJaNGiZjUvi6saKf2R4Fpag5/u1oxV37EUoykZM=;
        b=TLMprQLFoU0fsfiXEsQ49dVFY0jaX8bOVIkyRiQE0z0vPv3TV3PTU3206uoZ9xCDtd
         JSqu7YLYqf3mtyeIrT4dZ+jmC5QcOzTh5YIadjrXkhmdccSU208K+Toqc9IDrmp0TFeA
         kp/9w/EaZ0JoiSJKcWLHl0YQmLDBoz4cvh0hSIeyn4PrYZTGHWc5NrWCKqFYpWmQprad
         hvEMUgDq0e/iqpeoma2FF+IqHaZ1GDpskBCcc05H59LcCZrN9znMdBMx45KyPPdh/5nN
         SD+vqEf85qM7dWslNxnsVFzjGEH5WTnT5OLnGkdw//x5lP4Jo33NGvFANuY+7+5oZEYT
         gJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406828; x=1712011628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlPMTJaNGiZjUvi6saKf2R4Fpag5/u1oxV37EUoykZM=;
        b=kJYWIGIoqWCQaeWlxpiEKQdxcVYuslzc6VIrsS78fi3N6a4g7RXXW4UArFZ1idEi/M
         cHonaZPh/aTgqo1YaE50oHRu+v4R73ndOf4lrGyghWmeLpRFqE6DMMzU6qbKzw6H8/ac
         J75MHvWqKT8BA31cODc0ce3NZbaH20peBe7Uw9UvL3h/kj1G+8zWs8H/nzY7EQ5QU1KD
         V77PXQLbAoVLbpLTH2sglW7QWXyQ/UWh7IZrzCh14wl17eIb9FGMPI1t1ZCqisemR/Lw
         AktvHHagOI86LnzWPDdKYo9IYPUyHcq6WN3/XRDVQ+V6BhaoitjQ2uRXlueUkOHSpWww
         Zppw==
X-Forwarded-Encrypted: i=1; AJvYcCWnu08SCjkBQ+4vui8ySd77UpiRPojTX5FjJHipbM8eXpOn52ODaWx1x/35Pug370QvjUsf6zFEe/HFTWMbSV2rjAhlmnEAhiAYY3goKhgZ
X-Gm-Message-State: AOJu0YypN+drJWvczF8yzR1g97kgCfScTvjbhA4Ou5vnT2VIb4+oHFey
	w/cwApAWBLtEepid7p29YQlFVdOIJOgyQ6vsEFOQwAYBuV1o0S0pJiwhJkWSvMg=
X-Google-Smtp-Source: AGHT+IGDPiepzyYCbNq3PzR9FEl5rqH5RJZULTTzRDmX08wdPkssFOKZgU0ofAN2KeN76EJt1Kopyw==
X-Received: by 2002:ac8:5a8c:0:b0:431:621d:46ed with SMTP id c12-20020ac85a8c000000b00431621d46edmr2407680qtc.28.1711406827783;
        Mon, 25 Mar 2024 15:47:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id cr10-20020a05622a428a00b00430a44f49dasm3048635qtb.7.2024.03.25.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:47:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rot5u-001VXC-N0;
	Mon, 25 Mar 2024 19:47:06 -0300
Date: Mon, 25 Mar 2024 19:47:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240325224706.GB8419@ziepe.ca>
References: <ZgHdZ15cQ7MIHsGL@neat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHdZ15cQ7MIHsGL@neat>

On Mon, Mar 25, 2024 at 02:24:07PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Use the `struct_group_tagged()` helper to separate the flexible array
> from the rest of the members in flexible `struct cm_work`, and avoid
> embedding the flexible-array member in `struct cm_timewait_info`.
> 
> Also, use `container_of()` to retrieve a pointer to the flexible
> structure.
> 
> So, with these changes, fix the following warning:
> drivers/infiniband/core/cm.c:196:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/core/cm.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index bf0df6ee4f78..80c87085499c 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -182,18 +182,21 @@ struct cm_av {
>  };
>  
>  struct cm_work {
> -	struct delayed_work work;
> -	struct list_head list;
> -	struct cm_port *port;
> -	struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
> -	__be32 local_id;			/* Established / timewait */
> -	__be32 remote_id;
> -	struct ib_cm_event cm_event;
> +	/* New members must be added within the struct_group() macro below. */
> +	struct_group_tagged(cm_work_hdr, hdr,
> +		struct delayed_work work;
> +		struct list_head list;
> +		struct cm_port *port;
> +		struct ib_mad_recv_wc *mad_recv_wc;	/* Received MADs */
> +		__be32 local_id;			/* Established / timewait */
> +		__be32 remote_id;
> +		struct ib_cm_event cm_event;
> +	);
>  	struct sa_path_rec path[];
>  };

I didn't look, but does it make more sense to break out the path side
into its own type and avoid the struct_group_tagged? I seem to
remember only one thing used it.

Jason
