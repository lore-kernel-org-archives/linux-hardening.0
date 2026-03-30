Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BF3CFF59
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876391; cv=none; b=eJe67hULKnnfaGUsPMJjCaEEfxdRN1ZqCgZVFlvlUvi4uZmMEUfW1hUcMXlB71RcqCAu05Maagn54DMAgG0uCiNkc8vBVEYpvHQToz9WEoDdywaCqf9B38RKWNOQb8VJMV3XL0WsAiJXyeYBD6CGdougDBh//yVREZchCOYNVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876391; c=relaxed/simple;
	bh=1B8TDAFwpLGHwiDqq4lc4BeRA9+0ahIvheZoJR/1alo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=caVXndegn1cgTocO+a4pshzZ+pw0pcjmLEdGnGoMhFIa7jCHy75NDD4RDSYAkVZ82Vs5TSzn7LKcjGmMJcUHFqN9GX2lPZtf3Tb2EVX7IakZbGG0EVGZnyrp8q1MVK6PZCYzITabvPuNA0Y7AmCtnx0diNkEq7Yz1DTXgfVW9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxrIKICo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxrIKICo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774876389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUo0/wHcRmQzbX45cbbWi4ZZUfa7cbgmLMG4WHaF32c=;
	b=gxrIKICoH9XVn7hnVob0gZdtRFpGDYoC0UjVHUxY3PijgkJXLvPvseZ0GiPKAU5iFl7LbC
	GfqNNff1NoQ13CqLzQWZEYH0OACKpV3fMTEOSF9XnNkt4XpoVzlrMe6UT1QL6zpiQCJUhg
	qe0SEIkQ15ej8a+TkwcotWAG2ptLvlg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-er6OV7bWM7-__iUUkmM-AA-1; Mon, 30 Mar 2026 09:13:08 -0400
X-MC-Unique: er6OV7bWM7-__iUUkmM-AA-1
X-Mimecast-MFC-AGG-ID: er6OV7bWM7-__iUUkmM-AA_1774876388
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a0013d87bso231940216d6.2
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 06:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876388; x=1775481188;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUo0/wHcRmQzbX45cbbWi4ZZUfa7cbgmLMG4WHaF32c=;
        b=P5WemPouvgNZHLddzLRP2GKwtQQSiWCTItzSJAfDVvyKnsza1WDi35ILIIaVDADhPZ
         bvhytRwMUqUUJj5mCdLwh+a8Y6F5JGPDOcsqbH75tWA6tfeAvF7j01BqaSi7FKBFh70o
         SU69g0niWaQ023pObK+vla9ubhPEP17ZJcMOpNUcDW0pXn7JbPDBrvOd56BcR4Rwjay6
         XkR1RsyWa+VtN6HP2K+H1fD0UJskSdIl1Cho89sqioQzcOyaeBRGredQqXnzW+aw6cdr
         OgoOZZUKIjI0RfLsj0YX3gNYvwthjTzoxlfCOVetNZubLsJwVyByRDtjIbVqR/j1PV/2
         o/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7PSGHvT7cVpKgKzBOnq2pr/BjOQTG9ILlkvJpJ3/mZrWkcjqL7V4ZpXgO97yqbrgpnX+afmswf+xOVyFzcs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbRzT1gzlL4stwzuVM/2cFiwiuceM3vmqxNsh5OTkzcCcBEM/
	9Ans2d2UqK4uLnahKvSPeQ/IXZU2sIXDEMu0dKgKoOKTqqKhgzOdh8LDETT7fqm5cS6BM6b9Bvf
	czF0Hh81qIGqajRil0e3gyHsk/LnLQZsh8FSMtQr67sEQqBbI47AbnBUBPr2Jtlrdi0uN/A==
