Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A6658A5
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 17:26:50 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001121BFB
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c736b00639so18024855ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696008396; x=1696613196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgWJstEGJd48Eg1HdzFdOilLMPMqmWhwLsi9bYeQl7s=;
        b=R11ri71zTmA5emJGU5mz5LjwNMZA1cCORaTtco5nfVll1TcZLsagRgajqn5QjUsLdL
         bO/I3H/6VJpyCkesYCHixGyzmUnW8GtEREaPiLSeh26totC5vRaBm74rQviNDNsuVMYD
         PEd8RePwhMCbAyOVm36MobRdHCt+WR3Dr2aJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008396; x=1696613196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgWJstEGJd48Eg1HdzFdOilLMPMqmWhwLsi9bYeQl7s=;
        b=LZRM8K4VaizJtMb76/LTriUp26jQUkk2zyj9OudBOIWSTdT6o+oQQ6MlVeRC0Gqari
         f0XlZ+1CSbHSOGihTGtBSPe7J7DMdB8eTzJH21r/BeQ3RTJ5UxLoO/oXL/UsXeVo5sJ/
         sXaozCb0z4C2JaHuFf5kuG1wvMuXN0qB7ygfDeT17Au1OOp4mcdox20PYW7hpUPfxNcq
         DwBUzKJyymtaFlDbdKujJtrgNk+gk7I6j0NyAxQyp6X8ivrgw/SehDb+zr9D8tec/jpC
         olH3/oGBImRioG1iXakrm/m9xWDg1JzR4Zdr7eXUf0N+WEikYgsn7hbjLA8ctO9sRjjS
         YF9Q==
X-Gm-Message-State: AOJu0YwMo116Fz9ALwFuwlt2ZcJTLmOlo+FbOLJqdltzc7RZ5gQo041v
	gltLrsKnA+rTP1kiYP31vi7K2CEoFkvJNGd3RnU=
X-Google-Smtp-Source: AGHT+IG3mCcEa8WVJpFPvOj0b5dGwRnh2/1kFQNVIYL87dKwC/DqhQALhB/xIzmN0rioBZhmbty5Cw==
X-Received: by 2002:a17:90a:bd8d:b0:268:e5db:6e19 with SMTP id z13-20020a17090abd8d00b00268e5db6e19mr4483958pjr.20.1696008396220;
        Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b00276fc32c0dasm1701460pjb.4.2023.09.29.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:35 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:26:35 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jussi Kivilinna <jussi.kivilinna@iki.fi>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 comm_runtime
Message-ID: <202309291024.14F6DA0@keescook>
References: <ZRb0WiViajjqcyKT@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRb0WiViajjqcyKT@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 05:59:22PM +0200, Gustavo A. R. Silva wrote:
> `struct urb` is a flexible structure, which means that it contains a
> flexible-array member at the bottom. This could potentially lead to an
> overwrite of the objects following `receiver` in `struct comm_runtime`,
> among them some function pointers.
> 
> Fix this by placing the declaration of object `receiver` at the end of
> `struct comm_runtime`.
> 
> Fixes: ddb6b5a96437 ("ALSA: 6fire: fix DMA issues with URB transfer_buffer usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Should these mention -Wflex-array-member-not-at-end ?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
