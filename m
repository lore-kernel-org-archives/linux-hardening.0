Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B662F4E
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wu+000MO"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05DC9E
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 13:42:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5c91bece9so35712835ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696884135; x=1697488935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQQInxgsjBt8w5xcxIPIHbM5AYNFsiZIBl4w68pdIx8=;
        b=Wu+000MO5t3eBFYqm22mZBbmq8jg7gvPF00LNVrW5E0kJlsEJL3c18fdwsSNzRehm9
         kAO/9ugiSIt6CTMutB999b+SOmUl8BEpvRLAxv4esa0OfQaHbgboDsckZ0ToUCk3jimg
         C7zE/Its3EVqTcbDo8+wel28Z66Mpk14wKyoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884135; x=1697488935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQQInxgsjBt8w5xcxIPIHbM5AYNFsiZIBl4w68pdIx8=;
        b=LbJ9b1fqZTCvej7Yby4xp/1EPRtsDwUjTLnA7Zu4glvN0TCulXwLVuJ/H8ZZaMkDVl
         Lh+BvJx7gNyC8tRRQjetuix0qGgc6imiXZzexkIOYPmhGt6F58aBWx3WZ1WPUlyG7zRg
         z6qPeGLvshcLmtUjMBpQIrF3KrKnyOk02Fe4jQUJmWgYuaNe5O8/mb+Cg9XCczS6e5rB
         jy4ySLQWuuct2CdmalUJA5kEJv9QSA22sBas7RQ0DfJearlxSElGBfQh+rMJR3Mjh3uF
         RP+UigR3d+fkKxh4of8op+ch/UixJ4JUR20wBEVHbH7yCaVF4XBGDEJekv4JWuh8rFTu
         QClg==
X-Gm-Message-State: AOJu0Yy+gPTPl/kSZVdlwDP2UwTnCgOFHz9bhKhfwvXtoFOpLhVCP/Gq
	/maz/gOaeqvj/g564JuyfB7Myg==
X-Google-Smtp-Source: AGHT+IH9MdMNUUJjdaGAliL795A9zatzD6Si8kgw2QUoHjHiomp879pl81fC008rIbxKA5Jr3etkHA==
X-Received: by 2002:a17:902:e883:b0:1c6:19da:b29f with SMTP id w3-20020a170902e88300b001c619dab29fmr16439549plg.26.1696884135372;
        Mon, 09 Oct 2023 13:42:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b001c465bedaccsm10286698plb.83.2023.10.09.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:42:14 -0700 (PDT)
Date: Mon, 9 Oct 2023 13:42:12 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Message-ID: <202310091341.74A2D82BB@keescook>
References: <ZSRXXvWMMkm7qqRW@work>
 <202310091253.665A9C9@keescook>
 <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 02:33:01PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 10/9/23 21:54, Kees Cook wrote:
> > On Mon, Oct 09, 2023 at 01:41:18PM -0600, Gustavo A. R. Silva wrote:
> > > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > > attribute. Flexible array members annotated with __counted_by can have
> > > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > > functions).
> > > 
> > > While there, use struct_size() helper, instead of the open-coded
> > > version, to calculate the size for the allocation of the whole
> > > flexible structure, including of course, the flexible-array member.
> > > 
> > > This code was found with the help of Coccinelle, and audited and
> > > fixed manually.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   drivers/net/wireless/intersil/hostap/hostap_download.c | 3 +--
> > >   drivers/net/wireless/intersil/hostap/hostap_wlan.h     | 2 +-
> > >   2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
> > > index 3672291ced5c..5e5bada28b5b 100644
> > > --- a/drivers/net/wireless/intersil/hostap/hostap_download.c
> > > +++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
> > > @@ -732,8 +732,7 @@ static int prism2_download(local_info_t *local,
> > >   		goto out;
> > >   	}
> > > -	dl = kzalloc(sizeof(*dl) + param->num_areas *
> > > -		     sizeof(struct prism2_download_data_area), GFP_KERNEL);
> > > +	dl = kzalloc(struct_size(dl, data, param->num_areas), GFP_KERNEL);
> > >   	if (dl == NULL) {
> > >   		ret = -ENOMEM;
> > >   		goto out;
> > > diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> > > index c25cd21d18bd..f71c0545c0be 100644
> > > --- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> > > +++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> > > @@ -617,7 +617,7 @@ struct prism2_download_data {
> > >   		u32 addr; /* wlan card address */
> > >   		u32 len;
> > >   		u8 *data; /* allocated data */
> > > -	} data[];
> > > +	} data[] __counted_by(num_areas);
> > >   };
> > 
> > Should this be considered a v2 of:
> > https://lore.kernel.org/linux-hardening/94848cc3-6f5c-46d7-8cc7-98a4f10865b3@embeddedor.com/
> > 
> > ?
> 
> Oops... sorry, I forgot I had reviewed this patch of yours.
> 
> > 
> > Yours is more complete since it includes the struct_size() change...
> > 
> 
> Should I resend this explicitly marking it as a v2?

I defer to Kalle -- your Subject is more accurate, so perhaps let's just
let this stand?

-- 
Kees Cook