X-Gm-Gg: ATEYQzxIfQAHVaMghX3b3d9L9vrR5eBo9lLI4/AAVGfOu1qbvVACRwy0BGFROwWKKZX
	5qxSVQkDOwuq0hBIT+NPeiUacRwlTLiqLdCh1hzHXGa43OlUd1bh11xohWn7f+vUR3myddkcCDK
	BBdZlF508fLiPQApyWxqW5zkVI9bcqKkNT937bqBe2B2t1ivbdI5VDyjUKoSvqjTU2CbL36JJkU
	LqRmz/VCejbAweKgUDEBSf8ocV651IQWREpD3KS0LaUV3zRdpa58qQBzeOuv95mKQGmzJ/FKSwR
	3LKOGSKoE6E926zvhLZwc8NyTbAkEkN0hfhGAFwyqKd6EDNxTFpl49dz31E7P15Yxildsj9o7BE
	Os39bDXDRSFPl9+Jr2wKeTdz/QAv6qRmSIeY9yWXc98BaT6XdqakzRIwn
X-Received: by 2002:a05:6214:4105:b0:8a0:22bb:1d3c with SMTP id 6a1803df08f44-8a022bb1fb2mr76477666d6.3.1774876387567;
        Mon, 30 Mar 2026 06:13:07 -0700 (PDT)
X-Received: by 2002:a05:6214:4105:b0:8a0:22bb:1d3c with SMTP id 6a1803df08f44-8a022bb1fb2mr76476806d6.3.1774876386785;
        Mon, 30 Mar 2026 06:13:06 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ec6ec2266sm63989576d6.0.2026.03.30.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:13:06 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:13:04 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] clk: kirkwood: use kzalloc_flex
Message-ID: <acp24GchNcb9iHXJ@redhat.com>
References: <20260326045555.240730-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260326045555.240730-1-rosenp@gmail.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KKvKdH5iC_xs7ktp9xmK5Lpx1aXP_V7ICLn85Dk2CxI_1774876388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2026 at 09:55:55PM -0700, Rosen Penev wrote:
> Simplify allocation by using a flexible array member and kzalloc_flex to
> combine allocations.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment to right after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/clk/mvebu/kirkwood.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
> index ed061d82fb65..fc2972538008 100644
> --- a/drivers/clk/mvebu/kirkwood.c
> +++ b/drivers/clk/mvebu/kirkwood.c
> @@ -253,8 +253,8 @@ struct clk_muxing_soc_desc {
>  
>  struct clk_muxing_ctrl {
>  	spinlock_t *lock;
> -	struct clk **muxes;
>  	int num_muxes;
> +	struct clk *muxes[] __counted_by(num_muxes);
>  };
>  
>  static const char *powersave_parents[] = {
> @@ -297,21 +297,18 @@ static void __init kirkwood_clk_muxing_setup(struct device_node *np,
>  	if (WARN_ON(!base))
>  		return;
>  
> -	ctrl = kzalloc_obj(*ctrl);
> -	if (WARN_ON(!ctrl))
> -		goto ctrl_out;
> -
> -	/* lock must already be initialized */
> -	ctrl->lock = &ctrl_gating_lock;
> -
>  	/* Count, allocate, and register clock muxes */
>  	for (n = 0; desc[n].name;)
>  		n++;
>  
> +	ctrl = kzalloc_flex(*ctrl, muxes, n);
> +	if (WARN_ON(!ctrl))
> +		goto ctrl_out;
> +
>  	ctrl->num_muxes = n;
> -	ctrl->muxes = kzalloc_objs(struct clk *, ctrl->num_muxes);
> -	if (WARN_ON(!ctrl->muxes))
> -		goto muxes_out;

Question from Sashiko:

https://sashiko.dev/#/patchset/20260326045555.240730-1-rosenp%40gmail.com

    This isn't a bug, but since the goto muxes_out error path was removed here,
    should the muxes_out label and its kfree(ctrl) be removed at the end of the
    function?
    They appear to be dead code now and might cause an unused label warning:
    	return;
    muxes_out:
    	kfree(ctrl);
    ctrl_out:
    	iounmap(base);
    }

Brian


> +
> +	/* lock must already be initialized */
> +	ctrl->lock = &ctrl_gating_lock;
>  
>  	for (n = 0; n < ctrl->num_muxes; n++) {
>  		ctrl->muxes[n] = clk_register_mux(NULL, desc[n].name,
> -- 
> 2.53.0
> 

